FROM node:10.13-alpine

ENV NUXT_HOST=0.0.0.0

WORKDIR /app

COPY package.json package-lock.json /app/

RUN set -x \
  && npm install --production \
  && npm run build

COPY . .

EXPOSE 3000

CMD ["npm", "run", "start"]
