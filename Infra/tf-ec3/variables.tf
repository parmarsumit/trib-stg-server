
/* Environment Variables */


variable "ec2keyname" {
  default = "aws-eb"
}

variable "hosted_zone_id" {
  default = "Z2UINGL6HRO476"
  
}

variable "instance_type" {
  default = "t2.micro"
}
# variable "vpc_id" {
#   default = "vpc-77200511"
# }
variable "subnets" {
  default = ["subnet-1131a677", "subnet-8b482ec3", "subnet-bdbe6ee7"]
}

variable "tags" {
  type = "map"

  default = {
    Name            = "server"
    Environment     = "stg"
  }
}
