variable "security_group_id" {
  description = "Security Group ID for ALB"
  type        = string
}

variable "target_group_id" {
  description = "Target Group ID for ALB"
  type        = string
}

variable "certificate_arn" {
  description = "ARN of the ACM certificate for ALB"
  type        = string
}

variable "subnets" {
  description = "List of subnet IDs where the ALB will be deployed"
  type        = list(string)
}