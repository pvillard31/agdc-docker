#!/bin/sh

sed -i 's/POSTGRES_PASSWORD/'$POSTGRES_PASSWORD'/g' /tmp/createUser.txt; \
#sed -i 's/flyway.password.*/flyway.password='$POSTGRES_PASSWORD'/g' /root/flyway/flyway-3.2.1/conf/flyway.conf; \
#sed -i 's/flyway.locations.*/flyway.locations=filesystem:\/root\/datacube\/agdc\/database\/sql/g' /root/flyway/flyway-3.2.1/conf/flyway.conf; 
#sed -i 's#flyway.url.*#flyway.url=jdbc:postgresql://'$POSTGRES_PORT_5432_TCP_ADDR':'$POSTGRES_PORT_5432_TCP_PORT'/datacube#g' /root/flyway/flyway-3.2.1/conf/flyway.conf

psql -U "$POSTGRES_USER" -f /tmp/createUser.txt
psql -U "$POSTGRES_USER" -f /root/datacube/agdc/database/setup-database-extensions.sql datacube

#/root/flyway/flyway-3.2.1/flyway info
#/root/flyway/flyway-3.2.1/flyway migrate

