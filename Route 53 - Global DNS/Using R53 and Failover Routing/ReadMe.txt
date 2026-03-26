
Purpose:

In this demo, we will explore how to improve application resilience and internal DNS management using Amazon Route 53.

We will:

	- Configure Failover Routing for high availability
	- Implement health checks to monitor endpoints
	- Create and use a Private Hosted Zone for internal DNS resolution


Key Concepts:

	Failover Routing

	Failover routing in Amazon Route 53 allows you to define:

		- A primary endpoint (active)
		- A secondary endpoint (standby)

		- Traffic is automatically redirected to the secondary endpoint if the primary fails a health check.


Health Checks:

	Route 53 health checks monitor the health of your application endpoints.

	They can check:

		- HTTP/HTTPS endpoints
		- TCP connections

	If a health check fails:

		- Route 53 marks the endpoint as unhealthy
		- Failover routing redirects traffic accordingly
		- Private Hosted Zones

	A Private Hosted Zone allows DNS resolution only within a VPC.

	This is useful for:

		- Internal applications
		- Microservices communication
		- Private infrastructure

	Key characteristics:

		- Not publicly accessible
		- Associated with one or more VPCs
		- Enables internal domain names like:
		- app.internal.local
		- db.mycompany.local


Architecture Overview:


	User Request
		 ↓
	Route 53 DNS
		 ↓
	Primary Endpoint (Healthy?) ── Yes ──> Serve Traffic
		 │
		 └── No ──> Secondary Endpoint (Failover)


For Private Hosted Zone:

	VPC
	 ├── EC2 Instance (app.internal.local)
	 ├── RDS Database (db.internal.local)
	 └── Internal DNS Resolution via Route 53



Implementation Steps:


	- Start by going to the one EC2 instance, and try to open the public IP in a new tab. It shouldn’t work

	- For this we need to allocate an Elastic IP


	*** Refer to screenshot 1 ***

		- Here we are assigning an elastic IP, so we can the instance can be reached via the public internet

	*** Refer to screenshot 2 ***

		- After you Allocate one, we need to associate it with the instance. So right click the elastic IP and hit associate

	*** Refer to screenshot 3 ***

		- This EC2 instance is our main record, it runs the website. We want to setup an S3 bucket in case it fails
		- It’s important to name the bucket with your registered domain name
		- Allow public access (so uncheck the block all box), and check the acknowledge box

	*** Refer to screenshot 4 ***

		- Here we uploaded a few files necessary to make static hosting work.

	*** Refer to screenshot 5 ***
	
		- Go to bucket settings and enable static website

	*** Refer to screenshot 6 ***

		- Go to permissions and add a bucket policy
		- Make sure to replace the ARN with ARN of our S3 Bucket


	*** Refer to screenshot 7 ***

		- Now that our bucket is setup with static hosting and a policy, we move over to R53 and setup a health check
		- Name it something relevant and under advanced settings he made it check every 10 seconds, which would incur more charge, 
		  but it is so the website can be recovered quicker

	*** Refer to screenshot 8 ***

		- Here we enable health checks

	*** Refer to screenshot 9 ***

		- Here we are using the wizard to create a failover record

	*** Refer to screenshot 10 ***
	
		- First part of defining a failover record
	

	*** Refer to screenshot 11 ***

		- before defining the record, for name he put www and set the ttl to 60s
		- This defines the EC2 instance with an attached health check


	*** Refer to screenshot 12 ***

		- We also want to create a failover record for the bucket we created
		- This isn’t associated with any health checks because it is the failover
		- At this point if you enter the url hostname into a new tab the website should resolve

		- To simulated a fail, you can stop the instance. The health check should show unhealthy, then it should recover from the bucket



Private Hosted Zones:

	*** Refer to screenshot 13 ***

		- Here we start to setup the hosted zone configuration

	*** Refer to screenshot 14 ***

		- We used the default VPC for this hosted zone. We will change this later.
		  This will show that we need to associate this hosted zone with our custom VPC

	*** Refer to screenshot 15 ***

		- We can create a simple record and is use 1.1.1.1 as a testing IP

	*** Refer to screenshot 16 ***

		- You can go to our instance and try to ping the address. 
		- It doesn’t work because our hosted zone is associated with the Default VPC and not our A4L one.

	*** Refer to screenshot 17 ***

		- I went back and edited the zone to be associate with our custom VPC
		- Head back to the EC2 instance. The pinging 1.1.1.1 will work now.