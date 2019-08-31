# The main terraform config
provider "aws" {
  region = "${var.region}"
}

module "simple-stack" {
  # Source for the repeatable module
  source  = "modules/simple-stack"
  
  # Load Balancer settings
  # TODO: Enable after DNS validation
  # load_balancer_acm = "	arn:aws:acm:ap-southeast-2:059615316341:certificate/9f70ec22-da73-4648-8437-dc715ed088ad"

  # ASG Settings
  asg_max = "2"

  # Application Settings
  app_ami_id = "${var.app_ami_id}" # ami-09ed3399f245db127
  app_listen_port = "${var.app_listen_port}" # 5000
}