resource "aws_codebuild_project" "usml" {
  name          = "usml-project"
  description   = "usml_project"
  build_timeout = "60"
  service_role  = "arn:aws:iam::674520542290:role/AWS-CodePipeline-Service"

  artifacts {
    type = "NO_ARTIFACTS"
  }

  cache {
    type     = "NO_CACHE"

  }

  environment {
    compute_type = "BUILD_GENERAL1_MEDIUM"
    image = "aws/codebuild/standard:2.0"
    type = "LINUX_CONTAINER"
    #image_pull_credentials_type = "CODEBUILD"
    privileged_mode = "true"


  }

  source {
    type     = "CODECOMMIT"
    location = "https://git-codecommit.eu-west-1.amazonaws.com/v1/repos/USML"
    insecure_ssl = "false"
    buildspec = "buildspec.yaml"

  }


  tags = {
    "Environment" = "usml-project"
  }
}

resource "aws_codebuild_project" "deploy" {
  name          = "deploy-project"
  description   = "deploy_project"
  build_timeout = "60"
  service_role  = "arn:aws:iam::674520542290:role/AWS-CodePipeline-Service"

  artifacts {
    type = "NO_ARTIFACTS"
  }

  cache {
    type     = "NO_CACHE"

  }

  environment {
    compute_type = "BUILD_GENERAL1_MEDIUM"
    image = "aws/codebuild/standard:2.0"
    type = "LINUX_CONTAINER"
    #image_pull_credentials_type = "CODEBUILD"
    privileged_mode = "true"


  }

  source {
    type     = "CODECOMMIT"
    location = "https://git-codecommit.eu-west-1.amazonaws.com/v1/repos/USML"
    insecure_ssl = "false"
    buildspec = "Pipeline/Deploy/buildspec.yaml"

  }


  tags = {
    "Environment" = "deploy-project"
  }
}

