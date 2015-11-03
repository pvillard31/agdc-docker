#!/bin/bash

docker stop datacubeContainer;  docker rm datacubeContainer; docker build -t agdc-datacube .;
