output "ec2_instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.this.id
}
