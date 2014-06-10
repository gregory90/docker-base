FROM phusion/baseimage:0.9.10

# Set correct environment variables.
ENV HOME /root

# Remove ssh
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Install etcdctl
RUN \
  cd /tmp && \
  wget https://github.com/coreos/etcd/releases/download/v0.4.3/etcd-v0.4.3-linux-amd64.tar.gz && \
  tar xvzf etcd-v0.4.3-linux-amd64.tar.gz && \
  cd etcd-v0.4.3-linux-amd64.tar.gz && \
  cp -f etcdctl /usr/local/bin

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
