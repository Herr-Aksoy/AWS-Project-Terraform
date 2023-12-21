

resource "aws_autoscaling_group" "proje2_ASG" {
  desired_capacity        = 1
  min_size                = 1
  max_size                = 2
  health_check_type       = "ELB"
  health_check_grace_period = 300

  launch_template {
    id      = aws_launch_template.proje2_launch_template.id
    version = "$Latest"  # Kullanılacak sürüm numarası
  }

  vpc_zone_identifier = [
    aws_subnet.proje2_private_subnet[0].id,
    aws_subnet.proje2_private_subnet[1].id
    # İhtiyaca göre diğer subnetler eklenebilir
  ]

  target_group_arns = [
    aws_lb_target_group.proje2TargetGroup.arn
  ]

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "proje2_ASG"
    propagate_at_launch = true
  }

}

resource "aws_autoscaling_policy" "example_policy" {
  name                   = "example"
  policy_type             = "TargetTrackingScaling"
  estimated_instance_warmup = 300

  autoscaling_group_name  = aws_autoscaling_group.proje2_ASG.name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value              = 70.0
  }
}









# resource "aws_autoscaling_group" "proje2_ASG" {
#   name                 = "proje2_ASG"             # bu kisim yok






  #   ignore_changes = [                    # Bu kisim yok
  #     initial_lifecycle_hook
  #   ]
  # }

  # initial_lifecycle_hook {                                    # Bu kisim yok
  #   name                 = "proje2-lifecycle-hook"
  #   lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"
  #   notification_target_arn = aws_sns_topic.proje2_topic.arn
  #   notification_metadata = jsonencode({
  #     foo = "bar"
  #   })

  #   # İlgili IAM rolü için ARN                                  # BU kisim yok
  #   role_arn = aws_iam_role.proje2_EC2_S3_Full_Access.arn
  # }
# }

# resource "aws_autoscaling_policy" "example" {
#   name                   = "example"
#   scaling_adjustment      = 1
#   adjustment_type         = "ChangeInCapacity"
#   cooldown                = 300
#   estimated_instance_warmup = 300

#   policy_type             = "SimpleScaling"
#   autoscaling_group_name  = aws_autoscaling_group.proje2_ASG.name

#   target_tracking_configuration {
#     predefined_metric_specification {
#       predefined_metric_type = "ASGAverageCPUUtilization"
#     }
#     target_value              = 70.0
#   }
# }

# resource "aws_autoscaling_notification" "example" {
#   group_names = [aws_autoscaling_group.proje2_ASG.name]
  
#   notifications = [
#     "autoscaling:EC2_INSTANCE_LAUNCH",
#     "autoscaling:EC2_INSTANCE_TERMINATE",
#     "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
#     "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
#   ]

#   topic_arn = aws_sns_topic.proje2_topic.arn
# }








# resource "aws_sns_topic" "proje2_topic" {
#   name = "proje2_topic"
# }

# resource "aws_sns_topic_subscription" "proje2_topic_subscription" {
#   topic_arn = aws_sns_topic.proje2_topic.arn
#   protocol  = "email"
#   endpoint  = "mat.aksoy06@gmail.com"
# }

# resource "aws_autoscaling_group" "proje2_ASG" {
#   name                 = "proje2_ASG"
#   vpc_zone_identifier  = [
#     aws_subnet.proje2_public_subnet[0].id,
#     aws_subnet.proje2_public_subnet[1].id
#   ]

#   launch_template {
#     id      = aws_launch_template.proje2_launch_template.id
#     version = "$Latest"
#   }

#   desired_capacity     = 2
#   min_size             = 2
#   max_size             = 4

#   health_check_type           = "EC2"
#   health_check_grace_period   = 300

#   lifecycle {
#     create_before_destroy = true

#     ignore_changes = [
#       initial_lifecycle_hook
#     ]
#   }

#   initial_lifecycle_hook {
#     name                 = "proje2-lifecycle-hook"
#     lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"
#     notification_target_arn = aws_sns_topic.proje2_topic.arn
#     notification_metadata = jsonencode({
#       foo = "bar"
#     })

#     # IAM rolü için ARN
#     role_arn = aws_iam_role.proje2_EC2_S3_Full_Access.arn
#   }
# }

# resource "aws_autoscaling_policy" "example" {
#   name                   = "example"
#   scaling_adjustment      = 1
#   adjustment_type         = "ChangeInCapacity"
#   cooldown                = 300
#   estimated_instance_warmup = 300

#   policy_type             = "SimpleScaling"
#   autoscaling_group_name  = aws_autoscaling_group.proje2_ASG.name

