Technology stack



AWS Code Commit
AWS CodePipline
AWS CodeBuild
HashiCorp Terraform
Boto3 Python Library
Infrastructure as Code via terraform
CodeCommit repo
AWS ECR (Elastic Container registry)
ECS Cluster Fargate
ECS task definition
ECS Service
Application Load balancer to service requests.

Cloudwatch event rule - Rule with a pattern that must be satisfied and it will trigger the target,
Cloudwatch Event target - triggers pipeline when rule is match.
CodePipeline to run various stages of build;
		- package jar file
		- run test
		- create docker image and tag
		- push image to ecr ECR
		- run a python script as last step to update the service with latest image

		Endpoint will be http://ALBUSML-1410632175.eu-west-1.elb.amazonaws.com:8081/services/UMSL/