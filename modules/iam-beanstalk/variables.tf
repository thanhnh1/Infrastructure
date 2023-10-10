variable "beanstalk_role_name" {
  type        = string
  description = "IAM role name"
}

variable "beanstalk_policy_name" {
  type        = string
  description = "IAM policy name"
}

variable "beanstalk_web_tier_policy" {
  type        = string
  default     = "AWSElasticBeanstalkWebTier"
  description = "Beanstalk web tier policy name"
}

variable "beanstalk_read_only_policy" {
  type        = string
  default     = "AWSElasticBeanstalkReadOnly"
  description = "Beanstalk read only policy name"
}
