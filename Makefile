.PHONY: init format validate plan apply destroy clean setup all check package-gcp package-azure

all: format validate docs

init:
	terraform init

format:
	terraform fmt -recursive

validate: init
	terraform validate
	@find ./modules -type d -name ".terraform" -prune -o -name "*.tf" -exec dirname {} \; | sort -u | xargs -I {} sh -c 'cd {} && terraform validate'

docs:
	@pre-commit run terraform_docs --all-files

check:
	pre-commit run --all-files

plan: validate
	terraform plan -out=tfplan

apply:
	terraform apply tfplan

destroy:
	terraform destroy

clean:
	rm -rf .terraform/ tfplan
	@find . -type d -name ".terraform" -exec rm -rf {} +
	@find . -name ".terraform.lock.hcl" -delete
	@find . -name "*.tfstate*" -delete
	@rm -rf dist/

setup:
	asdf install
	@if ! command -v pipx >/dev/null; then \
		echo "Installing pipx..."; \
		brew install pipx; \
		pipx ensurepath; \
	fi
	pipx install pre-commit
	pre-commit install

package-gcp:
	@mkdir -p dist/gcp
	@VERSION=$$(grep -oP 'module_version\s*=\s*"\K[^"]+' modules/gcp/versions.tf 2>/dev/null || echo "0.1.0"); \
	PACKAGE_NAME="terraform-gcp-modules-$${VERSION}"; \
	mkdir -p "dist/gcp/$${PACKAGE_NAME}"; \
	cp -r ./modules/gcp/* "dist/gcp/$${PACKAGE_NAME}/"; \
	cd dist/gcp && zip -r "$${PACKAGE_NAME}.zip" "$${PACKAGE_NAME}" && cd ../..; \
	echo "Package created at dist/gcp/$${PACKAGE_NAME}.zip"

package-azure:
	@mkdir -p dist/azure
	@VERSION=$$(grep -oP 'module_version\s*=\s*"\K[^"]+' modules/azure/versions.tf 2>/dev/null || echo "0.1.0"); \
	PACKAGE_NAME="terraform-azure-modules-$${VERSION}"; \
	mkdir -p "dist/azure/$${PACKAGE_NAME}"; \
	cp -r ./modules/azure/* "dist/azure/$${PACKAGE_NAME}/"; \
	cd dist/azure && zip -r "$${PACKAGE_NAME}.zip" "$${PACKAGE_NAME}" && cd ../..; \
	echo "Package created at dist/azure/$${PACKAGE_NAME}.zip"

init-all:
	@find ./modules -type d -name ".terraform" -prune -o -name "*.tf" -exec dirname {} \; | sort -u | xargs -I {} sh -c 'cd {} && terraform init -backend=false'

help:
	@echo "Available targets:"
	@echo "  init         - Initialize terraform in current directory"
	@echo "  init-all     - Initialize terraform in all module directories"
	@echo "  format       - Format terraform code"
	@echo "  validate     - Validate terraform code"
	@echo "  docs         - Generate terraform docs"
	@echo "  check        - Run pre-commit checks"
	@echo "  plan         - Create terraform plan"
	@echo "  apply        - Apply terraform plan"
	@echo "  destroy      - Destroy terraform resources"
	@echo "  clean        - Clean up generated files and directories"
	@echo "  setup        - Setup development environment"
	@echo "  all          - Run format, validate, and docs (default)"
	@echo "  package-gcp  - Package GCP modules locally"
	@echo "  package-azure - Package Azure modules locally"
