
resource "aws_lb" "javaee_mini_lb" {
  name                       = "ecs-javaee-mini-lb"
  internal                   = false
  security_groups            = [aws_security_group.javaee_mini_sg.id]
  subnets                    = [aws_subnet.public_1a.id, aws_subnet.public_1c.id]
  enable_cross_zone_load_balancing = true
  enable_deletion_protection = false
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.javaee_mini_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.javaee_mini_tg.arn
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group
resource "aws_lb_target_group" "javaee_mini_tg" {
  name        = "javaee-mini-tg"
  target_type = "ip"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
}
