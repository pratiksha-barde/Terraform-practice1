# Create VPC
resource "aws_vpc" "dev" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "devvpc"
  }
}

# Create Internet Gateway and attach to VPC
resource "aws_internet_gateway" "dev" {
  vpc_id = aws_vpc.dev.id
}

# Public Subnet
resource "aws_subnet" "public" {
  cidr_block        = "10.0.0.0/24"
  vpc_id            = aws_vpc.dev.id
  availability_zone = "ap-south-1a"
}

# Private Subnet
resource "aws_subnet" "pvt" {
  cidr_block        = "10.0.1.0/24"
  vpc_id            = aws_vpc.dev.id
  availability_zone = "ap-south-1a"
}

# Route Table
resource "aws_route_table" "dev" {
  vpc_id = aws_vpc.dev.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev.id
  }
}

# Route Table Association with Public Subnet
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.dev.id
}

# Security Group
resource "aws_security_group" "allow_tls" {
  name   = "allow_tls"
  vpc_id = aws_vpc.dev.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "dev_sg"
  }
}

# EC2 Instance
resource "aws_instance" "web" {
  ami                         = "ami-062f0cc54dbfd8ef1"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.allow_tls.id]

  tags = {
    Name = "web-server"
  }
}

# create private server and give secure instance to instance through not gateway
