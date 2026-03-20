
Purpose:

AWS EC2 Storage Demo – EBS vs Instance Store
Overview

This demo explores the differences between Amazon EBS and EC2 Instance Store using Amazon EC2 instances.

The lab demonstrates persistence, portability, and lifecycle behavior of different storage types across instances, Availability Zones, and regions.


Architecture:

- 3 EC2 instances deployed via AWS CloudFormation

Instances spread across:

- AZ-A (Instance 1 & 2)
- AZ-B (Instance 3)
- Custom VPC with public subnets


Key Takeaways:
EBS (Persistent Storage):

Survives:

Reboot 
Stop/Start 
Instance termination (if configured) 

Can:

Move between instances (same AZ)
Be snapshotted
Be restored in different AZs or regions
Instance Store (Ephemeral Storage)

Survives:

Reboot 

Does NOT survive:

Stop/Start

Termination


Tied to:

Physical host hardware


Real-World Use Cases
Use EBS for:

Databases
Application data
Persistent workloads
Use Instance Store for:
Cache (Redis, temp data)
Scratch space
High-performance ephemeral workloads



Implementation Steps:

We will:

- Create an EBS Volume
- Mount it to an EC2 instance
- Create and Mount a file system
- Generate a test file
- Migrate the volume to another EC2 instance in the same AZ
- verify the file system and file are intact
- Create a EBS Snapshot from the volume
- Create a new EBS Volume in AZ-B
- Verify the filesystem and file are intact
- Copy the snapshot to another region
- Create an EC2 instance with instance store volumes
- Create a filesystem and test file
- Restart instance and verify the file system is intact
- Stop and Start the instance
- Verify the file system is no longer present - new EC2 Host.


 *** Refer to screenshot 1 ***

- In the EC2 console. You can see the three EBS volumes in use, as they are the boot volumes for the instances


 *** Refer to screenshot 2 ***

- Here we are creating the GP3 Volume that we will use

 
 *** Refer to screenshot 3 ***

Right click the new volume and hit attach. Here you can attach it to the instance, and choose the “name” (Drive Path)


 *** Refer to screenshot 4 ***
 
- After Connecting to the instance we first check that the 10 GB volume is there, and make sure it just says data, 
which means there’s nothing on it and we need to give it a filesystem


 *** Refer to screenshot 5 ***
 
- Created a filesystem, checked that it was there

 
 *** Refer to screenshot 6 ***
  
- Made ebstest directory and mounted the volume to it
- Created a text file and read from it using Cat
- Finished part 1 with a reboot

  
 *** Refer to screenshot 7 ***
   
- (Important) When we reboot we don’t see our filesystem because we manually mounted it

   
 *** Refer to screenshot 8 ***
 
 - Grab the UUID of our volume
 
  
 *** Refer to screenshot 9 ***
 
- Using Nano we can edit the fstab file and add
  /ebtest xfs defaults,nofail 
 
  
 *** Refer to screenshot 10 & 11 ***
   
- We can see that our txt file is still there showing that EBS data is persistent. Data is there after reboot.
   
   
 *** Refer to screenshot 12 ***

- We shutdown the instance, and detached the EBS volume. Showing that EBS isn’t instance attached
- We will now attach it to the other instance in this AZ
	

 *** Refer to screenshot 13 ***

- You can see that our filesystem still exists even on the other instance
- Our text file is still in the ebstest directory
- We can shutdown this instance now
- Now we are going to attempt to move our ebs volume to the instance in AZ B. Because it’s AZ locked we will make a snapshot which is stored on S3(region wide)
	 
	 
 *** Refer to screenshot 14 & 15 ***
 
- Go to snapshots, right click, create volume from snapshot
- Change the availability zone
- Then you want to attach the volume to the instance in Zone B
 
 *** Refer to screenshot 16 ***
 
- There’s our test file in this instance running is AZ-B
 
 
 *** Refer to screenshot 17 ***
 
- Start by making a pretty default instance. We need one that supports instance storage so we looked for m5dn.large.
- Choose our custom VPC and sn-web-A subnet
- We use a custom Security Group
- Remember that instance storage is included with the instance
 
 *** Refer to screenshot 18 ***
 
- Did the same process of creating the filesystem, mounting, create dir, make file
- Rebooting the instance didn’t delete the instance storage, but if you stop the instance/host changes then the data won’t be there anymore