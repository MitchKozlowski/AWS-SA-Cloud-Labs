
Purpose:

	In this demo, we will migrate the database from the monolithic animals4life WordPress instance to a dedicated MariaDB database running on EC2.

	This simulates a common real-world scenario where applications are decoupled to improve scalability, performance, and maintainability.

	Objectives:
		- Separate the database layer from a monolithic WordPress deployment
		- Provision and configure a dedicated MariaDB instance on EC2
		- Perform a manual database migration
		- Reconfigure WordPress to use the new external database



Architecture Change:

	Before (Monolithic):

		- EC2 instance running:
		- Apache/PHP
		- WordPress
		- Local MariaDB database

	After (Decoupled):

		- EC2 Instance #1:
		- Apache/PHP
		- WordPress
		- EC2 Instance #2:
		- Dedicated MariaDB database



Key Concepts:

	Decoupling Architecture

		Separating the database from the application layer:

		- Improves scalability
		- Allows independent upgrades
		- Reduces blast radius of failures


Tradeoffs

	Pros:

	- Better scalability
	- Cleaner architecture
	- Easier to migrate to managed services later (e.g., RDS)

	Cons:

	- More infrastructure to manage
	- Slight increase in latency
	- Requires networking/security configuration






Implementation Steps:


	Lab Commands:
	# Backup of Source Database
	mysqldump -u root -p a4lwordpress > a4lwordpress.sql


	# Restore to Destination Database
	mysql -h privateipof_a4l-mariadb -u a4lwordpress -p a4lwordpress < a4lwordpress.sql 

	# Change WP Config
	cd /var/www/html
	sudo nano wp-config.php

	replace
	/** MySQL hostname */
	define('DB_HOST', 'localhost');

	with 
	/** MySQL hostname */
	define('DB_HOST', 'REPLACEME_WITH_MARIADB_PRIVATEIP'); 

	sudo service mariadb stop



*** Refer to screenshot 1 ***

	- The purpose of this lab is to move away from a monolith architecture
	- We will be migrating the DB from the Application Instance to a separate DB instance
	- Here are the 2 instances we will be using
	
*** Refer to screenshot 2 ***

	- For this Demo we will need to setup wordpress using the public IP
	- We have Wordpress installed on the first EC2 instance
	- When you put the public IP via the web browser you should see this setup page

*** Refer to screenshot 3 ***

	- Here we can create a blog post, with some pictures, to populate our monolithic database


*** Refer to screenshot 4 ***

	- After that we are going to head to the monolith instance and start entering the commands
	- On the second command and commands going forward we will need to replace some of the placeholders
	- Here we add the private IPv4 address of the DB instance

*** Refer to screenshot 5 ***

	- In the config file, we change this from localhost, to the Private IP of the DB instance

*** Refer to screenshot 6 ***

	- Now when we reload the wordpress site it still works and is pointing at the DB instance
	- We can verify that by stopping MariaDB on the monolith instance and the blog still connects

	It should be stressed that this isn't the best use of cloud architecture. When possible, you should use a database service like RDS.
	This reduced admin overhead and improves resiliency 
