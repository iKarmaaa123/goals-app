resource "aws_cloudwatch_log_group" "my_aws_cloudwatch_log_group" {
  name = "goalslogs"
  retention_in_days = 30
}

resource "aws_cloudwatch_log_stream" "my_aws_cloudwatch_log_stram" {
  name           = "goalsstream"
  log_group_name = aws_cloudwatch_log_group.my_aws_cloudwatch_log_group.name
}