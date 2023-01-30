resource "aws_alb" "AppLB" {
  name = "ApplicationLB"
  subnets = aws_subnet.publicsubnet.*.id
  security_groups = [aws_security_group.AppLBSG.id]

  tags = {
    "Name" = "AppLB"
  }
}

resource "aws_alb_target_group" "AppLBTG" {
  name = "ApplicationLBTG"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.main.id
  target_type = "ip"

 health_check {
    healthy_threshold   = "5"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "5"
    path                = "/"
    unhealthy_threshold = "2"
  }
}

 resource "aws_alb_listener" "AppLBListener" {
  load_balancer_arn = aws_alb.AppLB.id
  port              = 5000
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.AppLBTG.id
    type             = "forward"
  }
}
   
 