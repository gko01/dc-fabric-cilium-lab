#!/bin/bash
# Install Cilium CNI

set -e

echo "Installing Cilium CNI..."

# Install Cilium CLI
CILIUM_CLI_VERSION=$(curl -s https://raw.githubusercontent.com/cilium/cilium-cli/main/stable.txt)
CLI_ARCH=amd64
if [ "$(uname -m)" = "aarch64" ]; then CLI_ARCH=arm64; fi
curl -L --fail --remote-name-all https://github.com/cilium/cilium-cli/releases/download/${CILIUM_CLI_VERSION}/cilium-linux-${CLI_ARCH}.tar.gz{,.sha256sum}
sha256sum --check cilium-linux-${CLI_ARCH}.tar.gz.sha256sum
sudo tar xzvfC cilium-linux-${CLI_ARCH}.tar.gz /usr/local/bin
rm cilium-linux-${CLI_ARCH}.tar.gz{,.sha256sum}

# Install Cilium with VXLAN overlay and BGP support
cilium install \
  --version 1.14.5 \
  --set operator.replicas=1 \
  --set tunnel=vxlan \
  --set ipam.mode=kubernetes \
  --set kubeProxyReplacement=partial \
  --set k8sServiceHost=192.168.1.10 \
  --set k8sServicePort=6443 \
  --set bgpControlPlane.enabled=true \
  --set routingMode=tunnel \
  --set autoDirectNodeRoutes=false \
  --set ipv4NativeRoutingCIDR="10.244.0.0/16" \
  --set enableIPv6=false \
  --set prometheus.enabled=true \
  --set operator.prometheus.enabled=true \
  --set hubble.enabled=true \
  --set hubble.relay.enabled=true \
  --set hubble.ui.enabled=true

echo "Waiting for Cilium to be ready..."
cilium status --wait

echo "Cilium installation completed!"

# Enable Hubble UI port-forward (optional)
# kubectl port-forward -n kube-system svc/hubble-ui 12000:80 &
