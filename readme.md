# README
This repo contains scripts to setup nodes for kubernetes exercise. 

## Prerequisite
1. Install virtual box
2. Configure a hostonly network with your preffered ip range (/24)
3. Configure last octet of DHCP and server IP to 251
4. Create a VM with 2 interface
    - enp0s3 connected to NAT
    - enp0s8 connected to hostonly network you created on step2
5. Configure it as a NAT gateway for your hostonly network (last octet of ip should be 254)

## Executing the script
1. Spinup an ubuntu 18 server VM and login as root
2. git clone https://github.com/jayanatl/kubernetes.git
3. cd kubernetes
4. bash setup_node.sh [node<x>.<domainname.com>]
NOTE: if no arguments are given node will be named as node<last octet of ip>.example.com