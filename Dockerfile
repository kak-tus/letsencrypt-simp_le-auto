FROM alpine:3.4

MAINTAINER Andrey Kuzmin "kak-tus@mail.ru"

ENV EMAIL=

ENV DOCKER_VERSION=latest
ENV CERTS_DIR=/etc/simp_le/
ENV LISTEN_PORT=9002
ENV SERVER_NAME=simp_le

COPY ["gen", "/etc/periodic/weekly/"]
COPY ["start", "/bin/start"]

RUN apk add --update-cache curl bash \
  && curl -sSL https://get.docker.com/builds/Linux/x86_64/docker-$DOCKER_VERSION -o /usr/bin/docker \
  && chmod +x /usr/bin/docker \
  && apk del curl && rm -rf /var/cache/apk/* \
  && chmod +x /etc/periodic/weekly/gen

ENTRYPOINT ["start"]

