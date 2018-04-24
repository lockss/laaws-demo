# LAAWS Demo

## Introduction
The LAAWS Demo project aims to demonstrate the state of development of 
[various LAAWS components](#containers-started-by-docker-compose), and their integration into a unified LOCKSS system. 
The demo is configured (through its Docker Compsose file -- `docker-compose.yaml`) to instantiate versioned Docker
images that the LOCKSS team has built and released to the Docker Hub repository, instead of relying on images built and 
available only locally.

You may view the available Docker images on the [LOCKSS team's Docker Hub page](https://hub.docker.com/u/lockss/).

## Prerequistes

You must have Docker and Docker Compose installed. An installation guide is outside the scope of this document, but 
Docker has excellent [installation guides](https://docs.docker.com/engine/installation/) for various platforms.

To bring up the LAAWS Demo in a virtual machine, you must have Vagrant and VirtualBox installed. Please see 
[Vagrant's documentation](https://www.vagrantup.com/docs/installation/) for installation instructions.

# Running The Demo
The quickest way to bring up the demo is to invoke Docker Compose and run the containers specified in the provided 
Docker Compose file directly on the host system, however this will modify the state of the Docker engine. Further, 
Docker Compose is configured to map service ports to the host system, so that the services running in its containers are
accessible for debugging, but if a port is already in use, Docker will fail to start the container.

A list of the default ports used by each container is documented below in the 
[Container Hostnames And Ports](#container-hostnames-and-ports) section. 

The Docker Compose environment can alternatively be started within a virtual machine managed by Vagrant. This is 
significantly slower, since Vagrant has to spin up, configure a new virtual machine, and download Docker images per each
invocation, but avoids possible port collisions, and will not modify the state of Docker on the host system.

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
It controls which Docker images are instantiated, the command line arguments, the network links between containers, and
container to host networking and port mapping.

### LAAWS Demo Configuration
The LAAWS Demo is not configured to use a LOCKSS Props server. Instead, PLN and cluster -wide configuration is kept in 
the `config/laaws-demo.txt`. This file is shared among all LOCKSS services by passing it as a common configuration 
parameter to respective Docker containers in the Docker Compose environment.

Additionally, the LAAWS Demo starts up a LOCKSS Configuration Service. The location of the Configuration Service is also
provided to all LOCKSS services that can be configured to use one. The Configuration Service configuration and the 
configurations it serves is kept under `config/configuration-service`, and passed to the service using a command line
argument passed via the `command` directive in the `lockss-configuration-service` block of the Docker Compose file.

### Service Configuration
Each service can be individually configured by modifying its configuration under the `config/` directory. Any new 
configuration files must be passed to the service by modifying the `command` directive in container definition block in 
the Docker Compose file.

## Containers Started By Docker Compose
The following containers are started by the LAAWS Demo's Docker Compose environment (which is configured via the 
provided `docker-compose.yaml` file). The list of containers and a short description of each follows:

|Service Name|Description|
|:-------|:------|
|**laaws-demo-webui** |Contains an Nginx web server hosting the LAAWS Demo web user interface.|
|**lockss-configuration-service**|Contains an instance of the LOCKSS Configuration Service for use by other services.|
|**lockss-metadata-service**|Contains an instance of |


## Container Hostnames And Ports
The following hostnames and port maps are defined by the LAAWS Demo's Docker Compose file.

| Name                        | Port  |
|-----------------------------|-------|
| laaws-demo-webui            | 80    |
| lockss-configuration-service| 54420 |
| lockss-metadata-service     | 49520 | 
| lockss-metadataextractor    | 28120 |
| lockss-metadata-pgsql       | 5432  | 
| lockss-poller               | 25250 | 
| lockss-repository-service   | 32640 |

**Note:** Hostnames are only available within the Docker or Docker Compose contexts. To connect to a specific service 
from the host system, you must use `localhost` and that service's port. 

## FAQ

### 

# Support

Please contact LOCKSS Support by writing to [support@lockss.org](mailto:support@lockss.org).

