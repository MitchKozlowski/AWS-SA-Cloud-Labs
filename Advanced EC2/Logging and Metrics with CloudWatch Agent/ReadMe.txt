
Purpose:

	In this lab, we will install and configure the Amazon CloudWatch Agent on an EC2 instance to collect system and application logs.

	You will also configure an IAM role that enables secure interaction with:

		- Amazon CloudWatch
		- Amazon CloudWatch Logs
		- AWS Systems Manager Parameter Store
		- Objectives
		- Install the CloudWatch Agent on EC2
		- Configure the agent to collect log files
		- Store the agent configuration in Parameter Store
		- Stream logs to CloudWatch Logs
		- Validate log ingestion


Log Files Monitored:

	The agent will be configured to collect the following logs:

		/var/log/secure
		/var/log/httpd/access_log
		/var/log/httpd/error_log



Architecture:

	EC2 Instance
	   │
	   ├── CloudWatch Agent
	   │       │
	   │       ├── Reads log files
	   │       ├── Sends logs → CloudWatch Logs
	   │       └── Stores config → Parameter Store
	   │
	   └── IAM Role
			   ├── CloudWatch permissions
			   ├── Logs permissions
			   └── SSM Parameter Store permissions


Key Concepts:

	CloudWatch Agent

	A unified agent that:

		Collects logs and metrics
		Sends data to CloudWatch
		Supports centralized configuration
	
	
	Parameter Store Integration:
	
		Stores agent configuration securely
		Enables reuse across multiple EC2 instances
		Supports versioning and updates
	
	IAM Role Usage
	
		Removes need for hardcoded credentials
		Grants least-privilege access
		Enables secure service-to-service communication



Implementation Steps:

	- Start by connecting to the EC2 Instance
	- This instance has wordpressed installed and the Cowsay banner

	- Installed Cloudwatch agent, but need to setup an IAM role for it. We didn’t configure agent or anything yet

	- We created a role for a service (EC2) and gave it these 2 policies:

		CloudWatchAgentServerPolicy`
		And `AmazonSSMFullAccess`


	*** Refer to screenshot 1 ***

		- Go to Instance → security → IAM Role
		- We connect to the instance and go through the cloudwatch agent installation process. Most of it is default execpt what is in the user commands.txt document


	*** Refer to screenshot 2 ***

		- If you go to the parameter store of SSM you can see this parameter that has been creating. 
		- It contains all of our configs we just setup and can be used for this/other instances


	*** Refer to screenshot 3 ***

		- We manually installed the Cloudwatch agent on our EC2 instance:
		
			sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-config-wizard
			# Accept all defaults, until default metrics .. pick advanced.

			# then when asking for log files to monitor

			# 1 /VAR/LOG/SECURE
			/var/log/secure
			/var/log/secure
			(Accept default instance ID)
			Accept the default retention option

			# 2 /var/log/httpd/access_log
			/var/log/httpd/access_log
			/var/log/httpd/access_log
			(Accept default instance ID)
			Accept the default retention option

			# 3 /var/log/httpd/error_log
			/var/log/httpd/error_log
			/var/log/httpd/error_log
			(Accept default instance ID)
			Accept the default retention option

			Answer no to any more logs
			Save config into SSM
			Use the default name.

			# Config will be stored in /opt/aws/amazon-cloudwatch-agent/bin/config.json and stored in SSM

			# Bug Fix (these are needed else the agent won't start)
			sudo mkdir -p /usr/share/collectd/
			sudo touch /usr/share/collectd/types.db



	*** Refer to screenshot 4 ***

		- Cloudwatch expects this directory to be here and we setup a database for it.
		- Then we tell the instance to fetch the SSM parameter


	*** Refer to screenshot 5 ***

		- Here in the cloudwatch log groups you can see the directories we made.
		- If you don’t see the access_log, just open up the public IP of the instance then check again
		- You can also see the metrics for the instance in CloudWatch
