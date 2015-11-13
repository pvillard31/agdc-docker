#/bin/bash

# run the agdc database for the first time
docker run -p 12345:5432 --name agdcdb -e POSTGRES_PASSWORD=123456 -d agdc-postgres

# wait for the database to be configured
sleep 60


# update the database
docker exec -it agdcdb /root/flyway/flyway-3.2.1/flyway info
docker exec -it agdcdb /root/flyway/flyway-3.2.1/flyway migrate
