resource "aws_cloudwatch_log_group" "web_app_logs" {
  name = "/aws/eks/web-app-logs"
}

resource "aws_cloudwatch_log_stream" "web_app_log_stream" {
  log_group_name = aws_cloudwatch_log_group.web_app_logs.name
  name           = "web-app-log-stream"
}
