###Update the system:
sudo apt-get update -y
### Turn off Swap
sudo swapoff -a 
### Install Curl
sudo apt-get install -y curl
###Install Docker:
curl -fsSL https://get.docker.com | bash
sh get-docker.sh
###Install Kubernetes and Add Kubernetes Signing Key
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
### Add Software Repositories
sudo echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
###Update the system:
sudo apt-get update -y
### Removing trash files
sudo apt-get autoremove -y
###Kubernetes Installation Tools
sudo apt-get install -y kubeadm kubelet kubectl