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
RUN useradd -u 1000 -d /home/jenkins -m -s /bin/bash jenkins
RUN mkdir /home/jenkins/.ssh
COPY id_rsa.pub /home/jenkins/.ssh/authorized_keys
RUN chown -R jenkins:jenkins /home/jenkins/.ssh
RUN chmod 600 /home/jenkins/.ssh/authorized_keys
RUN rm -f /etc/motd

ENV DOCKER_VERSION 1.6.0
RUN curl -L https://get.docker.com/builds/Linux/x86_64/docker-$DOCKER_VERSION > /usr/bin/docker
RUN chmod +x /usr/bin/docker

RUN mkdir -p ~jenkins/.ssh
RUN chown -R jenkins:jenkins ~jenkins/.ssh
RUN chmod 700 ~jenkins/.ssh
RUN mkdir -p ~root/.ssh
RUN chown -R root:root ~root/.ssh
RUN chmod 700 ~root/.ssh
RUN chmod 4755 /usr/bin/sudo
ADD authorized_keys /home/jenkins/.ssh/authorized_keys
RUN echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config

EXPOSE 22

CMD ["/usr/sbin/sshd", "-De"]
