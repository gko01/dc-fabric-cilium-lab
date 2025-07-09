# Contributing to DC Fabric with Cilium CNI Lab

Thank you for your interest in contributing to this lab! 🎉

## How to Contribute

### 🐛 Bug Reports
- Check existing issues first
- Use the bug report template
- Include lab environment details
- Provide reproduction steps

### ✨ Feature Requests
- Check existing feature requests
- Describe the use case
- Explain the expected behavior
- Consider implementation complexity

### 🔧 Code Contributions

#### Setup Development Environment
```bash
git clone https://github.com/YOUR_USERNAME/dc-fabric-cilium-lab.git
cd dc-fabric-cilium-lab
```

#### Testing Your Changes
```bash
# Test deployment
make deploy

# Test full setup
make all

# Test specific components
make bgp-status
make cilium-status

# Clean up
make cleanup
```

#### Pull Request Process
1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Make your changes
4. Test thoroughly
5. Update documentation if needed
6. Commit: `git commit -m "Add amazing feature"`
7. Push: `git push origin feature/amazing-feature`
8. Create a Pull Request

### 📝 Documentation Improvements
- Fix typos or grammar
- Add examples
- Improve clarity
- Update outdated information

### 🧪 Lab Enhancements
- Add new test scenarios
- Improve automation scripts
- Add monitoring capabilities
- Enhance error handling

## Code Style

### Shell Scripts
- Use `#!/bin/bash`
- Add `set -e` for error handling
- Include comments for complex logic
- Use meaningful variable names

### Configuration Files
- Follow vendor best practices
- Include inline comments
- Use consistent formatting
- Validate syntax

### Documentation
- Use clear, concise language
- Include code examples
- Add diagrams where helpful
- Update table of contents

## Lab Environment

### Minimum Requirements
- **CPU**: 4+ cores
- **Memory**: 8GB+ RAM
- **Storage**: 20GB+ free space
- **OS**: Linux (Ubuntu 20.04+ recommended)

### Software Dependencies
- Containerlab 0.68+
- Docker 20.10+
- Git

### Testing Checklist
- [ ] Lab deploys successfully
- [ ] BGP sessions establish
- [ ] EVPN routes exchange
- [ ] Kubernetes cluster forms
- [ ] Cilium CNI works
- [ ] Pod-to-pod connectivity
- [ ] Services accessible
- [ ] Cleanup works properly

## Issue Templates

### Bug Report
```markdown
**Describe the bug**
A clear description of what the bug is.

**To Reproduce**
Steps to reproduce the behavior:
1. Run command '...'
2. See error

**Expected behavior**
What you expected to happen.

**Environment:**
- OS: [e.g. Ubuntu 22.04]
- Containerlab version: [e.g. 0.68.0]
- Docker version: [e.g. 24.0.0]

**Additional context**
Add any other context about the problem.
```

### Feature Request
```markdown
**Is your feature request related to a problem?**
A clear description of what the problem is.

**Describe the solution you'd like**
A clear description of what you want to happen.

**Describe alternatives you've considered**
Alternative solutions or features you've considered.

**Additional context**
Add any other context about the feature request.
```

## Recognition

Contributors will be acknowledged in:
- README.md Contributors section
- Release notes
- GitHub repository insights

## Questions?

- 💬 Start a [Discussion](https://github.com/YOUR_USERNAME/dc-fabric-cilium-lab/discussions)
- 🐛 Open an [Issue](https://github.com/YOUR_USERNAME/dc-fabric-cilium-lab/issues)
- 📧 Contact maintainers

## Code of Conduct

This project follows the [Contributor Covenant](https://www.contributor-covenant.org/) Code of Conduct.

---

Happy contributing! 🚀
