FROM centos:7
MAINTAINER Naftuli Kay <me@naftuli.wtf>
# with credits upstream: https://hub.docker.com/r/geerlingguy/docker-centos7-ansible/

# systemd wants this: http://red.ht/2sPKSZA
ENV container=docker

# allow man page installation
RUN sed -i '/tsflags=nodocs/d' /etc/yum.conf

# install (reinstall in order to get man pages)
RUN yum makecache fast >/dev/null \
  && yum -y install deltarpm initscripts sudo which less >/dev/null \
  && yum list installed -q | tail -n +2 | awk '{print $1;}' | xargs yum reinstall -y >/dev/null \
  && yum clean all >/dev/null

# configuration
RUN sed -i -e 's/^\(Defaults\s*requiretty\)/#--- \1/' /etc/sudoers \
  && mkdir /etc/systemd/system/network.service.d/ \
  && echo -e '[Unit]\nConditionVirtualization=!container' > /etc/systemd/system/network.service.d/99-docker.conf \
  && rm -f /etc/machine-id \
       /usr/lib/systemd/system/sysinit.target.wants/systemd-firstboot.service \
       /usr/lib/systemd/system/multi-user.target.wants/getty.target

# our own utility for awaiting systemd "boot" in the container
COPY bin/systemd-await-target /usr/bin/systemd-await-target
COPY bin/wait-for-boot /usr/bin/wait-for-boot

ENTRYPOINT ["/usr/sbin/init"]
