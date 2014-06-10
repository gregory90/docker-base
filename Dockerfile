FROM phusion/baseimage:0.9.10

# Set correct environment variables.
ENV HOME /root

# Remove ssh
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Install etcdctl
RUN \
  DEBIAN_FRONTEND=noninteractive apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y wget && \
  cd /tmp && \
  wget -q https://github.com/coreos/etcd/releases/download/v0.4.3/etcd-v0.4.3-linux-amd64.tar.gz && \
  tar xvzf etcd-v0.4.3-linux-amd64.tar.gz && \
  cd etcd-v0.4.3-linux-amd64 && \
  cp -f etcdctl /usr/local/bin && \
  wget -qO confd_0.3.0_linux_amd64.tar.gz https://github.com/kelseyhightower/confd/releases/download/v0.3.0/confd_0.3.0_linux_amd64.tar.gz && \
  tar -zxvf confd_0.3.0_linux_amd64.tar.gz && \
  mv confd /usr/local/bin/confd


# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
