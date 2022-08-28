<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | = 1.2.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | = 4.22.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.22.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | 3.14.2 |

## Resources

| Name | Type |
|------|------|
| [aws_ecs_cluster.test_cluster](https://registry.terraform.io/providers/hashicorp/aws/4.22.0/docs/resources/ecs_cluster) | resource |
| [aws_ecs_service.iis_service](https://registry.terraform.io/providers/hashicorp/aws/4.22.0/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.iis_task_definition](https://registry.terraform.io/providers/hashicorp/aws/4.22.0/docs/resources/ecs_task_definition) | resource |
| [aws_security_group.tcp_security_group](https://registry.terraform.io/providers/hashicorp/aws/4.22.0/docs/resources/security_group) | resource |

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END_TF_DOCS -->