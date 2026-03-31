
Purpose:

	In this demo, we will:

	- Deploy a managed Amazon RDS MySQL instance
	- Migrate a WordPress database from a self-managed MariaDB EC2 instance
	- Update WordPress to use the new RDS backend


Prerequisites:

	- Existing EC2 instance running:
	- WordPress
	- MariaDB
	- SSH access to EC2
	- Security group access configured


Takeaways:

	- RDS removes the need for DB maintenance (patching, backups)
	- Always ensure network connectivity before migration
	- mysqldump is a simple but powerful migration tool
	- Application config updates are critical post-migration



Implementation Steps:


	- I have attached a terraform directory that handles the setup for this lab


*** Refer to screenshot 1 ***

	- Similar start to the DB migration we did in the last lab
	- We have 2 EC2 instances provisioned using Cloudformation, and bootstrapping
	- At the end of the last lab, we decoupled a monolith configuration into  application and database servers

*** Refer to screenshot 2 ***

	- Here we went to the public ip of the app instance and created a blog post.
	  This will populate some data in the database


*** Refer to screenshot 3 ***

	- We begin to setup RDS
	- First we need to create a subnet group

*** Refer to screenshot 4 ***

	- There’s a lot of config in this section, I’ll try to list it out here
    - For MySQL Version check the compatibility of the DB you are looking to migrate
    - Use Sandbox option

*** Refer to screenshot 5 ***

	- First we set the Name, Identifier, and password for the DB

*** Refer to screenshot 6 ***

	- We are using burstable class and gp2 attached storage

*** Refer to screenshot 7 ***

	- Here I assigned a networking config
	- I am using our custom VPC and subnet group
	- Need to create a security group for this to work

*** Refer to screenshot 8 ***

	- Finally we configured the backups to be encrypted with KMS

*** Refer to screenshot 9 ***

	- We are going to edit the Security Group from the photo above

*** Refer to screenshot 10 ***

	- Edit inbound rules

*** Refer to screenshot 11 ***

	- Here we searched for Instance and chose rd2 migrate
	
	
*** Refer to screenshot 12 ***

	- Make sure to copy or note this endpoint, we will need it for the migration
	
	
	- We are going to connect to the instance hosting the MariaDB. 
	- We need to enter these commands in the terminal in order to migrate the DB
	
	
	# Backup of Source Database
	mysqldump -h PRIVATEIPOFMARIADBINSTANCE -u a4lwordpress -p a4lwordpress > a4lwordpress.sql

		- * Change the PRIVATEIPOFMARIADBINSTANCE holder with the private ip of the DB instance
		
		*** Refer to screenshot 13 ***



	# Restore to Destination Database
	mysql -h CNAMEOFRDSINSTANCE -u a4lwordpress -p a4lwordpress < a4lwordpress.sql 

		- * This is where the endpoint we noted will be used. Replace the CNAMEOFRDSINSTANCE with the endpoint ID

	# Change WP Config
	cd /var/www/html
	sudo nano wp-config.php

	replace
	/** MySQL hostname */
	define('DB_HOST', 'PRIVATEIPOFMARIADBINSTANCE');

	with 
	/** MySQL hostname */
	define('DB_HOST', 'REPLACEME_WITH_RDSINSTANCEENDPOINTADDRESS'); 
	

	- Now if we stop the DB instance that has MariaDB on it, The aplication should point to RDS. 
	- You can enter the public IP of the running (application) instance, and see that the blog post still exists
	because it is pointing to RDS