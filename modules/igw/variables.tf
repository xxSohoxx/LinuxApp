variable "vpc_id" {
  description = "The ID of the VPC to attach the Internet Gateway to"
}

variable "igw_name" {
  description = "The name of the Internet Gateway"
  default     = "my-internet-gateway"
  type        = string
}
