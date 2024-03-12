output "public_IP_Artifact" {
  value = aws_instance.artifactory_instance.public_ip
}

output "private_IP_Artifact" {
  value = aws_instance.artifactory_instance.private_ip
}

output "public_IP_Agent" {
  value = aws_instance.agent_linux_instance.public_ip
}

output "private_IP_Agent" {
  value = aws_instance.agent_linux_instance.private_ip
}