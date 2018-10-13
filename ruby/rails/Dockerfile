FROM ruby:2.5.1-alpine

ARG UID=501

ENV LANG C.UTF-8

WORKDIR /app
COPY . .

RUN set -x\
  && apk add --no-cache --update \
    libxml2-dev \
    libxslt-dev \
    libstdc++ \
    tzdata \
    nodejs \
    build-base \
    linux-headers \
    ca-certificates \
    mysql-client \
    mysql-dev \
    less \
  && gem install bundler \
  && bundle install --jobs=4\
  && addgroup app \
  && adduser -h /app -s /bin/sh -D -G app -u ${UID} app \
  && chown -R app:app /app

USER app

EXPOSE 3000
