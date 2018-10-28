
/* Environment Variables */


variable "ec2keyname" {
  default = "ems_dev_key"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "tags" {
  type = "map"

  default = {
    
  }
}
