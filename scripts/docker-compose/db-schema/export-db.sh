#!/bin/bash
#
# Export database schemas from running OpenReplay containers.
# Overwrites the init_schema.sql files used by docker-compose migration services.
#
# Usage:
#   bash db-schema/export-db.sh
#
# Run from: scripts/docker-compose/

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMPOSE_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
SCHEMA_DIR="$COMPOSE_DIR/../schema/db/init_dbs"
DATE=$(date '+%Y-%m-%d')

# Load credentials from common.env
COMMON_ENV="$COMPOSE_DIR/common.env"
if [ ! -f "$COMMON_ENV" ]; then
    echo "ERROR: common.env not found at $COMMON_ENV" >&2
    exit 1
fi
source "$COMMON_ENV"

PG_PASSWORD="${COMMON_PG_PASSWORD:?COMMON_PG_PASSWORD not set in common.env}"
PG_OUT="$SCHEMA_DIR/postgresql/init_schema.sql"
CH_OUT="$SCHEMA_DIR/clickhouse/create/init_schema.sql"

log() { echo "[$(date '+%H:%M:%S')] $1"; }

export_postgres() {
    log "Exporting PostgreSQL schema -> $PG_OUT"

    # Idempotency header (skip if DB already exists)
    cat > "$PG_OUT" << 'HEADER'
-- OpenReplay PostgreSQL Schema
-- Exported from working instance (includes all fixes)
-- Replaces upstream init_schema.sql which had missing columns/schemas

\set ON_ERROR_STOP true
SELECT EXISTS (SELECT 1
               FROM information_schema.tables
               WHERE table_schema = 'public'
                 AND table_name = 'tenants') AS db_exists;
\gset
\if :db_exists
\echo >DB already exists, stopping script
\q
\endif

HEADER

    # Append schema dump
    docker exec postgres env PGPASSWORD="$PG_PASSWORD" \
        pg_dump -U postgres -s --no-owner --no-privileges --no-comments --no-security-labels postgres \
        2>/dev/null | grep -v '\\restrict' | grep -v '\\allow' \
        >> "$PG_OUT"

    local lines
    lines=$(wc -l < "$PG_OUT")
    log "PostgreSQL: $lines lines exported"
}

export_clickhouse() {
    log "Exporting ClickHouse schemas -> $CH_OUT"

    cat > "$CH_OUT" << HEADER
-- OpenReplay ClickHouse Schema
-- Exported from working instance on $DATE (includes all fixes)
-- Replaces upstream init_schema.sql which was missing product_analytics
-- and had incomplete column definitions

HEADER

    # Export all non-system databases
    local databases
    databases=$(docker exec clickhouse clickhouse-client \
        --query "SELECT name FROM system.databases WHERE name NOT IN ('system','INFORMATION_SCHEMA','information_schema','default')" \
        2>/dev/null)

    for db in $databases; do
        echo "CREATE DATABASE IF NOT EXISTS $db ENGINE = Atomic;" >> "$CH_OUT"
        echo "" >> "$CH_OUT"

        local tables
        tables=$(docker exec clickhouse clickhouse-client --query "SHOW TABLES FROM $db" 2>/dev/null)

        for table in $tables; do
            echo "-- Table: ${db}.${table}" >> "$CH_OUT"
            docker exec clickhouse clickhouse-client \
                --query "SHOW CREATE TABLE ${db}.${table} FORMAT TSVRaw" 2>/dev/null >> "$CH_OUT"
            echo ";" >> "$CH_OUT"
            echo "" >> "$CH_OUT"
        done
    done

    local lines
    lines=$(wc -l < "$CH_OUT")
    log "ClickHouse: $lines lines exported"
}

main() {
    log "=== Exporting OpenReplay DB Schemas ==="

    # Check containers are running
    for container in postgres clickhouse; do
        if ! docker inspect "$container" --format '{{.State.Running}}' 2>/dev/null | grep -q true; then
            log "ERROR: $container container not running"
            exit 1
        fi
    done

    export_postgres
    export_clickhouse

    log "=== Export Complete ==="
    log "Files updated:"
    log "  $PG_OUT"
    log "  $CH_OUT"
}

main "$@"
