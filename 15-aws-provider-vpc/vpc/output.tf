output "vpc_id_default" {
  description = "VPC ID of AWS Default Region"
  value       = aws_vpc.default.id
}

output "vpc_id_provider_1" {
  description = "VPC ID of AWS Provider_1 Region"
  value       = aws_vpc.provider_1.id
}

output "vpc_id_provider_2" {
  description = "VPC ID of AWS Provider_2 Region"
  value       = aws_vpc.provider_2.id
}