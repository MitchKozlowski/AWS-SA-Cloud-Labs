
Purpose:

VPC Setup (3-Tier Architecture Foundation)
This lab focuses on creating the foundational networking layer for a future 3-tier application using Amazon Web Services.

Overview

A custom Amazon VPC was created to serve as the base infrastructure for upcoming labs where a 
full 3-tier architecture (web, application, database) will be deployed.

Region: us-east-1

CIDR Block: 10.16.0.0/16

DNS Resolution: Enabled

DNS Hostnames: Enabled



Architecture Design:

The VPC is structured to span multiple Availability Zones for high availability and fault tolerance.

3 Availability Zones: A, B, C

Each AZ is allocated address space for future subnet creation

Designed to support:

Web Tier (Public Subnets)

Application Tier (Private Subnets)

Database Tier (Isolated Subnets)

Additionally, extra IP space is reserved for:

Future expansion into additional Availability Zones

Scaling subnet capacity as needed




Key Concepts Demonstrated:

VPC CIDR planning and IP space allocation

Multi-AZ architecture design

Preparing network infrastructure for scalable applications

Enabling DNS features required for service communication




Diagram

The diagram shows:

A single VPC (10.16.0.0/16)

Segmentation across three Availability Zones (A, B, C)

A VPC router handling internal routing

Connectivity to the internet via the AWS public network

Reserved space for future expansion



Implementation Steps:


 *** Refer to screenshot 1 ***
- Here we manually configured the VPC
- We gave it a name, region, and IPv4 CIDR
- Keep IPv6 enabled as we will configure this as well


 *** Refer to screenshot 2 ***

- You can view VPC ID and other parameters/labels

 
 *** Refer to screenshot 3 ***
 
- Go to Actions→Edit VPC:
- We want to enable DNS Resolution & Hostnames

















