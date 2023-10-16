resource "aws_iam_role" "iam_role" {
  name               = var.iam_role_name
  assume_role_policy = var.iam_role_assume
}

resource "aws_iam_role_policy" "iam_role_policy" {
  name   = var.iam_role_policy_name
  role   = aws_iam_role.iam_role.name
  policy = var.iam_role_policy
}
