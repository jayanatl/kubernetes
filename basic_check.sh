#!/bin/bash
###############################################################################
# Author: jayanatl@gmail.com
# Description: Basic system check
# Date: 2019-07-04
###############################################################################

# Variables
hl="#####################################################################"

# Functions
ping_test() {
    ping -c1 ${1} -W1 &> /dev/null && echo -en "\e[01;32m\xE2\x9C\x94 " || echo -en "\e[01;31m\xE2\x9D\x8C"; echo -e "$1\e[0m"
}

# Main
echo ${hl}
echo -e "HOSTNAME: \e[1;36m${HOSTNAME}\e[0m"
echo ${hl}| tr '#' '-'

echo "Testing network connectivity"
echo ${hl:0:40}| tr '#' '.'
nodes=(master node1 node2 node3 router 1.1.1.1)
for node in ${nodes[@]}; do
    ping_test ${node}
done
echo ${hl}