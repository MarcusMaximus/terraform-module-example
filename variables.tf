# Variables to be used. MAke variables as descriptive as possible. 
variable "deploy_region" {
  type = "string"
  default = "ap-southeast-2"
}
variable "app_ami_id" {
  type = "string"
  default = "ami-09ed3399f245db127"
}