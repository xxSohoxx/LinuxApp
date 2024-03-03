output "main_vpc_id" {
  description = "The ID of the main VPC"
  value       = aws_vpc.this.id
}
