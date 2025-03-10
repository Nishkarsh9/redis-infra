output "vpc_id" {
  value = module.vpc.vpc_id
}

output "bastion_host_public_ip" {
  value = module.bastion_host.bastion_host_public_ip
}

output "alb_dns_name" {
  value = module.alb.alb_dns_name
}
