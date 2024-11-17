
#################################################
# VPC
#################################################

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.15.0"
   
  name = "${var.cluster_name}-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["${var.region}a", "${var.region}b", "${var.region}c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  intra_subnets   = ["10.0.104.0/24", "10.0.105.0/24", "10.0.106.0/24"]
  
  enable_nat_gateway = true
  single_nat_gateway = true
  one_nat_gateway_per_az = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/interal-elb"= 1
     "karpenter.sh/discovery" = var.cluster_name
  }
  tags = {
    Terraform = "true"
    Environment = "prod"
  }

}