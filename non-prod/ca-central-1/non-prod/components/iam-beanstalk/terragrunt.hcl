terraform {
  source = "../../../../../modules/iam-beanstalk"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  beanstalk_role_name   = "aws-elasticbeanstalk-ec2-role"
  beanstalk_policy_name = "aws-elasticbeanstalk-ec2-policy"
}
