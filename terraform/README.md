<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | = 1.2.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | = 4.22.0 |
| <a name="requirement_docker"></a> [docker](#requirement\_docker) | 2.20.2 |
| <a name="requirement_null"></a> [null](#requirement\_null) | 3.1.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.22.0 |
| <a name="provider_docker"></a> [docker](#provider\_docker) | 2.20.2 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.1.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | 3.14.2 |

## Resources

| Name | Type |
|------|------|
| [aws_ecr_repository.nginx](https://registry.terraform.io/providers/hashicorp/aws/4.22.0/docs/resources/ecr_repository) | resource |
| [aws_ecs_cluster.test_cluster](https://registry.terraform.io/providers/hashicorp/aws/4.22.0/docs/resources/ecs_cluster) | resource |
| [aws_ecs_service.nginx_service](https://registry.terraform.io/providers/hashicorp/aws/4.22.0/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.nginx_task_definition](https://registry.terraform.io/providers/hashicorp/aws/4.22.0/docs/resources/ecs_task_definition) | resource |
| [aws_iam_role.task_execution_role](https://registry.terraform.io/providers/hashicorp/aws/4.22.0/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.attaching_ecs_task_execution_role_policy_to_task_execution_role](https://registry.terraform.io/providers/hashicorp/aws/4.22.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_security_group.tcp_security_group](https://registry.terraform.io/providers/hashicorp/aws/4.22.0/docs/resources/security_group) | resource |
| [docker_image.nginx](https://registry.terraform.io/providers/kreuzwerker/docker/2.20.2/docs/resources/image) | resource |
| [null_resource.pushing_container_image_to_ecr](https://registry.terraform.io/providers/hashicorp/null/3.1.1/docs/resources/resource) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/4.22.0/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/4.22.0/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/4.22.0/docs/data-sources/region) | data source |
| [docker_registry_image.nginx](https://registry.terraform.io/providers/kreuzwerker/docker/2.20.2/docs/data-sources/registry_image) | data source |

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END_TF_DOCS -->