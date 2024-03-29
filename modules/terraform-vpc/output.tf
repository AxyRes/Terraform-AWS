output "vpc_id" {
  value = aws_vpc.main.id
}

output "default_security_group_id" {
  value = aws_vpc.main.default_security_group_id
}

output "public_subnet_ids" {
  value = aws_subnet.first_public_az.id
}