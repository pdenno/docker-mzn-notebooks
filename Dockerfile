FROM dclong/jupyterlab 

LABEL maintainer="https://github.com/pdenno"

USER root

RUN apt-get update
RUN apt-get install -y apt-utils
RUN apt-get install -y software-properties-common
RUN apt-get install wget 
# RUN add-apt-repository "deb http://us.archive.ubuntu.com/ubuntu/ bionic universe multiverse"
# RUN add-apt-repository "deb http://us.archive.ubuntu.com/ubuntu/ bionic-updates universe multiverse"

RUN apt-get install -y libqt5printsupport5

RUN cd /opt && \
    wget -nv https://github.com/MiniZinc/MiniZincIDE/releases/download/2.2.3/MiniZincIDE-2.2.3-bundle-linux-x86_64.tgz && \
    tar xzf MiniZincIDE-2.2.3-bundle-linux-x86_64.tgz && \
    rm MiniZincIDE-2.2.3-bundle-linux-x86_64.tgz

# Switch back to jovyan to avoid accidental container runs as root
#########USER $NB_UID

ENV MINIZINC_DIR=/opt/MiniZincIDE-2.2.3-bundle-linux
ENV PATH=$MINIZINC_DIR/bin:$PATH

RUN pip3 install --upgrade pip
RUN pip3 install pandas numpy pandoc 
# -U is upgrade --user installs it for the current user. 
RUN pip3 install xlrd xlwt openpyxl plotly
RUN pip3 install iminizinc
RUN pip3 install python-gantt

