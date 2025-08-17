# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service
resource "aws_ecs_service" "javaee_mini" {
  name            = "javaee_mini_service"
  cluster         = aws_ecs_cluster.main.id
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.javaee_mini.arn
  desired_count   = 2
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service#network_configuration
  network_configuration {
    subnets          = [aws_subnet.private_1a.id, aws_subnet.private_1c.id]
    security_groups  = [aws_security_group.javaee_mini_sg.id]
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.javaee_mini_tg.arn
    container_name   = "javaee_mini"
    container_port   = 8080
  }   
}
