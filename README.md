# Prerequistes

You must have Docker and Docker Compose installed. Docker has excellent [installation guides](https://docs.docker.com/engine/installation/) for various platforms.

# Building The Demo

Running the following command to build the demo:

    docker-compose build

# Running The Demo

Running the following command will build (if you did not run the command above) and run the set of Docker containers that are necessary for a working demo of LAAWS components:

    docker-compose up

# Port numbers

* laaws-demo: 80
* laaws-mdq: 8082
* laaws-mdx: 8083
* laaws-openwayback: 8080
* laaws-metadata-solr: 8983
* laaws-metadata-pgsql: 5432
* laaws-repo-solr: 8984
* laaws-repo-hdfs: 9000, 50010, 50020, 50070, 50075
* laaws-repo: 8700

