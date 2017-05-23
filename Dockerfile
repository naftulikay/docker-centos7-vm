FROM centos:7
MAINTAINER Naftuli Kay <me@naftuli.wtf>
# with credits upstream: https://hub.docker.com/r/geerlingguy/docker-centos7-ansible/

ENV container=docker

# install and configure systemd;
# > [b]ut systemd starts tons of services in the container like udev, getty logins, ... I only want to run systemd,
# > journald, [...] within the container
# - Dan Walsh: https://developers.redhat.com/blog/2014/05/05/running-systemd-within-docker-container/
RUN yum -y update >/dev/null ; yum clean all >/dev/null ; \
  ( cd /lib/systemd/system/sysinit.target.wants/; for i in *; do \
    [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; \
  done ); \
  rm -f /lib/systemd/system/multi-user.target.wants/*; \
  rm -f /etc/systemd/system/*.wants/*; \
  rm -f /lib/systemd/system/local-fs.target.wants/*; \
  rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
  rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
  rm -f /lib/systemd/system/basic.target.wants/*; \
  rm -f /lib/systemd/system/anaconda.target.wants/*;

# install ansible and system utilities
RUN yum makecache fast >/dev/null \
 && yum -y install deltarpm epel-release initscripts >/dev/null \
 && yum -y update >/dev/null \
 && yum -y install ansible sudo which >/dev/null \
 && yum clean all >/dev/null

# disable requiretty.
RUN sed -i -e 's/^\(Defaults\s*requiretty\)/#--- \1/' /etc/sudoers

# install local inventory file.
RUN echo -e '[local]\nlocalhost ansible_connection=local' > /etc/ansible/hosts

VOLUME ["/sys/fs/cgroup"]

ENTRYPOINT ["/usr/sbin/init"]
