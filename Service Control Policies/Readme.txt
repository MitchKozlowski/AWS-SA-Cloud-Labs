
Purpose:
we update the structure within the organization 
and apply an SCP to the PRODUCTION account to test their capabilities.

 *** Refer to screenshot 1 ***
- In AWS Organizations, We created two OUs. Click box next to root→Actions→New
- Then moved the Prod and Dev accounts into their OU

 *** Refer to screenshot 2 ***
- Next switch to the Prod Role
- Created an S3 Bucket and uploaded files
- We can upload and view the picture in the production account


 *** Refer to screenshot 3 ***
- Went back into General and enabled SCPs


 *** Refer to screenshots 4 & 5 ***
- We then created the Allow All Except S3 SCP
- It takes this JSON file which denies S3 and Allows everything else:


 *** Refer to screenshot 6 ***
- We went to the Prod OU and attached the policy:
- Also removed the directly attached full access policy
- Now when we got to PROD and list the S3 buckets we get a denied message
