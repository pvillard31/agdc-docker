# we start from the latest image of PostgreSQL/PostGIS
FROM mdillon/postgis:latest
# author
MAINTAINER Pierre Villard <pierre.villard@capgemini.com>

# install wget and git
RUN apt-get update && apt-get install -y \
    wget \
    git \
    vim

# retrieve agdc code
RUN mkdir /root/datacube; \
    cd /root/datacube; \
    git clone https://github.com/pvillard31/agdc.git; \
    cd /root/datacube/agdc; \
    git checkout develop 

# download, install and configure flyway to update the agdc database
RUN mkdir /root/flyway; \
    cd /root/flyway; \
    wget https://bintray.com/artifact/download/business/maven/flyway-commandline-3.2.1-linux-x64.tar.gz; \
    tar -xvzf flyway-commandline-3.2.1-linux-x64.tar.gz; \
    rm -rf flyway-commandline-3.2.1-linux-x64.tar.gz; \
    cp /root/datacube/agdc/database/flyway-example.properties /root/flyway/flyway-3.2.1/conf/flyway.conf; 

# put the init script in the correct folder
RUN mkdir -p /docker-entrypoint-initdb.d
COPY ./v0_agdc.sh /docker-entrypoint-initdb.d/v0_agdc.sh

# prepare execution of flyway to update the database
RUN cp /root/datacube/agdc/database/sql/* /root/flyway/flyway-3.2.1/sql

# put the user database user creation script in the correct folder
COPY ./createUser.txt /tmp/createUser.txt

# END
