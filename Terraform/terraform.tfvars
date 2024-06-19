vpc_name           = "IVOLVE-VPC"
vpc_cidr           = "10.0.0.0/16"
region             = "us-east-1"
ami                = "ami-04b70fa74e45c3917"
public_subnet_cidr = "10.0.2.0/24"
public_subnet_az   = "us-east-1a"
instance_type      = "t2.large"
key_name           = "EC2-KEY"
bucket-name        = "marawantarek17-s3-bucket-terraform"
volume_size        = 20
sg = {
  ingress_count = [{ count = 3 }]
  ingress_rule = [{
    port     = 9000
    protocol = "tcp"
    cidr     = "0.0.0.0/0"
    },
    { port     = 8080
      protocol = "tcp"
      cidr     = "0.0.0.0/0"
    },
    { port     = 22
      protocol = "tcp"
      cidr     = "0.0.0.0/0"
  }]
}

log_group_name                = "IVOLVE-log-group"
log_group_retention_in_days   = 14
log_stream_name               = "IVOLVE-log-stream"
alarm_name                    = "IVOLVE-ALARM"
alarm_comparison_operator     = "GreaterThanOrEqualToThreshold"
alarm_evaluation_periods      = 1
alarm_metric_name             = "CPUUtilization"
alarm_namespace               = "AWS/EC2"
alarm_period                  = 300
alarm_statistic               = "Average"
alarm_threshold               = 50
sns_topic_name                = "IVOLVE-sns-topic"
sns_email                     = "marawantarek17@gmail.com"
