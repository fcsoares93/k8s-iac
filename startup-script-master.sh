#!/bin/bash -e

###Update the system:
sudo apt-get update -y
### Turn off Swap
sudo swapoff -a
### Install Curl
sudo apt-get install -y curl
###Install Docker:
sudo curl -fsSL https://get.docker.com | bash
### Enable Docker
sudo systemctl enable docker
###Install Kubernetes and Add Kubernetes Signing Key
sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
### Add Software Repositories
sudo echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list
###Update the system:
sudo apt-get update -y
### Removing trash files
sudo apt-get autoremove -y
###Kubernetes Installation Tools
sudo apt-get install -y kubeadm kubelet kubectl
### Start Containerd
sudo systemctl start containerd
### Fix kubelet
cat > /etc/containerd/config.toml <<EOF
[plugins."io.containerd.grpc.v1.cri"]
  systemd_cgroup = true
EOF
### Restart conteinerd
sudo systemctl restart containerd
### Initiate Kubeadm and configure Master
sudo kubeadm init --apiserver-advertise-address $(hostname -i)
### Commands to start a cluster 1
# mkdir -p $HOME/.kube
# # ### Commands to start a cluster 2
# sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
# ### Commands to start a cluster 3
# sudo chown $(id -u):$(id -g) $HOME/.kube/config
### Add pod network On
# kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
EOF