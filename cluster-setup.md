# Lab environment setup
Follow https://github.com/jayanatl/kubernetes.git to create the lab infrastructure

# Cluster configuration

# Install following software on all nodes (follow official documentation)
1. docker
2. kubeadm kubelet kubectl jq
3. Configure default editor as vim
4. configure ssh password less login from workstation to all servers
5. configure kubernetes bash completion
6. setup vim config

# Setup master / initialize cluster
kubeadm init --pod-network-cidr=192.168.200.0/2

# TODO:
check on switching context
check on connecting to cluster from laptop/ws directly instead of going through master
check on user and RBAC

### Important tips
- format json !%jq .
- format yaml: Use python if needed
