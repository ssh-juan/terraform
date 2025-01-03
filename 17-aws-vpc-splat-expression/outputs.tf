output "subnets_id" {
  description = "Subnets IDs"
  value       = aws_subnet.subnet[*].id
}