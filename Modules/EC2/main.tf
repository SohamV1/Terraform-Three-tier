resource "aws_instance" "my-instance" {
  ami = var.ami
  subnet_id = var.subnet_id
  instance_type = var.instance_type
  key_name = var.key_name
  vpc_security_group_ids = var.vpc_security_group_ids
  # user_data = var.user_data
  tags = {
    Name = var.instance_name
    Environment = var.Environment
  }
}

