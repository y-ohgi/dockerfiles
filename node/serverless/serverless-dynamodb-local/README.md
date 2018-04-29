
# 概要
[99xt/serverless-dynamodb-local](https://github.com/99xt/serverless-dynamodb-local) 用Dockerfile

# e.g. docker-compose.yaml

```yaml
version: "3.2"

services:
  app:
    image: node:8.10
    volumes:
      - .:/app/
      - ~/.aws:/root/.aws
    working_dir: /app
    command: yarn run start
    # environment:
    #   SLS_DEBUG: DEBUG
    ports:
      - 3000:3000
    depends_on:
      - ddb-local

  ddb-local:
    image: yohgi/serverless-dynamodb-local:latest
    command: "--migrate --sharedDb --dbPath /dynamodb_local_db"
    ports:
      - 8000:8000
    volumes:
      - "./dynamodb_local_db:/dynamodb_local_db"
      - "./package.json:/opt/dynamodb-local/package.json"
      - "./serverless.yml:/opt/dynamodb-local/serverless.yml"
```
