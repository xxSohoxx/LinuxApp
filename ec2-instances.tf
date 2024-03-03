# Security Group for Linux App
resource "aws_security_group" "linux_app_sg" {
  name        = "linux-app-sg"
  description = "Security group for Linux App"
  vpc_id      = module.vpc.main_vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }
}

# Security Group for MySQL
resource "aws_security_group" "mysql_sg" {
  name        = "mysql-sg"
  description = "Security group for MySQL"
  vpc_id      = module.vpc.main_vpc_id

  ingress {
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    security_groups  = [aws_security_group.linux_app_sg.id]
  }
}

module "ec2_linux_app" {
  source          = "./modules/ec2-instance"
  ami_id          = var.linux_app_ami_id
  instance_type   = var.instance_type
  subnet_id       = aws_subnet.public_subnets["subnet-a"].id
  security_groups = [aws_security_group.linux_app_sg.id]
  tags = merge(
    var.tags,
    {
      Name = "LinuxAppInstance"
    }
  )
}

module "ec2_mysql" {
  source          = "./modules/ec2-instance"
  ami_id          = var.linux_mysql_ami_id
  instance_type   = var.instance_type
  subnet_id       = aws_subnet.public_subnets["subnet-b"].id
  security_groups = [aws_security_group.mysql_sg.id]
  tags = merge(
    var.tags,
    {
      Name = "LinuxAppInstance"
    }
  )
}