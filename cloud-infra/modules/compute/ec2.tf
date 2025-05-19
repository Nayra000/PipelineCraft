resource "aws_key_pair" "ssh_key" {
  key_name   = "my-key"
  public_key = file("/home/nayra/project/id_rsa.pub") 
}



resource "aws_instance" "bastion" {
  ami           = var.ami_id
  instance_type = var.ec2_type          
  subnet_id     =  var.public_subnet_id
  vpc_security_group_ids = [
    var.ssh_SG_id
  ]
  key_name = aws_key_pair.ssh_key. key_name
  tags = {
    Name = "Bastion-Host"
  }
}

resource "aws_instance" "application" {
  ami           = var.ami_id
  instance_type = var.ec2_type           
  subnet_id     = var.private_subnet_id
  vpc_security_group_ids = [
    var.ssh_3000_SG_id
  ]
  key_name = aws_key_pair.ssh_key. key_name 
  tags = {
    Name = "Application-Host"
  }
}

