output "redis_instance_ids" {
  value = aws_instance.redis_servers[*].id
}
