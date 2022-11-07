1. VPC - 192.168.0.0/16
2. Create IGW
   - IGW attach to VPC
3. Public Subnet - 192.168.1.0/24
    - Public Subnet to VPC
    - Public Subnet which AZ
4. Private Subnet - 192.168.2.0/24
    - Public Subnet to VPC
    - Public subnet which AZ
5. Public Route Table
    - Which VPC?
6. Privat Route Table 
    - Which VPC?
7. Create Public Route 
    - Which Route Table?
    - destination - 0.0.0.0/0
    - target - IGW
8. EIP 

9. Create NAT GW
    - Which Subnet?
    - EIP attach NAT GW
10. Create Private Route
    - Which Route Table?
    - Destination - 0.0.0.0/0
    - Target - NAT Gateway