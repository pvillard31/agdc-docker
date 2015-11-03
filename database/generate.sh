#!/bin/bash

docker stop agdcdb;  docker rm agdcdb; docker build -t agdc-postgres .;
