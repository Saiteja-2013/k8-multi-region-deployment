resource "aws_sns_topic" "guardduty_alerts" {
  name = "guardduty-alerts"
}

resource "aws_guardduty_membership" "member" {
  detector_id = aws_guardduty_detector.guardduty.id
  account_id  = "aws-account-id"  # Replace with your account ID
  email       = "team@example.com"
}

resource "aws_guardduty_subscription" "alerts_subscription" {
  detector_id  = aws_guardduty_detector.guardduty.id
  sns_topic_arn = aws_sns_topic.guardduty_alerts.arn
}
