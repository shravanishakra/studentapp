#taking base image ubuntu version-22.04
FROM ubuntu:22.04

#LABEL are use for tagging
LABEL DEV="amit"

#installing dependancies java and unzip
RUN apt-get update -y && \
    apt-get install unzip openjdk-11-jdk -y

#downloading apache tomcat from internet 
ADD https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.111/bin/apache-tomcat-9.0.111.zip /opt/

#changing the working directory
WORKDIR /opt/

#now unzip the apache tomcat server installation file
RUN unzip apache-tomcat-9.0.111.zip

#copying the context.xml file from local to /conf folder
COPY context.xml apache-tomcat-9.0.111/conf/
#adding war and sql connector file to apache directory
ADD https://s3-us-west-2.amazonaws.com/studentapi-cit/student.war /opt/apache-tomcat-9.0.111/webapps/student.war
ADD https://s3-us-west-2.amazonaws.com/studentapi-cit/mysql-connector.jar /opt/apache-tomcat-9.0.111/lib/mysql-connector.jar
#give access to catalina.sh file to run
RUN chmod +x /opt/apache-tomcat-9.0.111/bin/catalina.sh

#exposing the image on port 8080
EXPOSE 8080

#command for running the container process
CMD ["/opt/apache-tomcat-9.0.111/bin/catalina.sh","run"]