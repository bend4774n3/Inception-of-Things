# Inception of Things – P1

## Overview

P1 introduces Kubernetes using **K3s** and **Vagrant**. It creates a multi-node cluster with one server node and one worker node running on VirtualBox.

## Architecture

- **Server:** Runs the K3s control plane.
- **Worker:** Joins the cluster as a worker node.
- **Vagrant:** Manages virtual machines.
- **K3s:** Lightweight Kubernetes distribution.

## Network

| Node | IP Address |
|---|---|
| Server(zbendahhs) | `192.168.56.110` |
| Worker(zbendahhsw) | `192.168.56.111` |


## Usage

```bash
make help       # Show available commands
make up         # Generate token and start cluster
make status     # Show VM status
make ssh        # Connect to a running node
make nodes      # List Kubernetes nodes
make pods       # List all pods
make namespace  # List namespaces
make down       # Stop VMs
make validate   # Validate configuration
make clean      # Destroy VMs
make fclean     # Full cleanup
make re         # Rebuild cluster
```

## Project Structure

```text
p1/
├── Vagrantfile
├── Makefile
├── MEADME.md
├── scripts/
│   ├── bootstrap_controller.sh
│   ├── bootstrap_worker.sh
│   └── generate_token.sh
└── shared/
    └── token
```

## Goal

Deploy and manage a multi-node Kubernetes cluster using K3s, Vagrant, and VirtualBox.