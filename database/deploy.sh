#/bin/bash

docker run -p 12345:5432 --name agdcdb -e POSTGRES_PASSWORD=123456 -d agdc-postgres

sleep 60

docker exec -it agdcdb /root/flyway/flyway-3.2.1/flyway info
docker exec -it agdcdb /root/flyway/flyway-3.2.1/flyway migrate
