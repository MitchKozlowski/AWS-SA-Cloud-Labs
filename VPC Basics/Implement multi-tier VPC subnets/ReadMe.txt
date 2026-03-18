
Purpose:

Using the existing Amazon VPC (10.16.0.0/16), subnets were created to support a highly available 3-tier application design:

- Web Tier (Public-facing)
- Application Tier (Private)
- Database Tier (Isolated)
- Reserved Tier (Future use / expansion)

Each tier is deployed across 3 Availability Zones (A, B, C) to ensure redundancy and fault tolerance.



Subnet Design:

Each Availability Zone contains four /20 subnets, evenly segmented:

AZ A
- Reserved: 10.16.0.0/20
- DB: 10.16.16.0/20
- App: 10.16.32.0/20
- Web: 10.16.48.0/20

AZ B
- Reserved: 10.16.64.0/20
- DB: 10.16.80.0/20
- App: 10.16.96.0/20
- Web: 10.16.112.0/20

AZ C
- Reserved: 10.16.128.0/20
- DB: 10.16.144.0/20
- App: 10.16.160.0/20
- Web: 10.16.176.0/20

This structured allocation ensures:
- Predictable IP addressing
- Easy scaling and management
- Logical separation of application layers
- IPv6 Configuration
- IPv6 was enabled and configured across all subnets:
- Each subnet was assigned an IPv6 range
- Auto-assign IPv6 addresses enabled on all subnets
- IPv6 ranges increment logically per subnet (e.g., IPv6 00 → 0B)


This allows:
- Dual-stack networking (IPv4 + IPv6)
- Future-proofing for modern applications
- Improved global connectivity
- Key Concepts Demonstrated
- Multi-AZ subnet architecture
- CIDR block subdivision (/16 → /20)
- Tiered network isolation (Web / App / DB)
- IPv6 subnet allocation and configuration
- Designing for scalability and high availability



The diagram illustrates:
- Subnet distribution across AZs A, B, and C
- Separation of DB, App, and Web tiers
- Reserved subnet space for future use
- Logical IP range allocation within the VPC



Subnet naming convention:
- sn-web-A, sn-app-B, etc.
- Reserved subnets are intentionally unused for future expansion
- This design prepares for later labs involving:
- Route tables
- Internet Gateway / NAT Gateway
- Load balancing and application deployment



Implementation steps:


 *** Refer to screenshot 1 ***

To start be in the VPC console→subnets(sidebar)→create subnet

2 things to note. First is when assigning the subnet CIDR use the network range (eg. 10.16.0.0/20) Second,
the numbers next to IPv6 in the document above are there own v6 networks. Y
ou can do this by changing the IPv6 address in the create subnet page from :1100 to :1101 and so on. 
You can do this by clicking the right arrow


 *** Refer to screenshot 2 ***

Just keep hitting add subnet in the bottom left until we have all 4

Another thing to keep in mind is that you want them all in the same availability zone


 *** Refer to screenshot 3 ***

Then we rinse and repeat for the subnets in AZ-B and AZ-C



 *** Refer to screenshot 4 ***

Lastly, so that each subnet can auto-assign v6 addresses, we edit each subnet and check this box.




