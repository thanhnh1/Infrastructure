output "id" {
  value       = aws_acm_certificate.certificate.id
  description = "id - The ARN of the certificate"
}

output "arn" {
  value       = aws_acm_certificate.certificate.arn
  description = "arn - The ARN of the certificate"
}

output "domain_name" {
  value       = aws_acm_certificate.certificate.domain_name
  description = "domain_name - The domain name for which the certificate is issued"
}

output "domain_validation_options" {
  value       = aws_acm_certificate.certificate.domain_validation_options
  description = "domain_validation_options - Set of domain validation objects which can be used to complete certificate validation. Can have more than one element, e.g. if SANs are defined. Only set if DNS-validation was used."
}

output "status" {
  value       = aws_acm_certificate.certificate.status
  description = "status - Status of the certificate."
}

output "validation_emails" {
  value       = aws_acm_certificate.certificate.validation_emails
  description = "validation_emails - A list of addresses that received a validation E-Mail. Only set if EMAIL-validation was used."
}
