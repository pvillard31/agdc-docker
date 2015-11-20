#/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: ./deploy.sh <Database password> <Port of the host to access the container database>"
else
	# retrieve the image for the agdc database
	docker pull pvillard/agdc-docker-db
	# run the agdc database for the first time
	docker run -p $2:5432 --name agdcdb -e POSTGRES_PASSWORD=$1 -d pvillard/agdc-docker-db
	
	# wait for the database to be configured
	sleep 60
	
	
	# update the database
	docker exec -it agdcdb /root/flyway/flyway-3.2.1/flyway info
	docker exec -it agdcdb /root/flyway/flyway-3.2.1/flyway migrate
fi
