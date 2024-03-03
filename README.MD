# POC for PP #

### Prerequisities ###
- We assume that ACM certificate is already created, so we just use its ARN.
- Our app requires package to be installed from example.com before startup. In order to optimize the boot process we need to prepare AMI image for the app with already pre-installed package.
### Basic diagram ###


### Possible improvements ###
- Configure remote backend for Terraform (S3 for example)
- Create private subnets for the app and locate it behind AWS NAT GateWay
- Implement ASG for the APP EC2 instance
- Discover possibility to migrate MySQL EC2 instance to RDS and implement multi-AZ configuration
- Configure health-check endpoints for the app and add Cloudwatch alerts for the app and MySQL
- Enable WAF on ALB
- Create Route 53 domain to avoid using long domain names from AWS
- Discover possibility to migrate app from EC2 to ECS
