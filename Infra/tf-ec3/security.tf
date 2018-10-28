/*
 *  Defined Security Groups
 *  
 */

resource "aws_security_group" "ec2" {
  name        = "${var.tags["Name"]} - Default"
  description = "Default security group for ${var.tags["Name"]} EC2"
  vpc_id      = "${data.terraform_remote_state.env.vpc_id}"
  # vpc_id      = "${var.vpc_id}"

  tags = "${var.tags}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 9999
    to_port     = 9999
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
