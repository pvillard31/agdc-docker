#/bin/bash

if [ "$#" -ne 1 ]; then
	echo "Usage: ./connect_remote.sh <instance_name>"
else
	# start the datacubeContainer if it is not already started, and launch a console
	docker start $1 ; docker exec -it $1 /bin/bash
fi
