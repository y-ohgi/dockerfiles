FROM node:14-alpine

ENV NUXT_HOST=0.0.0.0

WORKDIR /app

COPY package.json package-lock.json /app/

RUN set -x \
  && apk add --no-cache --virtual .gyp python make g++ \
  && npm install

COPY . .

RUN npm run build

EXPOSE 3000

CMD ["npm", "run", "start"]
