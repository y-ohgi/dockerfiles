AmazonLinux2
---

# 概要
普段使い用。

# How to use
```
$ docker build -t amz-common .
$ docker run -it amz-common bash
```

# publish
```
$ docker build .
$ docker tag ${hash} yohgi/amz-common
$ docker push yohgi/amz-common
```

# 参考
* [library/amazonlinux - Docker Hub](https://hub.docker.com/r/library/amazonlinux/)
