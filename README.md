# LAAWS Demo

## Introduction
The LAAWS Demo project aims to demonstrate the state of development of 
[various LAAWS components](#containers-started-by-docker-compose), and their integration into a unified LOCKSS system. 
The demo is configured (through its `docker-compose.yaml` file) to instantiate versioned Docker images that the LOCKSS 
team has built and released to the Docker Hub image repository, instead of relying on images built and available 
locally.

You may view the available images at [the LOCKSS Program's Docker Hub page](https://hub.docker.com/u/lockss/).

## Prerequistes

You must have Docker and Docker Compose installed. An installation guide is outside the scope of this document, but 
Docker has excellent [installation guides](https://docs.docker.com/engine/installation/) for various platforms.

# Running The Demo
The quickest way to bring up the demo is to invoke Docker Compose and run the containers specified in the provided 
Docker Compose file directly on the host system. Docker Compose is configured to map service ports to the host system, 
so that the services running in containers are accessible for debugging, etc. *If a port is already in use, Docker will
fail to start the respective container!*

A list of the default ports used by each container is documented below in the 
[Container hostnames and ports](#container-hostnames-and-ports) section. 

If port collisions are an issue, the Docker Compose environment can be started within a virtual machine managed by 
Vagrant. This is significantly slower, since Vagrant has to spin up and configure a new virtual machine per invocation.

## With Docker Compose

1. Clone this project, if you have not already done so:

    ```bash
    git clone https://github.com/lockss/laaws-demo.git
    ```

2. In the root of the `laaws-demo` project, run the following command:

    ```bash
    docker-compose up
    ```
    
3. Point your web browser to http://localhost/ to access the LAAWS Demo web user interface.
    

## With Vagrant

1. Clone this project, if you have not already done so:

    ```bash
    git clone https://github.com/lockss/laaws-demo.git
    ```
    
2. In the `laaws-demo/vagrant` directory, run the following command:

    ```bash
    vagrant up
    ```
    
3. Point your web browser to http://laaws-demo/ to access the LAAWS Demo web user interface.


# Technical Documentation 

## Configuration

### Docker Compose Environment
The Docker Compose environment is configured by the `docker-compose.yaml` file in the root of the `laaws-demo` project.
It controls which Docker containers are started, the command line arguments, the network links between containers, and
container to host networking and port mapping.

### LAAWS Demo Environment
The LAAWS Demo is not configured to use a LOCKSS Props server. Instead PLN and cluster -wide configuration is kept in 
the `config/laaws-demo.txt`. This file is shared among all LOCKSS services by passing it as a common configuration 
parameter to respective Docker containers in the Docker Compose environment.

Additionally, the LAAWS Demo starts up a LOCKSS Configuration Service. The location of which is also passed to all LOCKSS services which 
can be configured to use it. The Configuration Service configuration and the configuration it serves is kept under 
`config/configuration-service`.

### Service Environments 
Each service can be individually configured

## Containers started by Docker Compose
The following containers are started by the LAAWS Demo's Docker Compose environment. The list of containers started by 
the environment are controlled by the `docker-compose.yaml` file. The list of containers and a short description of each
follows:

|Service|Description|
|-------|------|
|**laaws-demo-webui:** |Contains an Nginx web server hosting the LAAWS Demo web user interface, which allows users to 
exercise |

## Container hostnames and ports
| Name                        | Port  |
|-----------------------------|-------|
| laaws-demo-webui            | 80    |
| lockss-configuration-service| 54420 |
| lockss-metadata-service     | 49520 | 
| lockss-metadataextractor    | 28120 |
| lockss-metadata-pgsql       | 5432  | 
| lockss-poller               | 25250 | 
| lockss-repository-service   | 32640 |
