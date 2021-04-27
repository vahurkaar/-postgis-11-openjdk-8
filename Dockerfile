FROM mdillon/postgis:11-alpine

VOLUME /tmp

# Install OpenJDK-8
RUN apk update
RUN apk fetch openjdk8
RUN apk add openjdk8
ENV JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk
ENV PATH="$JAVA_HOME/bin:${PATH}"

# Copy database setup files to work dir
RUN mkdir -p /docker-entrypoint-initdb.d

COPY ./entrypoint.sh /entrypoint.sh
COPY ./run-java.sh /run-java.sh

RUN ["chmod", "+x", "/entrypoint.sh"]
RUN ["chmod", "+x", "/run-java.sh"]

ENTRYPOINT ["/entrypoint.sh"]

CMD ["postgres"]

EXPOSE 5432
