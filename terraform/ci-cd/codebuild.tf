resource "aws_codebuild_project" "web_app_build" {
  name          = "web-app-build"
  service_role  = aws_iam_role.codebuild_role.arn
  build_timeout = "10"

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image          = "aws/codebuild/standard:5.0"
    type           = "LINUX_CONTAINER"
    privileged_mode = true
  }

  source {
    type = "CODEPIPELINE"
    buildspec = file("ci-cd/buildspec.yml")
  }
}
