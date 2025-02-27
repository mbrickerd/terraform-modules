.PHONY: init format validate plan apply destroy clean setup

init:
	terraform init

format:
	terraform fmt -recursive

validate: init
	terraform validate

plan: validate
	terraform plan -out=tfplan

apply:
	terraform apply tfplan

destroy:
	terraform destroy

clean:
	rm -rf .terraform/ tfplan

setup:
	asdf install
	@if ! command -v pipx >/dev/null; then \
		echo "Installing pipx..."; \
		brew install pipx; \
		pipx ensurepath; \
	fi
	pipx install pre-commit
	pre-commit install
