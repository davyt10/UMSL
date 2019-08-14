#Create and ALB to front the service
resource "aws_alb" "alb_usml" {
  name            = "ALBUSML"
  subnets         = ["subnet-8b3f36ee","subnet-f23e77ab"]
  security_groups = [ "sg-0b26558a65fa955b7"]

  tags {
    Name        = "ALB-USML"

  }
}

#Create a target group ALB will route requests to.

resource "aws_alb_target_group" "AlbTargetGroup8081" {
  name     = "USMLAlbTargetGroup8081"
  port     = 8081
  protocol = "HTTP"
  vpc_id   = "vpc-75133410"
  target_type = "ip"

  #Create Health check

  health_check {
    path = "/services/UMSL/"
    interval = 30
    port = "traffic-port"
    timeout = 5
    healthy_threshold = 5
    unhealthy_threshold = 2


  }

  lifecycle {
    create_before_destroy = true
  }
}

#Create a listener on port 80 to give a standard repsonse

resource "aws_alb_listener" "USMLFixedResponseListener" {
  load_balancer_arn = "${aws_alb.alb_usml.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Fixed response content"
      status_code  = "200"
    }
  }
}


#Create a listener on port 8081


resource "aws_alb_listener" "USML8081Listener" {
  load_balancer_arn = "${aws_alb.alb_usml.arn}"
  port              = "8081"
  protocol          = "HTTP"
  depends_on        = ["aws_alb_target_group.AlbTargetGroup8081"]

  default_action {
    target_group_arn = "${aws_alb_target_group.AlbTargetGroup8081.arn}"
    type             = "forward"
  }
}