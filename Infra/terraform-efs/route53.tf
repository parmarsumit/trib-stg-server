/*
 *  Create DNS Mapping
 *  Defaults to 
 */

resource "aws_route53_record" "cname" {
  zone_id = "${var.hosted_zone_id}"
  name = "${var.tags["Name"]}"
  ttl = 60
  type = "CNAME"
  records = ["${aws_efs_file_system.default.id}.efs.${var.aws_region}.amazonaws.com"]

}
