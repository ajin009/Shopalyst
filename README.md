# Shopalyst
# AWS Highly Available Infrastructure Deployment Using Terraform

## Project Overview

This project demonstrates the provisioning of a scalable, secure, and highly available AWS infrastructure using Terraform as Infrastructure as Code (IaC).

The architecture includes an internet-facing Application Load Balancer (ALB), Auto Scaling Group (ASG) hosting EC2 web servers in private subnets, and an Amazon RDS PostgreSQL database deployed in private subnets with Multi-AZ availability.

## Architecture

**AWS Region:** ap-south-1 (Mumbai)

**Infrastructure Components:**
- Custom AWS VPC
- Two Availability Zones
- Public and private subnets
- Internet Gateway and NAT Gateway
- Application Load Balancer
- EC2 Auto Scaling Group
- Amazon RDS PostgreSQL with Multi-AZ
- AWS IAM Roles
- Security Groups
- AWS Secrets Manager
- Amazon CloudWatch monitoring

**Traffic Flow:**

Internet → Application Load Balancer → EC2 Auto Scaling Group → Amazon RDS PostgreSQL

## Infrastructure Implementation

### 1. VPC and Networking

Configured a custom VPC spanning two Availability Zones to provide high availability.

- Created public subnets for the internet-facing ALB.
- Configured private subnets for application servers.
- Configured Internet Gateway routing for public subnets.
- Configured NAT Gateway routing for private subnet outbound connectivity.
- Configured route tables and subnet associations.

![AWS VPC](screenshots/vpc.png)

![Route Tables](screenshots/route-tables.png)

### 2. Application Load Balancer and Auto Scaling

Implemented an internet-facing Application Load Balancer to distribute incoming HTTP traffic across EC2 instances managed by an Auto Scaling Group.

- Configured an HTTP listener on port 80.
- Created a target group with health checks.
- Configured Auto Scaling based on CPU utilization.
- Integrated Amazon CloudWatch alarms for monitoring.

![CloudWatch CPU Alarm](screenshots/cloudwatch-alarm.png)

![ALB Target Group](screenshots/alb-target-group.png)

### 3. Amazon RDS PostgreSQL

Provisioned an Amazon RDS PostgreSQL database with the following configurations:

- Private subnet deployment
- Multi-AZ high availability
- Public access disabled
- Restricted database connectivity through security groups
- Database credentials managed securely using AWS Secrets Manager

![Amazon RDS](screenshots/rds.png)

### 4. Security Configuration

Implemented three security groups to enforce controlled communication between infrastructure components.

| Security Group | Inbound Access |
|---|---|
| ALB Security Group | HTTP port 80 from 0.0.0.0/0 |
| Web Security Group | HTTP port 80 from ALB Security Group only |
| Database Security Group | PostgreSQL port 5432 from Web Security Group only |

EC2 instances are deployed in private subnets without direct public SSH access.

![Security Group](screenshots/security-group.png)

### 5. Secrets Management

Used AWS Secrets Manager to securely manage database credentials, avoiding hardcoded database passwords in Terraform configuration and EC2 user data.

![AWS Secrets Manager](screenshots/secrets-manager.png)

### 6. EC2 User Data Configuration

Configured EC2 instances to automatically install and start the Nginx web server during instance initialization.

```bash
#!/bin/bash
apt-get update -y
apt-get install -y nginx
systemctl enable --now nginx
echo "<h1>Hello World from $(hostname -f)</h1>" > /var/www/html/index.html
```

### 7. Terraform Deployment

**Prerequisites:**
- Terraform installed
- AWS CLI configured
- AWS credentials with appropriate permissions

Initialize Terraform:

```bash
terraform init
```

Validate the configuration:

```bash
terraform fmt -check
terraform validate
```

Review the infrastructure deployment plan:

```bash
terraform plan
```

Deploy the infrastructure:

```bash
terraform apply
```

Destroy the infrastructure when no longer required:

```bash
terraform destroy
```

## Validation

The infrastructure was reviewed through the AWS Management Console, including:

- VPC and subnet configuration
- Route table associations
- CloudWatch CPU utilization alarms
- ALB target group registration and health status
- Security group inbound rules
- AWS Secrets Manager configuration
- RDS PostgreSQL deployment

## Security Best Practices

- EC2 instances hosted in private subnets
- Database not publicly accessible
- Security group rules restricting traffic between tiers
- Database credentials managed through AWS Secrets Manager
- IAM-based access management
- Infrastructure managed using Terraform

## Conclusion

This project demonstrates the implementation of a scalable, secure, and highly available AWS infrastructure using Terraform. It incorporates network isolation, application load balancing, automatic scaling, managed database services, and security controls to support reliable application hosting.
