resource "aws_security_group" "k8s" {
  name        = "k8s-cluster-sg"
  description = "Security Group for Kubernetes cluster"
  vpc_id      = aws_vpc.k8s.id

  tags = {
    Name = "k8s-cluster-sg"
  }
}

# SSH - somente do IP do administrador
resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.k8s.id

  cidr_ipv4   = var.my_ip
  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp"

  description = "SSH from administrator IP"
}

# Kubernetes API Server
resource "aws_vpc_security_group_ingress_rule" "kubernetes_api" {
  security_group_id = aws_security_group.k8s.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 6443
  to_port     = 6443
  ip_protocol = "tcp"

  description = "Kubernetes API Server"
}

# Kubelet - comunicação entre os nós
resource "aws_vpc_security_group_ingress_rule" "kubelet" {
  security_group_id = aws_security_group.k8s.id

  referenced_security_group_id = aws_security_group.k8s.id
  from_port                    = 10250
  to_port                      = 10250
  ip_protocol                  = "tcp"

  description = "Kubelet communication"
}

# NodePort
resource "aws_vpc_security_group_ingress_rule" "nodeport" {
  security_group_id = aws_security_group.k8s.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 30000
  to_port     = 32767
  ip_protocol = "tcp"

  description = "Kubernetes NodePort"
}

# Comunicação interna entre os nós
resource "aws_vpc_security_group_ingress_rule" "cluster_internal" {
  security_group_id = aws_security_group.k8s.id

  referenced_security_group_id = aws_security_group.k8s.id
  ip_protocol                  = "-1"

  description = "Internal Kubernetes cluster communication"
}

# Saída para a Internet
resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.k8s.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"

  description = "Allow all outbound traffic"
}