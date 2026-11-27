.DEFAULT_GOAL := help

SHELL := /bin/bash
MAKEFLAGS += --no-print-directory

.PHONY: help token up down reload provision status validate \
        ssh nodes pods clean fclean re

SERVER_NODE := zbendahhs
WORKER_NODE := zbendahhsw

#---------------------------------------------------------------------------

up:
	@bash scripts/generate_token.sh
	@vagrant up

down:
	@vagrant halt

reload:
	@vagrant reload

provision:
	@vagrant provision

status:
	@vagrant status

validate:
	@vagrant validate
	@echo "Validating shell scripts..."
	@for script in scripts/*.sh; do \
		bash -n "$$script" || exit 1; \
		echo "✓ $$script"; \
	done
	@echo "Validation successful!"

#---------------------------------------------------------------------------

ssh:
	@NODES=$$(vagrant status --machine-readable | awk -F, \
	'$$3 == "state" && $$4 == "running" {print $$2}'); \
	COUNT=$$(echo "$$NODES" | grep -c .); \
	if [ "$$COUNT" -eq 0 ]; then \
		echo "No running nodes found."; \
	elif [ "$$COUNT" -eq 1 ]; then \
		vagrant ssh $$(echo "$$NODES" | head -n 1); \
		else \
		echo ""; \
		echo "Available Machines:"; \
		select NODE in $$NODES "Exit"; do \
			if [ "$$NODE" = "Exit" ]; then \
				exit 0; \
			elif [ -n "$$NODE" ]; then \
				vagrant ssh "$$NODE"; \
				break; \
			else \
				echo "Invalid choice. Try again."; \
			fi; \
		done; \
	fi

#---------------------------------------------------------------------------

nodes:
	@vagrant ssh $(SERVER_NODE) -c 'sudo k3s kubectl get nodes -o wide'

pods:
	@vagrant ssh $(SERVER_NODE) -c 'sudo k3s kubectl get pods -A'

namespace:
	@vagrant ssh $(SERVER_NODE) -c 'sudo k3s kubectl get ns'

#---------------------------------------------------------------------------

clean:
	@vagrant destroy -f

fclean: clean
	@rm -rf .vagrant
	@rm -f shared/token

re:
	@$(MAKE) fclean
	@$(MAKE) up

#---------------------------------------------------------------------------

help:
	@echo ""
	@echo "INCEPTION OF THINGS - P1"
	@echo ""
	@echo "CLUSTER"
	@echo "  make up          Start VMs and generate K3s token"
	@echo "  make down        Stop VMs"
	@echo "  make reload      Reload VMs"
	@echo "  make provision   Run provisioning scripts"
	@echo "  make status      Show Vagrant status"
	@echo ""
	@echo "CONNECTION"
	@echo "  make ssh         Connect to running nodes"
	@echo ""
	@echo "KUBERNETES"
	@echo "  make nodes       List Kubernetes nodes"
	@echo "  make pods        List all pods"
	@echo "  make namespace   List Kubernetes namespaces"
	@echo ""
	@echo "MAINTENANCE"
	@echo "  make validate    Validate configuration"
	@echo "  make clean       Destroy VMs"
	@echo "  make fclean      Full cleanup"
	@echo "  make re          Rebuild cluster"
	@echo ""