resource "aws_cloudwatch_log_group" "my_aws_cloudwatch_log_group" {
  name = var.goals_logs
  retention_in_days = var.retention_in_days
}

resource "aws_cloudwatch_log_stream" "my_aws_cloudwatch_log_stram" {
  name           = "goalsstream"
  log_group_name = aws_cloudwatch_log_group.my_aws_cloudwatch_log_group.name
}