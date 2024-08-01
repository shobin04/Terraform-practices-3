resource "aws_instance" "private_server" {
  ami             = var.private_ami
  instance_type   = var.instance_type
  subnet_id       = var.private_subnet_id
  security_groups = [var.private_sg_id]
  key_name = var.key_name
  tags = {
    Name = var.private_name
  }
}