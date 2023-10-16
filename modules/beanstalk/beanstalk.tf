# Elastic Beanstalk Application definition
resource "aws_elastic_beanstalk_application" "beanstalk_application" {
  name        = var.bealstalk_application_name
  description = var.bealstalk_application_description
}

# Elastic Beanstalk Environment
resource "aws_elastic_beanstalk_environment" "beanstalk_environment" {
  name                   = var.beanstalk_environtment_name
  application            = aws_elastic_beanstalk_application.beanstalk_application.name
  cname_prefix           = var.beanstalk_environtment_cname
  tier                   = var.beanstalk_environtment_tier
  solution_stack_name    = var.beanstalk_environtment_solution_stack_name
  wait_for_ready_timeout = "20m"
  tags                   = var.beanstalk_environtment_tags

  # Email notifications
  setting {
    namespace = "aws:elasticbeanstalk:sns:topics"
    name      = "Notification Protocol"
    value     = "email"
  }
  setting {
    namespace = "aws:elasticbeanstalk:sns:topics"
    name      = "Notification Endpoint"
    value     = var.beanstalk_notification_email
  }

  # VPC & subnets
  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = data.aws_vpc.selected.id
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = join(",", data.aws_subnets.private_subnet.ids)
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBSubnets"
    value     = join(",", data.aws_subnets.public_subnet.ids)
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "AssociatePublicIpAddress"
    value     = "false"
  }

  # Launch Configurations
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = var.beanstalk_instance_role_name
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "EC2KeyName"
    value     = var.beanstalk_instance_keypair_name
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = var.beanstalk_instance_type
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "RootVolumeSize"
    value     = var.beanstalk_instance_volume_size
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "RootVolumeType"
    value     = var.beanstalk_instance_volume_type
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "SecurityGroups"
    value     = var.ec2_sg_id
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "SSHSourceRestriction"
    value     = "tcp, 3389, 3389"
  }

  # Environment - Service Role
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "ServiceRole"
    value     = var.beanstalk_service_role_name
  }

  # Auto Scaling Group
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = var.beanstalk_auto_scaling_min
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = var.beanstalk_auto_scaling_max
  }

  # Autoscaling triggers:
  # - scale up 2 nodes when CPU over 60% for 5 minutes
  # - scale down 1 node when CPU is under 30% for 5 minutes
  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "MeasureName"
    value     = var.beanstalk_auto_scaling_metric
  }
  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "Unit"
    value     = var.beanstalk_auto_scaling_unit
  }
  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "Statistic"
    value     = var.beanstalk_auto_scaling_statistic
  }
  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "UpperBreachScaleIncrement"
    value     = var.beanstalk_auto_scaling_scale_up_increment
  }
  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "LowerBreachScaleIncrement"
    value     = var.beanstalk_auto_scaling_scale_down_increment
  }
  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "UpperThreshold"
    value     = var.beanstalk_auto_scaling_upper_threshold
  }
  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "LowerThreshold"
    value     = var.beanstalk_auto_scaling_lower_threshold
  }
  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "BreachDuration"
    value     = var.beanstalk_auto_scaling_breach_duration
  }

  # Load Balancer
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerType"
    value     = var.beanstalk_load_balancer_type
  }
  setting {
    namespace = "aws:elbv2:loadbalancer"
    name      = "AccessLogsS3Enabled"
    value     = var.beanstalk_load_balancer_s3_log_enable
  }
  setting {
    namespace = "aws:elbv2:loadbalancer"
    name      = "AccessLogsS3Bucket"
    value     = var.beanstalk_load_balancer_s3_bucket
  }
  setting {
    namespace = "aws:elbv2:loadbalancer"
    name      = "AccessLogsS3Prefix"
    value     = var.beanstalk_load_balancer_log_prefix
  }
  setting {
    namespace = "aws:elbv2:loadbalancer"
    name      = "ManagedSecurityGroup"
    value     = var.alb_sg_id
  }
  setting {
    namespace = "aws:elbv2:loadbalancer"
    name      = "SecurityGroups"
    value     = var.alb_sg_id
  }
  setting {
    namespace = "aws:elbv2:listener:443"
    name      = "DefaultProcess"
    value     = "default"
  }
  setting {
    namespace = "aws:elbv2:listener:443"
    name      = "ListenerEnabled"
    value     = "true"
  }
  setting {
    namespace = "aws:elbv2:listener:default"
    name      = "ListenerEnabled"
    value     = "false"
  }
  setting {
    namespace = "aws:elbv2:listener:443"
    name      = "Protocol"
    value     = "HTTPS"
  }
  setting {
    namespace = "aws:elbv2:listener:443"
    name      = "SSLCertificateArns"
    value     = var.beanstalk_load_balancer_certificate_arn
  }
  setting {
    namespace = "aws:elbv2:listener:443"
    name      = "SSLPolicy"
    value     = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
  }

  # Healthcheck 
  setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "Port"
    value     = "80"
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "Protocol"
    value     = "HTTP"
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment:process:https"
    name      = "HealthCheckInterval"
    value     = "300"
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment:process:https"
    name      = "HealthCheckTimeout"
    value     = "10"
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment:process:https"
    name      = "HealthCheckPath"
    value     = "/healthcheck"
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment:process:https"
    name      = "HealthyThresholdCount"
    value     = "2"
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment:process:https"
    name      = "UnhealthyThresholdCount"
    value     = "3"
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment:process:https"
    name      = "MatcherHTTPCode"
    value     = "200"
  }

  # Environment Variables
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "Environment_Name"
    value     = var.bealstalk_application_name
  }
}
