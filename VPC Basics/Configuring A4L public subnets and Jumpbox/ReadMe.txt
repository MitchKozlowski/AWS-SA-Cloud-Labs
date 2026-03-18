
Purpose:

Internet Gateway, Route Tables & Bastion Host:

This lab extends the VPC and subnet design by enabling public internet access for the 
Web tier and deploying a bastion host for administrative access.


⚠️ Important Note (Real-World Context)

- Bastion hosts (jump boxes) are generally considered a legacy pattern.
- While useful for learning and certain controlled environments, modern best practices favor:
- AWS Systems Manager (Session Manager)
- Zero-trust / identity-based access
- Eliminating public SSH exposure entirely
- However, understanding bastion hosts is important because:
- They still exist in real environments
- You need to recognize and evaluate them during architecture reviews


Overview:

- In this step, the Amazon VPC is configured to support inbound and outbound internet connectivity for the Web subnets.



Key components implemented:

- Internet Gateway (IGW)
- Route Tables and Routes
- Public subnet configuration
- Bastion host (jump box) deployment


Internet Gateway (IGW):

- An Internet Gateway was:
- Created and attached to the VPC
- Used to enable communication between the VPC and the public internet


Route Tables & Public Subnets:

- A route table was configured for the Web tier subnets:

- Added route:
- 0.0.0.0/0 → Internet Gateway
- Associated the route table with all Web subnets (A, B, C)
- This makes the Web subnets public, allowing:
- Inbound traffic from the internet (if security groups allow)
- Outbound internet access


Bastion Host (Jump Box):

- A bastion host was deployed in a public Web subnet:
- Assigned a public IPv4 address
- Used as an entry point to access resources inside the VPC
- Typically accessed via SSH (or RDP depending on OS)

Purpose:

- Centralized administrative access
- Avoid exposing private instances directly to the internet


Connectivity Test:

- Connected to the bastion host using its public IP

Verified:

- Internet connectivity
- Ability to reach internal/private resources (in later labs)


Key Concepts Demonstrated:

- Attaching an Internet Gateway to a VPC
- Creating public vs private subnets via route tables
- Default route (0.0.0.0/0) behavior
- Bastion host architecture and use cases
- Secure entry points into a VPC


Implementation Steps:

 *** Refer to screenshot 1 ***

- Created and attached IGW to VPC
- Now we want to make the WEB zone publicly accessible

 *** Refer to screenshot 2 ***

- We created a route table and associated it with the three web subnets


 *** Refer to screenshot 3 ***

- We expanded Route Table and went to edit routes
- AWS routing always tries to choose the most specific route first, So adding 0.0.0.0/0 as the default route means if it 
doesn’t match any of the other listed networks it will do what we tell it to.

 
 *** Refer to screenshot 4 ***

- Here we have our default routes, that will be sent to the IGW


 *** Refer to screenshot 5 ***

- We went back to the three web subnets and let them auto assign v4 addresses, for public internet use


 *** Refer to screenshot 6 ***

- Creating an EC2 instance to verify that the VPC and IGW are working properly. It’s a fairly default EC2 instance besides this bit


 *** Refer to screenshot 7 ***

- Using an SSH client on our machine, we are able to connect to the jumpbox