#   target_tracking_configuration {
#     predefined_metric_specification {
#       predefined_metric_type = "ASGAverageCPUUtilization"
#     }
#     target_value              = 70.0
#   }
# }

# resource "aws_autoscaling_notification" "example" {
#   group_names = [aws_autoscaling_group.proje2_ASG.name]
  
#   notifications = [
#     "autoscaling:EC2_INSTANCE_LAUNCH",
#     "autoscaling:EC2_INSTANCE_TERMINATE",
#     "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
#     "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
#   ]

#   topic_arn = aws_sns_topic.proje2_topic.arn
# }









# resource "aws_sns_topic" "proje2_topic" {
#   name = "proje2_topic"
# }

# resource "aws_sns_topic_subscription" "proje2_topic_subscription" {
#   topic_arn = aws_sns_topic.proje2_topic.arn
#   protocol  = "email"
#   endpoint  = "mat.aksoy06@gmail.com"
# }

# resource "aws_autoscaling_group" "proje2_ASG" {
#   name                 = "proje2_ASG"
#   vpc_zone_identifier  = [
#     aws_subnet.proje2_public_subnet[0].id,
#     aws_subnet.proje2_public_subnet[1].id
#   ]

#   depends_on = [
#     aws_iam_role.proje2_EC2_S3_Full_Access
#   ]

#   launch_template {
#     id      = aws_launch_template.proje2_launch_template.id
#     version = "$Latest"
#   }

#   desired_capacity     = 2
#   min_size             = 2
#   max_size             = 4

#   health_check_type           = "ELB"
#   health_check_grace_period   = 300

#   lifecycle {
#     create_before_destroy = true

#     ignore_changes = [
#       initial_lifecycle_hook
#     ]
#   }

#   initial_lifecycle_hook {
#     name                 = "proje2-lifecycle-hook"
#     lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"
#     notification_target_arn = aws_sns_topic.proje2_topic.arn
#     notification_metadata = jsonencode({
#       foo = "bar"
#     })
#   }
# }

# resource "aws_autoscaling_policy" "example" {
#   name                   = "example"
#   scaling_adjustment      = 1
#   adjustment_type         = "ChangeInCapacity"
#   cooldown                = 300
#   estimated_instance_warmup = 300

#   policy_type             = "SimpleScaling"
#   autoscaling_group_name  = aws_autoscaling_group.proje2_ASG.name

#   target_tracking_configuration {
#     predefined_metric_specification {
#       predefined_metric_type = "ASGAverageCPUUtilization"
#     }
#     target_value              = 70.0
#   }
# }

# resource "aws_autoscaling_notification" "example" {
#   group_names = [aws_autoscaling_group.proje2_ASG.name]
  
#   notifications = [
#     "autoscaling:EC2_INSTANCE_LAUNCH",
#     "autoscaling:EC2_INSTANCE_TERMINATE",
#     "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
#     "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
#   ]

#   topic_arn = aws_sns_topic.proje2_topic.arn
# }





# resource "aws_sns_topic" "proje2_topic" {
#   name = "proje2_topic"
# }

# resource "aws_sns_topic_subscription" "proje2_topic_subscription" {
#   topic_arn = aws_sns_topic.proje2_topic.arn
#   protocol  = "email"
#   endpoint  = "mat.aksoy06@gmail.com"
# }

# resource "aws_autoscaling_group" "proje2_ASG" {
#   name                 = "proje2_ASG"
#   vpc_zone_identifier  = [
#     aws_subnet.proje2_public_subnet[0].id,
#     aws_subnet.proje2_public_subnet[1].id
#   ]

#   depends_on = [
#       aws_iam_role.proje2_EC2_S3_Full_Access                    ## Bu olusmadan calistigi icin hata verdi.
#   ]

#   launch_template {
#     id      = aws_launch_template.proje2_launch_template.id
#     version = "$Latest"
#   }

#   desired_capacity     = 2
#   min_size             = 2
#   max_size             = 4

#   health_check_type           = "ELB"
#   health_check_grace_period   = 300

#   lifecycle {
#     create_before_destroy = true
#   }

#   initial_lifecycle_hook {
#     name                 = "proje2-lifecycle-hook"
#     lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"
#     notification_target_arn = aws_sns_topic.proje2_topic.arn
#     notification_metadata = jsonencode({
#       foo = "bar"
#     })
#   }

# }


# resource "aws_autoscaling_policy" "example" {
#   name                   = "example"
#   scaling_adjustment      = 1
#   adjustment_type         = "ChangeInCapacity"
#   cooldown                = 300
#   estimated_instance_warmup = 300

