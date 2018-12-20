# docker-centos7-vm [![Build Status][travis.svg]][travis] [![Docker Build][docker.svg]][docker]

A lightweight CentOS 7 VM in Docker, primarily used for integration testing of Ansible roles.

## Usage

The image and container can be built and started like so:

```
$ docker build -t naftulikay/centos7-vm:latest ./
$ docker run -d --name centos7 -v /sys/fs/cgroup:/sys/fs/cgroup:ro --privileged \
      naftulikay/centos7-vm:latest
$ docker exec -it centos7 wait-for-boot
```

View [`docker-compose.yml`](./docker-compose.yml) for a working reference on how to build and run the image/container.

## License

Licensed at your discretion under either:

 - [MIT License](./LICENSE-MIT)
 - [Apache License, Version 2.0](./LICENSE-APACHE)

 [docker]: https://hub.docker.com/r/naftulikay/centos7-vm/
 [docker.svg]: https://img.shields.io/docker/automated/naftulikay/centos7-vm.svg?maxAge=2592001
 [travis]: https://travis-ci.org/naftulikay/docker-centos7-vm
 [travis.svg]: https://travis-ci.org/naftulikay/docker-centos7-vm.svg?branch=master
