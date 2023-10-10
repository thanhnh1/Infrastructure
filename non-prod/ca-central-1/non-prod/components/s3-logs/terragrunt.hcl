include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../../modules/s3-bucket"
}

## To see what inputs are loaded automatically, check your root terragrunt.hcl 
inputs = {
  region      = "ca-central-1"
  bucket_name = "np-s3-logs"
  tags = {
    "Environment" = "NON_PROD"
    "Description" = "S3 bucket logs"
  }
}
