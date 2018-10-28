
/* Environment Variables */



variable "hosted_zone_id" {
  default = "Z2UINGL6HRO476"
  
}
variable "aws_region" {
  default = "eu-west-1"
}

variable "tags" {
  type = "map"

  default = {
    Name            = "efs"
    Environment     = "stg"
  }
}
