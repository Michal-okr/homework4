provider "aws" {
  region = var.aws_region
}


# Vytvoreni key pair pro SSH pristup
resource "aws_key_pair" "ec2_key" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

# Security group pro SSH pristup
resource "aws_security_group" "ec2_sg" {
  name        = "${var.name_prefix}-sg"
  description = "Security group pro EC2 instanci s SSH pristupem"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["84.246.166.6/32"]
    description = "SSH pristup"
  }

  # Pridáme HTTP port pro bonus úkol s Apache
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["84.246.166.6/32"]
    description = "HTTP pristup"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Povoleni veskereho odchoziho provozu"
  }

  tags = {
    Name        = "${var.name_prefix}-sg"
    Environment = var.environment
    Course      = var.course_name
  }
}

# EC2 instance
resource "aws_instance" "ec2_instance" {
  ami                    = "ami-0a72753edf3e631b7"
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.ec2_key.key_name
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<html><body><h1>Terraform EC2 Instance</h1><p>Vytvoreno pomoci Terraform pro ${var.course_name}</p></body></html>" > /var/www/html/index.html
  EOF

  tags = {
    Name        = "${var.name_prefix}-instance"
    Environment = var.environment
    Course      = var.course_name
  }
}