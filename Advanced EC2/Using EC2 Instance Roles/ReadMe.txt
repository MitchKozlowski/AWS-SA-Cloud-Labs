
Purpose:

	In this demo, you will create an EC2 Instance Role, attach it to an EC2 instance, and explore how AWS provides temporary credentials to the instance via the Instance Metadata Service (IMDS).

	This demonstrates how EC2 instances can securely interact with AWS services without hardcoding credentials.


Objectives:

	- Create an IAM Role for EC2
	- Attach the role to an EC2 instance
	- Verify access to AWS services (S3)
	- Retrieve and inspect temporary credentials from instance metadata



Key Concepts:

	- An Instance Role allows an EC2 instance to assume an IAM role and inherit its permissions automatically.

	- No need to store access keys
	- Credentials are temporary and rotated automatically
	- Improves security and scalability




Implementation Steps:
	
	- You can refer to the cloudformation template. It creates an S3 bucket, our custom VPC wiht an IGW and RT, and a T3 micro EC2 instance.
	
	*** Refer to screenshot 1 ***
	
		- Connect to the only EC2 instance via instance connect
		- This a fresh install Amazon AMI
		- This doesn’t have any key pairs or credentials to interact with AWS
		- So we’ll give it an InstanceRole
		- Head over to IAM and create a role
	
	
	*** Refer to screenshot 2 ***
	
		- When creating the IAM role, you can see that we set the use case to EC2.
	
	*** Refer to screenshot 3 ***
	
		- We’ll give it S3 Read only access
		- When role is created, it creates an IAM Role and an Instance Profile
	
	*** Refer to screenshot 4 ***
	
		- When you click on "Security" in the drop down, you should see the option to add a role.
		- Here you can add the role we setup for this Instance
	
	*** Refer to screenshot 5 ***

		- This shows the IAM role attached to the instance

	*** Refer to screenshot 6 ***
	
		- With the instance role attached, we can list(read) the S3 bucket
	
	*** Refer to screenshot 7 ***
	
		- This meta-data shows how the instance profile/Role is passed to the instance or User