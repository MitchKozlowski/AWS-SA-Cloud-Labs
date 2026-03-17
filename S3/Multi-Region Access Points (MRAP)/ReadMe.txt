
Purpose:

This mini project explores how Amazon S3 Multi-Region Access Points provide a single global endpoint to simplify access to data stored across multiple 
AWS regions. Instead of managing separate regional endpoints and complex routing logic, 
Multi-Region Access Points automatically direct requests to the optimal S3 bucket based on factors such as latency and availability.

During the project, you gain hands-on experience configuring and using Multi-Region Access Points to route traffic from various sources, 
including VPCs, on-premises environments, and the public internet. This demonstrates how AWS enables highly available, low-latency, 
and globally distributed applications without requiring complex networking configurations.

Architecture / Services Used:

Amazon S3 – Stores objects across multiple regions

S3 Multi-Region Access Point – Provides a single global endpoint for routing requests

AWS Global Network – Routes traffic to the nearest or most optimal region

Amazon Virtual Private Cloud (VPC) – Enables private access to S3 resources

AWS Identity and Access Management (IAM) – Controls access to S3 and access points


Key Concepts Demonstrated:

Using Multi-Region Access Points for global S3 access

Simplifying cross-region architecture and request routing

Improving application availability and performance

Understanding how AWS routes traffic using its global infrastructure

Enabling access from VPCs, on-premises environments, and the public internet



Implementation Steps:

- Log into the iamadmin of the general account
- *** Select 2 different regions to use
- Create 2 buckets ( 1 in each zone) (multi-region-demo-virginia-297836879) (multi-region-demo-oregon-894876821)
- Just make sure to turn on versioning

 *** Refer to Screenshot 1 ***


 *** Refer to Screenshot 2 ***

- To create the MRAP, give it a name and then add the 2 buckets we created
- These can take up to 24 hours to create
- Now we have to setup bucket replication, b/c anyone who is using an access point will be redirected to the closest bucket


 *** Refer to Screenshot 3 ***

- Note Alias and ARN
- We want to set up replication on all buckets, because we have an active active architecture


 *** Refer to Screenshot 4 ***

- We are going to use the cloudshell to test this, just make sure to move to a different region close enough to one of the buckets



 *** Refer to Screenshot 5 ***
 
- If you go back to each bucket, you should see test1.file there
- Now create test2.file in another region close to the other bucket and you should see both test files in both buckets







