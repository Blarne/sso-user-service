FROM alpine/git as clone
WORKDIR /app
RUN git clone https://github.com/Karumien/sso-user-service

FROM maven:3.6-openjdk-11-slim as build
WORKDIR /app
COPY --from=clone /app/sso-user-service /app
RUN mvn install

FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=build /app/target/sso-user-service-1.0.0-SNAPSHOT.jar /app
#ADD TestSSL.class /tmp
#ADD digcert.cer /etc/ssl/certs/
#RUN echo "yes" | $JAVA_HOME/bin/keytool -import -trustcacerts -file /etc/ssl/certs/digcert.cer -alias digcert-root-ca -keystore

RUN apt-get update; \
    apt-get install -y dnsutils; \
    apt-get install -y procps
#    echo "10.48.148.190 login-test.eurowag.com" >> /etc/hosts; \
#    echo "10.48.148.125 login-uat.eurowag.com" >> /etc/hosts

ADD start.sh /app
RUN chmod +x /app/start.sh

EXPOSE 2205
ENTRYPOINT ["sh", "-c"]

#CMD ["java -jar sso-user-service-1.0.0-SNAPSHOT.jar"]
CMD ["/app/start.sh"]
