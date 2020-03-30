FROM podenno/jupyter-plotly

LABEL maintainer="https://github.com/pdenno"

USER root
EXPOSE 3001 7001 8889

# build.sh move nb-agent.jar into this directory
RUN mkdir -p /opt/nb-agent 
ADD nb-agent.jar /opt/nb-agent

RUN apt-get update
RUN apt-get install -y apt-utils
RUN apt-get install -y software-properties-common
RUN apt-get install wget
RUN apt-get install -y libqt5printsupport5
# For python-sat
RUN apt-get install -y zlib1g-dev

# Surprisingly, this isn't included in FROM. Suppress complaints from install python-sat
ENV DEBIAN_FRONTEND noninteractive
# Libraries for nb-agent and scheduling notebooks
RUN pip3 install --upgrade pip
RUN pip3 install python-sat
RUN pip3 install pandas numpy pandoc
RUN pip3 install ipywidgets plotly
RUN pip3 install xlrd xlwt openpyxl XlsxWriter 
RUN pip3 install --index-url https://test.pypi.org/simple/ mznb-pdenno
RUN pip3 install --index-url https://test.pypi.org/simple/ nba-gateway-pdenno
RUN pip3 install ast2json

# MiniZinc
RUN cd /opt && \
    wget -nv https://github.com/MiniZinc/MiniZincIDE/releases/download/2.4.3/MiniZincIDE-2.4.3-bundle-linux-x86_64.tgz && \
    tar xzf MiniZincIDE-2.4.3-bundle-linux-x86_64.tgz && \
	rm MiniZincIDE-2.4.3-bundle-linux-x86_64.tgz

RUN cd /opt && mv MiniZincIDE-2.4.3-bundle-linux-x86_64 minizinc

ENV MINIZINC_DIR=/opt/minizinc
ENV MINIZINC_BIN=/opt/minizinc/bin

# java https://github.com/AdoptOpenJDK/openjdk-docker/blob/master/8/jdk/debian/Dockerfile.hotspot.releases.full
ENV JAVA_VERSION=jdk8u242-b08
ENV ESUM=f39b523c724d0e0047d238eb2bb17a9565a60574cf651206c867ee5fc000ab43
ENV BINARY_URL=https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u242-b08/OpenJDK8U-jdk_x64_linux_hotspot_8u242b08.tar.gz

RUN curl -LfsSo /tmp/openjdk.tar.gz ${BINARY_URL}; \
    echo "${ESUM} */tmp/openjdk.tar.gz" | sha256sum -c -; \
    mkdir -p /opt/java/openjdk; \
    cd /opt/java/openjdk; \
    tar -xf /tmp/openjdk.tar.gz --strip-components=1; \
    rm -rf /tmp/openjdk.tar.gz;

ENV JAVA_HOME=/opt/java/openjdk
ENV JAVA_BIN=/opt/java/openjdk/bin
# Currently not very useful because running as $DOCKER_USER.
ENV PATH=$MINIZINC_BIN:$JAVA_BIN:$PATH

# clojure - useful for working on the repl-server (7001)
RUN wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein -O /usr/bin/lein && chmod +x /usr/bin/lein
RUN lein self-install

COPY scripts /scripts
COPY settings /settings
