#/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: ./generate.sh <Database password>"
else
    docker run --link agdcdb:agdcdbserver --name=datacubeContainer -v /data/agdc:/data/agdc -itd agdc-datacube /bin/bash
    docker exec -it datacubeContainer sed -i 's/POSTGRES_PASSWORD/'$1'/g' /root/.datacube/config
fi
