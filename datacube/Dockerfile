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
    vim

############
### GDAL
############

RUN mkdir /root/gdal; \
    cd /root/gdal; \
    wget http://download.osgeo.org/gdal/2.0.1/gdal-2.0.1.tar.gz; \
    tar -xvzf gdal-2.0.1.tar.gz; \
    rm -rf gdal-2.0.1.tar.gz; \
    cd /root/gdal/gdal-2.0.1; \
    ./configure && make && make install \

############
### PostgreSQL and PostGIS
############

RUN rpm -iUvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm; \
    yum -y install http://yum.postgresql.org/9.4/redhat/rhel-7-x86_64/pgdg-centos94-9.4-1.noarch.rpm; \
    yum -y update && yum -y upgrade; \
    yum -y install \
        postgresql94-server \
        postgresql94-contrib \
        postgresql94-devel \
        postgis2_94; \
    echo export PATH=\"/usr/pgsql-9.4/bin:\$PATH\" >> /root/.bashrc && source /root/.bashrc

############
### Numpy
############

RUN yum -y install \
        python-devel \
        blas-devel \
        liblas-devel \
        lapack-devel \
        lapack64-devel \
        lapack lapack64; \
    mkdir /root/numpy; \
    cd /root/numpy; \
    wget https://pypi.python.org/packages/source/n/numpy/numpy-1.10.1.tar.gz; \
    tar -xvzf numpy-1.10.1.tar.gz; \
    rm -rf numpy-1.10.1.tar.gz; \
    cd /root/numpy/numpy-1.10.1/; \
    python setup.py build && python setup.py install

############
### Scipy
############

RUN mkdir /root/scipy; \
    cd /root/scipy; \
    wget https://github.com/scipy/scipy/releases/download/v0.16.1/scipy-0.16.1.tar.gz; \
    tar -xvzf scipy-0.16.1.tar.gz; \
    rm -rf scipy-0.16.1.tar.gz; \
    cd /root/scipy/scipy-0.16.1/; \
    python setup.py build && python setup.py install

############
### Python dependencies
############

RUN yum -y update && yum -y upgrade && yum -y install python-pip; \
    pip install --upgrade pip; \
    source /root/.bashrc; \
    pip install psycopg2; \
    pip install numexpr; \
    pip install pyephem; \
    pip install python-dateutil; \
    pip install pytz

############
### eo-tools
############

RUN mkdir /root/eotools; \
    cd /root/eotools; \
    git clone https://github.com/GeoscienceAustralia/eo-tools.git; \
    cd /root/eotools/eo-tools; \
    python setup.py build && python setup.py install

############
### datacube
############

RUN mkdir /root/datacube; \
    cd /root/datacube; \
    git clone https://github.com/pvillard31/agdc.git; \
    cd /root/datacube/agdc; \
    git checkout develop; \
    python setup.py build && python setup.py install

# END
