FROM httpd:latest

MAINTAINER "Daniel Vargas" <dlvargas@stanford.edu>

EXPOSE 8001

# Add static httpd documents
ADD htdocs htdocs

# Add Apache configuration files
ADD conf/httpd.local.conf conf
RUN echo "include conf/httpd.local.conf" >> conf/httpd.conf