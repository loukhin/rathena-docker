FROM alpine:3.12.3

ENV PACKETVER=20200304

RUN addgroup -S rathena && adduser -S rathena -G rathena
RUN mkdir -p /opt/src/rathena \
    && apk update \
    && apk add --no-cache bash coreutils util-linux git make gcc g++ mariadb-dev mariadb-connector-c-dev zlib-dev pcre-dev pcre libstdc++ dos2unix mariadb-client bind-tools linux-headers \
    && git clone https://github.com/rathena/rathena.git /opt/src/rathena \
    && cd /opt/src/rathena \
    && ./configure --enable-packetver=${PACKETVER} --with-mysql=/usr/bin/mariadb_config \
    && make clean \
    && make server \
    && chmod a+x login-server && chmod a+x char-server && chmod a+x map-server \
    && chown -R rathena /opt/src/rathena \
    && apk del git make gcc g++ mariadb-dev zlib-dev pcre-dev

WORKDIR /opt/rathena
VOLUME /opt/rathena

COPY ./docker-entrypoint.sh /bin/
ENTRYPOINT [ "docker-entrypoint.sh" ]

EXPOSE 6900/tcp 6121/tcp 5121/tcp

CMD [ "/opt/rathena/athena-start", "watch" ]
