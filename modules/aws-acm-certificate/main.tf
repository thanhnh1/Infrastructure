resource "aws_acm_certificate" "certificate" {
  domain_name               = var.acm_domain_name
  subject_alternative_names = var.acm_subject_alternative_names
  validation_method         = var.acm_validation_method

  options {
    certificate_transparency_logging_preference = var.acm_logging_preference
  }

  # required for seamless update w/ resources using the cert (ex: aws-alb)
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "certificate_record" {
  count   = length(aws_acm_certificate.certificate.domain_validation_options)
  zone_id = var.route53_zone_id
  name    = tolist(aws_acm_certificate.certificate.domain_validation_options)[count.index].resource_record_name
  records = [tolist(aws_acm_certificate.certificate.domain_validation_options)[count.index].resource_record_value]
  type    = "CNAME"
  ttl     = 300
}
