############################################################
# Trobz's Ubuntu 14.04 base image
############################################################

FROM ubuntu:14.04

MAINTAINER Thuan Duong <thuan@trobz.com>

# disable interactive debconf mode
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Install all dependencies
############################################################

ADD config/apt/sources.14.04.list /etc/apt/sources.list
ADD config/apt/apt.conf.d /etc/apt/apt.conf.d

# Linux command line tools
RUN apt-get install -qq -y sudo openssh-server supervisor aptitude apt-transport-https \
    dnsutils net-tools mtr-tiny nmap ngrep telnet traceroute iputils-ping netstat-nat \
    htop ncdu nano lynx vim-nox zsh bash-completion screen tig tmux lftp apt-utils \
    wget curl git-core locate man rsync build-essential make gcc keychain \
    dialog locales software-properties-common python-software-properties

# Configure timezone and locale
RUN echo "Asia/Ho_Chi_Minh" > /etc/timezone; dpkg-reconfigure -f noninteractive tzdata
RUN locale-gen en_US.UTF-8 && \
    dpkg-reconfigure locales && \
    /usr/sbin/update-locale LANG=en_US.UTF-8

# Set locale environment
ADD config/user/locale /etc/default/locale
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# Install Trobz's certificates by default
ADD config/cert/bundle.crt /usr/local/share/ca-certificates/trobz_bundle.crt
ADD config/cert/trobz.crt /usr/local/share/ca-certificates/trobz.crt
RUN update-ca-certificates

# sudo
ADD config/user/sudoers /etc/sudoers
RUN chmod 0440 /etc/sudoers

# bash shell
ADD config/user/bash.bashrc /tmp/setup/user/bash.bashrc
ADD config/user/skel /etc/skel
ADD scripts/common /etc/bash
ADD scripts/bash /etc/bash.d

# vim
ADD config/vim/vim.tar.gz /tmp/setup

# supervisor
COPY config/supervisor/supervisord.conf /etc/supervisor/supervisord.conf
RUN mkdir -p /var/run/supervisor
RUN mkdir -p /var/log/supervisor

# sshd
RUN mkdir /var/run/sshd
RUN chmod 0755 /var/run/sshd
# configure ssh server service with supervisord
COPY config/supervisor/conf.d/sshd.conf /etc/supervisor/conf.d/sshd.conf

# install latest git from launchpad ppa
ADD scripts/setup/git.sh /tmp/setup/git/git.sh
RUN /bin/bash < /tmp/setup/git/git.sh

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
ONBUILD RUN apt-get dist-upgrade -y
ONBUILD RUN updatedb

EXPOSE 22 8011

USER root
CMD [ "/usr/local/docker/start/main.sh" ]
