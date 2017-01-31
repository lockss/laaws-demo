FROM ubuntu:latest

MAINTAINER "Daniel Vargas" <dlvargas@stanford.edu>

# Set LANG (needed for msginit -- called by lockss-daemon build.xml)
ENV LANG en_US.UTF-8
RUN locale-gen ${LANG}

# Install build tools
RUN apt-get update
RUN apt-get -y install git subversion ant gettext openjdk-8-jdk-headless maven

# Get laaws-mdq source 
RUN git clone https://gitlab.lockss.org/laaws/laaws-metadataservice.git --recursive

# Build LOCKSS daemon JARs
WORKDIR /laaws-mdq
RUN ./initBuild

# XXX Isolate only what's needed to run
#RUN mkdir /laaws-mdq
#RUN mv target /laaws-mdq
#RUN mv runLaawsmdq /laaws-mdq
#RUN mv src /laaws-mdq

# XXX Clean up 
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
#RUN rm -rf ~/.m2 ~/.subversion

# XXX Ask fergaloy to fix
RUN mkdir logs
RUN touch logs/laawsmdq.log

# XXX Overlay needed for demo
ADD lockss.opt /laaws-mdq

CMD ["/bin/sh", "/laaws-mdq/runLaawsMdq"]
