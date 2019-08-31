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
- Possibly allow ELB and EC2 availiblity zones to be passed as variables also.