#   policy_type             = "SimpleScaling"
#   autoscaling_group_name  = aws_autoscaling_group.proje2_ASG.name

#   target_tracking_configuration {
#     predefined_metric_specification {
#       predefined_metric_type = "ASGAverageCPUUtilization"
#     }
#     target_value              = 70.0
#   }
# }



# resource "aws_autoscaling_notification" "example" {
#   group_names = [aws_autoscaling_group.proje2_ASG.name]
  
#   notifications = [
#     "autoscaling:EC2_INSTANCE_LAUNCH",
#     "autoscaling:EC2_INSTANCE_TERMINATE",
#     "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
#     "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
#   ]

#   topic_arn = aws_sns_topic.proje2_topic.arn
# }







# resource "aws_sns_topic" "proje2_topic" {
#   name = "proje2_topic"
# }

# resource "aws_sns_topic_subscription" "proje2_topic_subscription" {
#   topic_arn = aws_sns_topic.proje2_topic.arn
#   protocol  = "email"
#   endpoint  = "mat.aksoy06@gmail.com"
# }

# resource "aws_autoscaling_group" "proje2_ASG" {
#   name                 = "proje2_ASG"
#   vpc_zone_identifier  = [
#     aws_subnet.proje2_public_subnet[0].id,
#     aws_subnet.proje2_public_subnet[1].id
#   ]

#   launch_template {
#     id      = aws_launch_template.proje2_launch_template.id
#     version = "$Latest"
#   }

#   desired_capacity     = 2
#   min_size             = 2
#   max_size             = 4

#   health_check_type           = "ELB"
#   health_check_grace_period   = 300

#   lifecycle {
#     create_before_destroy = true
#   }

#   initial_lifecycle_hook {
#     name                 = "proje2-lifecycle-hook"
#     lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"
#     notification_target_arn = aws_sns_topic.proje2_topic.arn
#     notification_metadata = jsonencode({
#       foo = "bar"
#     })
#   }

#   scaling_policy {
#     name  = "proje2_TargetTrackingPolicy"
#     adjustment_type = "ChangeInCapacity"
#     cooldown = 300
#     estimated_instance_warmup = 300

#     target_tracking_configuration {
#       predefined_metric_specification {
#         predefined_metric_type = "ASGAverageCPUUtilization"
#       }
#       target_value              = 70.0
#     }
#   }

#   notification_configuration {
#     topic_arn = aws_sns_topic.proje2_topic.arn
#     notification_types = [
#       "autoscaling:EC2_INSTANCE_LAUNCH",
#       "autoscaling:EC2_INSTANCE_TERMINATE",
#       "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
#       "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
#     ]
#   }
# }










# resource "aws_sns_topic" "proje2_topic" {
#   name = "proje2_topic"
# }

# resource "aws_sns_topic_subscription" "proje2_topic_subscription" {
#   topic_arn = aws_sns_topic.proje2_topic.arn
#   protocol  = "email"
#   endpoint  = "mat.aksoy06@gmail.com"
# }

# resource "aws_autoscaling_group" "proje2_ASG" {
#   name                 = "proje2_ASG"
#   vpc_zone_identifier  = [
#     aws_subnet.proje2_public_subnet[0].id,
#     aws_subnet.proje2_public_subnet[1].id
#   ]

#   launch_template {
#     id      = aws_launch_template.proje2_launch_template.id
#     version = "$Latest"
#   }

#   desired_capacity     = 2
#   min_size             = 2
#   max_size             = 4

#   health_check_type           = "ELB"
#   health_check_grace_period   = 300

#   lifecycle {
#     create_before_destroy = true
#   }

#   initial_lifecycle_hook {
#     name                 = "proje2-lifecycle-hook"
#     lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"
#     notification_target_arn = aws_sns_topic.proje2_topic.arn
#     notification_metadata = jsonencode({
#       foo = "bar"
#     })
#   }

#   tags = [
#     {
#       key                 = "Name"
#       value               = "proje2_ASG"
#       propagate_at_launch = true
#     },
#   ]

#   scaling_policies {
#     policy_name               = "proje2_TargetTrackingPolicy"
#     target_tracking_configuration {
#       predefined_metric_specification {
#         predefined_metric_type = "ASGAverageCPUUtilization"
#       }
#       target_value              = 70.0
#       scale_in_cooldown         = 300
#       scale_out_cooldown        = 300
#     }
#   }

#   notification_configuration {
#     topic_arn = aws_sns_topic.proje2_topic.arn
#     notification_types = [
#       "autoscaling:EC2_INSTANCE_LAUNCH",
#       "autoscaling:EC2_INSTANCE_TERMINATE",
#       "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
#       "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
#     ]
#   }
# }

