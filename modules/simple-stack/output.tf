# The terraform outputs file
output "elb_address" {
  value = "${aws_elb.app_elb.dns_name}"
}