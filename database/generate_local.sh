#!/bin/bash

# stop the agdcdb container and remove it if it exists, then build the agdcdb container
docker stop agdcdb;  docker rm agdcdb; docker build -no-cache -t agdc-postgres .;
