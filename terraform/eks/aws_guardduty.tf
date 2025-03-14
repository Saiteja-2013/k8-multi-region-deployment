resource "aws_guardduty_detector" "guardduty" {
  enable = true
}

resource "aws_guardduty_membership" "member" {
  account_id = "aws-account-id"  # Add account id for other regions
  detector_id = aws_guardduty_detector.guardduty.id
  email = "team@example.com"
}
