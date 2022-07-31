terraform_codebuild = {
  pattern_of_branch_names = {
    planning_terraform = "^refs/heads/(release|hotfix)/.+$"
    applying_terraform = "^refs/heads/master$"
  }
}

