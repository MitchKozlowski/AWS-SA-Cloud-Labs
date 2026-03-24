
Purpose:

	In this demo, we will bootstrap two EC2 instances running WordPress with a custom cowsay login banner.

	Instance 1: Bootstrapped using User Data via the EC2 Console
	Instance 2: Bootstrapped using CloudFormation


Objectives:

	Understand how User Data automates EC2 provisioning
	Compare manual (console) vs automated (CloudFormation) deployments
	Deploy a fully functional WordPress environment
	Customize the EC2 login experience using cowsay
	Diagnose bootstrapping using Instance Metadata and log files


Bootstrapping Theory:

	User Data:
	Runs scripts automatically at instance launch
	Enables fast, repeatable provisioning
	Common in immutable infrastructure patterns

	Console vs CloudFormation:

	Console = imperative, manual deployment
	CloudFormation = declarative, scalable and repeatable IaC

	Observability:

	Metadata endpoint allows inspection of runtime configuration
	Logs provide visibility into success/failure of scripts

Architecture:

	EC2 Instance (Amazon Linux 2023)
	Apache Web Server (httpd)
	MariaDB Database
	PHP
	WordPress
	EC2 User Data (bootstrapping script)


Key Takeaways:

	User Data enables fully automated instance configuration
	CloudFormation provides repeatable and scalable infrastructure
	Metadata service is critical for introspection and debugging
	Logs are the primary source of truth for bootstrapping issues






Implementation Steps:


- Userdata.txt is used to bootstrap the instance

- Look through the userdata file to see what is happening. We will be installing wordpress with it’s DB and Cowsay for MOTD
- Start by creating an EC2 instance named A4L-MANUALWORDPRESS, with Amazon Linux AMI and no key pair


 *** Refer to screenshot 1 ***
 
	- For network settings, in the VPC configuration, choose the sn-web-A subnet
	- Use the existing security group created with Cloudformation
	 
 
 
 *** Refer to screenshot 2 ***
 
	- Input the Userdata into this text box under advanced settings
	- AWS will read in base 64 encoded data. We will see this a few times. An EC2 instance (I believe this applies to linux distros) will take commands if they
	are wrapped in the Base64 conversion. They need to be converted to Base 64 or the EC2 instance won't accept the commands.
 
 
 
 *** Refer to screenshot 3 ***
 
	- Connect Via Instance Connect
	- First thing that you can see is that the Cowsay banner was installed on initialization due to bootstrapping
 
 
 
 *** Refer to screenshot 4 ***
 
	- And If you go to the public IPv4 address, you’ll see that Wordpress is working

	- Have to put in the first command, but if you run the two commands below that you can see the meta data and the user data


		TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"`

		curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/

		curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/user-data/
 
 
 
 *** Refer to screenshot 5 ***

	- These two logs are important for cloud specific content
