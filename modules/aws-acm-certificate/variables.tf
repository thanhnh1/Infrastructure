variable "acm_domain_name" {
  type        = string
  description = "domain_name - (Required) A domain name for which the certificate should be issued"
}

variable "acm_subject_alternative_names" {
  type        = list(string)
  description = "subject_alternative_names - (Optional) Set of domains that should be SANs in the issued certificate. To remove all elements of a previously configured list, set this value equal to an empty list ([]) or use the terraform taint command to trigger recreation."
  default     = []
}

variable "acm_validation_method" {
  type        = string
  description = "validation_method - (Required) Which method to use for validation. DNS or EMAIL are valid, NONE can be used for certificates that were imported into ACM and then into Terraform."
  default     = "DNS"
}

variable "acm_logging_preference" {
  type        = string
  description = "certificate_transparency_logging_preference - (Optional) Specifies whether certificate details should be added to a certificate transparency log. Valid values are ENABLED or DISABLED"
  default     = "ENABLED"
}

variable "route53_zone_id" {
  type        = string
  description = "Route53 zone ID"
}
