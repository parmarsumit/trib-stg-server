# Beanstalk instance profile
data "template_file" "eb_role" {
  template = "${file("${path.module}/templates/roles/elasticbeanstalk.json")}"
}

data "template_file" "ec2_role" {
  template = "${file("${path.module}/templates/roles/ec2.json")}"
}

resource "aws_iam_instance_profile" "ec2" {
  name = "${var.tags["ApplicationName"]}-beanstalk-ec2-user"
  role = "${aws_iam_role.ec2.name}"
}

resource "aws_iam_instance_profile" "service" {
  name = "${var.tags["ApplicationName"]}-beanstalk-service-user"
  role = "${aws_iam_role.service.name}"
}

resource "aws_iam_role" "ec2" {
  name = "${var.tags["ApplicationName"]}-beanstalk-ec2-role"

  assume_role_policy = "${data.template_file.ec2_role.rendered}"
}

resource "aws_iam_role" "service" {
  name = "${var.tags["ApplicationName"]}-beanstalk-service-role"

  assume_role_policy = "${data.template_file.eb_role.rendered}"
}

resource "aws_iam_policy_attachment" "ec2" {
  name       = "${var.tags["ApplicationName"]}-elastic-beanstalk-ec2"
  roles      = ["${aws_iam_role.ec2.id}"]
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
}

resource "aws_iam_policy_attachment" "service" {
  name       = "${var.tags["ApplicationName"]}-elastic-beanstalk-service"
  roles      = ["${aws_iam_role.service.id}"]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSElasticBeanstalkService"
}

resource "aws_iam_policy_attachment" "service_health" {
  name       = "${var.tags["ApplicationName"]}-elastic-beanstalk-service-health"
  roles      = ["${aws_iam_role.service.id}"]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSElasticBeanstalkEnhancedHealth"
}
