# Terraform Practice exercise 2

#### Below are the lab exercises for practicing Terraform.

-----------------------------

Create the below resources using terraform as per the attached infrastructure diagram . Please reach out to Kumar (kumar@cloudifyops.com) or Adarsh (adarshashok.k@cloudifyops.com) if any questions or doubts. 

Once the terraform code is ready and tested, place it in the gitlab account and update the status over the email to the above email ids.

![image.png](./image.png)

- Configure the backend file for storing the state file into S3
- Create module for 
    - network part(vpc,subnets,igw,nat,route-tables)
    - Security groups
    - EC2
    - Cloudwatch Alaram
    - SNS and Subscription
    - S3
    - RDS 
    - Lambda Function
- VPC cidr range should be - 10.0.0.0/16.
- Public subnets - 10.0.1.0/24,10.0.2.0/24
- Private subnet - 10.0.3.0/24,10.0.4.0/24
- Create IGW and attach the same to the vpc.
- Create private and public route tables and associate the same with the respective subnets.
- Create NAT gateway and route it to private subnet
- Create a bastion host in public subnet - allow ssh access from 0.0.0.0/0 (volume = 10 gb)
- Create a private server in private subnet - allow ssh access from sg of bastion host.(volume= 25 gb)
- Create a application load balancer and place in application server
- Create a postgres db and connect with each server.
- Create an cloudwatch alaram for application server (metric - cpu utilization)
- Set up alerts (email notification)automatically through SNS when the metric reaches a threshold 80%
- Create lambda function and add a s3 bucket as a trigger  (lambda function file is also added in this repo "lambda-function.py")
