FROM alpine:3.13

RUN apk add openjdk8
COPY /target/cats-api-2.4.3.jar /app.jar

ENTRYPOINT ["java", "-jar", "/app.jar"]