variable "name" {}
variable "vpc_id" {}
variable "subnet_ids" {
  type = list(string)
  description = "List of subnet IDs for the ALB"
}
variable "security_group_ids" {
  type = list(string)
  description = "List of security group IDs for the ALB"
}
variable "target_port" {
  type    = number
  default = 80
}
variable "health_check_path" {
  type    = string
  default = "/"
}