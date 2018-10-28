/*
 *  Defined Security Groups
 *  
 */

resource "aws_security_group" "default" {
  
  name        = "${var.tags["ApplicationName"]}-${var.tags["Version"]} - Default"
  description = "Default security group for ${var.tags["ApplicationName"]} ${var.tags["Environment"]}"
  vpc_id      = "${data.terraform_remote_state.env.vpc_id}"
  # vpc_id = "vpc-77200511"
  
  
  tags {
    Name        = "${var.tags["ApplicationName"]}-${var.tags["Version"]}"
    Environment = "${var.tags["Environment"]}"
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
}