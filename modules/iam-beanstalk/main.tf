data "aws_caller_identity" "this" {}

data "aws_region" "this" {}

data "aws_iam_policy" "beanstalk_web_tier_policy" {
  name = var.beanstalk_web_tier_policy
}

data "aws_iam_policy" "beanstalk_read_only_policy" {
  name = var.beanstalk_read_only_policy
}

data "aws_iam_policy_document" "beanstalk_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "beanstalk_policy_document" {
  statement {
    sid    = "GetParameterStore"
    effect = "Allow"
    actions = [
      "ssm:GetParameter*"
    ]
    resources = [
      "arn:aws:ssm:ca-central-1:${data.aws_caller_identity.this.account_id}:parameter/*"
    ]
  }

  statement {
    sid    = "DecryptKey"
    effect = "Allow"
    actions = [
      "kms:Decrypt"
    ]
    resources = [
      "arn:aws:kms:ca-central-1:${data.aws_caller_identity.this.account_id}:*"
    ]
  }
}

module "beanstalk_role" {
  source = "../iam-module"

  iam_role_name        = var.beanstalk_role_name
  iam_role_assume      = data.aws_iam_policy_document.beanstalk_assume_role_policy.json
  iam_role_policy_name = var.beanstalk_policy_name
  iam_role_policy      = data.aws_iam_policy_document.beanstalk_policy_document.json
}

resource "aws_iam_role_policy_attachment" "beanstalk_web_tier_attachment" {
  role       = module.beanstalk_role.iam_role_name
  policy_arn = data.aws_iam_policy.beanstalk_web_tier_policy.arn
}

resource "aws_iam_role_policy_attachment" "beanstalk_read_only_attachment" {
  role       = module.beanstalk_role.iam_role_name
  policy_arn = data.aws_iam_policy.beanstalk_read_only_policy.arn
}

resource "aws_iam_instance_profile" "beanstalk_profile" {
  name = var.beanstalk_role_name
  role = module.beanstalk_role.iam_role_name
}
