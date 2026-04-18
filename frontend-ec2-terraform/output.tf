output "ec2_public_ip" {
  description = "Ye GitHub Secrets 'EC2_HOST' mein jayega"
  value       = aws_instance.frontend_server.public_ip
}

output "private_key_pem" {
  description = "Ye GitHub Secrets 'EC2_SSH_KEY' mein jayega"
  value       = tls_private_key.rsa_key.private_key_pem
  sensitive   = true 
}