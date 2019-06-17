variable "region" {
  default     = "eu-central-1"
  description = "AWS Region"
}

variable "cron" {
  default = "cron(30 8,12,19 * * ? *)"
}

variable "app_name" {
  default = "stop_ec2_instances"
}
