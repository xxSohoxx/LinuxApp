variable "vpc_id" {
  description = "The ID of the VPC"
}

variable "cidr_block" {
  description = "The CIDR block for the subnet"
}

variable "availability_zone" {
  description = "The availability zone for the subnet"
}

variable "subnet_name" {
  description = "The name of the subnet"
}

variable "tags" {
  description = "Additional tags for the subnet"
  type        = map(string)
  default     = {}
}
