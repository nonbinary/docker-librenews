FROM python:2.7.15-stretch
RUN apt-get update
RUN apt-get -y install git

# TODO: make it possible to run mongodb locally
#install lmongodb
#RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4; \
    #echo "deb http://repo.mongodb.org/apt/debian stretch/mongodb-org/4.0 main" > /etc/apt/sources.list.d/mongodb.list; \
    #apt-get update; \
    #apt-get install -y mongodb-org

# run mongodb
#RUN mkdir -p /data/db

# Expose the default port
#EXPOSE 27017

# Default port to execute the entrypoint (MongoDB)
# CMD ["--port 27017"]
#CMD ["--port 27017", "--smallfiles"]
# Set default container command
#RUN usr/bin/mongod --port 27017 --smallfiles

RUN git clone https://github.com/milesmcc/LibreNews-Server /code
WORKDIR /code/src
RUN pip install -r /code/requirements.txt
RUN pip install pytz pycountry humanize python-geoip-geolite2 geoip
ADD ./config.json /code/src/config.json

# temporary hack to accept external mongodb server
RUN sed -i 's/client\ =\ MongoClient()/import os\nclient = MongoClient(os.environ["MONGODB_HOST"], int(os.environ["MONGODB_PORT"]))/' /code/src/push.py

ENTRYPOINT ["python", "-u", "/code/src/webserver.py"]
