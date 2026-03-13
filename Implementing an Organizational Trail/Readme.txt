In this Lab we will implement a Organizational CloudTrail for the Animals4life organisation.

This CloudTrail will be configured for all regions and set to log global services events.

We will set the trail to log to an S3 bucket and then enhance it to inject data into CloudWatch Logs


 *** Refer to Screenshot 1 ***

- Searched “CloudTrail” in the search bar
- Went to trails —> Create Trails
- Gave the trail a name → Created S3 Bucket→ Disbaled SSE-KMS Encryption
- Then we opted into CloudWatch Logs


 *** Refer to Screenshot 2 ***
On the next page we left as default, 
but remember that other event types besides Management events cost money


 *** Refer to Screenshot 3 ***
If you click the link under S3 bucket in CloudTrail,
You can view the logs/ log file structure


 *** Refer to Screenshot 4 ***
A view of logs in CloudWatch:
If you go under trails→”the trail”, You can stop logging as to not incur any cost


