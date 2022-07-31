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

variable "pattern_of_branch_name" {
  type        = string
  nullable    = true
  default     = null
  description = "To specify the pattern of the branch name to start the CodeBuild project."
}
