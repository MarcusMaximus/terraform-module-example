# The main terraform config
provider "aws" {
  region = "${var.region}"
}

module "simple-stack" {
  # Source for the repeatable module
  source  = "./modules/simple-stack"
  
  # Load Balancer settings
  # TODO: Enable after DNS validation
  # load_balancer_acm = "${var.load_balancer_acm}"

  # ASG Settings
  asg_max = "2"
  asg_desired = "2"

  # Application Settings
  app_name = "${var.app_name}" 
  app_ami_id = "${var.app_ami_id}" # ami-09ed3399f245db127
  app_listen_port = "${var.app_listen_port}" # 5000
}