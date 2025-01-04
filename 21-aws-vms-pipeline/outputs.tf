output "vm_aws_ip" {
  description = "VM's IP AWS"
  value       = aws_instance.vm.public_ip
}