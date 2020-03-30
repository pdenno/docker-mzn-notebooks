#!/bin/bash

echo "export PATH=/opt/java/openjdk/bin:/opt/minizinc/bin:${PATH}" > /home/${DOCKER_USER}/.bash_profile

USER_PATH="export PATH=/opt/java/openjdk/bin:/opt/minizinc/bin:${PATH}"

su -m $DOCKER_USER -c "export PATH=${USER_PATH}; /opt/java/openjdk/bin/java -jar /opt/nb-agent/nb-agent.jar &"

su -m $DOCKER_USER -c "jupyter lab --allow-root --ip='0.0.0.0' --port=8889 --no-browser --notebook-dir=/workdir"
