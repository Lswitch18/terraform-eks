terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

  backend "s3" {
    bucket = "statebackendbr20241990uasdi"
    key    = "PROD/terraform.tfstate"
    region = "us-east-1"
  }
}