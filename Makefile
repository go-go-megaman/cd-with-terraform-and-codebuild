RUNNER_IMAGE=runner:latest

.PHONY: runner-image
runner-image:
	docker build \
		-t ${RUNNER_IMAGE} \
		./runner

.PHONY: check-terraform-format
check-terraform-format:
	docker run --rm \
		-v ${PWD}:/work \
		-w /work \
		${RUNNER_IMAGE} check-format

.PHONY: run-terraform
run-terraform:
	docker run \
		--rm \
		-e AWS_DEFAULT_REGION \
		-e AWS_CONTAINER_CREDENTIALS_RELATIVE_URI \
		-e TERRAFORM_WORKSPACE \
		-e TERRAFORM_SHOULD_APPLY \
		${RUNNER_IMAGE} run

.PHONY: run-shellcheck
run-shellcheck:
	docker run --rm \
 		-v ${PWD}:/work \
 		-w /work \
 		koalaman/shellcheck:v0.8.0 ./runner/entrypoint.sh

.PHONY: run-hadolint
run-hadolint:
	docker run --rm \
		-v ${PWD}:/work \
		-w /work \
		hadolint/hadolint:2.10.0 hadolint --no-color ./runner/Dockerfile

.PHONY: check-terraform-documents
check-terraform-documents:
	docker run --rm \
		-v ${PWD}:/terraform-docs \
		-u $(shell id -u) \
		quay.io/terraform-docs/terraform-docs:0.16.0 markdown table --output-file README.md --output-check --recursive /terraform-docs/terraform

.PHONY: validate-terraform-code
validate-terraform-code:
	docker run --rm \
		-v ${PWD}:/work \
		-w /work \
		${RUNNER_IMAGE} validate
