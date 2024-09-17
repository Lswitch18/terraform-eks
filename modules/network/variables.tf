variable "cidr_block_vpc" {
  type        = string
  default     = "10.0.0.0/16"
  description = "CIDR_BLOCK VPC"

}

variable "us-east-2a" {
  type        = string
  default     = "us-east-2"
  description = "Region"
}
