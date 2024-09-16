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
resource "aws_vpc" "my_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "Enterprise-vpc"
  }
}

# Subnet Pública
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-2a" # Zona de disponibilidade específica
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet"
  }
}

# Subnet Privada
resource "aws_subnet" "public_subnet2" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-2a" # Ajuste conforme a zona de disponibilidade desejada
  map_public_ip_on_launch = true
  tags = {
    Name = "public_subnet2"
  }
}

# Subnet Privada 1
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-2b" # Zona de disponibilidade específica
  map_public_ip_on_launch = true
  tags = {
    Name = "private-subnet"
  }
}

# Subnet Privada 2
resource "aws_subnet" "private_subnet2" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-2b" # Ajuste conforme a zona de disponibilidade desejada
  tags = {
    Name = "private_subnet2"
  }
}

# Internet Gateway para acesso público
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "my-igw"
  }
}

# Tabela de Roteamento Pública
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "public-route-table"
  }
}

# Associa a tabela de roteamento pública com a subnet pública
resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

# Tabela de Roteamento Privada
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "private-route-table"
  }
}

# Associa a tabela de roteamento privada com a subnet privada
resource "aws_route_table_association" "private_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}
