FROM ruby:2.5-alpine

ENV LANG C.UTF-8

WORKDIR /app

RUN set -x\
  && apk add --no-cache --update \
    libxml2-dev \
    libxslt-dev \
    libstdc++ \
    tzdata \
    nodejs \
    nodejs-npm \
    build-base \
    linux-headers \
    ca-certificates \
    postgresql-dev \
    mysql-client \
    mysql-dev \
    git \
    curl-dev \
  && gem install bundler rails\
  && npm install -g yarn

EXPOSE 3000
