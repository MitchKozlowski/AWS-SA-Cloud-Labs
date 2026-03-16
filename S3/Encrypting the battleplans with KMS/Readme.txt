
Purpose:

This demo explores how AWS Key Management Service (KMS) can be used to securely encrypt and decrypt sensitive data. 
During the lab, a customer-managed KMS key is created and configured along with a key alias for easier identification and management. 
Using the AWS Command Line Interface (CLI), data is encrypted and later decrypted to demonstrate how KMS integrates with applications and workflows.
The exercise highlights how KMS enables secure handling of sensitive information while maintaining centralized control over encryption keys within **Amazon Web Services.


Architecture / Services Used:

AWS Key Management Service (KMS) – Creates and manages encryption keys used to protect sensitive data

Customer Managed KMS Key (CMK) – Used to perform encryption and decryption operations

KMS Alias – Provides a human-readable reference for the KMS key

AWS Command Line Interface (CLI) – Executes encryption and decryption commands using the KMS key



Key Concepts Demonstrated:

Creating and managing customer-managed encryption keys

Using aliases to simplify key management

Performing encryption and decryption operations with KMS

Understanding how applications can interact with KMS through the CLI

Centralized key management and secure data protection in AWS



Implementation Steps:

View the "Linux Commands.txt" file included in this directory. We will use these to encrypt/decrypt a .txt file


 *** Refer to screenshot 1 ***
- Went to the KMS console and created a key with defualt config
- Gave it an alias of catrobot
- Here we gave admin permission to the iamadmin to use the key
- The next step says how has usage privilege of the key


 *** Refer to screenshot 2 ***
 
 - Here you can see our customer managed key that we created
 
 *** Refer to Screenshot 3 ***
 
- Click the terminal icon to use Cloudterminal. Here we can import the cli text uploaded in this lesson
- Using the Linux commands you can see that the output of the .txt file is encrypted


 *** Refer to screenshot 4 ***
- After entering the second portion of linux commands, you can see that we have decrypted the txt file using the KMS key