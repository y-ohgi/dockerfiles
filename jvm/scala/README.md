scala用Dockerfile
---

https://github.com/sbt/sbt-assembly

```
$ sbt assembly
$ docker build -t scala-app .
$ docker run -p 8080:8080 scala-app
```
