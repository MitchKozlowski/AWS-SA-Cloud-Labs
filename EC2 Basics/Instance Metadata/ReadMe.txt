
Purpose:

EC2 Instance Metadata Exploration Lab
Overview

This lab focuses on interacting with EC2 Instance Metadata, a powerful feature in Amazon Web Services that allows instances to access information about themselves at runtime.

Instance metadata provides details such as:

- Public IP address
- Hostname
- Availability Zone
- Security groups
- IAM role information

This data is accessed from within the instance using a link-local address:
http://169.254.169.254



Architecture

The lab environment was deployed using AWS CloudFormation and includes:

Custom VPC (10.16.0.0/16)
Public subnets across 3 Availability Zones
Internet Gateway for public connectivity
EC2 instance deployed in a public subnet
IAM role for Systems Manager access
Key Component
Public EC2 Instance
Instance Type: t3.micro
OS: Amazon Linux 2
Access: SSH + Session Manager
Public IP enabled


Key Learnings:

1. Metadata is Local to the Instance
Accessible only from within the EC2 instance
Uses a non-routable IP (169.254.169.254)
2. Critical for Automation

Metadata enables:

Dynamic configuration scripts
Region/AZ-aware deployments
Self-configuring applications
3. IAM Role Integration
Metadata service can provide temporary credentials
Used securely instead of hardcoding AWS keys





Implementation Steps:

- Head over to the EC2 instance
- Note both IPv4 addresses and the v6 one as well

 *** Refer to screenshot 1 ***

- Here’s the first example. An instance wouldn’t know it’s public IP address to obtaining the metadata for it is how you could see it

 *** Refer to screenshot 2 ***
 
- Same thing here for Hostname


 *** Refer to screenshot 3 ***

- Here is an example of the information you can access using the ec2-metadata command