provider "aws" {
  region = var.aws_region
}

resource "aws_eks_cluster" "us_west_2_cluster" {
  name     = "web-app-cluster-us-west-2"
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    subnet_ids = var.subnet_ids
  }
}

resource "aws_eks_cluster" "us_east_1_cluster" {
  name     = "web-app-cluster-us-east-1"
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    subnet_ids = var.subnet_ids
  }
}

resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket = "web-app-deployment-pipeline-bucket"
}

resource "aws_iam_role" "codepipeline_role" {
  name = "CodePipelineServiceRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Principal = {
        Service = "codepipeline.amazonaws.com"
      }
      Effect    = "Allow"
      Sid       = ""
    }]
  })
}

resource "aws_codepipeline" "web_app_pipeline" {
  name     = "web-app-deployment-pipeline"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = aws_s3_bucket.codepipeline_bucket.bucket
    type     = "S3"
  }

  stage {
    name = "Source"
    action {
      name             = "Source"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["SourceOutput"]
      configuration = {
        Owner      = "your-github-username"
        Repo       = "your-repository-name"
        Branch     = "main"
        OAuthToken = "your-github-oauth-token"
      }
    }
  }

  stage {
    name = "Build"
    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["SourceOutput"]
      output_artifacts = ["BuildOutput"]
      configuration = {
        ProjectName = aws_codebuild_project.web_app_build.name
      }
    }
  }

  stage {
    name = "Deploy"
    action {
      name             = "Deploy"
      category         = "Deploy"
      owner            = "AWS"
      provider         = "EKS"
      version          = "1"
      input_artifacts  = ["BuildOutput"]
      configuration = {
        ClusterName       = aws_eks_cluster.us_west_2_cluster.name
        RoleArn           = aws_iam_role.eks_role.arn
        KubernetesManifest = "k8s-manifests/region-1/app-deployment.yaml"
      }
    }
    action {
      name             = "Deploy"
      category         = "Deploy"
      owner            = "AWS"
      provider         = "EKS"
      version          = "1"
      input_artifacts  = ["BuildOutput"]
      configuration = {
        ClusterName       = aws_eks_cluster.us_east_1_cluster.name
        RoleArn           = aws_iam_role.eks_role.arn
        KubernetesManifest = "k8s-manifests/region-2/app-deployment.yaml"
      }
    }
  }
}

resource "aws_codebuild_project" "web_app_build" {
  name           = "web-app-build"
  service_role   = aws_iam_role.codebuild_role.arn
  build_timeout  = 60
  source {
    type     = "S3"
    location = "s3://your-source-bucket"
  }
  artifacts {
    type     = "S3"
    location = "s3://your-artifact-bucket"
  }
  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:4.0"
    type         = "LINUX_CONTAINER"
  }
}
