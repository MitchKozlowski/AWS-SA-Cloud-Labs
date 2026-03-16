
Purpose:

This demo illustrates how to implement Cross-Region Replication (CRR) for a static website hosted in Amazon S3.
During the lab, two S3 buckets are created in separate AWS regions — N. Virginia and N. California. 
CRR is then configured to automatically replicate objects from the primary bucket to the secondary bucket, ensuring data durability, compliance, 
and faster access for users in different regions.

The exercise demonstrates how replication can be used to increase availability, protect against regional failures, 
and maintain consistent content across multiple locations.


Architecture / Services Used:

Amazon S3 – Two buckets in different regions for hosting the static website

Cross-Region Replication (CRR) – Automatically replicates objects from the source bucket to the destination bucket

AWS Identity and Access Management (IAM) – Configures permissions to allow replication between buckets


Key Concepts Demonstrated:

Setting up S3 buckets in multiple regions

Configuring Cross-Region Replication to synchronize objects automatically

Ensuring data durability and business continuity across AWS regions

Understanding role-based permissions required for replication

Maintaining availability and redundancy for a static website


Implementation Steps:

 *** Refer to screenshot 1 ***
 
- Created a bucket in US-East-1 called sourcebucketmk2798638712
- We turned on static hosting for the source bucket:
- Because we are making this a static website, we need to turn off block public access in the bucket permissions

 *** Refer to screenshot 2 ***

- Then we need to make a bucket policy. This policy is included in the demo files
- ^^^ Don’t forget to change the resource ARN
- With the destination bucket make sure to change region (us-west-1)

 *** Refer to screenshot 3 ***
- Then create a bucket with static web hosting (with bucket policy), and allow public access


 *** Refer to screenshots 4 & 5 ***
- Under source bucket go to management → Replication rules


 *** Refer to screenshot 6 ***
- We uploaded these files to the source bucket and as you can see:
- We then uploaded new files with the same name. When we opened the source bucket the site changed, but not yet for the destination bucket


