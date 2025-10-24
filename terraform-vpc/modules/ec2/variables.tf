variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Instance type for EC2"
  type        = string
  default     = "t3.micro"
}

variable "subnet_id" {
  description = "Subnet ID where instance will be created"
  type        = string
}

variable "key_name" {
  description = "Key pair name for SSH access"
  type        = string
}

variable "instance_name" {
  description = "Tag name for the EC2 instance"
  type        = string
}

variable "associate_public_ip" {
  description = "Whether to assign a public IP"
  type        = bool
  default     = true
}