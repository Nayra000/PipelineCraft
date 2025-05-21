resource "aws_security_group" "allow_ssh_anywhere" {
  name        = "allow_ssh"
  vpc_id      = aws_vpc.myvpc.id

  ingress {
    description = "Allow SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh_anywhere"
  }
}

resource "aws_security_group" "allow-ssh-and-3000" {
  name        = "allow-ssh-and-3000-vpc"
  vpc_id      = aws_vpc.myvpc.id

  ingress {
    description = "Allow SSH from VPC CIDR"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.myvpc.cidr_block]
  }

  ingress {
    description = "Allow port 3000 from VPC CIDR"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.myvpc.cidr_block]
  }
  
  ingress {
  description     = "Allow port 3000 from ALB SG"
  from_port       = 3000
  to_port         = 3000
  protocol        = "tcp"
  security_groups = [aws_security_group.lb_sg.id]
 }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-ssh-and-3000-vpc"
  }
}

resource "aws_security_group" "lb_sg" {
  name        = "lb-sg"
  description = "Allow HTTP"
  vpc_id      = aws_vpc.myvpc.id

  ingress {
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
}
