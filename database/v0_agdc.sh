#!/bin/sh

# replace the user password in the user creation script
sed -i 's/POSTGRES_PASSWORD/'$POSTGRES_PASSWORD'/g' /tmp/createUser.txt; \

# execute the database initial setup
psql -U "$POSTGRES_USER" -f /tmp/createUser.txt
psql -U "$POSTGRES_USER" -f /root/datacube/agdc/database/setup-database-extensions.sql datacube


