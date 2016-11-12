FROM docker:1.12.1

MAINTAINER Andrey Kuzmin "kak-tus@mail.ru"

ENV EMAIL=

ENV CERTS_DIR=/etc/simp_le/
ENV LISTEN_PORT=9002
ENV SERVER_NAME=simp_le
ENV DOCKER_SIMP_LE_ARGS=
ENV DOCKER_RUN_SIMP_LE_ARGS=
ENV AUTO_CONF_D=/etc/simp_le-auto.d

COPY ["gen", "/etc/periodic/weekly/"]
COPY ["start", "/bin/start"]

RUN apk add --update-cache bash \

  && rm -rf /var/cache/apk/*

ENTRYPOINT ["start"]

