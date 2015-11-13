#/bin/bash

# start the datacubeContainer if it is not already started, and launch a console
docker start datacubeContainer ; docker exec -it datacubeContainer /bin/bash
