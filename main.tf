terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"

    }
  }

  backend "s3" {
    bucket = "statebackendbr20241990uasdi"
    key    = "PROD/terraform.tfstate" # Ajuste para um caminho mais específico
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-2"
}

# VPC
resource "aws_vpc" "eks-vpc" {
  cidr_block           = var.cidr_block_vpc
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "Enterprise-vpc"
  }
}

# Subnet Pública 1
resource "aws_subnet" "public_subnet1" {
  vpc_id                  = aws_vpc.eks-vpc.id
  cidr_block              = cidrsubnet(var.cidr_block_vpc, 8, 1)
  availability_zone       = "us-east-2a" # Zona de disponibilidade específica
  map_public_ip_on_launch = true
  tags = {
    Name                     = "public_subnet1"
    "kubernetes.io/role/elb" = 1
  }
}

# Subnet Publica 2
resource "aws_subnet" "public_subnet2" {
  vpc_id                  = aws_vpc.eks-vpc.id
  cidr_block              = cidrsubnet(var.cidr_block_vpc, 8, 2)
  availability_zone       = "us-east-2b" # Ajuste conforme a zona de disponibilidade desejada
  map_public_ip_on_launch = true
  tags = {
    Name                     = "public_subnet2"
    "kubernetes.io/role/elb" = 1
  }
}

# Subnet Privada 1
resource "aws_subnet" "private_subnet1" {
  vpc_id            = aws_vpc.eks-vpc.id
  cidr_block        = cidrsubnet(var.cidr_block_vpc, 8, 3)
  availability_zone = "us-east-2a" # Zona de disponibilidade específica
  tags = {
    Name                              = "private_subnet1"
    "kubernetes.io/role/internal-elb" = 1
  }
}

# Subnet Privada 2
resource "aws_subnet" "private_subnet2" {
  vpc_id            = aws_vpc.eks-vpc.id
  cidr_block        = cidrsubnet(var.cidr_block_vpc, 8, 4)
  availability_zone = "us-east-2b" # Ajuste conforme a zona de disponibilidade desejada
  tags = {
    Name                              = "private_subnet2"
    "kubernetes.io/role/internal-elb" = 1
  }
}

# Internet Gateway para acesso público
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.eks-vpc.id
  tags = {
    Name = "my-igw"
  }
}

# Tabela de Roteamento Pública
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.eks-vpc.id
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
  vpc_id = aws_vpc.eks-vpc.id
  tags = {
    Name = "private-route-table"
  }
}

# Associa a tabela de roteamento privada com a subnet Publica
resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.public_route_table.id
}

# Associa a tabela de roteamento privada com a subnet Publica2
resource "aws_route_table_association" "public_association2" {
  subnet_id      = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.public_route_table.id
}

# Associa a tabela de roteamento privada com a subnet privada1
resource "aws_route_table_association" "private_association" {
  subnet_id      = aws_subnet.private_subnet1.id
  route_table_id = aws_route_table.private_route_table.id
}

# Associa a tabela de roteamento privada com a subnet privada2
resource "aws_route_table_association" "private_association2" {
  subnet_id      = aws_subnet.private_subnet2.id
  route_table_id = aws_route_table.private_route_table.id
}

