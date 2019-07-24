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
1. Spinup an ubuntu 18 server VM with one network interface which is connected to NAT network and login as root
2. git clone https://github.com/jayanatl/kubernetes.git
3. cd kubernetes
4. Change network interface from NAT to hostonly network
5. Switch to root: sudo su
6. Set network ip from hostonly network: netplan apply
7. bash setup_node.sh [node<x>.<domainname.com>]

NOTE: If no arguments are given node will be named as node<last octet of ip>.example.com


# Temp notes
kubeadm join 192.168.100.250:6443 --token kzhzfq.us5qapt64adughrk \
    --discovery-token-ca-cert-hash sha256:7810f714f273e496bb4e2bc3000bd1217fa16afb91aa750504bab3facb6c5022

# Sysctl,
# Configure kubeadmin
# Run fennel command
# Wait for fennel to come up, check status using kubectl get pods --all-namespaces

# join nodes
# wait for nodes to come up


# Commands which are helpful
kubectl get deploy
kubectl get nodes
kubectl get pods
kubectl delete deploy <nginx>
kubectl delete pods <podid>

# Exercises
1. Create an nginx pod
2. Create an postgres pod
3. Delete nginx pod
4. Create a repicaset with 3 nginx pods
5. Create a replica set to manage existing nginx pod and number of replicas must be 3
6. Update nginx replicaset to run 6 pods (replace configuration)
7. Scale postgres replica set to run 6 pods but without configuration update (using config file and using replicaset name)
8. Create/delete one of the pods and verify replica set working
9. What if the pod is created with an additional label say costcenter = 10