#
# Dockerfile for Storm Mesos framework
#
FROM mesosphere/mesos:0.26.0-0.2.145.ubuntu1404
MAINTAINER Timothy Chen <tnachen@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y software-properties-common python-software-properties
RUN add-apt-repository ppa:openjdk-r/ppa -y

# export environment
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

ENV MESOS_NATIVE_JAVA_LIBRARY /usr/lib/libmesos.so

RUN apt-get install -y python-pip && pip install awscli

RUN apt-get update && \
  apt-get install -yq openjdk-8-jdk maven wget

ADD . /work

WORKDIR /work

RUN ./bin/build-release.sh main && \
  mkdir -p /opt/storm && \
  tar xf storm-mesos-*.tgz -C /opt/storm --strip=1 && \
  rm -rf /work ~/.m2 #&& \
  apt-get -yf autoremove openjdk-8-jdk maven && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /opt/storm
