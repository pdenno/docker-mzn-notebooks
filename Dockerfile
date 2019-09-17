FROM dclong/jupyterlab 

LABEL maintainer="https://github.com/pdenno"

USER root

RUN mkdir -p /opt/nb-agent 
# Seems like it likes it to be local.
ADD nb-agent.jar /opt/nb-agent
EXPOSE 3001 7001 8889 

RUN apt-get update
RUN apt-get install -y apt-utils
RUN apt-get install -y software-properties-common
RUN apt-get install wget 
RUN apt-get install -y libqt5printsupport5

RUN cd /opt && \
    wget -nv https://github.com/MiniZinc/MiniZincIDE/releases/download/2.2.3/MiniZincIDE-2.2.3-bundle-linux-x86_64.tgz && \
    tar xzf MiniZincIDE-2.2.3-bundle-linux-x86_64.tgz && \
    rm MiniZincIDE-2.2.3-bundle-linux-x86_64.tgz

ENV MINIZINC_DIR=/opt/MiniZincIDE-2.2.3-bundle-linux
ENV PATH=$MINIZINC_DIR/bin:$PATH

RUN pip3 install --upgrade pip
RUN pip3 install pandas numpy pandoc 
RUN pip3 install xlrd xlwt openpyxl plotly
RUN pip3 install python-gantt
RUN pip3 install mznb-pdenno
RUN pip3 install nba-gateway-pdenno

# java https://github.com/AdoptOpenJDK/openjdk-docker/blob/master/8/jdk/debian/Dockerfile.hotspot.releases.full
ENV JAVA_VERSION=jdk8u22
ENV ESUM=37356281345b93feb4212e6267109b4409b55b06f107619dde4960e402bafa77
ENV BINARY_URL=https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u222-b10/OpenJDK8U-jdk_x64_linux_hotspot_8u222b10.tar.gz

RUN curl -LfsSo /tmp/openjdk.tar.gz ${BINARY_URL}; \
    echo "${ESUM} */tmp/openjdk.tar.gz" | sha256sum -c -; \
    mkdir -p /opt/java/openjdk; \
    cd /opt/java/openjdk; \
    tar -xf /tmp/openjdk.tar.gz --strip-components=1; \
    rm -rf /tmp/openjdk.tar.gz;

ENV JAVA_HOME=/opt/java/openjdk \
    PATH="/opt/java/openjdk/bin:$PATH"

# clojure - maybe not needed since I have the .jar, but I've come this far...
RUN wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein -O /usr/bin/lein && chmod +x /usr/bin/lein
RUN lein self-install

# Modified from dclong (Go get these!) <=======================================
COPY scripts /scripts
COPY settings /settings
