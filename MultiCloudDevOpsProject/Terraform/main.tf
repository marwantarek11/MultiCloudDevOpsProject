provider "aws" {
  region  = var.region
  profile = "default"
}
module "VPC" {
  source             = "./modules/VPC"
  vpc_cidr           = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  public_subnet_az   = var.public_subnet_az
  vpc_name           = var.vpc_name
}

module "EC2" {
  source        = "./modules/EC2"
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = module.VPC.subnet_id
  vpc_id        = module.VPC.vpc_id
  sg            = var.sg
  key_name      = var.key_name
  volume_size   = var.volume_size
}

module "Cloudwatch" {
  source = "./modules/Cloudwatch"

  log_group_name                = var.log_group_name
  log_group_retention_in_days   = var.log_group_retention_in_days
  log_stream_name               = var.log_stream_name
  alarm_name                    = var.alarm_name
  alarm_comparison_operator     = var.alarm_comparison_operator
  alarm_evaluation_periods      = var.alarm_evaluation_periods
  alarm_metric_name             = var.alarm_metric_name
  alarm_namespace               = var.alarm_namespace
  alarm_period                  = var.alarm_period
  alarm_statistic               = var.alarm_statistic
  alarm_threshold               = var.alarm_threshold
  instance_id                   = module.EC2.ec2_id
  sns_topic_name                = var.sns_topic_name
  sns_email                     = var.sns_email
}

resource "local_file" "EC2-KEY" {
  content    = tls_private_key.EC2-KEY.private_key_pem
  filename   = "../Ansible/EC2-KEY.pem"
  depends_on = [module.EC2]
}

resource "null_resource" "set_permissions" {
  provisioner "local-exec" {
    command = "chmod 400 ../Ansible/EC2-KEY.pem"
  }

  depends_on = [local_file.EC2-KEY]
}