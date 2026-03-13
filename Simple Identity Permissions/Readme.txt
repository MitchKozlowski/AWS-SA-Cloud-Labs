

Purpose:
In this Lab we create an IAM user, and experiment with assigning permissions on two S3 buckets via inline policies and managed policies.

the 1st will login to the IAMADMIN user of the general account

the 2nd will login to an IAM user called 'sally' for testing.


 *** Refer to Stack Resources screenshot and the template YAML file to see the resources created by Cloudformation. ***
 
 
- We used a template to create the Sally user
- Sally didn’t have access to any of the S3 buckets we created, and had to change her username when we logged in
- We then gave her permission to the 2 buckets and were able to upload a picture to both of them
- After deleting the policy she couldn’t view or interact with the buckets
- Then we gave her an inline policy that gives her access to the S3 buckets but denies Access to the Catpics Bucket
 
 
