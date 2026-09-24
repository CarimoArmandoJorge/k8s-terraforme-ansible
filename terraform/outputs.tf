output "control_plane_public_ip" {
  description = "Public IP of the Kubernetes control plane"
  value       = aws_instance.control_plane.public_ip
}

output "control_plane_private_ip" {
  description = "Private IP of the Kubernetes control plane"
  value       = aws_instance.control_plane.private_ip
}

output "worker_public_ips" {
  description = "Public IPs of the Kubernetes workers"
  value       = aws_instance.worker[*].public_ip
}

output "worker_private_ips" {
  description = "Private IPs of the Kubernetes workers"
  value       = aws_instance.worker[*].private_ip
}
 