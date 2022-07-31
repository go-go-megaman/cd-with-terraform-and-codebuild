<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | = 1.2.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | = 4.22.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_applying_terraform_project"></a> [applying\_terraform\_project](#module\_applying\_terraform\_project) | ./modules/terraform_codebuild | n/a |
| <a name="module_planning_terraform_project"></a> [planning\_terraform\_project](#module\_planning\_terraform\_project) | ./modules/terraform_codebuild | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_terraform_codebuild"></a> [terraform\_codebuild](#input\_terraform\_codebuild) | To specify the patterns of the branch name. The CodeBuild projects start to build if the branch is matching specified patterns. | <pre>object({<br>    pattern_of_branch_names = object({<br>      planning_terraform = string<br>      applying_terraform = string<br>    })<br>  })</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->