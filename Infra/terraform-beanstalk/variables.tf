/*
 *  APPLICATION
 */

variable "solution_stack" {
  default = "64bit Amazon Linux 2018.03 v2.11.2 running Multi-container Docker 18.03.1-ce (Generic)"
}

variable "aws_beanstalk_eu_west_1_zone_id" {
  default = "Z2NYPWQ7DFZAZH"
}

variable "minimum_instances_in_service" {
  default = 1
}

variable "scale_min" {
  default = 1
}

variable "scale_max" {
  default = 2
}

variable "instance_type" {
  default = "t2.micro"
}

variable "instance_key" {
  default = "aws-eb"
}

variable "server_port" {
  default = "9999"
}

variable "dns_name" {
  default = "tribute.global"
}

variable "cpuutilization" {
  default = "80"
}

variable "docker_tag" {
  description = "Tag for the docker image to be deployed"
  default = "staging"
}

variable "docker_image" {
  description = "Image name for the docker image to be deployed"
  default = "933186250239.dkr.ecr.eu-west-1.amazonaws.com/tribute-server"
}

variable "docker_ports" {
  description = "Docker ports to expose"
  type        = "list"
  default = [9999]
}


variable "tags" {
  type = "map"

  default = {
    ApplicationName    = "tribute-server"
    Environment        = "staging"
    Version = "1"
  }
}
