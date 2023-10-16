terraform {
  source = "../../../../../modules/beanstalk"
}

include {
  path = find_in_parent_folders()
}

dependency "alb_certificate" {
  config_path = "../alb-certificate"

  mock_outputs_allowed_terraform_commands = ["plan"]
  mock_outputs = {
    arn = ""
  }
}

dependency "beanstalk_ec2_role" {
  config_path = "../../components/iam-beanstalk"

  mock_outputs_allowed_terraform_commands = ["plan"]
  mock_outputs = {
    iam_role_name = "aws-elasticbeanstalk-ec2-role"
  }
}

dependency "s3_logs" {
  config_path = "../../components/s3-logs"

  mock_outputs_allowed_terraform_commands = ["plan"]
  mock_outputs = {
    bucket_id = ""
  }
}

inputs = {
  # Elastic Beanstalk Configuration
  bealstalk_application_name                 = "np-beanstalk-app"
  bealstalk_application_description          = "Beanstalk application"
  beanstalk_environtment_name                = "np-beanstalk-env"
  beanstalk_environtment_cname               = "webapp-non-prod"
  beanstalk_environtment_tier                = "WebServer"
  beanstalk_environtment_solution_stack_name = "64bit Windows Server 2019 v2.11.5 running IIS 10.0"
  beanstalk_environtment_tags = {
    "Environment" = "NON_PROD"
    "Description" = "Elastic Beanstalk Application"
  }

  # Elastic Beanstalk Settings
  ## Email Settings
  beanstalk_notification_email = "Thanh.HaiNguyen@email.com"

  ## Launch Configurations
  beanstalk_instance_role_name    = dependency.beanstalk_ec2_role.outputs.iam_role_name
  beanstalk_instance_type         = "t2.micro"
  beanstalk_instance_volume_size  = 100
  beanstalk_instance_volume_type  = "gp2"
  beanstalk_instance_keypair_name = "np-beanstalk-keypair"

  ## Environment - Service Role
  beanstalk_service_role_name = "aws-elasticbeanstalk-service-role"

  ## Auto Scaling Group Settings
  beanstalk_auto_scaling_min                  = 1
  beanstalk_auto_scaling_max                  = 2
  beanstalk_auto_scaling_metric               = "CPUUtilization"
  beanstalk_auto_scaling_unit                 = "Percent"
  beanstalk_auto_scaling_statistic            = "Average"
  beanstalk_auto_scaling_breach_duration      = 5
  beanstalk_auto_scaling_upper_threshold      = 80
  beanstalk_auto_scaling_scale_up_increment   = 1
  beanstalk_auto_scaling_lower_threshold      = 30
  beanstalk_auto_scaling_scale_down_increment = -1

  ## Load Balancer Settings
  beanstalk_load_balancer_type            = "application"
  beanstalk_load_balancer_s3_log_enable   = "true"
  beanstalk_load_balancer_s3_bucket       = dependency.s3_logs.outputs.bucket_id
  beanstalk_load_balancer_log_prefix      = "alblogs"
  beanstalk_load_balancer_certificate_arn = dependency.alb_certificate.outputs.arn

  # SG
  ec2_sg_id = ""
  alb_sg_id = ""
}
