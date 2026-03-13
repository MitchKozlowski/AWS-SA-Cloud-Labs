
Purpose:
we use s3 to create a static website showing Animals4life TOP 10 animals


- We start by going over to S3 and creating a bucket
- *** IF you registered a domain, set the bucket name accordingly

 *** Refer to screenshot 1 ***

- This doesn’t mean that the public can immediately access the bucket, there are other steps for that

 *** Refer to screenshot 2 ***

- In the bucket we went to properties and then did this ^^^
- Index.html is used as the default page when the site is loaded
- Error.html Is what is shown when some kind of error has occurred. Like a slightly wrong URL

Went here to upload a file and the 2 files to the bucket:

 *** Refer to screenshot 3 ***

- When we open the site now we get a 403 error. We don’t have permission because we are anonymous to the site and S3 isn’t public by default
- While in the bucket, go to the permissions tab → We gonna add a new bucket policy

 *** Refer to screenshot 4 ***

- *** Need to replace the Resource arn ^^^^