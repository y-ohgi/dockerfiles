
# About
docker-compose間でnetwork共有のテスト用ディレクトリ

# Usage
1. nginxの起動
2. pythonのhttpサーバの起動
3. pythonサーバへアクセス

## 1. nginxの起動
```
$ cd nginx
$ docker-compose up
```

## 2. pythonのhttpサーバの起動
```
$ cd python
$ docker-compose up
```

## 3. pythonサーバへアクセス
[http://localhost:8000/cgi-bin/main.py](http://localhost:8000/cgi-bin/main.py)
