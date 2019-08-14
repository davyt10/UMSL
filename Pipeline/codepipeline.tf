#Create Code pipeline
resource "aws_codepipeline" "codepipeline" {
  name    = "USML"
  role_arn = "arn:aws:iam::674520542290:role/AWS-CodePipeline-Service"


  artifact_store {
    location = "outputbuckettonge"
    type     = "S3"

  }
 stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["source_output"]


      configuration = {
        RepositoryName   = "USML"
        BranchName = "master"
        PollForSourceChanges = "false",

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
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = "usml-project"
      }
    }
  }

   stage {
    name = "DeployToProd"

    action {
      name             = "Deploy"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      #output_artifacts = ["source_output"]
      input_artifacts  = ["source_output"]


      configuration = {
        ProjectName = "deploy-project"
      }
    }
  }

  }