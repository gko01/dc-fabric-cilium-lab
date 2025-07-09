#!/bin/bash
# Cleanup Lab Script

set -e

echo "Cleaning up DC Fabric with Cilium Integration Lab..."

# Destroy containerlab topology
echo "Destroying containerlab topology..."
containerlab destroy -t dc-fabric.yml

# Clean up any remaining containers
echo "Cleaning up remaining containers..."
docker system prune -f

echo "Lab cleanup completed!"
