# The terraform outputs file
output "module_elb_address" {
  value = "${module.simple-stack.elb_address}"
}