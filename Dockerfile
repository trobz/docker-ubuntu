############################################################
# Basic ubuntu 12.04 image
############################################################

FROM ubuntu:12.04

MAINTAINER Michel Meyer <mmeyer@trobz.com>

# disable interactive debconf mode
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Install all dependencies

ADD config/apt/sources.12.04.list /etc/apt/sources.list

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y \
    wget curl git locate man \
    build-essential apt-utils \
    nmap iputils-ping netstat-nat vim telnet traceroute \
    make gcc \
    dialog locales sudo \
    software-properties-common python-software-properties

RUN locale-gen en_US.UTF-8 && \
    dpkg-reconfigure locales && \
    /usr/sbin/update-locale LANG=en_US.UTF-8

# Set environment

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en

ADD config/user/bash.bashrc /tmp/setup/user/bash.bashrc
ADD config/user/sudoers /etc/sudoers
ADD config/user/skel /etc/skel
RUN chmod 0440 /etc/sudoers

# bugfix https://github.com/tianon/docker-brew-ubuntu-core/issues/17
RUN chown root:root /usr/bin/sudo
RUN chmod 4755 /usr/bin/sudo

ADD scripts/common /etc/bash
ADD scripts/bash /etc/bash.d

RUN mkdir -p /var/log/docker
RUN chmod a+rw /var/log/docker -R

ADD scripts/start /usr/local/docker/start
RUN chmod +x /usr/local/docker/start -R

# Finalization
############################################################

VOLUME ["/var/log/docker"]

ENV USERNAME docker
ENV PASSWORD docker
ENV USER_UID 1000
ENV USER_GID 1000
ENV USER_HOME /home/docker

ONBUILD RUN apt-get update
ONBUILD RUN apt-get upgrade -y
ONBUILD RUN updatedb

USER root
CMD [ "/usr/local/docker/start/main.sh" ]
