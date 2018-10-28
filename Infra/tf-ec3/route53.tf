/*
 *  Create DNS Mapping
 *  Defaults to 
 */

resource "aws_route53_record" "cname" {
  zone_id = "${var.hosted_zone_id}"
  name = "${var.tags["Name"]}.staging"
  # ttl = "300"
  type = "A"
  # records = ["${aws_eip.default.public_ip}"]
  alias {
    name = "${aws_lb.default.dns_name}"
    zone_id = "Z32O12XQLNTSW2"
    evaluate_target_health = false
  }
}
