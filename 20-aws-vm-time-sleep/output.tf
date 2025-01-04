output "vm_1_ip" {
  description = "IP from VM 1 created"
  value       = aws_instance.vm_1.public_ip
}

output "vm_2_ip" {
  description = "IP from VM 2 created"
  value       = aws_instance.vm_2.public_ip
}