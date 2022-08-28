resource "aws_ecs_cluster" "test_cluster" {
  name = "test-cluster-on-${terraform.workspace}"
}

resource "aws_ecs_task_definition" "iis_task_definition" {
  family                   = "iis"
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048
  requires_compatibilities = ["FARGATE"]

  container_definitions = jsonencode(
    [
      {
        name : "iis-container",
        image : "mcr.microsoft.com/windows/servercore/iis:windowsservercore-ltsc2019",
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

  runtime_platform {
    operating_system_family = "WINDOWS_SERVER_2019_CORE"
    cpu_architecture        = "X86_64"
  }
}

resource "aws_ecs_service" "iis_service" {
  name            = "iis-service"
  cluster         = aws_ecs_cluster.test_cluster.arn
  task_definition = aws_ecs_task_definition.iis_task_definition.arn
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
