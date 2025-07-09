# Makefile for DC Fabric with Cilium Integration Lab

.PHONY: help deploy setup test clean status

help:  ## Show this help message
	@echo "DC Fabric with Cilium Integration Lab"
	@echo ""
	@echo "Available targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-15s %s\n", $$1, $$2}'

deploy:  ## Deploy the containerlab topology
	@echo "Deploying DC Fabric lab..."
	@chmod +x scripts/*.sh
	@./scripts/deploy-lab.sh

setup:  ## Setup Kubernetes cluster with Cilium CNI
	@echo "Setting up Kubernetes cluster..."
	@./scripts/setup-k8s.sh

test:  ## Run connectivity tests
	@echo "Running connectivity tests..."
	@./scripts/test-connectivity.sh

status:  ## Show lab status
	@echo "=== Containerlab Status ==="
	@containerlab inspect -t dc-fabric.yml || echo "Lab not deployed"
	@echo ""
	@echo "=== Kubernetes Status ==="
	@docker exec clab-dc-fabric-cilium-host1 kubectl get nodes -o wide 2>/dev/null || echo "K8s cluster not ready"
	@echo ""
	@echo "=== Pod Status ==="
	@docker exec clab-dc-fabric-cilium-host1 kubectl get pods -o wide 2>/dev/null || echo "Pods not deployed"

clean:  ## Clean up the lab environment
	@echo "Cleaning up lab..."
	@./scripts/cleanup-lab.sh

all: deploy setup test  ## Deploy, setup, and test the complete lab

# Quick access commands
bgp-status:  ## Check BGP status on all devices
	@echo "=== Spine BGP Status ==="
	@docker exec clab-dc-fabric-cilium-spine1 sr_cli "show network-instance default protocols bgp neighbor" || echo "Spine not ready"
	@echo ""
	@echo "=== Leaf1 BGP Status ==="
	@docker exec clab-dc-fabric-cilium-leaf1 sr_cli "show network-instance default protocols bgp neighbor" || echo "Leaf1 not ready"
	@echo ""
	@echo "=== Leaf2 BGP Status ==="
	@docker exec clab-dc-fabric-cilium-leaf2 sr_cli "show network-instance default protocols bgp neighbor" || echo "Leaf2 not ready"

evpn-routes:  ## Show EVPN routes
	@echo "=== EVPN Routes on Spine ==="
	@docker exec clab-dc-fabric-cilium-spine1 sr_cli "show network-instance default protocols bgp routes evpn" || echo "Spine not ready"

cilium-status:  ## Check Cilium status
	@echo "=== Cilium Status ==="
	@docker exec clab-dc-fabric-cilium-host1 cilium status || echo "Cilium not ready"

pod-connectivity:  ## Test pod-to-pod connectivity
	@echo "=== Testing Pod Connectivity ==="
	@POD1=$$(docker exec clab-dc-fabric-cilium-host1 kubectl get pods -l app=test-pod1 -o jsonpath='{.items[0].metadata.name}' 2>/dev/null); \
	POD2_IP=$$(docker exec clab-dc-fabric-cilium-host1 kubectl get pods -l app=test-pod2 -o jsonpath='{.items[0].status.podIP}' 2>/dev/null); \
	if [ ! -z "$$POD2_IP" ]; then \
		echo "Testing ping from $$POD1 to $$POD2_IP"; \
		docker exec clab-dc-fabric-cilium-host1 kubectl exec $$POD1 -- ping -c 3 $$POD2_IP; \
	else \
		echo "Test pods not ready"; \
	fi

logs:  ## Show logs from key components
	@echo "=== Cilium Logs ==="
	@docker exec clab-dc-fabric-cilium-host1 kubectl logs -n kube-system -l k8s-app=cilium --tail=50 || echo "Cilium not ready"

shell-host1:  ## Access host1 shell
	@docker exec -it clab-dc-fabric-cilium-host1 bash

shell-host2:  ## Access host2 shell
	@docker exec -it clab-dc-fabric-cilium-host2 bash

shell-spine1:  ## Access spine1 CLI
	@docker exec -it clab-dc-fabric-cilium-spine1 sr_cli

shell-leaf1:  ## Access leaf1 CLI
	@docker exec -it clab-dc-fabric-cilium-leaf1 sr_cli

shell-leaf2:  ## Access leaf2 CLI
	@docker exec -it clab-dc-fabric-cilium-leaf2 sr_cli
