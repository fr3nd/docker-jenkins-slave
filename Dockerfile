FROM debian:jessie

MAINTAINER Carles Amigó, fr3nd@fr3nd.net

RUN apt-get update && apt-get install -y \
      curl \
      git \
      openjdk-7-jdk \
      openssh-server \
      && rm -rf /usr/share/doc/* \
      && rm -rf /usr/share/info/* \
      && rm -rf /tmp/* \
      && rm -rf /var/tmp/*

RUN mkdir /var/run/sshd
RUN useradd -u 1000 jenkins

ENV DOCKER_VERSION 1.6.0
RUN curl -L https://get.docker.com/builds/Linux/x86_64/docker-$DOCKER_VERSION > /usr/bin/docker
RUN chmod +x /usr/bin/docker

EXPOSE 22

CMD ["/usr/sbin/sshd", "-De"]
