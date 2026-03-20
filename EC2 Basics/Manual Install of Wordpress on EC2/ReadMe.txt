
Purpose:

In this demo lab, I manually deployed a WordPress website on an Amazon EC2 instance 
to understand the underlying setup process before leveraging automation tools.

This hands-on exercise highlights the configuration of a full LAMP/LEMP-style stack within AWS and 
reinforces foundational cloud and Linux administration skills.


Objectives:

Launch and configure an EC2 instance
Install and configure:
Apache Web Server
MariaDB Database Server
PHP and required libraries
Download and configure WordPress
Connect WordPress to the database
Host a functional website via EC2


Architecture Overview:

User (Browser)
      │
      ▼
EC2 Instance (Amazon Linux)
 ├── Apache (Web Server)
 ├── PHP (Application Layer)
 ├── MariaDB (Database)
 └── WordPress (CMS)


Outcome:

Successfully deployed a working WordPress site on EC2
Configured a full web stack manually
Gained deeper understanding of:
Web server setup
Database integration
Application deployment in the cloud


Takeaways:

Manual setup builds strong foundational knowledge before automation
Understanding each component (Apache, MariaDB, PHP) is critical for troubleshooting
This process can later be automated using:
AWS CloudFormation
User Data scripts
Docker or container services



Implementation Steps:

- We start this lab by deploying the cloudformation template
- We connect to the EC2 instance once it passes its ready checks

 *** Refer to screenshot 1 ***

- We set these as environment Variables
- Test with echo $Variable


 *** Refer to screenshot 2 ***

- Here we start the services

 *** Refer to screenshot 3 ***

- These are the commands we used to install/configure the app


 *** Refer to screenshot 4 ***
 
-  Where we currently stand at the end of part 1. We unzipped the wordpress/ dir and copied it to the web root ”/var/www/html”
 
 *** Refer to screenshot 5 ***
 
- This segments essentially modifies the wp-config file to replace the credential place holders


 *** Refer to screenshot 6 *** 
 
- We populated the db.setup file and run the server
- Wordpress should be working now


 *** Refer to screenshot 7 ***

- When we go to the public IP of the instance we have the installation dialog