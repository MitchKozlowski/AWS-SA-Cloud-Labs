
Purpose:

In this lab, we moved beyond manually installing WordPress on an EC2 instance and instead created a reusable, pre-configured machine image (AMI).

The goal was to:

Automate future WordPress deployments
Reduce setup time
Standardize configuration across instances

Additionally, we customized the EC2 login experience using cowsay for a fun, themed SSH banner.


Architecture:

AWS CloudFormation – Infrastructure provisioning
Amazon EC2 – Hosting WordPress
Amazon Machine Image (AMI) – Pre-configured instance template
Apache + MariaDB + PHP – WordPress stack
cowsay – Custom SSH login banner


Key Takeaways:

AMI creation is a powerful alternative to repeated manual configuration
Works great for:
Preconfigured applications
Standardized environments
Rapid scaling
Combines well with CloudFormation for full infrastructure automation



Implementation Steps:

We start off manually installing wordpress again. Here are the commands we ran in our EC2 instance:

# DBName=database name for wordpress
# DBUser=mariadb user for wordpress
# DBPassword=password for the mariadb user for wordpress
# DBRootPassword = root password for mariadb

# STEP 1 - Configure Authentication Variables which are used below
DBName='a4lwordpress'
DBUser='a4lwordpress'
DBPassword='4n1m4l$L1f3'
DBRootPassword='4n1m4l$L1f3'

# STEP 2 - Install system software - including Web and DB
sudo dnf install wget php-mysqlnd httpd php-fpm php-mysqli mariadb105-server php-json php php-devel -y


# STEP 3 - Web and DB Servers Online - and set to startup

sudo systemctl enable httpd
sudo systemctl enable mariadb
sudo systemctl start httpd
sudo systemctl start mariadb


# STEP 4 - Set Mariadb Root Password
sudo mysqladmin -u root password $DBRootPassword


# STEP 5 - Install Wordpress
sudo wget http://wordpress.org/latest.tar.gz -P /var/www/html
cd /var/www/html
sudo tar -zxvf latest.tar.gz
sudo cp -rvf wordpress/* .
sudo rm -R wordpress
sudo rm latest.tar.gz


# STEP 6 - Configure Wordpress

sudo cp ./wp-config-sample.php ./wp-config.php
sudo sed -i "s/'database_name_here'/'$DBName'/g" wp-config.php
sudo sed -i "s/'username_here'/'$DBUser'/g" wp-config.php
sudo sed -i "s/'password_here'/'$DBPassword'/g" wp-config.php   
sudo chown apache:apache * -R


# STEP 7 Create Wordpress DB

echo "CREATE DATABASE $DBName;" >> /tmp/db.setup
echo "CREATE USER '$DBUser'@'localhost' IDENTIFIED BY '$DBPassword';" >> /tmp/db.setup
echo "GRANT ALL ON $DBName.* TO '$DBUser'@'localhost';" >> /tmp/db.setup
echo "FLUSH PRIVILEGES;" >> /tmp/db.setup
mysql -u root --password=$DBRootPassword < /tmp/db.setup
sudo rm /tmp/db.setup


# STEP 8 - Browse to http://your_instance_public_ipv4_ip




 *** Refer to Screenshot 1 ***
 
- We we installed Cowsay which replaces the MOTD banner

- Here are the commands to do so:
- sudo dnf install -y cowsay
- cowsay "oh hi"
- Create file /etc/update-motd.d/40-cow
- sudo nano /etc/update-motd.d/40-cow
- #!/bin/sh
- cowsay "Amazon Linux 2023 AMI - Animals4Life"
- sudo chmod 755 /etc/update-motd.d/40-cow
- sudo update-motd
- sudo reboot

- Relogin


 *** Refer to screenshot 2 ***

- Need to shutdown the instance to prevent inconsistencies when creating an AMI
- Right click the instance → Image & Template → create image

- For now give it a name
- You’ll see a snapshot in the sidebar under EBS

- In the AMI sidebar you can launch an instance from this AMI, which we do
- Remember when you launch an instance from a custom  AMI, the username is usually wrong. You want ec2-user

- * Pretty powerful concept. You can see that the config you do in an instance can easily be saved and you can spin up X amount of instances from it










