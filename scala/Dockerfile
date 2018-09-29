FROM openjdk:8-jdk-alpine

WORKDIR /opt/app
ADD target/scala-2.12/Hello-assembly-0.1.0-SNAPSHOT.jar app.jar

RUN addgroup -g 1000 scala &&\
    adduser -u 1000 -H -D -G scala scala &&\
    chown -R scala:scala /opt/app/public

USER scala
EXPOSE 8080

CMD ["java", "-jar", "app.jar"]
