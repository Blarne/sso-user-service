#!/bin/bash

echo "10.48.148.190 login-test.eurowag.com" >> /etc/hosts
echo "10.48.148.125 login-uat.eurowag.com" >> /etc/hosts

java -jar sso-user-service-1.0.0-SNAPSHOT.jar
