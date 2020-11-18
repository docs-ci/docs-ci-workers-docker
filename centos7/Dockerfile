FROM centos:7
LABEL MAINTAINER GCM

ENV SUMMARY="Rubin Observatory base CentOS 7 image for Jenkins workers" \
    DESCRIPTION="This is the image to use for CentOS7 Jenkinssw workers"

LABEL name="jenkins-centos7-worker" \
      summary="$SUMMARY" \
      description="$DESCRIPTION" \
      io.k8s.description="$DESCRIPTION" \
      io.k8s.display-name="Rubin Observatory centos 7 container" 

# adding repository to enable docker installation
RUN yum install -y yum-utils && \
    yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

RUN INSTALL_PKGS="git patch vim-enhanced diffutils wget which java-1.8.0-openjdk docker-ce docker-ce-cli" && \
    yum install -y --setopt=tsflags=nodocs ${INSTALL_PKGS} && \
    rpm -V ${INSTALL_PKGS} && \
    yum -y clean all --enablerepo='*'

# Installing minicconda
RUN curl -sSL https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/miniconda.sh \
    && bash /tmp/miniconda.sh -bfp /usr/miniconda/ \
    && rm -rf /tmp/miniconda.sh

ENV PATH=/usr/miniconda/bin:${PATH}

RUN conda install -y python=3 \
    && conda update conda \
    && conda clean --all --yes

ENV JENKINS_HOME=/var/jenkins_home
ENV SWARM_HOME=/var/jenkins_swarm/centos7

RUN useradd jenkins -u 1000 -d ${JENKINS_HOME}

USER jenkins
ADD --chown=jenkins:jenkins rootfs /

WORKDIR ${JENKINS_HOME}

RUN curl -sSL -o ${SWARM_HOME}/swarm-client.jar https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/3.9/swarm-client-3.9.jar

# swarm-client.sh shall also deploy lsstsw
ENTRYPOINT "${SWARM_HOME}/swarm-client.sh"
