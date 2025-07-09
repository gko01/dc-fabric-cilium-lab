#!/bin/bash
# GitHub Repository Setup Script

set -e

echo "🚀 Setting up GitHub repository for DC Fabric Cilium Lab..."

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "❌ Git is not installed. Please install git first."
    exit 1
fi

# Check if we're already in a git repository
if [ -d ".git" ]; then
    echo "⚠️  This directory is already a git repository."
    read -p "Do you want to continue? This will reset the git repository. (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "❌ Aborted."
        exit 1
    fi
    rm -rf .git
fi

# Get GitHub username and repository name
echo "📝 Please provide your GitHub details:"
read -p "GitHub username: " GITHUB_USERNAME
read -p "Repository name (default: dc-fabric-cilium-lab): " REPO_NAME
REPO_NAME=${REPO_NAME:-dc-fabric-cilium-lab}

echo ""
echo "📋 Repository setup summary:"
echo "   Username: $GITHUB_USERNAME"
echo "   Repository: $REPO_NAME"
echo "   URL: https://github.com/$GITHUB_USERNAME/$REPO_NAME"
echo ""

read -p "Continue with setup? (Y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo "❌ Aborted."
    exit 1
fi

# Update README badges with actual username/repo
echo "🔧 Updating README badges..."
sed -i "s/YOUR_USERNAME/$GITHUB_USERNAME/g" README.md
sed -i "s/dc-fabric-cilium-lab/$REPO_NAME/g" README.md

# Update GITHUB_SETUP.md with actual details
sed -i "s/YOUR_USERNAME/$GITHUB_USERNAME/g" GITHUB_SETUP.md
sed -i "s/dc-fabric-cilium-lab/$REPO_NAME/g" GITHUB_SETUP.md

# Update CONTRIBUTING.md
sed -i "s/YOUR_USERNAME/$GITHUB_USERNAME/g" CONTRIBUTING.md
sed -i "s/dc-fabric-cilium-lab/$REPO_NAME/g" CONTRIBUTING.md

# Initialize git repository
echo "📦 Initializing git repository..."
git init

# Add all files
echo "📁 Adding files to git..."
git add .

# Create initial commit
echo "💾 Creating initial commit..."
git commit -m "Initial commit: DC Fabric with VXLAN EVPN and Cilium CNI lab

Features:
- BGP IPv6 Link-Local Underlay
- VXLAN EVPN Overlay with Nokia SR Linux  
- 2-node Kubernetes cluster
- Cilium CNI with BGP control plane
- Automated deployment and testing
- Comprehensive documentation"

# Set main branch
git branch -M main

# Add remote origin
echo "🔗 Adding GitHub remote..."
git remote add origin https://github.com/$GITHUB_USERNAME/$REPO_NAME.git

echo ""
echo "✅ Git repository initialized successfully!"
echo ""
echo "📋 Next steps:"
echo "1. Create the repository on GitHub:"
echo "   https://github.com/new"
echo "   - Repository name: $REPO_NAME"
echo "   - Description: 🏗️ Datacenter Fabric Lab with BGP IPv6 Link-Local Underlay, VXLAN EVPN Overlay, and Kubernetes with Cilium CNI"
echo "   - Set as Public"
echo "   - DON'T add README, .gitignore, or license (we have them)"
echo ""
echo "2. Push to GitHub:"
echo "   git push -u origin main"
echo ""
echo "3. Add repository topics on GitHub:"
echo "   containerlab, nokia-srlinux, bgp, evpn, vxlan, kubernetes, cilium, cni, datacenter, networking, lab, sdn"
echo ""
echo "4. Test your lab:"
echo "   make all"
echo ""
echo "🎉 Your repository is ready to share with the world!"
