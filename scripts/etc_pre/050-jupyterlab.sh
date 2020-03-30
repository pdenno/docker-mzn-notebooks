#!/usr/bin/env bash

# codemirror configuration
codemirror_dir=$HOME/.jupyter/lab/user-settings/@jupyterlab/codemirror-extension
mkdir -p $codemirror_dir
cp /settings/commands.jupyterlab-settings $codemirror_dir

# apputils-extension configuration
apputils_dir=$HOME/.jupyter/lab/user-settings/@jupyterlab/apputils-extension/
mkdir -p $apputils_dir
cp /settings/themes.jupyterlab-settings $apputils_dir

# jupyter_notebook_config
notebook_config_dir=$HOME/.jupyter/
cp /settings/jupyter_notebook_config.py $notebook_config_dir

chown -R $DOCKER_USER:$DOCKER_GROUP $HOME/.jupyter
