#################################################
# Provider
#################################################

provider "aws" {
    region = var.region
    allowed_account_ids = [var.aws_account_id]
}

terraform {
     required_providers {
       aws = {
          source = "terraform/aws"
          version = "~>5.0"
       }
     }
}