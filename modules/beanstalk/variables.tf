# Elastic Beanstalk
variable "bealstalk_application_name" {
  type        = string
  description = "Application name"
}

variable "bealstalk_application_description" {
  type        = string
  description = "Application description"
}

variable "beanstalk_environtment_name" {
  type        = string
  description = "Environment name"
}

variable "beanstalk_environtment_cname" {
  type        = string
  description = "Environment CNAME Prefix"
}

variable "beanstalk_environtment_tier" {
  type = string
}
variable "beanstalk_environtment_solution_stack_name" {
  type        = string
  description = "Solution name for this EB stack"
}

variable "beanstalk_environtment_tags" {
  type        = map(any)
  description = "map for tags variables"
}

##Email Setting
variable "beanstalk_notification_email" {
  type        = string
  description = "Notification email for SNS alerts"
}

## Launch Configurations
variable "beanstalk_instance_role_name" {
  type = string
}

variable "beanstalk_instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "beanstalk_instance_volume_size" {
  type        = number
  description = "EC2 instance volume size"
}

variable "beanstalk_instance_volume_type" {
  type        = string
  description = "EC2 instance volume type"
}

variable "beanstalk_instance_keypair_name" {
  type        = string
  description = "Keypair name in EC2 to associate the instances with"
}

## Environment - Service Role
variable "beanstalk_service_role_name" {
  type = string
}

## Auto Scaling Group Settings 
variable "beanstalk_auto_scaling_min" {
  type        = number
  description = "Minimum instances to be running for this EB app (integer)"
}

variable "beanstalk_auto_scaling_max" {
  type        = number
  description = "Maximum instances to be running for this EB app (integer)"
}

variable "beanstalk_auto_scaling_metric" {
  type        = string
  description = "Metric used for your Auto Scaling trigger."
  default     = "CPUUtilization"
}

variable "beanstalk_auto_scaling_unit" {
  type        = string
  description = "Unit for the trigger measurement, such as Percent"
}

variable "beanstalk_auto_scaling_statistic" {
  type        = string
  description = "Statistic the trigger should use, such as Average."
}

variable "beanstalk_auto_scaling_breach_duration" {
  type        = number
  description = "Amount of time, in minutes, a metric can be beyond its defined limit (as specified in the UpperThreshold and LowerThreshold) before the trigger fires."
}

variable "beanstalk_auto_scaling_upper_threshold" {
  type        = number
  description = "If the measurement is higher than this number for the breach duration, a trigger is fired."
}

variable "beanstalk_auto_scaling_scale_up_increment" {
  type        = number
  description = "How many Amazon EC2 instances to add when performing a scaling activity."
}

variable "beanstalk_auto_scaling_lower_threshold" {
  type        = number
  description = "If the measurement falls below this number for the breach duration, a trigger is fired."
}

variable "beanstalk_auto_scaling_scale_down_increment" {
  type        = number
  description = "How many Amazon EC2 instances to remove when performing a scaling activity."
}

## Load Balancer Settings
variable "beanstalk_load_balancer_type" {
  type        = string
  description = "Load balancer type (classic, application, network)"
}

variable "beanstalk_load_balancer_s3_log_enable" {
  type        = string
  description = "Enable S3 log for load balancer"
}

variable "beanstalk_load_balancer_s3_bucket" {
  type        = string
  description = "S3 bucket name for ELB logging"
}

variable "beanstalk_load_balancer_log_prefix" {
  type        = string
  description = "Prefix for ELB log"
}

variable "beanstalk_load_balancer_certificate_arn" {
  type        = string
  description = "ARN from Certificate Manager to attach to load balancer"
}

variable "ec2_sg_id" {
  type        = string
  description = "describe your variable"
}

variable "alb_sg_id" {
  type        = string
  description = "describe your variable"
}
