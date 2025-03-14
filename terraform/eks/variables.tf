variable "aws_region" {
  description = "AWS region for deploying resources"
  default     = "us-west-2"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  default     = "secure-eks-cluster"
}

variable "subnet_ids" {
  description = "List of subnet IDs for EKS nodes"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID where the EKS cluster will be deployed"
  type        = string
}

variable "node_instance_type" {
  description = "EC2 instance type for worker nodes"
  default     = "t3.medium"
}

variable "desired_capacity" {
  description = "Desired number of worker nodes"
  default     = 2
}

variable "max_capacity" {
  description = "Maximum number of worker nodes"
  default     = 3
}

variable "min_capacity" {
  description = "Minimum number of worker nodes"
  default     = 1
}

variable "github_owner" {
  description = "GitHub repository owner"
  type        = string
}

variable "github_repo" {
  description = "GitHub repository name"
  type        = string
}

variable "github_branch" {
  description = "GitHub branch to monitor for changes"
  default     = "main"
}

variable "github_oauth_token" {
  description = "GitHub OAuth token for authentication"
  type        = string
  sensitive   = true
}

variable "codebuild_project_name" {
  description = "AWS CodeBuild project name"
  default     = "web-app-build"
}

variable "codepipeline_name" {
  description = "AWS CodePipeline name"
  default     = "web-app-codepipeline"
}

variable "codedeploy_app_name" {
  description = "AWS CodeDeploy application name"
  default     = "web-app-deploy"
}

variable "codedeploy_group_name" {
  description = "AWS CodeDeploy deployment group name"
  default     = "web-app-deployment-group"
}

variable "monitoring_enabled" {
  description = "Enable AWS GuardDuty and CloudWatch monitoring"
  default     = true
}

variable "guardduty_detector_id" {
  description = "AWS GuardDuty detector ID"
  type        = string
}
