#!/bin/bash
# Setup Kubernetes Cluster Script

set -e

echo "Setting up Kubernetes cluster..."

# Wait for hosts to be ready
echo "Waiting for hosts to be ready..."
sleep 30

# Step 1: Initialize cluster on host1
echo "Step 1: Initializing Kubernetes cluster on host1..."
docker exec clab-dc-fabric-cilium-host1 bash /tmp/k8s/init-cluster.sh

# Step 2: Get join command
echo "Step 2: Getting join command..."
JOIN_CMD=$(docker exec clab-dc-fabric-cilium-host1 cat /tmp/join-command.sh)

# Step 3: Join host2 to cluster
echo "Step 3: Joining host2 to cluster..."
docker exec clab-dc-fabric-cilium-host2 bash -c "$JOIN_CMD"

# Step 4: Install Cilium CNI
echo "Step 4: Installing Cilium CNI..."
docker exec clab-dc-fabric-cilium-host1 bash /tmp/k8s/install-cilium.sh

# Step 5: Wait for nodes to be ready
echo "Step 5: Waiting for nodes to be ready..."
docker exec clab-dc-fabric-cilium-host1 kubectl wait --for=condition=Ready nodes --all --timeout=300s

# Step 6: Apply Cilium BGP configuration
echo "Step 6: Applying Cilium BGP configuration..."
docker exec clab-dc-fabric-cilium-host1 kubectl apply -f /tmp/k8s/cilium-bgp-config.yaml

# Step 7: Deploy test pods
echo "Step 7: Deploying test pods..."
docker exec clab-dc-fabric-cilium-host1 kubectl apply -f /tmp/k8s/test-pods.yaml

# Step 8: Wait for pods to be ready
echo "Step 8: Waiting for pods to be ready..."
docker exec clab-dc-fabric-cilium-host1 kubectl wait --for=condition=Ready pods --all --timeout=300s

echo "Kubernetes cluster setup completed!"
echo ""
echo "Cluster status:"
docker exec clab-dc-fabric-cilium-host1 kubectl get nodes -o wide
echo ""
echo "Pod status:"
docker exec clab-dc-fabric-cilium-host1 kubectl get pods -o wide
