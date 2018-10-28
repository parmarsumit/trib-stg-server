
output "AutoScalingGroupName" {
  value = "${aws_elastic_beanstalk_environment.default.autoscaling_groups}"
}
output "DNS Name" {
  value = "${aws_elastic_beanstalk_environment.default.cname}"
}
