locals {
  # Automatically load account-level variables
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))

  # Automatically load region-level variables
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Extract the variables we need for easy access
  aws_account_alias           = local.account_vars.locals.aws_account_alias
  aws_account_id              = local.account_vars.locals.aws_account_id
  aws_region                  = local.region_vars.locals.aws_region
  aws_account_data_kms_key_id = local.account_vars.locals.aws_account_data_kms_key_id
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  required_version = ">= 0.14"
}
provider "aws" {
  region              = "${local.aws_region}"
  allowed_account_ids = ["${local.aws_account_id}"]
}
EOF
}


# Configure Terragrunt to automatically store tfstate files in an S3 bucket
remote_state {
  backend      = "s3"
  disable_init = false
  config = {
    encrypt        = true
    bucket         = "tfstates-${local.aws_region}-${local.aws_account_alias}"
    key            = "${local.workload_name}/${path_relative_to_include()}/terraform.tfstate"
    region         = local.aws_region
    kms_key_id     = local.aws_account_data_kms_key_id
    dynamodb_table = "terraform-locks"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}


# ---------------------------------------------------------------------------------------------------------------------
# GLOBAL PARAMETERS
# These variables apply to all configurations in this subfolder. These are automatically merged into the child
# `terragrunt.hcl` config via the include block.
# ---------------------------------------------------------------------------------------------------------------------

# Configure root level variables that all resources can inherit. This is especially helpful with multi-account configs
# where terraform_remote_state data sources are placed directly into the modules.
inputs = merge(
  local.account_vars.locals,
  local.region_vars.locals,
  local.environment_vars.locals,
)
