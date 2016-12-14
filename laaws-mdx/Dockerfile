FROM ubuntu:latest

MAINTAINER "Daniel Vargas" <dlvargas@stanford.edu>

# Set LANG (needed for msginit -- called by lockss-daemon build.xml)
ENV LANG en_US.UTF-8
RUN locale-gen ${LANG}

# Install build tools
RUN apt-get update
RUN apt-get -y install git subversion ant gettext openjdk-8-jdk-headless maven

# Get laaws-mdx source 
RUN git clone https://github.com/lockss/laaws-mdx.git --recursive

# Build LOCKSS daemon JARs
WORKDIR /laaws-mdx
RUN ./initBuild

# XXX Isolate only what's needed to run
#RUN mkdir /laaws-mdx
#RUN mv target /laaws-mdx
#RUN mv runLaawsmdx /laaws-mdx
#RUN mv src /laaws-mdx

# XXX Clean up 
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
#RUN rm -rf ~/.m2 ~/.subversion

# XXX Ask fergaloy to fix
RUN mkdir logs
RUN touch logs/laawsmdx.log

CMD ["/bin/sh", "/laaws-mdx/runLaawsMdx"]
