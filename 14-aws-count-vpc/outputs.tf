output "subnet_0_id" {
  description = "Subnet 1 ID"
  value       = aws_subnet.subnet[0].id
}

output "subnet_1_id" {
  description = "Subnet 2 ID"
  value       = aws_subnet.subnet[1].id
}

output "subnet_2_id" {
  description = "Subnet 3 ID"
  value       = aws_subnet.subnet[2].id
}