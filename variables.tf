####### EC2 #######

variable "linux_app_ami_id" {
  description = "The ID of the custom Linux App AMI"
  default     = "ami-04dfd853d88e818e8"
}

variable "linux_mysql_ami_id" {
  description = "The ID of the MySQL AMI"
  default     = "ami-04dfd853d88e818e8"
}

variable "instance_type" {
  description = "The type of EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "alb_allowed_cidr_blocks" {
  description = "CIDR blocks for allowed IPs for ALB from secureweb.com"
  type        = list(string)
  default     = ["8.8.8.8/32"]
}

###### VPC ######
variable "subnets" {
  type = map(object({
    cidr_block : string,
    az         : string,
  }))

  default = {
    subnet-a = { cidr_block = "10.0.1.0/24", az = "eu-cantral-1a" },
    subnet-b = { cidr_block = "10.0.2.0/24", az = "eu-cantral-1b" },
    subnet-c = { cidr_block = "10.0.3.0/24", az = "eu-cantral-1c" },
  }
}

##### Other #####
variable "aws_region" {
  description = "The AWS region where resources will be created"
  type        = string
  default     = "eu-central-1"
}

variable "tags"  {
  description = "Default tags for resources"
  type        = map(string)
  default     = {
    Project     = "my_project",
    Managed_by  = "Terraform"
  }
}

variable "certificate_arn" {
  description = "The ACM certificate ARN"
  type        = string
  default     = ""
}