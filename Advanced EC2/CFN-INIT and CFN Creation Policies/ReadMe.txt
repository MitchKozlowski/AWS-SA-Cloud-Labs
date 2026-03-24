
Purpose:

In this demo, we will explore how CloudFormation bootstrapping tools enhance the reliability and control of EC2 instance provisioning.

	You will specifically work with:

		CFN-INIT – for structured instance configuration
		CFN-SIGNAL – for communicating success/failure back to CloudFormation
		Creation Policies – for controlling stack creation flow

		These components allow you to move beyond basic User Data scripts into production-grade automation.

Objectives:

	By the end of this lab, you will:

		Understand how cfn-init structures EC2 configuration
		Use cfn-signal to report instance status
		Implement Creation Policies to control provisioning success
		Inspect instance metadata and user data using IMDSv2



Key Concepts:


	CFN-INIT:
		Reads metadata from CloudFormation templates
		Applies configurations such as:
		Packages
		Files
		Services
		More structured and maintainable than raw User Data scripts
	
	
	CFN-SIGNAL:
		Sends a success/failure signal back to CloudFormation
		Typically used after bootstrapping completes
		Prevents stacks from completing if setup fails
		Creation Policies
		Define how long CloudFormation waits for signals
		Ensures resources are only marked CREATE_COMPLETE when ready
		Works with cfn-signal for validation


	Creation Policies:
		Define how long CloudFormation waits for signals
		Ensures resources are only marked CREATE_COMPLETE when ready
		Works with cfn-signal for validation





Implementation Steps:

	- This is a lot like the bootstrap we did to pre configure wordpress

 *** Refer to screenshot 1 ***

	- This time there is a creation policy which will wait 15 minutes before putting the instance into creation complete

 *** Refer to screenshot 2 ***

	- Line 189 will generate a “Pass” signal if working properly, and the highlighted line will pass the signal back to the Cloudformation stack
	- This is all stored in the metadata section of this config/txt file

 *** Refer to screenshot 3 ***

	- Just some more config. We want these services/components installed, and we want those services enabled and running.
	- We are doing another install of Wordpress and the cowsay banner. Things like PHP and the MariaDB are prerequisites to this.

 *** Refer to screenshot 4 ***

	- This bit here will rerun cfn if the stack is updated. Remember it differs from bootstrapping because it does just run once at creation.

 *** Refer to screenshot 5 ***

	- Here is that success statement that means that everything was installed properly.
	- This is important because it means the CFN-Signal worked as intended.

 *** Refer to screenshot 6 ***

	- Userdata is smaller, and you can see the variables replaced with the real values