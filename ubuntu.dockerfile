FROM ubuntu:20.04

RUN apt update && \
    apt install --no-install-recommends openssh-server sudo iptables snmpd -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY ./services.sh /
COPY ./ubuntu-snmpd.conf /etc/snmp/snmpd.conf

RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1000 msa
RUN echo 'msa  ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers

RUN  echo 'msa:ubiqube' | chpasswd

RUN service ssh start && service snmpd start

EXPOSE 22 161

RUN ["chmod", "+x", "/services.sh"]
CMD ["/services.sh"]
