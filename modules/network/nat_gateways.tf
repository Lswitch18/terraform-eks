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