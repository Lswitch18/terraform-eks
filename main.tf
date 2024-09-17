terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

  backend "s3" {
    bucket = "statebackendbr20241990uasdi"
    key    = "PROD/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-2"
}

# VPC
resource "aws_vpc" "eks_vpc" {
  cidr_block           = var.cidr_block_vpc
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "Enterprise-vpc"
  }
}

# Subnet Pública 1
resource "aws_subnet" "public_subnet1" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = cidrsubnet(var.cidr_block_vpc, 8, 1)
  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = true
  tags = {
    Name                     = "public_subnet1"
    "kubernetes.io/role/elb" = 1
  }
}

# Subnet Pública 2
resource "aws_subnet" "public_subnet2" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = cidrsubnet(var.cidr_block_vpc, 8, 2)
  availability_zone       = "us-east-2b"
  map_public_ip_on_launch = true
  tags = {
    Name                     = "public_subnet2"
    "kubernetes.io/role/elb" = 1
  }
}

# Subnet Privada 1
resource "aws_subnet" "private_subnet1" {
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = cidrsubnet(var.cidr_block_vpc, 8, 3)
  availability_zone = "us-east-2a"
  tags = {
    Name                              = "private_subnet1"
    "kubernetes.io/role/internal-elb" = 1
  }
}

# Subnet Privada 2
resource "aws_subnet" "private_subnet2" {
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = cidrsubnet(var.cidr_block_vpc, 8, 4)
  availability_zone = "us-east-2b"
  tags = {
    Name                              = "private_subnet2"
    "kubernetes.io/role/internal-elb" = 1
  }
}

# Internet Gateway para acesso público
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.eks_vpc.id
  tags = {
    Name = "my-igw"
  }
}

# Tabela de Roteamento Pública
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.eks_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "public-route-table"
  }
}

# Tabela de Roteamento Privada
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.eks_vpc.id
  tags = {
    Name = "private-route-table"
  }
}

# Associa a tabela de roteamento pública com a subnet pública 1
resource "aws_route_table_association" "public_association1" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.public_route_table.id
}

# Associa a tabela de roteamento pública com a subnet pública 2
resource "aws_route_table_association" "public_association2" {
  subnet_id      = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.public_route_table.id
}

# Associa a tabela de roteamento privada com a subnet privada 1
resource "aws_route_table_association" "private_association1" {
  subnet_id      = aws_subnet.private_subnet1.id
  route_table_id = aws_route_table.private_route_table.id
}

# Associa a tabela de roteamento privada com a subnet privada 2
resource "aws_route_table_association" "private_association2" {
  subnet_id      = aws_subnet.private_subnet2.id
  route_table_id = aws_route_table.private_route_table.id
}

# Elastic IP
resource "aws_eip" "eks_ngw_eip" {
  tags = {
    Name = "elastic_ip"
  }
}

# Elastic IP
resource "aws_eip" "eks_ngw_eip2" {
  tags = {
    Name = "elastic_ip2"
  }
}

resource "aws_nat_gateway" "public_nat_gateway1" {
  allocation_id = aws_eip.eks_ngw_eip.id
  subnet_id     = aws_subnet.public_subnet1.id

  tags = {
    Name = "ngw 1"
  }

}

resource "aws_nat_gateway" "public_nat_gateway2" {
  allocation_id = aws_eip.eks_ngw_eip2.id
  subnet_id     = aws_subnet.public_subnet2.id

  tags = {
    Name = "ngw 2"
  }

}