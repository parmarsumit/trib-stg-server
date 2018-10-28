variable "db_username" {
  default = "root"
}

variable "db_name" {
  default = "contents"
}

variable "aws_region" {
  default = "eu-west-1"
}

variable "account" {
  default = "Staging"
}

variable "engine" {
  default = "postgres"
}

variable "availability_zone" {
  default = "eu-west-1b"
}

variable "engine_version" {
  default = "9.6.3"
}

variable "instance_class" {
  type    = "string"
  default = "t2.micro"
}

variable "allocated_storage" {
  default = "10"
  type    = "string"
}

variable "storage_type" {
  default = "gp2"
}

variable "parameter_group_name" {
  default = "postgres9.6"
}

variable "instance_count" {
  type    = "string"
  default = 1
}

variable "skip_final_snapshot" {
  default = "true"
}

variable "multi_az" {
  default = "false"
}

variable "instance_tags" {
  type = "map"

  default = {
    Name               = "content-db"
    ApplicationName    = "content-db"
    Environment        = "stg"
  }
}
