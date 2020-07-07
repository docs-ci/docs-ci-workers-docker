FROM centos:8
LABEL MAINTAINER GCM

ENV SUMMARY="Rubin Observatory base CentOS 8 image for docugeneration Jenkins worker" \
    DESCRIPTION="This is the image to use for Jenkins docugeneration worker"

LABEL name="docugen-worker" \
      summary="$SUMMARY" \
      description="$DESCRIPTION" \
      io.k8s.description="$DESCRIPTION" \
      io.k8s.display-name="Rubin Observatory docugen container"

ARG DS_VER="1.2.rc13_0_ga622507"

# Installing required OS  Pakcages
RUN INSTALL_PKGS="curl bzip2 git patch diffutils wget java-1.8.0-openjdk-devel.x86_64" \
    && yum -y update \
    && yum install -y --setopt=tsflags=nodocs ${INSTALL_PKGS} \
    && rpm -V ${INSTALL_PKGS} \
    && yum -y clean all --enablerepo='*'

# Installing minicconda
RUN curl -sSL https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/miniconda.sh \
    && bash /tmp/miniconda.sh -bfp /usr/local/ \
    && rm -rf /tmp/miniconda.sh \
    && conda install -y python=3 \
    && conda update conda \
    && conda clean --all --yes

# Add channels and install docsteady
RUN conda config --add channels gcomoretto --system \
    && conda install docsteady=${DS_VER}

# Configuring Jenkins worker's folders and user
ENV JENKINS_HOME /var/jenkins_home
ENV SWARM_HOME /var/jenkins_swarm/docugen
RUN useradd jenkins -u 1000 -d ${JENKINS_HOME}
USER jenkins
ADD --chown=jenkins:jenkins rootfs /

WORKDIR ${JENKINS_HOME}

# download swarm-client jar
RUN curl -sSL -o ${SWARM_HOME}/swarm-client.jar https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/3.9/swarm-client-3.9.jar

ENTRYPOINT "${SWARM_HOME}/swarm-client.sh"
