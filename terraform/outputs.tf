output "server_public_ip" {
  description = "Public IP of the TaskOps server"
  value       = aws_instance.taskops_server.public_ip
}

output "app_url" {
  description = "URL to access the app"
  value       = "http://${aws_instance.taskops_server.public_ip}"
}

output "api_url" {
  description = "Backend API URL"
  value       = "http://${aws_instance.taskops_server.public_ip}:5000"
}

output "grafana_url" {
  description = "Grafana monitoring URL"
  value       = "http://${aws_instance.taskops_server.public_ip}:3000"
}
