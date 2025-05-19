
region      = "us-east-1"

ec2_type  = "t3.micro"

cidr = "10.0.0.0/16"

ami_id = "ami-084568db4383264d4" 

subnets_list = [
    {
        name = "public_subnet1" ,
        cidr_block = "10.0.1.0/24" ,
        az = "us-east-1a" ,
        type = "public"
    } ,
    {
        name = "public_subnet2" ,
        cidr_block = "10.0.3.0/24" ,
        az = "us-east-1b" ,
        type = "public"
    } ,
    {
        name = "private_subnet1" ,
        cidr_block = "10.0.2.0/24" ,
        az = "us-east-1a" ,
        type = "private"
    } ,
        {
        name = "private_subnet2" ,
        cidr_block = "10.0.4.0/24" ,
        az = "us-east-1b" ,
        type = "private"
    } ,


]



