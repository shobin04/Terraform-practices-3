resource "aws_db_instance" "this" {
  identifier          = var.identifier
  allocated_storage   = var.allocated_storage
  engine              = "postgres"
  instance_class      = var.instance_class
  db_name                = var.db_name
  username            = var.username
  password            = var.password
  vpc_security_group_ids = [var.security_group_id]
  db_subnet_group_name   = aws_db_subnet_group.this.name
  skip_final_snapshot    = var.skip_final_snapshot

}

resource "aws_db_subnet_group" "this" {
  name       = var.subnet_group_name
  subnet_ids = var.subnet_ids
}
