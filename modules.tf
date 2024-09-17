module "eks_network" {
  source         = "./modules/network"
  cidr_block_vpc = var.cidr_block_vpc
}