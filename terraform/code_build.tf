module "planning_terraform_project" {
  source                 = "./modules/terraform_codebuild"
  project_name           = "planning-terraform-on-${terraform.workspace}"
  terraform_should_apply = false
  pattern_of_branch_name = var.terraform_codebuild.pattern_of_branch_names.planning_terraform
  vpc_config = {
    security_group_ids = [module.vpc.default_security_group_id]
    subnet_ids         = module.vpc.private_subnets
    vpc_id             = module.vpc.vpc_id
  }
}

module "applying_terraform_project" {
  source                 = "./modules/terraform_codebuild"
  project_name           = "applying-terraform-on-${terraform.workspace}"
  terraform_should_apply = true
  pattern_of_branch_name = var.terraform_codebuild.pattern_of_branch_names.applying_terraform
  vpc_config = {
    security_group_ids = [module.vpc.default_security_group_id]
    subnet_ids         = module.vpc.private_subnets
    vpc_id             = module.vpc.vpc_id
  }
}
