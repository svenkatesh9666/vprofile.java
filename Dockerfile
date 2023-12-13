FROM openjdk:8 as BUILD_IMAGE
RUN apt update && apt install maven -y
RUN git clone https://github.com/svenkatesh9666/vprofile.java.git
WORKDIR /app
RUN cd /app && mvn install



FROM tomcat:8-jre11

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=BUILD_IMAGE /app/target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]


