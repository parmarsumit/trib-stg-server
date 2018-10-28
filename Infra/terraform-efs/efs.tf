# Define composite variables for resources

resource "aws_efs_file_system" "default" {
  creation_token="${var.tags["Name"]}-${var.tags["Environment"]}"
  tags = "${var.tags}"
}

resource "aws_efs_mount_target" "default" {
  file_system_id  = "${aws_efs_file_system.default.id}"
  subnet_id       = "${data.terraform_remote_state.env.private_subnets[0]}"
  security_groups = ["${aws_security_group.default.id}"]
}
