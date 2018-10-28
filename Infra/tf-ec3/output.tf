output "ip" {
  value  = "${aws_instance.ec2.private_ip}"
}
output "pub_ip" {
  value  = "${aws_instance.ec2.public_ip}"
}
output "id" {
  value  = "${aws_instance.ec2.id}"
}

# output "eip" {
#   value = "${aws_eip.default.public_ip}"
# }