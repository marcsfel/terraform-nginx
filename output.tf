output "ip_address" {
  value = aws_instance.Nginx_instance.public_ip
}