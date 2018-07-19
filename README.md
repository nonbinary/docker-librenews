# docker-librenews

Unofficial server image for Librenews app - Live breaking news notifications. Secure, private, and decentralized.

More information on the software is at https://librenews.io

Currently in alpha mode

Docker image is located at https://hub.docker.com/r/nonbinary/librenews/

Usage:

Edit the config.json file according to instructions from librenews: https://github.com/milesmcc/LibreNews-Server#3-librenews-server-operator-documentation
Currently the image uses an external Mongodb image, address supplied with environment variables.
Below is a sample docker-compose setup:

    version '3'
    services:
        librenews:
            image: nonbinary/librenews
            volumes:
                - librenews:/code
            ports:
                - 8888:8888
            environment:
                - MONGODB_HOST=mongo-server
                - MONGODB_PORT=27017
            networks:
                - mongodb
        mongodb:
            image: mongo:latest
            container_name: mongo-server
            networks:
                - mongodb
