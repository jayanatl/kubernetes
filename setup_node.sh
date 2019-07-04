#!/bin/bash
###############################################################################
# Author: jayanatl@gmail.com
# Description: Basic setup script
# Date: 2019-07-04
###############################################################################


# Find network the machine is in and calculate hostname
nw=$(ip a s enp0s3 |grep -w inet|awk '{print $2}')
ip=${nw%/*}
fqdn=${1:-node${ip/*.}.example.com}
dnsips="1.1.1.1, 1.0.0.1"

# setup /etc/hosts
bash hosts_generator.sh ${nw%.*} ${fqdn#*.} || exit 127

# Setup hostname based on nodename or ipaddress
sed -i 's/preserve_hostname: false/preserve_hostname: true/' /etc/cloud/cloud.cfg
hostnamectl set-hostname ${fqdn}

# Setup static ip and default route via router.<domainname>
ip=$(grep ${fqdn} /etc/hosts|cut -d" " -f1)/${nw#*/}
router=$(grep router /etc/hosts|cut -d" " -f1)

netplan=$(/etc/netplan/*-cloud-init.yaml)
cp ${netplan} ${netplan}.$(date +%s) || exit 127

cat << EOF > ${netplan}
# This file is generated from information provided by
# the datasource.  Changes to it will not persist across an instance.
# To disable cloud-init's network configuration capabilities, write a file
# /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg with the following:
# network: {config: disabled}
network:
    ethernets:
        enp0s3:
            dhcp4: false
            addresses: [${ip}]
            nameservers:
                addresses: [${dnsips}]
            routes:
                - to: 0.0.0.0/0
                  via: ${router}
                  metric: 100
    version: 2
EOF
netplan apply

# Setup basic_checks
mv /etc/update-motd.d /etc/update-motd.d.$(date +%s) || exit 127
mkdir /etc/update-motd.d
cp basic_check.sh /etc/update-motd.d/basic_check
chmod a+x /etc/update-motd.d/basic_check

# Reboot server
# reboot