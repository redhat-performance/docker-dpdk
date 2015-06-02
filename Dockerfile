FROM registry.access.redhat.com/rhel7/rhel-tools
MAINTAINER jeder@redhat.com

LABEL RUN docker run -it --privileged -v /sys/bus/pci/drivers:/sys/bus/pci/drivers -v /sys/kernel/mm/hugepages:/sys/kernel/mm/hugepages -v /sys/devices/system/node:/sys/devices/system/node -v /dev:/dev --name NAME -e NAME=NAME -e IMAGE=IMAGE IMAGE"

# Setup yum repos, or use subscription-manager

# Install DPDK support packages.
RUN yum install -y sudo libhugetlbfs-utils libpcap-devel \
    kernel kernel-devel kernel-headers

# Build DPDK and pktgen-dpdk for x86_64-native-linuxapp-gcc.
WORKDIR /root
COPY ./build_dpdk.sh /root/build_dpdk.sh
COPY ./dpdk-profile.sh /etc/profile.d/
RUN /root/build_dpdk.sh

# Defaults to a bash shell, you could put your DPDK-based application here.
CMD ["/usr/bin/bash"]
