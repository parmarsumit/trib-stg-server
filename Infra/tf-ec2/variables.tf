
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
    Name            = "testlab-devops"
    Roles           = "testlab-node"
    Environment     = "dev"
    CostCenter      = "1265"
    SupportGroup    = "es-devops"
    ApplicationName = "testlab"
    Team            = "devops"
    Owner           = "AllenV@DNB.com"
  }
}
