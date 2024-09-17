output "subnet_publica_1_id" {
  description = "ID da Subnet Pública 1"
  value       = module.eks_network.subnet_publica_1_id
}

output "subnet_publica_2_id" {
  description = "ID da Subnet Pública 2"
  value       = module.eks_network.subnet_publica_2_id
}

output "subnet_privada_1_id" {
  description = "ID da Subnet Privada 1"
  value       = module.eks_network.subnet_privada_1_id
}

output "subnet_privada_2_id" {
  description = "ID da Subnet Privada 2"
  value       = module.eks_network.subnet_privada_2_id
}