# Extend the official Mumble server image with sqlite3 and a wrapper that
# initializes the database, applies the channel migration, and then starts the
# server for real.

FROM mumblevoip/mumble-server:v1.5.915

USER root
RUN apt-get update && apt-get install -y --no-install-recommends sqlite3 && rm -rf /var/lib/apt/lists/*

COPY migration_seed_channels.sql /app/migration_seed_channels.sql
COPY entrypoint-wrapper.sh /app/entrypoint-wrapper.sh
RUN chmod +x /app/entrypoint-wrapper.sh

# Default Mumble voice/control port (TCP and UDP).
EXPOSE 64738/tcp 64738/udp

ENTRYPOINT ["/app/entrypoint-wrapper.sh"]
CMD ["/usr/bin/mumble-server"]
