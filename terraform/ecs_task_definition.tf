resource "aws_ecs_cluster" "test_cluster" {
  name = "test-cluster-on-${terraform.workspace}"
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "task_execution_role" {
  name               = "task-execution-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "attaching_ecs_task_execution_role_policy_to_task_execution_role" {
  role       = aws_iam_role.task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_ecs_task_definition" "nginx_task_definition" {
  family                   = "nginx"
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.task_execution_role.arn

  container_definitions = jsonencode(
    [
      {
        name : "nginx-container",
        image : aws_ecr_repository.nginx.repository_url,
        essential : true,
        cpu : 1024
        memory : 2048,
        portMapping : [
          {
            protocol : "tcp",
            containerPort : 80
          }
        ]
      }
    ]
  )
}

resource "aws_ecs_service" "nginx_service" {
  name            = "nginx-service"
  cluster         = aws_ecs_cluster.test_cluster.arn
  task_definition = aws_ecs_task_definition.nginx_task_definition.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    assign_public_ip = true
    security_groups  = [aws_security_group.tcp_security_group.id]
    subnets          = module.vpc.public_subnets
  }

  lifecycle {
    ignore_changes = [task_definition]
  }
}
