resource "aws_codebuild_webhook" "example" {
  count = var.pattern_of_branch_name == null ? 0 : 1

  project_name = aws_codebuild_project.terraform_codebuild_project.name
  build_type   = "BUILD"

  filter_group {
    filter {
      type    = "EVENT"
      pattern = "PUSH"
    }

    filter {
      type    = "HEAD_REF"
      pattern = var.pattern_of_branch_name
    }
  }
}
