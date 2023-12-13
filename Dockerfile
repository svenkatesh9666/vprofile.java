FROM ubuntu:22.04
RUN apt-get -y update
RUN apt-get -y install openjdk-17-jdk wget
RUN wget https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.55/bin/apache-tomcat-8.5.55.tar. gz -o /tmp/tomcat.tar.gz
RUN cd /tmp && tar xvfz tomcat.tar.gz
RUN mv /tmp/apache-tomcat-8.5.55 /opt/tomcat
COPY vprofile-v2.war /opt/tomcat/webapps/
COPY tomcat-users.xml /opt/tomcat/conf/
EXPOSE 8080
CMD  /opt/tomcat/bin/catalina.sh run
