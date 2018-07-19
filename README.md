# docker-librenews

Unofficial server image for Librenews app - Live breaking news notifications. Secure, private, and decentralized.

More information on the software is at https://librenews.io

Currently in beta mode

Usage:

* Start image, preferrably setting a volume at /code.  
* Edit the `/code/src/config.json` file according to instructions from librenews: https://github.com/milesmcc/LibreNews-Server#3-librenews-server-operator-documentation
* Set up a web proxy with https. For ease of use, we can recommend using jwilder's nginx-proxy (https://hub.docker.com/r/jwilder/nginx-proxy, along with its letsencrypt companion image.

API keys can be set using the following environment variables:

    TWITTER_ACCESS_TOKEN
    TWITTER_ACCESS_TOKEN_SECRET
    TWITTER_CONSUMER_KEY
    TWITTER_CONSUMER_SECRET
    VAPID_PRIVATE_KEY
    VAPID_PUBLIC_KEY


Twitter API keys needs to be fetched from https://apps.twitter.com   
Vapid keys needs to be created, but information on that process needs to be found using search engines etc.

After this information has been supplied, accounts needs to be added to `/code/src/config.json`, and the image needs to be restarted with the new information.
