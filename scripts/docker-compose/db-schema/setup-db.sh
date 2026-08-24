#!/bin/bash
#
# Setup database schemas for OpenReplay Docker Compose deployment.
# Run this AFTER infra services (postgres, clickhouse, minio, redis) are up.
#
# Usage:
#   bash db-schema/setup-db.sh
#
# Run from: scripts/docker-compose/

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMPOSE_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
SCHEMA_DIR="$COMPOSE_DIR/../schema/db/init_dbs"

# Schema file locations (same files used by docker-compose migration services)
PG_SCHEMA="$SCHEMA_DIR/postgresql/init_schema.sql"
CH_SCHEMA="$SCHEMA_DIR/clickhouse/create/init_schema.sql"

# Load credentials from common.env
COMMON_ENV="$COMPOSE_DIR/common.env"
if [ ! -f "$COMMON_ENV" ]; then
    err "common.env not found at $COMMON_ENV"
    exit 1
fi
source "$COMMON_ENV"

PG_PASSWORD="${COMMON_PG_PASSWORD:?COMMON_PG_PASSWORD not set in common.env}"
MINIO_HOST="http://minio.db.svc.cluster.local:9000"
MINIO_ACCESS_KEY="${COMMON_S3_KEY:?COMMON_S3_KEY not set in common.env}"
MINIO_SECRET_KEY="${COMMON_S3_SECRET:?COMMON_S3_SECRET not set in common.env}"

log() { echo "[$(date '+%H:%M:%S')] $1"; }
err() { echo "[$(date '+%H:%M:%S')] ERROR: $1" >&2; }

wait_for_postgres() {
    log "Waiting for PostgreSQL..."
    local retries=30
    while ! docker exec postgres pg_isready -U postgres >/dev/null 2>&1; do
        retries=$((retries - 1))
        if [ $retries -le 0 ]; then
            err "PostgreSQL not ready after 30 attempts"
            return 1
        fi
        sleep 2
    done
    log "PostgreSQL is ready"
}

wait_for_clickhouse() {
    log "Waiting for ClickHouse..."
    local retries=30
    while ! docker exec clickhouse clickhouse-client --query "SELECT 1" >/dev/null 2>&1; do
        retries=$((retries - 1))
        if [ $retries -le 0 ]; then
            err "ClickHouse not ready after 30 attempts"
            return 1
        fi
        sleep 2
    done
    log "ClickHouse is ready"
}

wait_for_minio() {
    log "Waiting for MinIO..."
    local retries=30
    while ! docker exec minio ls /bitnami/minio/data >/dev/null 2>&1; do
        retries=$((retries - 1))
        if [ $retries -le 0 ]; then
            err "MinIO not ready after 30 attempts"
            return 1
        fi
        sleep 2
    done
    log "MinIO is ready"
}

setup_postgres() {
    log "Setting up PostgreSQL schema..."

    if [ ! -f "$PG_SCHEMA" ]; then
        err "PostgreSQL schema file not found: $PG_SCHEMA"
        return 1
    fi

    # Check if DB is already initialized (tenants table exists)
    if docker exec postgres env PGPASSWORD="$PG_PASSWORD" psql -U postgres -tAc \
        "SELECT 1 FROM information_schema.tables WHERE table_name='tenants'" 2>/dev/null | grep -q 1; then
        log "PostgreSQL already initialized (tenants table exists). Skipping."
        return 0
    fi

    docker cp "$PG_SCHEMA" postgres:/tmp/init_schema.sql
    docker exec postgres env PGPASSWORD="$PG_PASSWORD" psql -U postgres -v ON_ERROR_STOP=1 -f /tmp/init_schema.sql
    docker exec postgres rm /tmp/init_schema.sql

    log "PostgreSQL schema imported successfully"
}

setup_clickhouse() {
    log "Setting up ClickHouse schema..."

    if [ ! -f "$CH_SCHEMA" ]; then
        err "ClickHouse schema file not found: $CH_SCHEMA"
        return 1
    fi

    # Check if already initialized (experimental.sessions exists)
    if docker exec clickhouse clickhouse-client --query "SHOW TABLES FROM experimental" 2>/dev/null | grep -q sessions; then
        log "ClickHouse already initialized. Skipping."
        return 0
    fi

    docker cp "$CH_SCHEMA" clickhouse:/tmp/init_schema.sql
    docker exec clickhouse bash -c "clickhouse-client --multiquery < /tmp/init_schema.sql"
    docker exec clickhouse rm /tmp/init_schema.sql

    log "ClickHouse schema imported successfully"
}

setup_minio() {
    log "Setting up MinIO buckets..."

    # Check if buckets already exist
    local existing
    existing=$(docker exec minio ls /bitnami/minio/data/ 2>/dev/null | wc -l)
    if [ "$existing" -ge 9 ]; then
        log "MinIO buckets already exist ($existing found). Skipping."
        return 0
    fi

    # Use the existing minio.sh from helmcharts
    local minio_script="$COMPOSE_DIR/../helmcharts/openreplay/files/minio.sh"
    if [ -f "$minio_script" ]; then
        docker run --rm \
            --network "$(docker inspect minio --format '{{range $k, $v := .NetworkSettings.Networks}}{{$k}}{{end}}' | head -1)" \
            -e MINIO_HOST="$MINIO_HOST" \
            -e MINIO_ACCESS_KEY="$MINIO_ACCESS_KEY" \
            -e MINIO_SECRET_KEY="$MINIO_SECRET_KEY" \
            -v "$minio_script:/tmp/minio.sh:ro" \
            --entrypoint bash \
            ghcr.io/openreplay/minio:2025 \
            /tmp/minio.sh init
    else
        log "minio.sh not found, creating buckets directly..."
        local buckets=("mobs" "sessions-assets" "static" "sourcemaps" "sessions-mobile-assets" "quickwit" "vault-data" "records" "spots")
        for bucket in "${buckets[@]}"; do
            docker exec minio mkdir -p "/bitnami/minio/data/$bucket" 2>/dev/null || true
        done
    fi

    log "MinIO buckets created"
}

main() {
    log "=== OpenReplay DB Schema Setup ==="
    log "PostgreSQL schema: $PG_SCHEMA"
    log "ClickHouse schema: $CH_SCHEMA"

    # Wait for all services
    wait_for_postgres
    wait_for_clickhouse
    wait_for_minio

    # Setup schemas
    setup_postgres
    setup_clickhouse
    setup_minio

    log "=== DB Schema Setup Complete ==="
    log ""
    log "Post-setup steps (run after 'docker compose up -d'):"
    log "  1. Restart spot service:   docker restart spot"
    log "     (spot has a startup race condition - it starts before schema is ready)"
    log "  2. Restart chalice service: docker restart chalice"
    log "     (ensures chalice picks up the ClickHouse schema changes)"
}

main "$@"
