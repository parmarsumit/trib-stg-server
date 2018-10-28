resource "aws_instance" "ec2" {
  ami           = "${data.aws_ami.ami.image_id}"
  instance_type = "${var.instance_type}"
  key_name      = "${var.ec2keyname}"

  #subnet_id                   = "${join(",",data.terraform_remote_state.env.private_subnet_list)}"
  # subnet_id = "${data.terraform_remote_state.env.private_subnets[0]}"
subnet_id = "${data.terraform_remote_state.env.public_subnets[0]}"
  #ebs_optimized               = true
  associate_public_ip_address = false
  iam_instance_profile        = "${aws_iam_instance_profile.instance-profile.name}"
  # vpc_security_group_ids      = ["${aws_security_group.ec2.id}"]
  vpc_security_group_ids      = ["${aws_security_group.ec2.id}"]
  volume_tags                 = "${var.tags}"
  tags                        = "${var.tags}"

  root_block_device {
    volume_size = "15"
    volume_type = "gp2"
  }

  user_data = "${file("${path.module}/templates/userdata.sh")}"
}
