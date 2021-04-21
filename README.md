# postgis-11-openjdk-8
PostgreSQL 11.2 Docker image with installed PostGIS extension and OpenJDK 8

Running as a standalone PostGIS service (with out a Java Application)
```
docker run --name postgis -d -p 5432:5432 -e POSTGRES_DB=gis -e POSTGRES_USER=gis -e POSTGRES_PASSWORD=gis vahurkaar/postgis-11-openjdk-8:latest
```

Running PostGIS with an additional Java application (example Dockerfile):

```
FROM vahurkaar/postgis-11-openjdk-8:latest

VOLUME /tmp

ARG JAR_FILE=application.jar # Path to your JAR file

COPY ./schema.sql /docker-entrypoint-initdb.d/11_schema.sql
COPY ./data.sql /docker-entrypoint-initdb.d/12_data.sql

COPY ${JAR_FILE} /app.jar

EXPOSE 8080 # Expose any necessary ports 

```