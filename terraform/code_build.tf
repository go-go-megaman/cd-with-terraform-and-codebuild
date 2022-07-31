module "planning_terraform_project" {
  source                 = "./modules/terraform_codebuild"
  project_name           = "planning-terraform-on-${terraform.workspace}"
  terraform_should_apply = false
  pattern_of_branch_name = var.terraform_codebuild.pattern_of_branch_names.planning_terraform
}

module "applying_terraform_project" {
  source                 = "./modules/terraform_codebuild"
  project_name           = "applying-terraform-on-${terraform.workspace}"
  terraform_should_apply = true
  pattern_of_branch_name = var.terraform_codebuild.pattern_of_branch_names.applying_terraform
}
