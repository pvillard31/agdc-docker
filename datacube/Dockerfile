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
### Upgrade pip
############

RUN yum -y install http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm && \
    yum -y install python-pip && \
    pip install --upgrade pip && \
    source /root/.bashrc


############
### NetCDF
############
RUN mkdir /root/netcdf && \
    cd /root/netcdf && \
    wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-4.3.3.1.tar.gz && \
    tar -xvzf netcdf-4.3.3.1.tar.gz && \
    cd netcdf-4.3.3.1 && \
    yum install m4 -y && \
    ./configure --prefix=/opt/netcdf --disable-netcdf-4 && \
    make check install


############
### GDAL
############

RUN mkdir /root/gdal && \
    cd /root/gdal && \
    wget http://download.osgeo.org/gdal/2.0.1/gdal-2.0.1.tar.gz && \
    tar -xvzf gdal-2.0.1.tar.gz && \
    rm -rf gdal-2.0.1.tar.gz && \
    cd /root/gdal/gdal-2.0.1 && \
    ./configure --with-netcdf=/opt/netcdf && make && make install 

############
### PostgreSQL and PostGIS
############

RUN yum -y install http://yum.postgresql.org/9.4/redhat/rhel-7-x86_64/pgdg-centos94-9.4-1.noarch.rpm && \
    yum -y update && yum -y upgrade && \
    yum -y install \
        postgresql94-server \
        postgresql94-contrib \
        postgresql94-devel \
        postgis2_94 && \
    echo export PATH=\"/usr/pgsql-9.4/bin:\$PATH\" >> /root/.bashrc && source /root/.bashrc

############
### Numpy
############

RUN yum -y install \
#      python-devel \
      blas-devel \
      liblas-devel \
      lapack-devel \
      lapack64-devel \
      lapack64 \
      proj-devel.x86_64 && \
    mkdir /root/numpy && \
    cd /root/numpy && \
    wget https://pypi.python.org/packages/source/n/numpy/numpy-1.10.1.tar.gz && \
    tar -xvzf numpy-1.10.1.tar.gz && \
    rm -rf numpy-1.10.1.tar.gz && \
    cd /root/numpy/numpy-1.10.1/ && \
    python setup.py build && python setup.py install

############
### Scipy
############

RUN mkdir /root/scipy && \
    cd /root/scipy && \
    wget https://github.com/scipy/scipy/releases/download/v0.16.1/scipy-0.16.1.tar.gz && \
    tar -xvzf scipy-0.16.1.tar.gz && \
    rm -rf scipy-0.16.1.tar.gz && \
    cd /root/scipy/scipy-0.16.1/ && \
    python setup.py build && python setup.py install

############
### Python dependencies
############

RUN source /root/.bashrc && \
    pip install psycopg2 && \
    pip install numexpr && \
    pip install pyephem && \
    pip install python-dateutil && \
    pip install pytz

############
### Jupyter and python
### dependencies for notebook
############

RUN yum -y install \
      freetype-devel \
      libpng \
      libpng-devel \
      libpng-static && \
    source /root/.bashrc && \
    pip install jupyter && \
    pip install matplotlib && \
    pip install pandas && \
    mkdir /root/idlfunctions && \
    cd /root/idlfunctions && \
    git clone https://github.com/sixy6e/idl-functions.git && \
    cd /root/idlfunctions/idl-functions && \
    python setup.py build && \
    python setup.py install

COPY ./run_notebook_server.sh /root/run_notebook_server.sh


############
### eo-tools
############

RUN mkdir /root/eotools && \
    cd /root/eotools && \
    git clone https://github.com/GeoscienceAustralia/eo-tools.git && \
    cd /root/eotools/eo-tools && \
    python setup.py build && python setup.py install

############
### datacube
############

RUN yum -y install python-lxml && \
    mkdir /root/datacube && \
    cd /root/datacube && \
    git clone https://github.com/pvillard31/agdc.git && \
    cd /root/datacube/agdc && \
    git checkout develop && \
    ldconfig /usr/local/lib/ && \
    python setup.py build && python setup.py install && \
    cd /root/datacube/agdc/api/ && \
    python setup.py build && python setup.py install

