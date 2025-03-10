variable "private_subnet_ids" {
  description = "List of private subnet IDs where Redis servers will be created"
  type        = list(string)
}

variable "redis_sg_id" {
  description = "Security group ID for Redis servers"
  type        = string
}

variable "redis_ami" {
  description = "AMI ID for Redis servers"
  type        = string
  default     = "ami-00bb6a80f01f03502" #(Mumbai)
}

variable "redis_instance_type" {
  description = "Instance type for Redis servers"
  type        = string
  default     = "t2.micro"
}
variable "key_name" {
  description = "Name of the SSH key pair to use for Redis servers"
  type        = string
}
