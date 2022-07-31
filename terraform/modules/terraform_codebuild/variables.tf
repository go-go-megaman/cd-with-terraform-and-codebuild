variable "project_name" {
  type        = string
  nullable    = false
  description = "To specify the name of the CodeBuild project."
}

variable "terraform_should_apply" {
  type        = bool
  nullable    = false
  description = "To specify whether the CodeBuild project should execute 'terraform apply'."
}
