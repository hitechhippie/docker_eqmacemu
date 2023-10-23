FROM debian:bookworm

# Establish build arguments for user ID, group ID
# These can be overridden in the .env file
ARG RUN_UID=1000
ARG RUN_GID=1000
ARG RUN_UNAME=eqmacemu

RUN apt update -y; \
    apt install -y --no-install-recommends \
                   build-essential \
                   cmake \
                   libboost-all-dev \
                   git \
                   wget \
                   inetutils-telnet \
                   ncat \
                   liblua5.1-0-dev \
                   libmariadb-dev \
                   mariadb-client \
                   libmysql++-dev \
                   libcurl4-openssl-dev \
                   uuid-dev \
                   libmbedtls-dev \
                   openssl ca-certificates; \
    apt clean -y

# Create runtime user and group
RUN groupadd -g ${RUN_GID} ${RUN_UNAME} && \
    useradd ${RUN_UNAME} -u ${RUN_UID} -g ${RUN_GID} -s /bin/bash

# Build folder structures
RUN mkdir -p /build/src \
             /build/out \
             /build/maps \
             /build/quests \
             /eqmacemu 

# Set folder structure permissions
RUN /usr/bin/chmod -R 0777 /build /eqmacemu

# Deploy git scripts
COPY --chmod=0775 scripts/clone_server.sh \
                  scripts/clone_maps.sh \
                  scripts/clone_quests.sh /build/

# Clone sources
RUN /build/clone_server.sh && \
    /build/clone_maps.sh && \
    /build/clone_quests.sh

# Deploy build script
COPY --chmod=0775 scripts/build_server.sh /build/

# Build server binaries
RUN /build/build_server.sh

# Deploy server scripts
COPY --chmod=0775 scripts/init_server.sh \
                  scripts/init_configs.sh \
                  scripts/init_db_data.sh \
                  scripts/init_files.sh \
                  scripts/zonelaunch.sh /build/

# Deploy server configuration templates
COPY --chmod=0664 files/eqemu_config.json \
                  files/spells_en.txt \
                  files/db.ini \
                  files/login.ini /build/

USER ${RUN_UID}:${RUN_GID}

