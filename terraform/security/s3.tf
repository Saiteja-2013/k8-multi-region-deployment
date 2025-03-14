resource "aws_s3_bucket" "pipeline_artifacts" {
  bucket = "web-app-pipeline-artifacts-${var.aws_region}"
}
