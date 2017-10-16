FROM ubuntu

COPY unit-config /tmp

RUN apt-get update && \
    apt-get install -y curl && \
    curl https://nginx.org/keys/nginx_signing.key | apt-key add - && \
    echo "deb http://nginx.org/packages/mainline/ubuntu/ xenial nginx" >> /etc/apt/sources.list && \
    echo "deb-src http://nginx.org/packages/mainline/ubuntu/ xenial nginx " >> /etc/apt/sources.list && \
    apt-get update && apt-get install -y unit php7.0 libphp7.0-embed

COPY scripts /www

CMD ["/usr/sbin/unitd", "--no-daemon"]
# curl -X PUT -d @/tmp/php_config.json  --unix-socket /run/control.unit.sock http://localhost/
