# Introduction
The LAAWS Demo project aims to demonstrate the state of development of various LAAWS components, and their integration 
into a unified LOCKSS system. The demo is configured (through its `docker-compose.yaml` file) to instantiate versioned 
Docker images that the LOCKSS team has built and released to the Docker Hub image repository. 

You may view the available images here: https://hub.docker.com/u/lockss/

## Prerequistes

You must have Docker and Docker Compose installed. An installation guide is outside the scope of this document, but 
Docker has excellent [installation guides](https://docs.docker.com/engine/installation/) for various platforms.

# Running The Demo

## With Docker Compose

1. Clone this project, if you have not already done so:

    git clone https://github.com/lockss/laaws-demo.git

1. In the root of the `laaws-demo` project, run the following command:

    docker-compose up
    
# Technical Documentation

## Hostname and ports
Docue

| Name | Port |
|------|------|
| laaws-demo | 80 |

## Docker Compose Components
* laaws-demo: 80
* laaws-mdq: 8082
* laaws-mdx: 8083
* laaws-openwayback: 8080
* laaws-metadata-solr: 8983
* laaws-metadata-pgsql: 5432
* laaws-repo-solr: 8984
* laaws-repo-hdfs: 9000, 50010, 50020, 50070, 50075
* laaws-repo: 8700

