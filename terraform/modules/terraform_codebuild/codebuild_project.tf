resource "aws_codebuild_project" "terraform_codebuild_project" {
  name          = var.project_name
  build_timeout = "120"
  service_role  = aws_iam_role.code_build.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  cache {
    type = "NO_CACHE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:6.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true

    environment_variable {
      name  = "TERRAFORM_WORKSPACE"
      value = terraform.workspace
    }

    environment_variable {
      name  = "TERRAFORM_SHOULD_APPLY"
      value = var.terraform_should_apply
    }
  }

  source {
    type      = "GITHUB"
    location  = "https://github.com/go-go-megaman/cd-with-terraform-and-codebuild.git"
    buildspec = "deployment/buildspec.yaml"
  }
}
