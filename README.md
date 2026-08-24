# cisgenx-openreplay

Self-hosted [OpenReplay](https://github.com/openreplay/openreplay) v1.23.0 deployment using Docker Compose.

Based on the [official OpenReplay repository](https://github.com/openreplay/openreplay).

## Quick Start

1. Copy example configs to active configs:

```bash
cd scripts/docker-compose
cp common.env.example common.env
cp docker-compose.yaml.example docker-compose.yaml
cp Caddyfile.example Caddyfile
# Copy all env examples
for f in docker-envs/*.env.example; do cp "$f" "${f%.example}"; done
```

2. Edit `common.env` with your domain and secrets
3. Start infra services and init DB schemas:

```bash
docker compose up -d postgres clickhouse redis minio
bash db-schema/setup-db.sh
```

4. Start all services:

```bash
docker compose up -d
docker restart spot chalice
```

> **Note:** The upstream OpenReplay only provides Helm/Kubernetes deployment.
> DB schemas in `scripts/schema/db/init_dbs/` have been replaced with schemas
> exported from a working instance (fixes missing columns and product_analytics DB).
> See `scripts/docker-compose/db-schema/` for setup and export scripts.

## File Structure

```text
scripts/
  docker-compose/
    *.example            # Template configs (committed, safe)
    *.env                # Active configs with credentials (gitignored)
    docker-compose.yaml  # Active compose file (gitignored)
    Caddyfile            # Active Caddy config (gitignored)
    Caddyfile.private    # Template: internal TLS (self-signed)
    db-schema/
      setup-db.sh        # Init DB schemas on fresh deploy
      export-db.sh       # Re-export schemas from running DB
  schema/db/init_dbs/
    postgresql/init_schema.sql   # PostgreSQL schema (source of truth)
    clickhouse/create/init_schema.sql  # ClickHouse schema (source of truth)
```

## Caddy TLS Options

- `Caddyfile.example` - Public domain with automatic Let's Encrypt TLS
- `Caddyfile.private` - Internal/private network with self-signed TLS

## Upstream

- Source: <https://github.com/openreplay/openreplay>
- Version: v1.23.0
- [Official docs](https://docs.openreplay.com/)

## License

This monorepo uses several licenses. See [LICENSE](/LICENSE) for more details.
