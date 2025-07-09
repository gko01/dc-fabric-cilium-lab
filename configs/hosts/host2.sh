#!/bin/bash
# Host2 Configuration Script for Kubernetes Worker Node

set -e

echo "Configuring Host2 as Kubernetes Worker Node..."

# Configure network interface
ip addr add 192.168.2.10/24 dev eth1
ip link set eth1 up
ip route add default via 192.168.2.1

# Configure hostname
echo "host2" > /etc/hostname
hostname host2

# Add hosts entries
cat >> /etc/hosts << EOF
192.168.1.10 host1 host1.lab.local
192.168.2.10 host2 host2.lab.local
EOF

# Update system and install required packages
apt-get update
apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release

# Install Docker
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io

# Configure Docker daemon
cat > /etc/docker/daemon.json << EOF
{
    "exec-opts": ["native.cgroupdriver=systemd"],
    "log-driver": "json-file",
    "log-opts": {
        "max-size": "100m"
    },
    "storage-driver": "overlay2"
}
EOF

systemctl enable docker
systemctl start docker

# Install Kubernetes components
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat > /etc/apt/sources.list.d/kubernetes.list << EOF
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

apt-get update
apt-get install -y kubelet=1.28.0-00 kubeadm=1.28.0-00 kubectl=1.28.0-00
apt-mark hold kubelet kubeadm kubectl

# Configure kubelet
cat > /etc/default/kubelet << EOF
KUBELET_EXTRA_ARGS="--cgroup-driver=systemd"
EOF

# Disable swap
swapoff -a
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

# Enable IP forwarding
echo 'net.ipv4.ip_forward = 1' >> /etc/sysctl.conf
echo 'net.bridge.bridge-nf-call-iptables = 1' >> /etc/sysctl.conf
echo 'net.bridge.bridge-nf-call-ip6tables = 1' >> /etc/sysctl.conf
sysctl -p

# Load required kernel modules
modprobe overlay
modprobe br_netfilter
cat > /etc/modules-load.d/k8s.conf << EOF
overlay
br_netfilter
EOF

echo "Host2 configuration completed. Ready to join Kubernetes cluster."
