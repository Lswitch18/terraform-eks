variable "cidr_block_vpc" {
  type        = string
  default     = "10.0.0.0/16"
  description = "CIDR_BLOCK VPC"

}

variable "us-east-1a" {
  type        = string
  default     = "us-east-1"
  description = "Region"
}
