resource "aws_cloudwatch_log_group" "my_aws_cloudwatch_log_group" {
  name = var.goals_log_name
  retention_in_days = var.retention_in_days
}

resource "aws_cloudwatch_log_stream" "my_aws_cloudwatch_log_stram" {
  name           = var.goals_log_stream_name
  log_group_name = aws_cloudwatch_log_group.my_aws_cloudwatch_log_group.name
}