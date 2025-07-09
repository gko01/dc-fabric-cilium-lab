#!/bin/bash
# Lab Deployment Script

set -e

echo "Starting DC Fabric with Cilium Integration Lab Deployment..."

# Check if containerlab is installed
if ! command -v containerlab &> /dev/null; then
    echo "Error: containerlab is not installed. Please install it first."
    echo "Visit: https://containerlab.dev/install/"
    exit 1
fi

# Check if required images are available
echo "Checking for required container images..."
if ! docker image inspect ghcr.io/nokia/srlinux:23.10.1 >/dev/null 2>&1; then
    echo "Pulling Nokia SR Linux image..."
    docker pull ghcr.io/nokia/srlinux:23.10.1
fi

if ! docker image inspect ghcr.io/hellt/network-multitool >/dev/null 2>&1; then
    echo "Pulling network-multitool image..."
    docker pull ghcr.io/hellt/network-multitool
fi

# Deploy the containerlab topology
echo "Deploying containerlab topology..."
containerlab deploy -t dc-fabric.yml

# Wait for containers to be ready
echo "Waiting for containers to be ready..."
sleep 60

# Check container status
echo "Checking container status..."
containerlab inspect -t dc-fabric.yml

echo "Lab deployment completed!"
echo ""
echo "Next steps:"
echo "1. Wait for all containers to be fully started"
echo "2. Run the Kubernetes initialization script on host1"
echo "3. Join host2 to the cluster"
echo "4. Install Cilium CNI"
echo "5. Deploy test pods"
echo ""
echo "Use 'containerlab destroy -t dc-fabric.yml' to clean up the lab"
