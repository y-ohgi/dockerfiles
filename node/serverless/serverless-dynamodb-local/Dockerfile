FROM node:8.10

WORKDIR /opt/dynamodb-local/

COPY ./serverless.yaml serverless.yaml
COPY ./package.json package.json

RUN apt update && \
    apt install -y default-jre && \
    npm install -g serverless && \
    yarn install && \
    sls dynamodb install && \
    mkdir /dynamodb_local_db

EXPOSE 8000

ENTRYPOINT ["sls", "dynamodb", "start", "--port", "8000"]
CMD ["--dbPath", "/dynamodb_local_db"]