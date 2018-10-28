/*
 *  Defined Security Groups
 *  
 */

resource "aws_security_group" "default" {
  name        = "${var.tags["Name"]} - Default"
  description = "EFS"
  vpc_id      = "${data.terraform_remote_state.env.vpc_id}"

  tags = "${var.tags}"
  
  lifecycle {
    create_before_destroy = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = "2049"
    to_port     = "2049"
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }


}
