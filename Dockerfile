#build
FROM maven:3.8.6-openjdk-11 AS builder

WORKDIR /app

COPY . .

RUN mvn clean package

#depolyment to tomcat
FROM tomcat

RUN cp -r /usr/local/tomcat/webapps.dist/* /usr/local/tomcat/webapps/


COPY --from=builder /app/webapp/target/*.war /usr/local/tomcat/webapps/

#for documentation purpose
EXPOSE 8080

CMD ["catalina.sh", "run"]