FROM postgres:11

VOLUME /tmp

# Environment variables
ENV POSTGIS_MAJOR 2.5
ENV POSTGIS_VERSION 2.5.5+dfsg-1.pgdg90+2

# Install OpenJDK-8 and PostGIS extention
RUN apt-get update \
      && apt-cache showpkg "postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR" \
      && apt-get install -y --no-install-recommends \
           openjdk-8-jdk=8u275-b01-1~deb9u1 \
           ant=1.9.9-1+deb9u1 \
           "postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR=$POSTGIS_VERSION" \
           "postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR-scripts=$POSTGIS_VERSION" \
      && rm -rf /var/lib/apt/lists/*

# Copy database setup files to work dir
RUN mkdir -p /docker-entrypoint-initdb.d

COPY ./initdb-postgis.sh /docker-entrypoint-initdb.d/10_postgis.sh
COPY ./update-postgis.sh /usr/local/bin
COPY ./entrypoint.sh /entrypoint.sh
COPY ./run-java.sh /run-java.sh

RUN ["chmod", "+x", "/entrypoint.sh"]
RUN ["chmod", "+x", "/run-java.sh"]

ENTRYPOINT ["/entrypoint.sh"]

CMD ["postgres"]