## [DEMO] **Simple Automation With CloudFormation (CFN)**

Purpose:
The purpose of this lab is to use Cloudformation to create a stack using a template. 
If you browser the YAML file you'll see the resources and parametersThat are defined. 
We esentially create an EC2 instance with public DNS and IP assigned.
A security group and session manager role is created as well.


- In AWS search stack and then we Created a template by uploading this YAML file
- After that as you click through the UI template creation, you’ll see the options populated


*** View the Attached YAML Files for Reference ***



- !Ref will point to an AWS specific resource/service
- The LatestAmiId field at the top points to the latest distro of whatever AMI is typed in

You’ll see this process when you complete the template:

*** Reference the Template photo ***