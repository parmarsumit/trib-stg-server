data "aws_ami" "ami" {
  most_recent = true
  filter {
    name   = "name"
    values = ["Ubuntu 16.04*"]
  }
}

data "template_file" "userdata" {
    template = "${file("${path.module}/templates/userdata.sh")}"
}