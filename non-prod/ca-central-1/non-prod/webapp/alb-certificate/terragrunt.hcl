include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../../modules/aws-acm-certificate"
}

## To see what inputs are loaded automatically, check your root terragrunt.hcl 
inputs = {
  acm_domain_name       = "domain.com"
  acm_validation_method = "DNS"
  route53_zone_id       = "ZZZZZZZZZZZZZZ"
}
