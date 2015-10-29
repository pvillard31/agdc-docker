#!/bin/sh

psql -U "$POSTGRES_USER" -c 'create group cube_admin_group;'
psql -U "$POSTGRES_USER" -c 'create group cube_user_group;'
psql -U "$POSTGRES_USER" -c 'create user cube_admin with password "'$POSTGRES_PASSWORD'" in group cube_admin_group;'
psql -U "$POSTGRES_USER" -c 'create user cube_user with password "'$POSTGRES_PASSWORD'" in group cube_user_group;'
psql -U "$POSTGRES_USER" -c 'create database datacube encoding "UTF-8" owner cube_admin;'

psql -U "$POSTGRES_USER" -f /root/datacube/agdc/database/setup-database-extensions.sql

/root/flyway/flyway-3.2.1/flyway info
/root/flyway/flyway-3.2.1/flyway migrate

