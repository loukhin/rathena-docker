FROM alpine:3.12.3 as build

ENV PACKETVER=20200304

RUN apk update \
    && apk add --no-cache coreutils util-linux git make gcc g++ mariadb-dev mariadb-connector-c-dev zlib-dev pcre-dev pcre libstdc++ dos2unix mariadb-client bind-tools linux-headers

RUN git clone https://github.com/rathena/rathena.git /opt/rathena \
    && cd /opt/rathena \
    && ./configure --enable-packetver=${PACKETVER} --with-mysql=/usr/bin/mariadb_config \
    && make clean \
    && make server \
    && chmod a+x login-server char-server map-server


FROM alpine:3.12.3

RUN addgroup -S rathena && adduser -S rathena -G rathena
COPY --chown=rathena:rathena --from=build /opt/rathena /opt/rathena

WORKDIR /opt/rathena
VOLUME /opt/rathena

COPY ./docker-entrypoint.sh /bin/
ENTRYPOINT [ "docker-entrypoint.sh" ]

EXPOSE 6900/tcp 6121/tcp 5121/tcp
