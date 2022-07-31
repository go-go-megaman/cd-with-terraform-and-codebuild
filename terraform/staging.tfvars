terraform_codebuild = {
  pattern_of_branch_names = {
    planning_terraform = "^refs/heads/(feature|hotfix)/.+$"
    applying_terraform = "^refs/heads/develop$"
  }
}
