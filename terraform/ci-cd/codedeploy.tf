resource "aws_codedeploy_app" "web_app_deploy" {
  name = "web-app-deploy"
}

resource "aws_codedeploy_deployment_group" "web_app_deploy_group" {
  app_name               = aws_codedeploy_app.web_app_deploy.name
  deployment_group_name  = "web-app-deployment-group"
  service_role_arn       = aws_iam_role.codedeploy_role.arn

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }
}
