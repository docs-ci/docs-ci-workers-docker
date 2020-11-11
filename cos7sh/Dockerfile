FROM centos:7
LABEL MAINTAINER GCM

ENV SUMMARY="Rubin Observatory base CentOS 7 image for Jenkins workers using shadow organizaion" \
    DESCRIPTION="This is the image to use for CentOS7 Jenkinssw workers using shadow organization"

LABEL name="jenkins-cos7sh-worker" \
      summary="$SUMMARY" \
      description="$DESCRIPTION" \
      io.k8s.description="$DESCRIPTION" \
      io.k8s.display-name="Rubin Observatory centos 7 container using shadow organization" 

RUN INSTALL_PKGS="git patch diffutils wget which java-1.8.0-openjdk" && \
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

ARG WNAME="cos7sh"
ENV JENKINS_HOME=/var/jenkins_home
ENV SWARM_HOME=/var/jenkins_swarm/${WNAME}
ENV JSW_HOME=/var/jenkins_home/${WNAME}

RUN useradd jenkins -u 1000 -d ${JENKINS_HOME}

USER jenkins
ADD --chown=jenkins:jenkins rootfs /

# changing home folder to force conda to use a specific condarc file
ENV HOME=${JENKINS_HOME}/${WNAME}

WORKDIR ${JENKINS_HOME}

RUN curl -sSL -o ${SWARM_HOME}/swarm-client.jar https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/3.9/swarm-client-3.9.jar

ENTRYPOINT "${SWARM_HOME}/swarm-client.sh"
