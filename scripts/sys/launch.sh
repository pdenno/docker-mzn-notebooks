#!/bin/bash

# POD move this to create_user.sh ???
echo "export PATH=/opt/java/openjdk/bin:/opt/MiniZincIDE-2.2.3-bundle-linux/bin:${PATH}" > /home/${DOCKER_USER}/.bash_profile

USER_PATH="export PATH=/opt/java/openjdk/bin:/opt/MiniZincIDE-2.2.3-bundle-linux/bin:${PATH}"

su -m $DOCKER_USER -c "export PATH=${USER_PATH}; /opt/java/openjdk/bin/java -jar /opt/nb-agent/nb-agent.jar &"

# jupyter notebook --allow-root --ip=* --port=8888 --no-browser --notebook-dir=/jupyter 
su -m $DOCKER_USER -c "jupyter lab --allow-root --ip='0.0.0.0' --port=8889 --no-browser --notebook-dir=/workdir"

