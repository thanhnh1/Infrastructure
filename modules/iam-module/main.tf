data "aws_caller_identity" "this" {}

data "aws_region" "this" {}

resource "alks_iamrole" "iam_role" {
  name                     = var.iam_role_name
  type                     = var.iam_role_type
  include_default_policies = false
}

resource "aws_iam_policy" "iam_policy" {
  depends_on = [
    alks_iamrole.iam_role
  ]

  name   = var.iam_policy_name
  path   = "/acct-managed/"
  policy = var.iam_policy
}

resource "aws_iam_policy_attachment" "iam_policy_attachment" {
  depends_on = [
    alks_iamrole.iam_role,
    aws_iam_policy.iam_policy
  ]
  name       = "attachment"
  roles      = [alks_iamrole.iam_role.name]
  policy_arn = aws_iam_policy.iam_policy.arn
}