RUN mkdir /root/.datacube && \
    echo export AGDC_API_CONFIG=/root/.datacube/config >> /root/.bashrc && source /root/.bashrc

############
### basemap
############

RUN mkdir /root/basemap && \
	cd /root/basemap && \
	wget http://pkgs.fedoraproject.org/repo/pkgs/python-basemap-data/basemap-1.0.7.tar.gz/48c0557ced9e2c6e440b28b3caff2de8/basemap-1.0.7.tar.gz && \
	tar -xvzf basemap-1.0.7.tar.gz && \
	cd /root/basemap/basemap-1.0.7/geos-3.3.3 && \
	export GEOS_DIR=/usr/local && \
	./configure --prefix=$GEOS_DIR && \
	make; make install && \
	cd /root/basemap/basemap-1.0.7 && \
	python setup.py install && \
	rm -f /root/basemap/basemap-1.0.7.tar.gz

#########
### segmentation analysis
#########

RUN mkdir /root/imageProcessing && \
	cd /root/imageProcessing && \
	git clone https://github.com/sixy6e/image-processing.git && \
	cd /root/imageProcessing/image-processing && \
	python setup.py build && \
	python setup.py install && \
	pip install fiona && \
	pip install rasterio && \
	mkdir /root/libspatialindex && \
	cd  /root/libspatialindex && \
	wget http://download.osgeo.org/libspatialindex/spatialindex-src-1.7.0.tar.gz && \
	tar -xvzf spatialindex-src-1.7.0.tar.gz && \
	cd spatialindex-src-1.7.0/ && \
	./configure; make; make install && \
	echo export LD_LIBRARY_PATH=/usr/local/lib/ >> /root/.bashrc && source /root/.bashrc && \
	pip install Rtree && \
	pip install shapely

########
### Spark
########

RUN mkdir /root/spark && \
	cd /root/spark && \
	wget http://d3kbcqa49mib13.cloudfront.net/spark-1.6.0-bin-hadoop2.6.tgz && \
	tar -xvzf spark-1.6.0-bin-hadoop2.6.tgz && \
	echo export SPARK_HOME=/root/spark/spark-1.6.0-bin-hadoop2.6 >> /root/.bashrc && \
 	echo export PATH=\$SPARK_HOME/bin:\$PATH >> /root/.bashrc && \
     	echo export PYTHONPATH=\$SPARK_HOME/python/\$PYTHONPATH >> /root/.bashrc  && \
	echo export PYTHONPATH=\$SPARK_HOME/python/lib/py4j-0.8.2.1-src.zip:\$PYTHONPATH >> /root/.bashrc && source /root/.bashrc && \
	mkdir /root/jdk

COPY ./jdk-7u45-linux-x64.tar.gz /root/jdk/jdk-7u45-linux-x64.tar.gz
RUN cd /root/jdk && \
	tar -xvzf jdk-7u45-linux-x64.tar.gz && \
        echo export JAVA_HOME=/root/jdk/jdk1.7.0_45/ >> /root/.bashrc && \
	echo export PATH=\$PATH:\$JAVA_HOME/bin/ >> /root/.bashrc && \
	source /root/.bashrc && pip install py4j && pip install --upgrade pip
COPY ./config /root/.datacube/
COPY ./handleSmosPicture.sh /root/handleSmosPicture.sh
COPY ./handleMoisturePercentilePicture.sh /root/handleMoisturePercentilePicture.sh
COPY ./handleForecastPicture.sh /root/handleForecastPicture.sh
COPY ./handlePrecipitationPercentilePicture.sh /root/handlePrecipitationPercentilePicture.sh
COPY ./updateAgdc.sh /root/updateAgdc.sh

# docker container folder /data/agdc can be linked to a host folder
VOLUME /data/agdc

# END
