ARG BASE_CONTAINER=jupyter/scipy-notebook
FROM $BASE_CONTAINER

LABEL maintainer="https://github.com/pdenno"

USER root

RUN cd /opt && \
    wget https://github.com/MiniZinc/MiniZincIDE/releases/download/2.2.3/MiniZincIDE-2.2.3-bundle-linux-x86_64.tgz && \
    tar xzf MiniZincIDE-2.2.3-bundle-linux-x86_64.tgz && \
    rm MiniZincIDE-2.2.3-bundle-linux-x86_64.tgz

# Switch back to jovyan to avoid accidental container runs as root
USER $NB_UID

ENV MINIZINC_DIR=/opt/MiniZincIDE-2.2.3-bundle-linux
ENV PATH=$MINIZINC_DIR/bin:$PATH 

RUN conda install --quiet --yes xlrd xlwt openpyxl plotly

# -U is upgrade --user installs it for the current user. 
RUN pip install -U iminizinc   


