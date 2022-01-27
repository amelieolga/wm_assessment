# module "vpc" {
#   source = "terraform-aws-modules/vpc/aws"

#   name = "my-vpc"
#   cidr = "10.0.0.0/16"

#   azs             = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
#   private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
#   public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

#   enable_nat_gateway = true
#   enable_vpn_gateway = true

#   tags = {
#     Terraform = "true"
#     Environment = "dev"
#   }
# }

# resource "aws_eip" "nat" {
#   count = 3

#   vpc = true
# }

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

// @see https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/2.51.0
module "vpc" {
  source               = "terraform-aws-modules/vpc/aws"
  name                 = "wm-case-study"
  cidr                 = "10.0.0.0/16"
  azs                  = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
  private_subnets      = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets       = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  enable_dns_hostnames = true
  enable_dns_support   = true
  enable_nat_gateway   = true
  enable_vpn_gateway   = true
}

# resource "aws_security_group" "worker" {
#   vpc_id = module.vpc.vpc_id

# #   ingress {
# #     from_port   = "80"
# #     to_port     = "80"
# #     protocol    = "tcp"
# #     cidr_blocks = [ "0.0.0.0/0" ]
# #   }

# #   ingress {
# #     from_port   = "443"
# #     to_port     = "443"
# #     protocol    = "tcp"
# #     cidr_blocks = [ "0.0.0.0/0" ]
# #   }

#   ingress {
#     from_port   = "22"
#     to_port     = "22"
#     protocol    = "tcp"
#     cidr_blocks = [ "0.0.0.0/0" ]
#   }

# #   egress {
# #     from_port   = 0
# #     to_port     = 0
# #     protocol    = "-1"
# #     cidr_blocks = [ "0.0.0.0/0" ]
# #   }
# }

# resource "aws_instance" "ghost" {
#   ami                         = "ami-01ae2cc311c621dfb"
#   instance_type               = "t2.small"
#   vpc_security_group_ids      = [module.vpc.default_security_group_id, aws_security_group.web.id]
#   subnet_id                   = module.vpc.public_subnets[0]
#   associate_public_ip_address = true
# }

# output "ghost_domain" {
#   value = aws_instance.ghost.public_dns
# }