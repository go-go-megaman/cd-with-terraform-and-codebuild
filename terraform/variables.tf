variable "terraform_codebuild" {
  type = object({
    pattern_of_branch_names = object({
      planning_terraform = string
      applying_terraform = string
    })
  })
  nullable    = false
  description = "To specify the patterns of the branch name. The CodeBuild projects start to build if the branch is matching specified patterns."
}
