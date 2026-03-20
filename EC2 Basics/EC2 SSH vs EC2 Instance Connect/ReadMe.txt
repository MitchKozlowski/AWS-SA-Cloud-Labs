
Purpose:

This lab demonstrates how to securely connect to an Amazon EC2 instance using Amazon EC2 Instance Connect, and contrasts it with traditional SSH key-based access.

The environment is deployed using AWS CloudFormation, which provisions a full VPC architecture along with a public EC2 instance.


Architecture Summary:

Building on a multi-tier VPC design, this lab deploys:
A custom Virtual Private Cloud (VPC) with IPv4 and IPv6 support
Public (Web), Private (App, DB), and Reserved subnets across 3 Availability Zones
An Internet Gateway for public connectivity
Route tables configured for internet access
A public EC2 instance for testing connectivity methods


EC2 Access Methods:

1. Traditional SSH Access

Uses an EC2 Key Pair

Requires:

Private key file (.pem)
SSH client (e.g., OpenSSH)
Security considerations:
Key distribution risk
Manual key management


2. EC2 Instance Connect

Uses IAM-based authentication
No need to manage SSH keys
Temporary public keys are pushed to the instance at connection time



Benefits:

Centralized access control via IAM

No long-lived SSH keys

Improved auditability

CloudFormation Deployment
Template Source

Provided via an S3-hosted template

Key Resources Created
Networking

VPC: 10.16.0.0/16

Internet Gateway attached

Route tables with:

0.0.0.0/0 (IPv4)

::/0 (IPv6)

Subnets (per AZ)

Web (Public)

App (Private)

DB (Private)

Reserved



Security Group allowing:

SSH (22)
HTTP (80)
IAM Role (Session Manager)
Enables access via AWS Systems Manager Session Manager


Permissions include:

SSM messaging
EC2 message handling

Security Configuration
Security Group Rules


Allow SSH (port 22) from:

0.0.0.0/0 (IPv4)
::/0 (IPv6)
Allow HTTP (port 80)


IAM Integration:

Instance Connect leverages IAM policies
Session Manager allows keyless access without opening SSH ports


Key Takeaways:

EC2 Instance Connect simplifies SSH access by removing key management
IAM policies provide fine-grained control over instance access
Session Manager can eliminate the need for SSH entirely
CloudFormation enables rapid, repeatable infrastructure deployment



Implementation Steps:

- Need to make sure that we have key pairs → in EC2 console
- This created an EC2 public instance as well as other infrastructure
- we’ll start off by going to the EC2 console

 *** Refer to screenshot 1 ***

- Here you can see that we are allowing any SSH/HTTP connection from any v4 or v6 address

 
 *** Refer to screenshot 2 ***

- We were able to do SSH Client connection fine, but we are playing around with this EC2 Instance Connect. 
Usually AWS finds the correct username automatically. If you are using a custom AMI however, then it’s not always correct


 *** Refer to screenshot 3 ***

- When using instance connect, you don’t use the key pairs, just AWS permissions
- You either need to allows all v4 addresses (bad practice), or use the ip_prefix for EC2_instance in your regions (See attached link).











