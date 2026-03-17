
Purpose:

This demo demonstrates how to securely share private objects stored in Amazon S3 using pre-signed URLs. 
During the lab, an S3 bucket is created, and an object is uploaded. 
A pre-signed URL is then generated to grant temporary access to the object for unauthenticated users.

The exercise highlights how pre-signed URLs allow controlled, 
time-limited access to private resources without making the bucket or object publicly accessible. Additionally, 
a deny policy is applied to reinforce security and demonstrate how access can still be tightly restricted even when sharing data.


Architecture / Services Used:

Amazon S3 – Stores the object and generates the pre-signed URL

Pre-Signed URL – Provides temporary, secure access to a private S3 object

AWS Identity and Access Management (IAM) – Manages permissions and applies access restrictions via policies

Bucket Policy (Deny Policy) – Explicitly restricts access to enforce security controls


Key Concepts Demonstrated:

Generating and using S3 pre-signed URLs for temporary access

Sharing private objects without making them publicly accessible

Applying explicit deny policies to enforce strict access control

Understanding how authentication and authorization interact with pre-signed URLs

Balancing security and usability when granting external access to resources



Implementation Steps:

- An image was used to populate the Bucket


 *** Refer to screenshot 1 ***

- Create a default bucket and upload the attached image to it
- If you expand the .jpg file and copy the url, you will see that the request is denied when we open it in a new tab
- B/c there is no authentication when we simply paste the url into a new tab
- If we hit the open button in the image file, we can open the image because we are authenticated through our AWS account


 *** Refer to screenshot 2 ***

- We opened AWS CloudShell to add authentication/presigned urls
- For the next example he made the expire time really large


 *** Refer to the denyS3.json Policy ***
 
- then we moved over to IAM and gave the iamadmin user an inline policy
- Now when we try to run (aws s3 ls) in the cloudshell, we get denied

- *** Just to show, when you create a presigned url, anyone who clicks the URL is essentially YOU with your permissions
- ^^^ Now that the deny policy is inplace, the presigned URL will not work
- URL is dynamic, if you remove the deny policy it will work again







