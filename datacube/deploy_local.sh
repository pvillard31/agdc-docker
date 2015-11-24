#/bin/bash


if [ "$#" -ne 1 ]; then
    echo "Usage: ./generate.sh <Database password>"
else
    # run the adgc-datacube image with the name datacubeContiner, linked to the agdcdb container with the host name agdcdbserver
    # link the local /data/agdc folder to the container internal folder /data/agdc
    docker run --link agdcdb:agdcdbserver --name=datacubeContainer -p 8888:8888 -v /data/agdc:/data/agdc -itd agdc-datacube /bin/bash

    # replace the password for the database in the configuration file
    docker exec -it datacubeContainer sed -i 's/POSTGRES_PASSWORD/'$1'/g' /root/.datacube/config
fi
