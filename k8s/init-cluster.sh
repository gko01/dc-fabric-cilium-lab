#!/bin/bash
# Kubernetes Cluster Initialization Script

set -e

echo "Initializing Kubernetes cluster..."

# Initialize Kubernetes cluster on host1
kubectl_config_file="/tmp/kubeadm-config.yaml"

# Create kubeadm configuration
cat > $kubectl_config_file << EOF
apiVersion: kubeadm.k8s.io/v1beta3
kind: ClusterConfiguration
kubernetesVersion: v1.28.0
controlPlaneEndpoint: "192.168.1.10:6443"
networking:
  serviceSubnet: "10.96.0.0/12"
  podSubnet: "10.244.0.0/16"
  dnsDomain: "cluster.local"
apiServer:
  advertiseAddress: "192.168.1.10"
  bindPort: 6443
etcd:
  local:
    dataDir: "/var/lib/etcd"
---
apiVersion: kubeadm.k8s.io/v1beta3
kind: InitConfiguration
localAPIEndpoint:
  advertiseAddress: "192.168.1.10"
  bindPort: 6443
nodeRegistration:
  criSocket: "unix:///var/run/containerd/containerd.sock"
  kubeletExtraArgs:
    cgroup-driver: "systemd"
EOF

# Initialize cluster
kubeadm init --config=$kubectl_config_file --skip-phases=addon/kube-proxy

# Setup kubectl for root user
mkdir -p /root/.kube
cp -i /etc/kubernetes/admin.conf /root/.kube/config
chown root:root /root/.kube/config

# Generate join command for worker node
kubeadm token create --print-join-command > /tmp/join-command.sh
chmod +x /tmp/join-command.sh

echo "Kubernetes cluster initialized successfully!"
echo "Join command saved to /tmp/join-command.sh"
