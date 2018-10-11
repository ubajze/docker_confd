# Download base ubuntu image
FROM ubuntu:16.04

# Install openssl and openssh-server
RUN apt-get update && \
    apt-get -y install openssl && \
    apt-get -y install openssh-server && \
    apt-get -y install make


ARG yangfile=configuration

# Copy ConfD installer to the container
COPY confd-basic-6.6.linux.x86_64.installer.bin /tmp

# Install the ConfD to /confd folder
RUN /bin/sh /tmp/confd-basic-6.6.linux.x86_64.installer.bin /confd

# Copy the custom YANG file, compile the file
# and copy the compiled file to the
# correct directory
COPY $yangfile.yang /confd/src/confd/yang/
RUN . /confd/confdrc && \
    cd /confd/src/confd/yang/ && \
    make && \
    cp $yangfile.fxs /confd/etc/confd/ && \
    make clean

# Run ConfD in foreground
CMD ["/confd/bin/confd", "--foreground"]

