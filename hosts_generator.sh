#!/bin/bash
###############################################################################
# Author: jayanatl@gmail.com
# Description: /etc/hosts file generator
# Date: 2019-07-04
###############################################################################

cp /etc/hosts /etc/hosts.$(date +%s)

baseip=${1:-192.168.100}
domain=${2:-example.com}
for ((i=1; i<250; ++i)); do
    echo ${baseip}.${i} node${i}.${domain} node${i} >> /etc/hosts1
done

# Static entries
cat << EOF >> /etc/hosts1
${baseip}.250 master.${domain} master
${baseip}.251 vmhost.${domain} vmhost
${baseip}.254 router.${domain} router nat
EOF