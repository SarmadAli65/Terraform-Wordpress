# Terraform-Wordpress
This repository will showcase a complete deployment of Wordpress using terraform

## Infrastructure
- 1 VPC, 2 Public Subnets, 2 Private subnets across 2 AZ's
- Routetables
- Internet gateway
- NAT gateway
- 2 Private EC2 instances
- Application loadbalancer
- RDS database
- CloudFlare DNS

## Deployment
```
terraform init
terraform plan
terraform apply
```

## Cleanup

```
terraform destroy
```