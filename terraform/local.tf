locals {
  code_build = {
    environment = {
      image = "aws/codebuild/standard:6.0"
    }
    source = {
      type            = "GITHUB"
      location        = "https://github.com/go-go-megaman/cd-with-terraform-and-codebuild.git"
      git_clone_depth = 1
      buildspec       = "deployment/buildspec.yaml"
    }
  }
}
