variable "cidr_block_vpc" {
  type        = string
  default     = "10.0.0.0/16"
  description = "CIDR block for the VPC"
}

module "eks_network" {
  source         = "./modules/network"
  cidr_block_vpc = var.cidr_block_vpc
}

