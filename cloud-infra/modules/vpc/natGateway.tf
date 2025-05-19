resource "aws_eip" "eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "natGateway" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.subnets["public_subnet1"].id

  tags = {
    Name = "natGateway"
  }

  depends_on = [aws_internet_gateway.IGW]
}
