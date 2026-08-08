#!/bin/sh
set -e

DB_FILE="/data/mumble-server.sqlite"
INIT_LOG="/tmp/mumble-init.log"
OFFICIAL_ENTRYPOINT="/entrypoint.sh"
MIGRATION_FILE="/app/migration_seed_channels.sql"

db_initialized() {
    if [ -f "$DB_FILE" ]; then
        if sqlite3 "$DB_FILE" "SELECT 1 FROM sqlite_master WHERE type='table' AND name='channels' LIMIT 1" 2>/dev/null | grep -q 1; then
            return 0
        fi
    fi
    return 1
}

needs_migration() {
    if [ "${FORCE_MIGRATION:-0}" = "1" ]; then
        return 0
    fi

    if [ ! -f "$DB_FILE" ]; then
        return 0
    fi

    if sqlite3 "$DB_FILE" "SELECT 1 FROM channels WHERE server_id = 1 AND channel_id = 0 AND NOT EXISTS (SELECT 1 FROM channels c2 WHERE c2.server_id = 1 AND c2.name = 'admin') LIMIT 1" 2>/dev/null | grep -q 1; then
        return 0
    fi

    return 1
}

wait_for_db() {
    pid=$1
    i=0
    while [ $i -lt 120 ]; do
        if db_initialized; then
            # Wait for Mumble to finish writing its initial schema.
            sleep 2
            return 0
        fi
        sleep 1
        i=$((i + 1))
    done

    echo "Timeout waiting for database initialization" >&2
    kill "$pid" 2>/dev/null || true
    wait "$pid" 2>/dev/null || true
    exit 1
}

apply_migration() {
    echo "Applying channel migration ($MIGRATION_FILE)..."
    sqlite3 "$DB_FILE" ".read $MIGRATION_FILE"
    echo "Migration applied."
}

if needs_migration; then
    echo "Initializing database..."

    # Start the official entrypoint in the background so the server creates the DB.
    "$OFFICIAL_ENTRYPOINT" "$@" > "$INIT_LOG" 2>&1 &
    bg_pid=$!

    wait_for_db "$bg_pid"

    # Stop the temporary server.
    kill "$bg_pid" 2>/dev/null || true
    wait "$bg_pid" 2>/dev/null || true

    apply_migration
else
    echo "Database already initialized."
fi

# Hand over to the official entrypoint so mumble-server runs as PID 1.
exec "$OFFICIAL_ENTRYPOINT" "$@"
