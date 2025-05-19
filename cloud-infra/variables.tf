variable "cidr" {
    type = string
}

variable "subnets_list" {
    type = list(object({
        name = string ,
        cidr_block = string ,
        az = string ,
        type = string
   
  }))
}

variable "ami_id" {
    type = string
}

variable "ec2_type" {
    type = string
  
}

variable "region" {
    type = string
  
}