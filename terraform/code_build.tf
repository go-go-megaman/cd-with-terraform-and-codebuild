module "planning_terraform_project" {
  source                 = "./modules/terraform_codebuild"
  project_name           = "planning-terraform-on-${terraform.workspace}"
  terraform_should_apply = false
}

module "applying_terraform_project" {
  source                 = "./modules/terraform_codebuild"
  project_name           = "applying-terraform-on-${terraform.workspace}"
  terraform_should_apply = true
}
