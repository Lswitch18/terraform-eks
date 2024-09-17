output "subnet_publica_1_id" {
  description = "ID da Subnet Pública 1"
  value       = aws_subnet.public_subnet1.id
}

output "subnet_publica_2_id" {
  description = "ID da Subnet Pública 2"
  value       = aws_subnet.public_subnet2.id
}

output "subnet_privada_1_id" {
  description = "ID da Subnet Privada 1"
  value       = aws_subnet.private_subnet1.id
}

output "subnet_privada_2_id" {
  description = "ID da Subnet Privada 2"
  value       = aws_subnet.private_subnet2.id
}
