# Subnet Pública 1
resource "aws_subnet" "public_subnet1" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = cidrsubnet(var.cidr_block_vpc, 8, 1)
  availability_zone       = "us-east-1a"
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
  availability_zone       = "us-east-1b"
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
  availability_zone = "us-east-1a"
  tags = {
    Name                              = "private_subnet1"
    "kubernetes.io/role/internal-elb" = 1
  }
}

# Subnet Privada 2
resource "aws_subnet" "private_subnet2" {
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = cidrsubnet(var.cidr_block_vpc, 8, 4)
  availability_zone = "us-east-1b"
  tags = {
    Name                              = "private_subnet2"
    "kubernetes.io/role/internal-elb" = 1
  }
}