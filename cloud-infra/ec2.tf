
resource "aws_instance" "bastion" {
  ami           = "ami-0e449927258d45bc4" 
  instance_type = "t2.micro"             
  subnet_id     = aws_subnet.public_subnet1.id
  vpc_security_group_ids = [
    aws_security_group.allow_ssh_and_https_anywhere.id
  ]
  tags = {
    Name = "Bastion-Host"
  }
}

resource "aws_instance" "application" {
  ami           = "ami-0e449927258d45bc4" 
  instance_type = "t2.micro"             
  subnet_id     = aws_subnet.private_subnet1.id
  vpc_security_group_ids = [
    aws_security_group.allow_ssh_and_3000_vpc.id
  ]

  tags = {
    Name = "Application-Host"
  }
}

