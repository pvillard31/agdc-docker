# we start from the latest image of centos
FROM centos:latest
# author
MAINTAINER Pierre Villard <pierre.villard@capgemini.com>

RUN yum -y update && yum -y upgrade && yum -y install \
    wget \
    gcc \
    gcc-c++ \
    make \
    git \
    vim \
    python-devel

############
### PostgreSQL and PostGIS
############

RUN yum -y install http://yum.postgresql.org/9.4/redhat/rhel-7-x86_64/pgdg-centos94-9.4-1.noarch.rpm && \
    yum -y install http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm && \
    yum -y update && yum -y upgrade && \
    yum -y install \
        postgresql94-server \
        postgresql94-contrib \
        postgresql94-devel \
        postgis2_94 && \
    echo export PATH=\"/usr/pgsql-9.4/bin:\$PATH\" >> /root/.bashrc && source /root/.bashrc

############
### GDAL
############

RUN mkdir /root/gdal && \
    cd /root/gdal && \
    wget http://download.osgeo.org/gdal/2.0.1/gdal-2.0.1.tar.gz && \
    tar -xvzf gdal-2.0.1.tar.gz && \
    rm -rf gdal-2.0.1.tar.gz && \
    cd /root/gdal/gdal-2.0.1 && \
    ./configure --with-python --with-pg=/usr/pgsql-9.4/bin/pg_config && make && make install 


