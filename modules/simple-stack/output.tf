# The terraform outputs file
# The terraform outputs file
output "elb_dns_name" {
  description = "The DNS name of the ELB"
  value       = aws_elb.app_elb.name
}