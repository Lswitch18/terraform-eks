# main.tf - Configuração Principal do Terraform
# Dados sensíveis agora são configurados via variáveis

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configuração do provider AWS
provider "aws" {
  region = var.aws_region
}

# Backend S3 configurado via variáveis
terraform {
  backend "s3" {
    bucket = var.aws_bucket_name
    key    = "${var.environment}/terraform.tfstate"
    region = var.aws_region
  }
}