resource "aws_ecs_task_definition" "task_definition" {
  family                   = "react-app" # Naming our first task
  container_definitions    = <<DEFINITION
  
  [
    {
      "name": "react-app",
      "image": "${data.aws_ecr_repository.ecr-repository.repository_url}",
      "essential": true,
      "portMappings": [
        {
          "containerPort": 80,
          "hostPort": 80
        }
      ],    
      "memory": 512,
      "cpu": 256
    }
  ]
  DEFINITION
  
  requires_compatibilities = ["FARGATE"] # Stating that we are using ECS Fargate
  network_mode             = "awsvpc"    # Using awsvpc as our network mode as this is required for Fargate
  memory                   = 512         # Specifying the memory our container requires
  cpu                      = 256         # Specifying the CPU our container requires
  execution_role_arn       = "${aws_iam_role.ecsTaskExecutionRole.arn}"
}


resource "aws_ecs_service" "frontend_service" {
  name            = "react-app"                             # Naming our first service
  cluster         = "${aws_ecs_cluster.ecs_cluster.id}"             # Referencing our created Cluster
  task_definition = "${aws_ecs_task_definition.task_definition.arn}" # Referencing the task our service will spin up
  launch_type     = "FARGATE"
  desired_count   = 3 # Setting the number of containers we want deployed to 2
  # health_check_grace_period_seconds = 10

  network_configuration {
    subnets          = ["${aws_subnet.subnet-public-a.id}", "${aws_subnet.subnet-public-b.id}"]
    assign_public_ip = true # Providing our containers with public IPs
    security_groups  = ["${aws_security_group.sg_ecs.id}"]
  }

  load_balancer {
    target_group_arn = "${aws_lb_target_group.target_group.arn}" # Referencing our target group
    container_name   = "${aws_ecs_task_definition.task_definition.family}"
    container_port   = 80 # Specifying the container port
  }
}