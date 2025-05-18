resource "aws_key_pair" "ssh_key" {
  key_name   = "my-key"
  public_key = file("/home/nayra/project/id_rsa.pub") 
}



resource "aws_instance" "bastion" {
  ami           = "ami-084568db4383264d4" 
  instance_type = "t2.micro"             
  subnet_id     = aws_subnet.public_subnet1.id
  vpc_security_group_ids = [
    aws_security_group.allow_ssh_and_https_anywhere.id
  ]
  key_name = aws_key_pair.ssh_key. key_name
  tags = {
    Name = "Bastion-Host"
  }
}

resource "aws_instance" "application" {
  ami           = "ami-084568db4383264d4" 
  instance_type = "t2.micro"             
  subnet_id     = aws_subnet.private_subnet1.id
  vpc_security_group_ids = [
    aws_security_group.allow_ssh_and_3000_vpc.id
  ]
  key_name = aws_key_pair.ssh_key. key_name 
  tags = {
    Name = "Application-Host"
  }
}

