# Let's encrypt simpl_le docker container with automated certificates renewal

Based on [Let's Encrypt](https://letsencrypt.org), [simp_le](https://github.com/kuba/simp_le), [simp_le Docker container](https://github.com/m3adow/docker-letsencrypt-simp_le).

## Setup

To automated renewal you need, that container will be accessible at domain, which will be certificate get.

If you use nginx (in docker or native) it is simple

```
server {
  server_name example.com;

  location /.well-known/acme-challenge/ {
    proxy_pass http://127.0.0.1:9002;
  }
}

```

In multi-frontend environment, you need to specify exactly ip or host of docker server with container

```
proxy_pass http://<ip or hostname of docker server with container>:9002;
```

If you are using consul DNS it is simple

```
proxy_pass http://simp_le.service.consul:9002;
```

## Run

```
docker run -itd -e "EMAIL=mail@example.com" -e "DOMAIN=example.com" -e "RESTART=nginx" -v /var/run/docker.sock:/var/run/docker.sock -v /etc/simp_le/:/etc/simp_le/ kaktuss/letsencrypt-simp_le-auto
```

Here

EMAIL environment variable is Let's Encrypt account email.

DOMAIN is domain for which you will be generate certificate.

RESTART is a container name, which you want to restart if certificates will be regenerated.

Certificates will be saved in /etc/simp_le/ with domain-specific names.

```
cert_example.com.pem   chain_example.com.pem   key_example.com.pem
```

## Extended confiruration with environment variables

CERTS_DIR=/etc/simp_le/ - if you change certificates location, you need also change "-v" option that point to new location.

LISTEN_PORT=9002 - port, in which simp_le container will be listen verification requests.

SERVER_NAME=simp_le - name of container, to proxy_pass trow nginx, if you are using consul DNS.

## Multi-domain certificate generation

Container support multi-domain certificate generation. You need to list comma separated domain names.

```
DOMAIN=example.com,www.example.com
```

## Restart multiplie containers

Comma separated list.

```
RESTART=nginx1,nginx2
```


## Multi-certificate generation

You can generate different certificates for different domains. ";" separated list.

```
DOMAIN=example.com,www.example.com;example2.com
```

Also you can use different containers to restart for different domain names. ";" separated list.

```
RESTART=nginx1,nginx2;nginx_for_example2.com
```
