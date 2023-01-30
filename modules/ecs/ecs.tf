resource "aws_ecs_cluster" "Cluster" {
  name = "Cluster"
}

resource "aws_ecs_task_definition" "ClusterTaskDefinition" {
  family                   = "${var.app_name}-${var.env}-task"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 1024
  memory                   = 2048
  container_definitions = jsonencode([

    {
        "name": "${var.app_name}-${var.env}-container",
        "image": "${local.app_image}",
        "cpu": 1024,
        "memory": 2048,
        "networkMode": "awsvpc",
        "essential": true,
        "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "/ecs/container-logs",
          "awslogs-create-group": "true",
          "awslogs-region": "eu-central-1",
          "awslogs-stream-prefix": "ecs"
        }
    },
    "portMappings": [
      {
        "containerPort": 5000,
        "hostPort": 5000
      }
    ],
     "environment": [
      {
        "name": "VERSION",
        "value": "0.0.1"
      }
     ]
    }
])
}

resource "aws_ecs_service" "main" {
  name            = "${var.app_name}-${var.env}-service"
  cluster         = aws_ecs_cluster.Cluster.arn
  task_definition = aws_ecs_task_definition.ClusterTaskDefinition.arn
  desired_count   = 3
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.EcsSG.id]
    subnets          = aws_subnet.privatesubnet.*.id
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.AppLBTG.id
    container_name   = "${var.app_name}-${var.env}-container"
    container_port   = 5000
  }

  depends_on = [aws_alb_listener.AppLBListener, aws_iam_role_policy.ecs_task_execution_role]
}