#!/bin/bash

# Build and install mznb and NBAgateway
#
#  python3 setup.py sdist bdist_wheel
#  pip install -i https://test.pypi.org/simple/ nba_gateway-pdenno
#  Uberjar built with lein uberjar

cp ~/Documents/git/nb-agent/target/uberjar/nb-agent.jar .
docker build -t podenno/mzn-notebook .
