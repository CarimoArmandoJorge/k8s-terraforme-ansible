
resource "aws_vpc" "k8s" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "k8s-vpc"
  }
}

resource "aws_subnet" "control_plane" {
  vpc_id                  = aws_vpc.k8s.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true

  tags = {
    Name = "k8s-control-plane-subnet"
  }
}

resource "aws_subnet" "workers" {
  vpc_id                  = aws_vpc.k8s.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true

  tags = {
    Name = "k8s-workers-subnet"
  }
}

resource "aws_internet_gateway" "k8s" {
  vpc_id = aws_vpc.k8s.id

  tags = {
    Name = "k8s-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.k8s.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.k8s.id
  }

  tags = {
    Name = "k8s-public-route-table"
  }
}

resource "aws_route_table_association" "control_plane" {
  subnet_id      = aws_subnet.control_plane.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "workers" {
  subnet_id      = aws_subnet.workers.id
  route_table_id = aws_route_table.public.id
}
 