variable "length" {
  default = "20"
}

resource "random_id" "password" {
  byte_length = "${var.length * 3 / 4}"
}

resource "aws_db_instance" "default" {
  allocated_storage      = "${var.allocated_storage}"
  availability_zone      = "${var.availability_zone}"
  storage_type           = "${var.storage_type}"
  # storage_encrypted      = true
  engine                 = "${var.engine}"
  engine_version         = "${var.engine_version}"
  instance_class         = "db.${var.instance_class}"
  name                   = "${var.db_name}${var.instance_tags["Environment"]}"
  identifier             = "${var.db_name}${var.instance_tags["Environment"]}"
  username               = "${var.db_username}"
  password               = "${random_id.password.b64}"
  vpc_security_group_ids = ["${aws_security_group.default.id}"]
  db_subnet_group_name   = "${aws_db_subnet_group.default.name}"
  parameter_group_name   = "${aws_db_parameter_group.default.id}"
  tags                   = "${var.instance_tags}"
  skip_final_snapshot    = "${var.skip_final_snapshot}"
  multi_az               = "${var.multi_az}"

  apply_immediately = true

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_db_subnet_group" "default" {
  name       = "${var.db_name}${var.instance_tags["Environment"]}"
  subnet_ids = ["${data.terraform_remote_state.env.private_subnets}"]
  tags       = "${var.instance_tags}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_db_parameter_group" "default" {
  name   = "${var.db_name}${var.instance_tags["Environment"]}"
  family = "postgres9.6"

}

resource "aws_security_group" "default" {
  name        = "sg_${var.db_name}${var.instance_tags["Environment"]}"
  vpc_id      = "${data.terraform_remote_state.env.vpc_id}"
  description = "Allow RDS for Internal traffic"

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
  }

  tags = "${var.instance_tags}"
}
