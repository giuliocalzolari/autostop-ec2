resource "aws_cloudwatch_event_rule" "auto_shutdown" {
  name        = "${var.app_name}"
  description = "${var.app_name}"

  schedule_expression = "${var.cron}"
}

resource "aws_cloudwatch_event_target" "auto_shutdown_lambda" {
  target_id = "${aws_lambda_function.stop_ec2_instances.handler}"
  rule      = "${aws_cloudwatch_event_rule.auto_shutdown.name}"
  arn       = "${aws_lambda_function.stop_ec2_instances.arn}"
}

resource "aws_cloudwatch_log_group" "cwlog" {
  name              = "/aws/lambda/${var.app_name}"
  retention_in_days = 14
}
