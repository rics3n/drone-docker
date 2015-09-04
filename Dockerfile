# Docker image for the docker plugin
#
#     docker build --rm=true -t plugins/drone-docker .

FROM gliderlabs/alpine:3.2
MAINTAINER platform-eng@c2fo.com

# Let's start with some basic stuff.
RUN apk-install iptables ca-certificates lxc e2fsprogs 

# Install Docker from Alpine repos
RUN apk-install docker

# Install the magic wrapper.
ADD ./wrapdocker /usr/local/bin/wrapdocker
ADD ./dmsetup /usr/local/bin/dmsetup
RUN chmod +x /usr/local/bin/wrapdocker /usr/local/bin/dmsetup

# Define additional metadata for our image.
ADD ./drone-docker /go/bin/
VOLUME /var/lib/docker
VOLUME /root
ENTRYPOINT ["/usr/local/bin/wrapdocker"]
