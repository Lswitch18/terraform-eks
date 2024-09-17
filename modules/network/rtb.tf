# Tabela de Roteamento Pública
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.eks_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.public_nat_gateway1.id
  }
  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table" "public_route_table2" {
  vpc_id = aws_vpc.eks_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.public_nat_gateway2.id
  }
  tags = {
    Name = "public-route-table2"
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