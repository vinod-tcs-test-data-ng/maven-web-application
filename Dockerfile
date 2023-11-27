FROM ubuntu:latest

#update
RUN apt-get update && apt-get install -y wget

#Install Java
RUN apt-get install -y default-jdk

#Environment Variables
ENV TOMCAT_VERSION 9.0.59
ENV CATALINA_HOME /opt/tomcat

#Working Directory
WORKDIR $CATALINA_HOME

# Download and install Tomcat
RUN wget https://archive.apache.org/dist/tomcat/tomcat-9/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz -O /tmp/tomcat.tar.gz
RUN mkdir -p ${CATALINA_HOME}
RUN tar xfz /tmp/tomcat.tar.gz -C ${CATALINA_HOME} --strip-components=1 


COPY target/maven-web-application.war /opt/tomcat/webapps/maven-web-application.war


EXPOSE 8080

#startTomcat
CMD ["/opt/tomcat/bin/catalina.sh", "run"]

