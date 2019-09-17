#!/bin/bash

java -jar /opt/nb-agent/nb-agent.jar &

# jupyter notebook --allow-root --ip=* --port=8888 --no-browser --notebook-dir=/jupyter 
su -m $DOCKER_USER -c "jupyter lab --allow-root --ip='0.0.0.0' --port=8889 --no-browser --notebook-dir=/workdir"

