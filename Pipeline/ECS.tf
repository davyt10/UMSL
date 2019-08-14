resource "aws_ecs_cluster" "usml_cluster" {
  name = "usml_cluster"
}


resource "aws_ecs_task_definition" "taskdef"  {
  family                = "usmltaskdef"
  container_definitions = "${file("task-definitions/task_definition.json")}"
  execution_role_arn = "arn:aws:iam::674520542290:role/ecsTaskExecutionRole"
  requires_compatibilities = ["FARGATE"]
  network_mode = "awsvpc"
  # required when FARGATE is set
  cpu = "512"
  memory = "4096"

}

# create a ECS service that will manage the tasks regsistering and deregistering from ALB.
resource "aws_ecs_service" "usml_service" {
  name            = "usmlservice"
  task_definition = "${aws_ecs_task_definition.taskdef.family}"
  desired_count   = 1
  launch_type     = "FARGATE"
  cluster =       "${aws_ecs_cluster.usml_cluster.name}"

  network_configuration {
    assign_public_ip = "True"
    security_groups = ["sg-0b26558a65fa955b7"]
    subnets         = ["subnet-8b3f36ee","subnet-f23e77ab"]

  }


  load_balancer {
    target_group_arn = "${aws_alb_target_group.AlbTargetGroup8081.arn}"
    container_name   = "usml-app-container"
    container_port   = "8081"
  }


}