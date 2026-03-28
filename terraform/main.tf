# ============================================================
# Terraform: Provision AWS EC2 instance with Docker installed
# ============================================================

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Security Group
resource "aws_security_group" "taskops_sg" {
  name        = "taskops-sg"
  description = "TaskOps DevOps Project Security Group"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Frontend HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Backend API"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Jenkins"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Grafana"
    from_port   = 3000
    to_port     = 3000
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
    Name    = "taskops-sg"
    Project = "TaskOps-DevOps"
  }
}

# EC2 Instance
resource "aws_instance" "taskops_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.taskops_sg.id]

  user_data = <<-EOF
    #!/bin/bash
    # Update system
    apt-get update -y
    apt-get upgrade -y

    # Install Docker
    apt-get install -y docker.io docker-compose git curl

    # Enable and start Docker
    systemctl enable docker
    systemctl start docker
    usermod -aG docker ubuntu

    # Clone project and run
    git clone https://github.com/YOUR_USERNAME/devops-project.git /home/ubuntu/app
    cd /home/ubuntu/app
    docker-compose up -d

    echo "TaskOps deployment complete!" > /home/ubuntu/deploy.log
  EOF

  tags = {
    Name    = "taskops-server"
    Project = "TaskOps-DevOps"
  }
}
# Terraform IaC - AWS EC2 
