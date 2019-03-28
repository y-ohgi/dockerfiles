FROM ruby:2.6.2-alpine

RUN apk add --no-cache gcc make sqlite-dev libc-dev \
  && gem install hotdog

ENTRYPOINT ["hotdog"]

# docker run -e DATADOG_API_KEY=<YOUR API KEY> -e DATADOG_APPLICATION_KEY=<YOUR APP KEY> hd ls -hl
