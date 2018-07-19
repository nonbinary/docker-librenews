FROM python:2.7.15-stretch
RUN apt-get update && apt-get dist-upgrade -y

RUN apt-get -y install git

#install lmongodb
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4; \
    echo "deb http://repo.mongodb.org/apt/debian stretch/mongodb-org/4.0 main" > /etc/apt/sources.list.d/mongodb.list; \
    apt-get update; \
    apt-get install -y mongodb-org
# run mongodb
RUN mkdir -p /data/db
# Expose the default port
#EXPOSE 27017

# install supervisord
RUN apt-get install -y supervisor
RUN git clone https://github.com/milesmcc/LibreNews-Server /code
WORKDIR /code/src
RUN pip install -r /code/requirements.txt
RUN pip install pytz pycountry humanize python-geoip-geolite2 geoip
ADD ./docker-entrypoint.sh /docker-entrypoint.sh
ADD ./supervisord.conf /etc/supervisord.conf
RUN chmod +x /docker-entrypoint.sh

# temporary hack to accept external mongodb server
#RUN sed -i 's/client\ =\ MongoClient()/import os\nclient = MongoClient(os.environ["MONGODB_HOST"], int(os.environ["MONGODB_PORT"]))/' /code/src/push.py

CMD ["/docker-entrypoint.sh"]
