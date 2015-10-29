# we start from the latest image of PostgreSQL/PostGIS
FROM mdillon/postgis:latest
# author
MAINTAINER Pierre Villard <pierre.villard@capgemini.com>

RUN apt-get update && apt-get install -y \
    wget \
    git

RUN mkdir /root/datacube; \
    cd /root/datacube; \
    git clone https://github.com/pvillard31/agdc.git; \
    cd /root/datacube/agdc; \
    git checkout develop

RUN mkdir /root/flyway; \
    cd /root/flyway; \
    wget https://bintray.com/artifact/download/business/maven/flyway-commandline-3.2.1-linux-x64.tar.gz; \
    tar -xvzf flyway-commandline-3.2.1-linux-x64.tar.gz; \
    rm -rf flyway-commandline-3.2.1-linux-x64.tar.gz; \
    cp /root/datacube/agdc/database/flyway-example.properties /root/flyway/flyway-3.2.1/conf/flyway.conf; \
    sed -i 's/flyway.password.*/flyway.password='$POSTGRES_PASSWORD'/g' /root/flyway/flyway-3.2.1/conf/flyway.conf; \
    sed -i 's/flyway.locations.*/flyway.locations=filesystem:\/root\/datacube\/agdc\/database\/sql/g' /root/flyway/flyway-3.2.1/conf/flyway.conf

RUN mkdir -p /docker-entrypoint-initdb.d
COPY ./initdb-agdc.sh /docker-entrypoint-initdb.d/agdc.sh

# END
