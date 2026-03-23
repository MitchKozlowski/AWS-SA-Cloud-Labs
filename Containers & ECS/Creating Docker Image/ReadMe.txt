
Purpose:

In this lab, we deploy an EC2 instance and use it as a Docker host to build and run a containerized application called “Container of Cats.”

The workflow demonstrates:

Installing Docker on EC2
Building a Docker image from source
Running and testing a container
Publishing the image to Docker Hub
Architecture Summary
VPC with public subnets
Internet Gateway for external access
EC2 instance (t3.micro) in a public subnet
Security Group allowing:
SSH (22)
HTTP (80)


Key Concepts Learned
Docker Image vs Container
Image → blueprint
Container → running instance
Port Mapping
External EC2 port → internal container port
Immutable Infrastructure
Build once → run anywhere




Implementation Steps:

- Start by deploying and connection to the EC2 instance via Session Manager

 *** Refer to screenshot 1 ***

- We installed Docker, Started the service, gave EC2-user permission, and verified that by switching to that user and running docker ps

Here is a summary of the commands we input:

# Install Docker Engine on EC2 Instance
sudo dnf install docker
sudo service docker start
sudo usermod -a -G docker ec2-user

LOGOUT and login

sudo su - ec2-user

# Build Docker Image
cd container
docker build -t containerofcats .
docker images --filter reference=containerofcats

# Run Container from Image
docker run -t -i -p 80:80 containerofcats


 *** Refer to screenshot 2 ***

- Here is the dockerfile which the engine will use


 *** Refer to screenshot 3 ***

- And here is the contents to the container directory
- Each line in this dockerfile will create a new layer in the docker image remember

- After running this command:

docker run -t -i -p 80:80 containerofcats

- You can connect to the ip address of the instance!
