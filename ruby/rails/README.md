rails
---

# 概要
Ruby on Rails を使う時用のテンプレート

# How To Use
## Railsプロジェクトの作成
```
$ docker build -t railscmd ../railscmd/Dockerfile
$ docker run -it -v `pwd`:/app -w /app railscmd rails new myapp -d mysql
```

or

```
$ docker run -it -v `pwd`:/app -w /app railscmd rails new . -d mysql
```

### databaseの向き先の変更
`config/database.yml`
```diff
-  host: localhost
+  host: <%= ENV['DATABASE_HOST'] %>
```

## 起動
binding.pryを使用したいため、 `up` ではなく `run` で起動する
```bash
$ cd /path/to/your/app
$ docker-compose run --rm web bundle exec rails db:migrate
$ docker-compose run --service-ports web
```

## 停止
```
C-c
$ docker-compose down
```
