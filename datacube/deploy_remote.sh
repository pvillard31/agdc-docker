#/bin/bash


if [ "$#" -ne 2 ]; then
    echo "Usage: ./generate.sh <Database password> <instance_name>"
else
    docker pull pvillard/agdc-docker
    # run the adgc-datacube image with the name datacubeContiner, linked to the agdcdb container with the host name agdcdbserver
    # link the local /data/agdc folder to the container internal folder /data/agdc
    docker run --link agdcdb:agdcdbserver --name=$2 -v /data/agdc:/data/agdc -p 8888:8888 -itd pvillard/agdc-docker /bin/bash

    # replace the password for the database in the configuration file
    docker exec -it $2 sed -i 's/POSTGRES_PASSWORD/'$1'/g' /root/.datacube/config
fi
