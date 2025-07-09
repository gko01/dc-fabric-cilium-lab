# Quick Start Guide

## Prerequisites Check
```bash
# Check if containerlab is installed
containerlab version

# Check if Docker is running
docker info

# Check if SR Linux image is available
docker image inspect ghcr.io/nokia/srlinux:23.10.1

# Check available resources
free -h
df -h
```

## Quick Deployment (5 minutes)

1. **Deploy Lab**:
   ```bash
   make deploy
   ```

2. **Setup Kubernetes** (wait 2-3 minutes after deploy):
   ```bash
   make setup
   ```

3. **Test Connectivity**:
   ```bash
   make test
   ```

4. **Check Status**:
   ```bash
   make status
   ```

## One-Command Deployment
```bash
make all
```

## Quick Access Commands

- **Check everything**: `make status`
- **BGP status**: `make bgp-status`
- **EVPN routes**: `make evpn-routes`
- **Cilium status**: `make cilium-status`
- **Pod connectivity**: `make pod-connectivity`

## Shell Access

- **Host1**: `make shell-host1`
- **Host2**: `make shell-host2`
- **Spine1**: `make shell-spine1`
- **Leaf1**: `make shell-leaf1`
- **Leaf2**: `make shell-leaf2`

## Cleanup
```bash
make clean
```

## Key IP Addresses

| Device | Management | Loopback | Access |
|--------|------------|----------|---------|
| Spine1 | 172.21.21.10 | 10.0.0.1/32 | - |
| Leaf1  | 172.21.21.11 | 10.0.0.11/32 | 192.168.1.1/24 |
| Leaf2  | 172.21.21.12 | 10.0.0.12/32 | 192.168.2.1/24 |
| Host1  | 172.21.21.21 | - | 192.168.1.10/24 |
| Host2  | 172.21.21.22 | - | 192.168.2.10/24 |

## Troubleshooting

If BGP sessions don't come up:
```bash
make shell-spine1
# Then in SR CLI:
show interface ethernet-1/1
show network-instance default protocols bgp neighbor
```

If Kubernetes nodes aren't ready:
```bash
make shell-host1
kubectl get nodes
journalctl -u kubelet -f
```

If Cilium isn't working:
```bash
make shell-host1
cilium status
kubectl get pods -n kube-system
```
