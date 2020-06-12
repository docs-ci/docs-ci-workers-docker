FROM centos:7
LABEL MAINTAINER GCM

ENV SUMMARY="Rubin Observatory base CentOS 7 image for Jenkins workers" \
    DESCRIPTION="This is the image to use for CentOS7 Jenkinssw workers"

LABEL name="jenkins-centos7-worker" \
      summary="$SUMMARY" \
      description="$DESCRIPTION" \
      io.k8s.description="$DESCRIPTION" \
      io.k8s.display-name="Rubin Observatory centos 7 container" 

RUN INSTALL_PKGS="git patch diffutils wget java-1.8.0-openjdk-devel.x86_64" && \
    yum install -y --setopt=tsflags=nodocs ${INSTALL_PKGS} && \
    rpm -V ${INSTALL_PKGS} && \
    yum -y clean all --enablerepo='*'

ENV JENKINS_HOME /var/jenkins_home
ENV SWARM_HOME /var/jenkins_swarm/centos7

RUN useradd jenkins -u 1000 -d ${JENKINS_HOME}

USER jenkins
ADD --chown=jenkins:jenkins rootfs /

WORKDIR ${JENKINS_HOME}

RUN curl -sSL -o ${SWARM_HOME}/swarm-client.jar https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/3.9/swarm-client-3.9.jar

RUN mkdir -p centos7 && \
    git clone https://github.com/lsst/lsstsw && \
    cd lsstsw && \
    ./bin/deploy

ENV LSSTSW_HOME=${JENKINS_HOME}/centos7/lsstsw

ENTRYPOINT "${SWARM_HOME}/swarm-client.sh"
