FROM debian:8
MAINTAINER Louie Miranda <lmiranda@gmail.com>
ADD rootfs.tar.xz /
CMD ["/bin/bash"]