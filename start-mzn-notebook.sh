#!/bin/bash

docker run -t --name nb_container -p 8888:8888 --mount type=bind,source="$(pwd)"/target,target=/home/jovyan/work podenno/mzn_notebook_base
