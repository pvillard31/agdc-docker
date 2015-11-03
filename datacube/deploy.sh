#/bin/bash

docker run --link agdcdb:agdcdbserver --name=datacubeContainer -v /data/agdc:/data/agdc -it agdc-datacube /bin/bash
