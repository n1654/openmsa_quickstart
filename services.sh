#!/bin/sh

# RUN SNMPD
snmpd -C -c /etc/snmp/snmpd.conf

# RUN SSHD
/usr/sbin/sshd -D
