
# Target Group oluşturma
resource "aws_lb_target_group" "proje2TargetGroup" {
  name        = "proje2TargetGroup"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.proje2_vpc.id

  health_check {
    interval = 20
  }
}

resource "aws_lb" "proje2ALB" {
  name               = "proje2ALB"
  internal           = false
  load_balancer_type = "application"
  subnets            = [
    aws_subnet.proje2_public_subnet[0].id,
    aws_subnet.proje2_public_subnet[1].id
  ]
  security_groups    = [aws_security_group.proje2_ALB_Sec_Group.id]

  enable_deletion_protection = false

  tags = {
    Name = "proje2ALB"
  }
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.proje2ALB.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.proje2TargetGroup.arn
  }
}
                                                                    ## Certifica ile burayi acip tekrar olusturacagiz.
# resource "aws_lb_listener" "https_listener" {
#   load_balancer_arn = aws_lb.proje2ALB.arn
#   port              = 443
#   protocol          = "HTTPS"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   certificate_arn   = "arn:aws:acm:us-east-1:067162000921:certificate/fadffd34-76f9-43ef-9e83-b3842cd4da63" # *.devopstricks.link SSL/TLS certificate ARN

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.proje2TargetGroup.arn
#   }
# }
























