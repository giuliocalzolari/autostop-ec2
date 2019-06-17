resource "aws_lambda_function" "stop_ec2_instances" {
  filename         = ".lambda_main_payload.zip"
  function_name    = "${var.app_name}"
  description      = "Shuts down unused EC2 instances."
  role             = "${aws_iam_role.lambda_start_stop_ec2.arn}"
  handler          = "main.lambda_handler"
  source_code_hash = "${base64sha256(file(".lambda_main_payload.zip"))}"
  runtime          = "python3.6"
  timeout          = 180
}

resource "aws_lambda_permission" "allow_execution_from_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.stop_ec2_instances.function_name}"
  principal     = "events.amazonaws.com"
  source_arn    = "${aws_cloudwatch_event_rule.auto_shutdown.arn}"
}
