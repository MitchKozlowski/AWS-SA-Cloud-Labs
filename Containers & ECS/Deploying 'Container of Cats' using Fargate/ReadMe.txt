
Purpose:

- Deploy a Docker container (hosted on Docker Hub) to AWS without managing servers using AWS Fargate.


Core Services

Amazon ECS manages container deployment, scheduling, and lifecycle.
AWS Fargate provides serverless compute, removing the need to manage EC2 instances.

Key Concepts:

A task definition is an immutable blueprint (image, CPU/memory, networking).
An ECS service maintains desired state and replaces failed tasks automatically.
awsvpc networking gives each task its own IP and isolation.

Tradeoffs:

Less operational overhead, faster deployments.
Higher cost at scale, less control over infrastructure.


Implementation Steps:


 *** Refer to screenshot 1 ***
 
- We be starting in the ECS console. Step 1 is to create Clusters
 
 *** Refer to screenshot 2 ***
 
- In the demo he changed networking options to use the default VPC.
- You may get an error if it’s the first time making one on an account. Just wait a few minutes and try agian
 
 *** Refer to screenshot 3 ***
 
- The cluster is active using fargate
 
 *** Refer to screenshot 4 ***
 
- Next we need to create a Task. Named it containerofcats, named container 1 containerofcatsweb and pointed the URI to his Docker image
- Set the port name as is in the image. Need to disable logging as well
 
 *** Refer to screenshot 5 ***
 
- Resource monitoring for the container
 
 *** Refer to screenshot 6 ***
 
- Showing how to create new tasks
 
 *** Refer to screenshot 7 ***
 
- This shows task definition
 
 *** Refer to screenshot 8 ***
 
- Here we setting the networking configuration. Again we are using subnets from the default VPC.
 
 *** Refer to screenshot 9 ***
 
- Here we have a custom security group, with connection from anywhere.
- This SG will be attached to the Task.
 
 *** Refer to screenshot 10 ***

- Note down the Public IP address.
- We have now deployed a fargate cluster and set up a container off of our image
 