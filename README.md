# docker-centos-vm [![Build Status][svg-travis]][travis]

A lightweight CentOS VM in Docker. [Based on `geerlingguy/docker-centos7-ansible`][upstream], do read the author's [excellent post][post] about testing Ansible across multiple operating systems.

Published to the Docker Hub as `naftulikay/centos-vm`.

### Running:

```
docker run --detach --privileged --volume=/sys/fs/cgroup:/sys/fs/cgroup:ro naftulikay/centos-vm:7
```

### Testing Ansible Roles

To test Ansible roles, pass something of the following to mount your role and execute your tests against it:

```
--volume=$(pwd):/etc/ansible/roles/$ROLE_NAME:ro
```

When starting the container, a container ID is emitted; this can be saved and used to execute commands within the Docker
"VM":

```
docker exec --tty $CONTAINER_ID env TERM=xterm ansible --version
docker exec --tty $CONTAINER_ID env TERM=xterm ansible-playbook /path/to/ansible/playbook.yml --syntax-check
```

 [travis]: https://travis-ci.org/naftulikay/docker-centos-vm
 [svg-travis]: https://travis-ci.org/naftulikay/docker-centos-vm.svg?branch=develop
 [post]: https://www.jeffgeerling.com/blog/2016/how-i-test-ansible-configuration-on-7-different-oses-docker
 [upstream]: https://hub.docker.com/r/geerlingguy/docker-centos7-ansible/
