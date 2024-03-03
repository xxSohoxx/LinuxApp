# Security Group for ALB
resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  description = "Security group for ALB"
  vpc_id      = module.vpc.main_vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.alb_allowed_cidr_blocks
  }
}

# ALB
resource "aws_lb" "alb" {
  name               = "my-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = values(aws_subnet.public_subnets)[*].id
  enable_deletion_protection = true

  tags = merge(
    var.tags,
    {
      Name = "MyALB"
    }
  )
}

# Target Group
resource "aws_lb_target_group" "linux_app_target_group" {
  name        = "linux-app-target-group"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = module.vpc.main_vpc_id

  depends_on = [aws_lb.alb]

  tags = merge(
    var.tags,
    {
      Name = "LinuxAppTargetGroup"
    }
  )
}

# ALB Listener Rule
resource "aws_lb_listener_rule" "linux_app_listener_rule" {
  listener_arn = aws_lb.alb.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.linux_app_target_group.arn
  }

  condition {
    path_pattern {
      values = ["/*"]
    }
  }

  depends_on = [aws_lb_target_group.linux_app_target_group]
}

# Attach the EC2 instance to the Target Group
resource "aws_lb_target_group_attachment" "linux_app_attachment" {
  target_group_arn = aws_lb_target_group.linux_app_target_group.arn
  target_id        = module.ec2_linux_app.ec2_instance_id
}

resource "aws_lb_listener_certificate" "example_listener_cert" {
  listener_arn    = aws_lb.alb.arn
  certificate_arn = var.certificate_arn
}