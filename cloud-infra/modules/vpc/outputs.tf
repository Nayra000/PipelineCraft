output "vpc_id" {
  value = aws_vpc.myvpc.id
}

output "subnet_ids" {
  description = "List of subnet IDs"
  value       = { for k, v in aws_subnet.subnets : k => v.id }
}

output "ssh_SG_id" {
  value       = aws_security_group.allow_ssh_anydwhere.id
}

output "ssh_3000_SG_id" {
  value       = aws_security_group.allow_ssh_and_3000_vpc.id
}
