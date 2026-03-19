
Purpose:

- Building on the existing Amazon VPC architecture, this lab enables private subnets (App, DB, Reserved) 
to securely access the internet without being directly exposed.
- This is achieved by deploying NAT Gateways in multiple Availability Zones and configuring routing appropriately.

NAT Gateway Deployment:

- 3 NAT Gateways created (one per AZ: A, B, C)

Each NAT Gateway is:

- Placed in a public Web subnet
- Associated with an Elastic IP
- Ensures AZ-level redundancy and avoids a single point of failure

Route Tables & Routing:

- Separate route tables were created for private subnets in each AZ:
- Default Route Configuration
- 0.0.0.0/0 → NAT Gateway (AZ-specific)

Associations
- Each route table was associated with:
- Reserved subnets
- Application subnets
- Database subnets

Per Availability Zone:

- AZ A → NAT Gateway A
- AZ B → NAT Gateway B
- AZ C → NAT Gateway C

This design ensures:

- Traffic stays within the same AZ (reduced latency & cost)
- High availability if an AZ fails


Connectivity Testing

Used an internal (private) instance to validate:

- Outbound internet access via NAT Gateway
- No direct inbound access from the internet

Key Concepts Demonstrated:

- NAT Gateway architecture and use cases
- High availability across multiple Availability Zones
- Private subnet internet access (outbound only)
- Route table segmentation per AZ
- Avoiding cross-AZ dependency for NAT traffic

Why This Design Matters:

- Security: Private resources are not publicly accessible
- High Availability: No single NAT Gateway dependency
- Cost Optimization: Keeps traffic within the same AZ
- Scalability: Supports production-grade architectures


⚠️ Important Notes:

- NAT Gateways are AZ-specific resources
- Using a single NAT Gateway for all AZs is:
- A single point of failure
- Potentially higher cost due to cross-AZ traffic

Outcome

By the end of this lab:

- All private subnets have secure outbound internet access
- The architecture is highly available across AZs
- The VPC now supports a production-ready network design



Implementation Steps:

 *** Refer to screenshot 1 ***
 
- Create the stack, and then under resources click on the a4linternaltest physical ID
- Right click the instance and hit connect, connect with session manager


 *** Refer to screenshot 2 ***

- Can’t ping any public addresses right now in the private VPC

 
 *** Refer to screenshot 3 ***

- Here we are creating NAT Gateway. Just be sure to hit allocate Elastic IP.


 *** Refer to screenshot 4 ***

- Now we create a route table for each of them


 *** Refer to screenshot 5 & 6 ***

- Need to add a route for the 3 tables:


 *** Refer to screenshot 7 ***

- Finally we need to associate the subnet for our EC2 instance to be able to ping public endpoints:

 *** Refer to screenshot 8 ***

- Ex of all of the "A" AZ subnets: