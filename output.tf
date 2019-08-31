# The terraform outputs file
output "elb_dns_name" {
  description = "The DNS name of the ELB"
  value       = "test " # module.simple-stack.aws_elb.app_elb
}