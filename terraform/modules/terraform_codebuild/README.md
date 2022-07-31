<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | = 1.2.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | = 4.22.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | = 4.22.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_codebuild_project.terraform_codebuild_project](https://registry.terraform.io/providers/hashicorp/aws/4.22.0/docs/resources/codebuild_project) | resource |
| [aws_iam_policy.iam_editor](https://registry.terraform.io/providers/hashicorp/aws/4.22.0/docs/resources/iam_policy) | resource |
| [aws_iam_role.code_build](https://registry.terraform.io/providers/hashicorp/aws/4.22.0/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.attaching_iam_editor_to_code_build](https://registry.terraform.io/providers/hashicorp/aws/4.22.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.attaching_power_user_to_code_build](https://registry.terraform.io/providers/hashicorp/aws/4.22.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.code_build](https://registry.terraform.io/providers/hashicorp/aws/4.22.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.iam_editor](https://registry.terraform.io/providers/hashicorp/aws/4.22.0/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | To specify the name of the CodeBuild project. | `string` | n/a | yes |
| <a name="input_terraform_should_apply"></a> [terraform\_should\_apply](#input\_terraform\_should\_apply) | To specify whether the CodeBuild project should execute 'terraform apply'. | `bool` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->