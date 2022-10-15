module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.16.1"

  name = "base_vpc_on_${terraform.workspace}"
  cidr = "10.0.0.0/16"

  azs             = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  manage_default_security_group  = true
  default_security_group_ingress = []
  default_security_group_egress  = []
}
