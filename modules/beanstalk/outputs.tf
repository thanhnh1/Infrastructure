output "beanstalk_arn" {
  value = aws_elastic_beanstalk_environment.beanstalk_environment.arn
}

output "beanstalk_cname" {
  value = aws_elastic_beanstalk_environment.beanstalk_environment.cname
}

output "beanstalk_load_balancer_arn" {
  value = aws_elastic_beanstalk_environment.beanstalk_environment.load_balancers[0]
}
