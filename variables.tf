# Variables to be used. MAke variables as descriptive as possible. 
variable "deploy_region" {
  type = "string"
  default = "ap-southeast-2"
}

variable "asg_max" {
  type = "string"
  default = "2"
}

variable "asg_desired" {
  type = "string"
  default = "2"
}

variable "availability_zones" {
  type = list(string)
  default = ["ap-southeast-2a","ap-southeast-2b","ap-southeast-2c"]
}

variable "app_name" {
  type = "string"
  default = "sample-app"
}
variable "app_ami_id" {
  type = "string"
  default = "ami-09ed3399f245db127"
}

variable "app_listen_port" {
  type = "string"
  default = "5000"
}

variable "load_balancer_acm" {
    type = "string"
    default = "arn:aws:acm:ap-southeast-2:059615316341:certificate/9f70ec22-da73-4648-8437-dc715ed088ad"
}