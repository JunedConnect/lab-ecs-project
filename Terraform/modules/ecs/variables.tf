variable "security_group_id" {
  description = "Security Group ID for ECS"
  type        = string
}

variable "target_group_id" {
  description = "Target Group ID for ECS"
  type        = string
}

variable "subnets" {
  description = "List of subnet IDs where the ECS service will run"
  type        = list(string)
}