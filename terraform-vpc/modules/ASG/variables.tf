variable "name" {}
variable "ami_id" {}
variable "instance_type" {}
variable "security_group_ids" {
  type = list(string)
  description = "List of security group IDs for ASG instances"
}
variable "subnet_ids" {
  type = list(string)
  description = "List of subnet IDs where ASG instances will launch"
}
variable "target_group_arns" {
  type        = list(string)
  description = "List of target group ARNs for ALB attachment"
  default     = []
}
variable "desired_capacity" {
  type    = number
  default = 2
}
variable "min_size" {
  type    = number
  default = 1
}
variable "max_size" {
  type    = number
  default = 3
}
variable "user_data" {
  type    = string
  default = ""
}