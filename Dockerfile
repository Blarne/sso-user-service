FROM alpine/git as clone
WORKDIR /app
RUN git clone https://github.com/Karumien/sso-user-service

FROM maven:3.5-jdk-8-alpine as build
WORKDIR /app
COPY --from=clone /app/sso-user-service /app
RUN mvn install

FROM openjdk:8-jre
WORKDIR /app
COPY --from=build /app/target/sso-user-service-1.0.0-SNAPSHOT.jar /app
ADD TestSSL.class /tmp
#ADD digcert.cer /etc/ssl/certs/
#RUN echo "yes" | $JAVA_HOME/bin/keytool -import -trustcacerts -file /etc/ssl/certs/digcert.cer -alias digcert-root-ca -keystore
EXPOSE 2205
ENTRYPOINT ["sh", "-c"]
CMD ["java -jar sso-user-service-1.0.0-SNAPSHOT.jar"]
