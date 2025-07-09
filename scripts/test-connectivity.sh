#!/bin/bash
# Connectivity Test Script

set -e

echo "Running connectivity tests..."

# Test 1: Check BGP sessions on spine
echo "=== Test 1: BGP Sessions on Spine ==="
docker exec clab-dc-fabric-cilium-spine1 sr_cli "show network-instance default protocols bgp neighbor"

# Test 2: Check BGP sessions on leafs
echo "=== Test 2: BGP Sessions on Leaf1 ==="
docker exec clab-dc-fabric-cilium-leaf1 sr_cli "show network-instance default protocols bgp neighbor"

echo "=== Test 3: BGP Sessions on Leaf2 ==="
docker exec clab-dc-fabric-cilium-leaf2 sr_cli "show network-instance default protocols bgp neighbor"

# Test 4: Check EVPN routes
echo "=== Test 4: EVPN Routes on Spine ==="
docker exec clab-dc-fabric-cilium-spine1 sr_cli "show network-instance default protocols bgp routes evpn"

# Test 5: Check Kubernetes cluster status
echo "=== Test 5: Kubernetes Cluster Status ==="
docker exec clab-dc-fabric-cilium-host1 kubectl get nodes -o wide

# Test 6: Check Cilium status
echo "=== Test 6: Cilium Status ==="
docker exec clab-dc-fabric-cilium-host1 cilium status

# Test 7: Check pod connectivity
echo "=== Test 7: Pod Connectivity Test ==="
POD1=$(docker exec clab-dc-fabric-cilium-host1 kubectl get pods -l app=test-pod1 -o jsonpath='{.items[0].metadata.name}')
POD2=$(docker exec clab-dc-fabric-cilium-host1 kubectl get pods -l app=test-pod2 -o jsonpath='{.items[0].metadata.name}')
POD2_IP=$(docker exec clab-dc-fabric-cilium-host1 kubectl get pod $POD2 -o jsonpath='{.status.podIP}')

echo "Pod1: $POD1"
echo "Pod2: $POD2 (IP: $POD2_IP)"

if [ ! -z "$POD2_IP" ]; then
    echo "Testing ping from $POD1 to $POD2 ($POD2_IP)..."
    docker exec clab-dc-fabric-cilium-host1 kubectl exec $POD1 -- ping -c 3 $POD2_IP
else
    echo "Could not get Pod2 IP address"
fi

# Test 8: Check service connectivity
echo "=== Test 8: Service Connectivity ==="
docker exec clab-dc-fabric-cilium-host1 kubectl get services -o wide

# Test 9: Cilium connectivity test
echo "=== Test 9: Cilium Connectivity Test ==="
docker exec clab-dc-fabric-cilium-host1 cilium connectivity test --test pod-to-pod

# Test 10: Check VXLAN tunnel status on leafs
echo "=== Test 10: VXLAN Status on Leafs ==="
docker exec clab-dc-fabric-cilium-leaf1 sr_cli "show tunnel-interface vxlan1"
docker exec clab-dc-fabric-cilium-leaf2 sr_cli "show tunnel-interface vxlan1"

# Test 11: Check EVPN instance status
echo "=== Test 11: EVPN Instance Status ==="
docker exec clab-dc-fabric-cilium-leaf1 sr_cli "show network-instance mac-vrf-100 protocols bgp-evpn"

echo "Connectivity tests completed!"
