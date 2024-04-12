FROM centos:latest
RUN yum install java -y
RUN mkdir /opt/tomcat
WORKDIR /opr/tomcat
ADD https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.87/bin/apache-tomcat-9.0.87.tar.gz
RUN tar -xvzf apache-tomcat-9.0.87.tar.gz
RUN mv apache-tomcat-9.0.87/* /opt/tomcat
EXPOSE 8080
CMD ["/opt/tomcat/apache-tomcat-9.0.87/bin/catalina.sh", "run"]


Docker file for install git java docker 

FROM ubuntu:latest
RUN mkdir /opt/software
WORKDIR /op/software
RUN apt install git -y 
RUN apt java -y
RUN apt docker -y 
CMD ["systemctl start docker", "run"]
CMD ["systemctl enable docker", "run"
