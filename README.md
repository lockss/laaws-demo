# LAAWS Dev/Demo Environment

## Introduction

The `laaws-demo` project provides a development and demonstration environment
for the LAAWS (LOCKSS Architected As Web Services) components of the LOCKSS
software. The dev/demo environment consists of three main groups of components:

*   Support components. This includes a Hadoop HDFS cluster, a Solr database and
    a Postgres database. These support components run from Docker containers. 
*   LAAWS components. This includes the Repository, Configuration, Metadata
    Docker instances, or from Maven JAR files which come from either Maven
    Central, Sonatype OSSRH, or a local Maven Central repository.
*   Auxiliary components. This includes Pywb and OpenWayback replayers and a
    Solr-based text indexer. These components run from Docker containers.

## Pre-Requisites

For all running modes:

*   Docker (Docker has [installation guides](https://docs.docker.com/install/)
    for various platforms.)
*   Docker Compose

If running the LAAWS components in JAR mode:

*   Java 8
*   Maven

If you have not already done so, clone this Git repository
(`git clone git@github.com:lockss/laaws-demo`) and run commands from its
top-level directory.

### Using a Demo Props Server

The LOCKSS Team maintains a demo props server with a few LOCKSS plugins and
suitable title database entries, for use with the dev/demo environment. To use
this demo props server, use
`--props-url=http://props.lockss.org:8001/demo/lockss.xml` as the value of
`${PROPSOPTS}` below.

## Bringing up the Dev/Demo Environment

### Docker Mode

If necessary, start Docker (e.g. `sudo systemctl start docker`). Check that
Docker is running with `docker info`.

*   Bring up the Repository service and its dependencies:
    
    ```
    scripts/run-with-docker ${PROPSOPTS} --detach lockss-repository-service
    ```
*   Bring up the Configuration service:
    
    ```
    scripts/run-with-docker ${PROPSOPTS} -d lockss-configuration-service
    ```
*   Bring up one or more of the other components and their dependencies, as
    desired (optionally combined into a single command):
    
    ```
    scripts/run-with-docker ${PROPSOPTS} --detach lockss-poller-service
    scripts/run-with-docker ${PROPSOPTS} --detach lockss-metadata-extraction-service
    scripts/run-with-docker ${PROPSOPTS} --detach lockss-metadata-service
    scripts/run-with-docker ${PROPSOPTS} --detach laaws-pywb
    scripts/run-with-docker ${PROPSOPTS} --detach laaws-openwayback
    scripts/run-with-docker ${PROPSOPTS} --detach laaws-edina-indexer
    ```

### JAR Mode

If necessary, start Docker (e.g. `sudo systemctl start docker`). Check that
Docker is running with `docker info`.

*   `scripts/run-with-jars ${PROPSOPTS}` will bring up every component in the
    dev/demo environment.
*   Otherwise, you can pass one or more component names to start the desired
    components and their dependencies (optionally combined into a single
    command):
    
    ```
    scripts/run-with-jars ${PROPSOPTS} lockss-poller-service
    scripts/run-with-jars ${PROPSOPTS} lockss-metadata-extraction-service
    scripts/run-with-jars ${PROPSOPTS} lockss-metadata-service
    scripts/run-with-jars ${PROPSOPTS} laaws-pywb
    scripts/run-with-jars ${PROPSOPTS} laaws-openwayback
    scripts/run-with-jars ${PROPSOPTS} laaws-edina-indexer
    ```

## Using the Dev/Demo Environment

### Ports

Whether in Docker mode or in JAR mode, you can connect to various ports on
`localhost` to interact with components:

| Component                   | Name                               | REST port | Web UI port |
|-----------------------------|------------------------------------|-----------|-------------|
| Repository service          | lockss-repository-service          | 32640     | n/a         |
| Configuration service       | lockss-configuration-service       | 54420     | 54421       |
| Metadata Extraction service | lockss-metadata-extraction-service | 28120     | 28121       |
| Metadata service            | lockss-metadata-service            | 49520     | 49521       | 
| Poller service              | lockss-poller                      | 25250     | 25251       | 
| Pywb Replay                 | laaws-pywb                         | n/a       | 8080        |
| OpenWayback Replay          | laaws-openwayback                  | n/a       | 8000        |

For those components that have a REST port, a Swagger UI is also running under
the path `/swagger-ui.html`, e.g. `http://localhost:32640/swagger-ui.html` for
the Repository service.

The LAAWS components are running a "classic" LOCKSS Web UI at the indicated
port, with the example username/password `lockss-u`/`lockss-p`.

The OpenWayback instance can be accessed at `http://localhost:8000/wayback/`. 

### Roles

By default, the Configuration service is configured to crawl remote plugin
registries on behalf of the cluster, and to act as a JMS broker for the cluster.
(JMS is a Java component used for inter-process communication.)

Although this could be done with any component, by default the Poller service is
configured to act as a crawler (except for remote plugin registries), so it is
the component to which you would add archival units (AUs) to be collected as you
might with a "classic" standalone LOCKSS daemon.

### Logs

In Docker mode, the logs for the LAAWS components are found at
`logs/${component}/app.log`.

To see the Docker logging for a Docker-bound component, use this command:

```
scripts/param-docker-compose logs ${component}
```

Use `... logs --follow ...` to keep tailing the log. Use
`... logs --no-color ...` if piping the output to a command or redirecting to a
file.

## Configuration

The dev/demo environment is configured via the `config/` tree of files. In most
directories, a given file `foo.ext` might be accompanied by `foo.docker.ext`
and `foo.jars.ext` is there is variant configuration for Docker mode or JAR
mode. Furthermore, in many cases if there is a file `foo.txt`, you can create
a customization file `foo.opt`, that is ignored by Git. In other words, you
should not edit the `.txt` files, and instead consider them as a baseline to be
customized in `.opt` files.

The `config/conf/` directory contains top-level parameterization for the
entire dev/demo environment.

The `config/cluster/` directory contains configuration for the dev/demo LOCKSS
cluster.

The `config/host/` directory is currently empty. In an environment where the
components of the cluster are run on more than one host, there would be a
(family of) configuration files that might apply to a whole host without
applying to the whole cluster, and this `config/host/` directory is used to
illustrate this (in this case on the single host where the dev/demo environment
is running).

The `config/plugins/` and `config/tdbxml/` directories are used when a local
props server is in use (as opposed to the demo props server). (TODO: document
this.)

Each component also has a `config/` subdirectory where configuration information
is found.

## Support

Please contact LOCKSS Support by writing to `lockss-support (at) lockss (dot) org`
for questions and help.
