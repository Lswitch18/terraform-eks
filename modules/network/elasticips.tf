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