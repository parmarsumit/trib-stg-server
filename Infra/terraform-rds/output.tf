output "db_username" {
  value = "${aws_db_instance.default.username}"
}

output "db_password" {
  value = "${random_id.password.b64}"
}

output "address" {
  value = "${aws_db_instance.default.address}"
}

output "instance" {
  value = "${aws_db_instance.default.instance_class}"
}

output "id" {
  value = "${aws_db_instance.default.id}"
}
