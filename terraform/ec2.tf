resource "aws_instance" "control_plane" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.control_plane.id
  vpc_security_group_ids      = [aws_security_group.k8s.id]
  key_name                    = var.key_name
  associate_public_ip_address = true

  tags = {
    Name = "k8s-control-plane"
  }
}

resource "aws_instance" "worker" {
  count = 2

  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.workers.id
  vpc_security_group_ids      = [aws_security_group.k8s.id]
  key_name                    = var.key_name
  associate_public_ip_address = true

  tags = {
    Name = "k8s-worker-${count.index + 1}"
  }
}
 