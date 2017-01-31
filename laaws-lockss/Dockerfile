FROM centos:latest

MAINTAINER "Daniel Vargas" <dlvargas@stanford.edu>

RUN yum -y -q update && yum clean all

# Install LOCKSS
ADD src/lockss.repo /etc/yum.repos.d
RUN rpm --import http://www.lockss.org/LOCKSS-GPG-RPM-KEY
RUN yum -y -q install lockss-daemon java-1.7.0-openjdk

# Add a link to the LOCKSS configuration files
#RUN ln -s /opt/lockss/config.dat /etc/lockss/config.dat
ADD lockss/config.dat /etc/lockss/config.dat

# Add files to the container
ADD src/motd /etc/motd
ADD src/start-lockss.sh /
ADD src/local.txt /home/lockss/local.txt

# Change the execute bit on the startup script
RUN chmod 755 /start-lockss.sh

# Declare an external volume
VOLUME ["/cache0"]

# LOCKSS LCAP and Administrative WebUI ports
EXPOSE 9729 8080-8086

# Set the default command to run 
CMD ["/start-lockss.sh"]
