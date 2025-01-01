output "vm_ip" {
  description = "IP from VM created"
  value       = aws_instance.vm.public_ip
}