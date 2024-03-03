resource "aws_instance" "this" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  subnet_id       = var.subnet_id
  security_groups = var.security_groups

  tags = var.tags
}