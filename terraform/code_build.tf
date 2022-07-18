resource "aws_codebuild_project" "planning_terraform" {
  name          = "planning-terraform-on-${terraform.workspace}"
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
    image                       = local.code_build.environment.image
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true

    environment_variable {
      name  = "TERRAFORM_WORKSPACE"
      value = terraform.workspace
    }

    environment_variable {
      name  = "TERRAFORM_SHOULD_APPLY"
      value = "false"
    }
  }

  source {
    type            = local.code_build.source.type
    location        = local.code_build.source.location
    git_clone_depth = local.code_build.source.git_clone_depth
    buildspec       = local.code_build.source.buildspec
  }
}

resource "aws_codebuild_project" "applying_terraform" {
  name          = "applying-terraform-on-${terraform.workspace}"
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
    image                       = local.code_build.environment.image
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true

    environment_variable {
      name  = "TERRAFORM_WORKSPACE"
      value = terraform.workspace
    }

    environment_variable {
      name  = "TERRAFORM_SHOULD_APPLY"
      value = "true"
    }
  }

  source {
    type            = local.code_build.source.type
    location        = local.code_build.source.location
    git_clone_depth = local.code_build.source.git_clone_depth
    buildspec       = local.code_build.source.buildspec
  }
}

