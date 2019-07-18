FROM alpine/git as clone
WORKDIR /app
RUN git clone https://github.com/Karumien/sso-user-service

FROM maven:3.5-jdk-8-alpine as build
WORKDIR /app
COPY --from=clone /app/sso-user-service /app
RUN mvn install

FROM openjdk:8-jre-alpine
WORKDIR /app
COPY --from=build /app/target/sso-user-service-1.0.0-SNAPSHOT.jar /app
EXPOSE 2205
ENTRYPOINT ["sh", "-c"]
CMD ["java -jar sso-user-service-1.0.0-SNAPSHOT.jar"]
