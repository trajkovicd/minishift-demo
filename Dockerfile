FROM jboss/wildfly:18.0.0.Final

LABEL vendor="SolutionSoft Systems, Inc"
LABEL maintainer="kzhao@solution-soft.com"

#ARG PYTHON_VERSION=3.6
#ARG TM_VERSION=12.10R5
#ARG TINI_VERSION=v0.18.0
#ARG WILDFLY_VERSION=18.0.0.Final
#ARG WILDFLY_SHA1=2d4778b14fda6257458a26943ea82988e3ae6a66

#ENV PATH=$HOME/.local/bin/:$PATH \
#    PYTHONUNBUFFERED=1 \
#    PYTHONIOENCODING=UTF-8 \
#    PIP_NO_CACHE_DIR=off

#ENV LC_ALL=en_US.UTF-8 \
#    LANG=en_US.UTF-8

#ENV TM_LICHOST=127.0.0.1 \
#    TM_LICPORT=57777 \
#    TM_LICPASS=docker

#ENV TMAGENT_DATADIR=/tmdata/data \
#    TMAGENT_LOGDIR=/tmdata/log

# User jboss to add demo app
USER jboss

ADD HW2.war /opt/jboss/wildfly/standalone/deployments/

# User root to install software
#USER root

# - ADD files and install packages

#ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini

# - install supervisor and TM

#RUN INSTALL_PKGS="rh-python36 rh-python36-python-devel rh-python36-python-setuptools rh-python36-python-pip nss_wrapper \
#	libffi-devel libtool-ltdl" \
#&&  yum -y update \
#&&  yum install -y centos-release-scl \
#&&  yum -y --setopt=tsflags=nodocs install --enablerepo=centosplus $INSTALL_PKGS \
#&&  rpm -V $INSTALL_PKGS \
#&&  source /opt/rh/rh-python36/enable \
#&&  pip3 install supervisor \
#&&  (cd /usr/bin; \
#     ln -f -s /opt/rh/rh-python36/root/bin/supervisord .; \
#     ln -f -s /opt/rh/rh-python36/root/bin/supervisorctl .; \
#     ln -f -s /opt/rh/rh-python36/root/bin/echo_supervisord_conf .;) \
#&&  mkdir -p /tmp/build \
#&&  (cd /tmp/build; \
#     curl -O ftp://ftp.solution-soft.com/pub/tm/linux/redhat/64bit/tm_linux_2.6.up_x86_64-${TM_VERSION}.tar.gz; \
#     tar -xzf tm_linux_2.6.up_x86_64-${TM_VERSION}.tar.gz; \
#     ./ssstm_install.sh tm_linux_2.6.up_x86_64-${TM_VERSION}.rpm; \
#     yum history sync) \
#&&  (cd /etc/ssstm/extras; rm -f .tm*.tar.gz Makefile.re) \
#&&  yum -y clean all --enablerepo='*' \
#&&  rm -rf /tmp/build \
#&&  chown root:root /tini \
#&&  chmod 0555 /tini \
#&&  mkdir -p /tmdata

# - install tmlicd

#COPY bin/tmlicd /usr/local/bin

# - install supervisord config files

#COPY config /

#EXPOSE 7800
EXPOSE 8080

#VOLUME /tmdata

#ENTRYPOINT ["/tini", "--", "/entrypoint.sh"]
#CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
