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

