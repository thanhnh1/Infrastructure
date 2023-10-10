variable "region" {
  default     = "ca-central-1"
  description = "The region of AWS, for AMI lookups."
}

variable "bucket_name" {}

variable "tags" {
  type        = map(any)
  description = "map for tags variables"
}

variable "bucket_event_bridge" {
  type        = bool
  default     = false
  description = "Event bridge enable or disable"
}
