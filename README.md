# terraform-module-example
## Problem Statement:
We're looking to build a repeatable infrastructure that has a number of EC2 instances behind a load balancer.

## Tasks:
Develop and implementation that allows the ability to:
- Have 2 or more EC2 instances behind a load balancer
- The load balancer is publicly available from port 443
- Use terraform for IaC

Things to think about 
- Least Previleged security principles.
- Which configuration should be dynamic
- Ability to run multiple times with differnet configurations.

## Technical Decisions
Create terrform module the creates a ASG with a minimum of 2 instances that sits behind a public ELB.
- Use an AMI that has an application baked into it using packer.
- Allow this AMI to be passed as a variable to terraform.
- The follow variables are also available.
    - "deploy_region" - The aws region to deploy to
    - "asg_max" - The max number of EC2s in the auto scaling group
    - "asg_desired" - The desired number of EC2s in the auto scaling group
    - "availability_zones" - The availablity zones to deploy to. (Should have used subnets)
    - "app_name" - The name of the application and associated resouces
    - "app_ami_id" - The pre baked AMI to deploy containing the app
    - "app_listen_port" - THe port the app listens on
    - "load_balancer_acm" - The SSL cert to use with the load balancer.

- Outputs the ELB DNS when terraform apply is complete.
```
Apply complete! Resources: 7 added, 0 changed, 0 destroyed.

Outputs:

module_elb_address = sample-app-elb-1791867273.ap-southeast-2.elb.amazonaws.com
```
