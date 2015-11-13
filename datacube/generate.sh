#!/bin/bash

# stop the datacubeContainer and delete it if it already exists, then build it
docker stop datacubeContainer;  docker rm datacubeContainer; docker build -t agdc-datacube .;
