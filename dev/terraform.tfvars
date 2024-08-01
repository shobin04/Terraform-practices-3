###vpc###
vpc_name             = "my_vpc"
cidr_block           = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidr1 = "10.0.3.0/24"
private_subnet_cidr2 = "10.0.4.0/24"
availability_zones   = ["us-east-1a", "us-east-1b"]
availability_zones1  = "us-east-1a"
availability_zones2  = "us-east-1b"
vpc_id               = "vpc-074dbdbc2f0e59052"

key_name = "new_key_pair"
##bastion-server##
instance_type    = "t2.micro"
bastion_ami      = "ami-0e001c9271cf7f3b9"
public_subnet_id = "subnet-0e11456c8a69ecd7a"
bastion_sg_id    = "sg-0c719560ead33a03f"
bastion_name     = "bastion-server"

##private-server##
private_ami       = "ami-0e001c9271cf7f3b9"
private_subnet_id = "subnet-0110929ed3821966d"
private_sg_id     = "sg-07173681c5358c24b"
private_name      = "private-server"
db_sg_id = "sg-02a6ae53676ff563c"

##alb##
subnets = ["subnet-0e11456c8a69ecd7a", "subnet-097de77a476a4220d"]
target_instance_ids = ["i-0fa153b4d6bcc56af"] 
security_groups = [ "sg-0304d7ebd17bde9f7" ]

##postgres##
identifier          = "my-postgres-db"
allocated_storage   = 20
instance_class      = "db.t3.micro"
db_name             = "mydatabase"
username            = "myuser"
password            = "mypassword"
subnet_ids      = ["subnet-0ca8d136d27a7342f", "subnet-0110929ed3821966d"]
security_group_id = "sg-02a6ae53676ff563c"

##s3##
bucket_id = "labmdatestingdemo123"