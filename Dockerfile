#build
FROM maven AS builder

WORKDIR /app

COPY . .

CMD [ "mvn clean package", "run" ]

#depolyment to tomcat
FROM tomcat

RUN cp -r /usr/local/tomcat/webapps.dist/* /usr/local/tomcat/webapps/


COPY --from=builder /app/webapp/target/*.war /usr/local/tomcat/webapps/

#for documentation purpose
EXPOSE 8080

CMD ["catalina.sh", "run"]