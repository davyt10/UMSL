resource "aws_cloudwatch_event_rule" "change" {
  name        = "USMLBranchChanges"
  description = "usmlBranchChanges"

  event_pattern = <<PATTERN
{
  "source": [
    "aws.codecommit"
  ],
  "detail-type": [
    "CodeCommit Repository State Change"
  ],
  "resources": [
    "arn:aws:codecommit:eu-west-1:674520542290:USML"
  ],
  "detail": {
    "event": [
      "referenceCreated",
      "referenceUpdated"
    ],
    "referenceType": [
      "branch"
    ],
    "referenceName": [
      "master"
    ]
  }
}
PATTERN
}

resource "aws_cloudwatch_event_target" "trigger_codepipeline" {
  rule = "${aws_cloudwatch_event_rule.change.name}"
  arn = "arn:aws:codepipeline:eu-west-1:674520542290:USML"
  role_arn = "arn:aws:iam::674520542290:role/AWS-CodePipeline-Service"
}