# VPC
resource "aws_vpc" "eks_vpc" {
  cidr_block           = var.cidr_block_vpc
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "Enterprise-vpc"
  }
}