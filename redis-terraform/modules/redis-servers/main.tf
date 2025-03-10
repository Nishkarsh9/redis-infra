resource "aws_instance" "redis_servers" {
  count                    = length(var.private_subnet_ids)
  ami                      = var.redis_ami
  instance_type            = var.redis_instance_type
  subnet_id                = var.private_subnet_ids[count.index]
  vpc_security_group_ids   = [var.redis_sg_id]
  key_name                 = var.key_name
  tags = {
    Name = "redis-server-${count.index}"
    Role = "infra-server"
  }
}
