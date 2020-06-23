FROM centos:7
LABEL MAINTAINER GCM

ENV SUMMARY="Rubin Observatorydocker image for docker builds Jenkins workers" \
    DESCRIPTION="This is the image to build docker images with docs-ci Jenkins"

LABEL name="docker-worker" \
      summary="$SUMMARY" \
      description="$DESCRIPTION" \
      io.k8s.description="$DESCRIPTION" \
      io.k8s.display-name="Rubin Observatory centos 8 container" 

# adding repository to enable docker installation
RUN yum install -y yum-utils && \
    yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

RUN INSTALL_PKGS="git patch diffutils wget which java-1.8.0-openjdk-devel.x86_64 docker-ce docker-ce-cli containerd.io" && \
    yum install -y --setopt=tsflags=nodocs ${INSTALL_PKGS} && \
    rpm -V ${INSTALL_PKGS} && \
    yum -y clean all --enablerepo='*'

ENV JENKINS_HOME /var/jenkins_home
ENV SWARM_HOME /var/jenkins_swarm/docker

RUN useradd jenkins -u 1000 -d ${JENKINS_HOME}

USER jenkins
ADD --chown=jenkins:jenkins rootfs /

WORKDIR ${JENKINS_HOME}

RUN curl -sSL -o ${SWARM_HOME}/swarm-client.jar https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/3.9/swarm-client-3.9.jar

ENTRYPOINT "${SWARM_HOME}/swarm-client.sh"
