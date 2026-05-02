# variables.tf - Variáveis do Projeto
# Configure via GitHub Secrets ou variáveis de ambiente

variable "aws_region" {
  type        = string
  description = "Região AWS"
  default     = ""  # Defina via TF_VAR_aws_region ou secrets
}

variable "aws_bucket_name" {
  type        = string
  description = "Nome do bucket S3 para state"
  default     = ""  # Defina via TF_VAR_aws_bucket_name ou secrets
}

variable "project_name" {
  type        = string
  description = "Nome do projeto"
  default     = "eks-infra"
}

variable "environment" {
  type        = string
  description = "Ambiente (dev, staging, prod)"
  default     = "dev"
}

variable "cluster_name" {
  type        = string
  description = "Nome do cluster EKS"
  default     = "my-eks-cluster"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR da VPC"
  default     = "10.0.0.0/16"
}