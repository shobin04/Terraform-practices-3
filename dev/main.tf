#vpc##
module "vpc" {
  source               = "/mnt/c/Users/Clops_Shobin/Terraform/terraform-practice3/modules/vpc"
  vpc_name             = var.vpc_name
  cidr_block           = var.cidr_block
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidr1 = var.private_subnet_cidr1
  private_subnet_cidr2 = var.private_subnet_cidr2
  availability_zones   = var.availability_zones
  availability_zones1  = var.availability_zones1
  availability_zones2  = var.availability_zones2
}

module "bastion_security_group" {
  source = "/mnt/c/Users/Clops_Shobin/Terraform/terraform-practice3/modules/bastion-security-group"
  vpc_id = var.vpc_id
}

module "private_security_group" {
  source        = "/mnt/c/Users/Clops_Shobin/Terraform/terraform-practice3/modules/private-security-group"
  vpc_id        = var.vpc_id
  bastion_sg_id = var.bastion_sg_id
  db_sg_id = var.db_sg_id
}

module "db_security_group" {
  source        = "/mnt/c/Users/Clops_Shobin/Terraform/terraform-practice3/modules/rds-security-group"
  vpc_id        = var.vpc_id
  private_sg_id = var.private_sg_id
}

##keypair##
module "key_pair" {
  source   = "/mnt/c/Users/Clops_Shobin/Terraform/terraform-practice3/modules/keypair"
  key_name = var.key_name
}

# ##bastion-server##
module "bastion" {
  source           = "/mnt/c/Users/Clops_Shobin/Terraform/terraform-practice3/modules/bastion-server"
  bastion_ami      = var.bastion_ami
  instance_type    = var.instance_type
  bastion_name     = var.bastion_name
  public_subnet_id = var.public_subnet_id
  bastion_sg_id    = var.bastion_sg_id
  key_name         = var.key_name
  vpc_id           = var.vpc_id
}

##private-server##
module "private_server" {
  source            = "/mnt/c/Users/Clops_Shobin/Terraform/terraform-practice3/modules/private-server"
  private_ami       = var.private_ami
  instance_type     = var.instance_type
  private_name      = var.private_name
  private_subnet_id = var.private_subnet_id
  private_sg_id     = var.private_sg_id
  key_name          = var.key_name
  vpc_id            = var.vpc_id
}

##alb-sg##
module "alb_security_group" {
  source = "/mnt/c/Users/Clops_Shobin/Terraform/terraform-practice3/modules/alb-security-group"
  vpc_id        = var.vpc_id
  private_sg_id = var.private_sg_id
}

##alb##
module "alb" {
  source              = "/mnt/c/Users/Clops_Shobin/Terraform/terraform-practice3/modules/alb"
  name                = "my-alb"
  security_groups     = var.security_groups
  subnets             = var.subnets
  vpc_id              = var.vpc_id
  target_group_name   = "my-targets"
  target_group_port   = 80
  target_instance_ids = var.target_instance_ids
  listener_port       = 80
}

##postgres-rds##
module "rds_postgres" {
  source              = "/mnt/c/Users/Clops_Shobin/Terraform/terraform-practice3/modules/rds-postgres"
  identifier          = var.identifier
  allocated_storage   = var.allocated_storage
  instance_class      = var.instance_class
  db_name             = var.db_name
  username            = var.username
  password            = var.password
  security_group_id   = var.security_group_id
  subnet_ids         = var.subnet_ids
  subnet_group_name   = "db-private-subnet-group"
}

##sns##
module "sns" {
  source              = "/mnt/c/Users/Clops_Shobin/Terraform/terraform-practice3/modules/sns"
  notification_email  = "shobin.s@cloudifyops.com"  # Replace with your email address
}

##cloudwatch##
module "cloudwatch_alarm" {
  source = "/mnt/c/Users/Clops_Shobin/Terraform/terraform-practice3/modules/cloudwatch"

  instance_id               = "i-0abcdef1234567890"  # Replace with your EC2 instance ID
  alarm_action_arn          = module.sns.sns_topic_arn
  ok_action_arn             = module.sns.sns_topic_arn
}

##s3-bucket##
module "s3_bucket" {
  source      = "/mnt/c/Users/Clops_Shobin/Terraform/terraform-practice3/modules/s3-bucket"
  bucket_name = "labmdatestingdemo123"  # Replace with a unique bucket name
  tags = {
    Name        = "lambda-trigger-bucket"
    Environment = "production"
  }
}

##lambda##
module "lambda_function" {
  source      = "/mnt/c/Users/Clops_Shobin/Terraform/terraform-practice3/modules/lambda-function"
  bucket_id = var.bucket_id
  bucket_name = module.s3_bucket.bucket_id
  bucket_arn  = module.s3_bucket.bucket_arn
}