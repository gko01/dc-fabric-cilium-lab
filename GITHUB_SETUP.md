# GitHub Repository Setup Guide

## Step 1: Create GitHub Repository

1. **Go to GitHub** and create a new repository:
   - Visit: https://github.com/new
   - Repository name: `dc-fabric-cilium-lab` (or your preferred name)
   - Description: `Datacenter Fabric with BGP Underlay, VXLAN EVPN Overlay, and Kubernetes with Cilium CNI Lab`
   - Set as **Public** (recommended for sharing) or **Private**
   - ✅ Add a README file: **Uncheck this** (we already have one)
   - ✅ Add .gitignore: **Uncheck this** (we already have one)
   - ✅ Choose a license: **MIT License** (recommended)

## Step 2: Initialize Local Git Repository

Run these commands in your lab directory:

```bash
# Initialize git repository
git init

# Add all files
git add .

# Create initial commit
git commit -m "Initial commit: DC Fabric with VXLAN EVPN and Cilium CNI lab"

# Add your GitHub repository as remote (replace with your actual repo URL)
git remote add origin https://github.com/gko01/dc-fabric-cilium-lab.git

# Set main branch
git branch -M main

# Push to GitHub
git push -u origin main
```

## Step 3: Repository Structure

Your repository will contain:

```
dc-fabric-cilium-lab/
├── README.md                    # Main documentation with architecture diagram
├── QUICKSTART.md               # Quick start guide
├── Makefile                    # Automation commands
├── dc-fabric.yml               # Containerlab topology
├── .gitignore                  # Git ignore rules
├── GITHUB_SETUP.md            # This setup guide
├── configs/                    # Device configurations
│   ├── spine/
│   │   └── spine1.cfg         # Nokia SR Linux spine config
│   ├── leaf/
│   │   ├── leaf1.cfg          # Nokia SR Linux leaf configs
│   │   └── leaf2.cfg
│   └── hosts/
│       ├── host1.sh           # Kubernetes master setup
│       └── host2.sh           # Kubernetes worker setup
├── k8s/                       # Kubernetes configurations
│   ├── init-cluster.sh        # Cluster initialization
│   ├── install-cilium.sh      # Cilium CNI installation
│   ├── cilium-bgp-config.yaml # Cilium BGP configuration
│   └── test-pods.yaml         # Test pod deployments
└── scripts/                   # Automation scripts
    ├── deploy-lab.sh          # Lab deployment
    ├── setup-k8s.sh           # Kubernetes setup
    ├── test-connectivity.sh   # Connectivity testing
    └── cleanup-lab.sh         # Lab cleanup
```

## Step 4: Repository Topics and Description

After creating the repository, add these topics for better discoverability:

**Topics to add:**
- `containerlab`
- `nokia-srlinux`
- `bgp`
- `evpn`
- `vxlan`
- `kubernetes`
- `cilium`
- `cni`
- `datacenter`
- `networking`
- `lab`
- `sdn`

**Repository Description:**
```
🏗️ Datacenter Fabric Lab with BGP IPv6 Link-Local Underlay, VXLAN EVPN Overlay, and Kubernetes with Cilium CNI. Built with Containerlab and Nokia SR Linux.
```

## Step 5: Create Repository Badges

Add these badges to your README.md (replace USERNAME/REPO):

```markdown
[![Lab Status](https://img.shields.io/badge/Lab-Production%20Ready-green)](https://github.com/USERNAME/REPO)
[![Containerlab](https://img.shields.io/badge/Containerlab-0.68+-blue)](https://containerlab.dev/)
[![Nokia SR Linux](https://img.shields.io/badge/Nokia%20SR%20Linux-23.10.1-orange)](https://www.nokia.com/networks/products/service-router-linux-NOS/)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-1.28-blue)](https://kubernetes.io/)
[![Cilium](https://img.shields.io/badge/Cilium-1.14.5-purple)](https://cilium.io/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
```

## Step 6: Enable GitHub Pages (Optional)

To showcase your lab documentation:

1. Go to repository **Settings**
2. Scroll to **Pages** section
3. Source: **Deploy from a branch**
4. Branch: **main**
5. Folder: **/ (root)**
6. Save

Your documentation will be available at: `https://USERNAME.github.io/REPO-NAME`

## Step 7: Create Release

After successful testing:

1. Go to **Releases** in your repository
2. Click **Create a new release**
3. Tag version: `v1.0.0`
4. Release title: `DC Fabric with Cilium CNI Lab v1.0.0`
5. Description:
   ```markdown
   ## 🎉 Initial Release - DC Fabric with VXLAN EVPN and Cilium CNI Lab
   
   ### Features
   - ✅ BGP IPv6 Link-Local Underlay (No OSPF/ISIS needed)
   - ✅ VXLAN EVPN Overlay with Nokia SR Linux
   - ✅ 2-node Kubernetes cluster
   - ✅ Cilium CNI with BGP control plane
   - ✅ Automated deployment with Makefile
   - ✅ Comprehensive testing and validation
   
   ### Quick Start
   ```bash
   git clone https://github.com/USERNAME/REPO-NAME.git
   cd REPO-NAME
   make all
   ```
   
   ### Requirements
   - Containerlab 0.68+
   - Docker
   - 8GB+ RAM recommended
   ```
6. Click **Publish release**

## Step 8: Repository Collaboration

To allow others to contribute:

1. **Settings** → **Manage access**
2. Add collaborators if needed
3. Set up **branch protection rules** for main branch (optional)

## Step 9: Documentation Links

Add these links to your repository description:

- 📖 [Quick Start Guide](QUICKSTART.md)
- 🏗️ [Architecture Documentation](README.md)
- 🚀 [Deployment Scripts](scripts/)
- ⚙️ [Configuration Files](configs/)

## Step 10: Community Files

Consider adding these community files:

- `CONTRIBUTING.md` - Contribution guidelines
- `CODE_OF_CONDUCT.md` - Code of conduct
- `SECURITY.md` - Security policy
- `CHANGELOG.md` - Version history

## Commands Summary

```bash
# Clone your repository
git clone https://github.com/gko01/dc-fabric-cilium-lab.git
cd dc-fabric-cilium-lab

# Deploy the lab
make all

# Check status
make status

# Clean up
make cleanup
```

Your repository is now ready to share with the networking community! 🎉
