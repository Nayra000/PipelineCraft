resource "aws_subnet" "public_subnet1" {
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"  
  map_public_ip_on_launch = true 
  tags = {
    Name = "public_subnet1"
  }
}

resource "aws_subnet" "private_subnet1" {
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1a" 

  tags = {
    Name = "private_subnet1"
  }
}

resource "aws_subnet" "public_subnet2" {
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1b" 
  map_public_ip_on_launch = true  

  tags = {
    Name = "public_subnet2"
  }
}

resource "aws_subnet" "private_subnet2" {
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1b" 

  tags = {
    Name = "private_subnet2"
  }
}
