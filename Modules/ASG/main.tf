resource "aws_launch_template" "my-lc" {
  image_id = var.ami
  instance_type = var.instance_type
  key_name = var.key_name
  vpc_security_group_ids = var.security_groups
  tags = {
    Name = var.instance_name
    Environment = var.Environment
  }
  user_data = base64encode(<<EOF
#!/bin/bash
sudo apt udpate 
sudo apt install nginx -y 
sudo systemctl enable nginx
sudo systemctl start nginx
EOF
  )
}

resource "aws_autoscaling_group" "ag" {
  name                 = var.alb_group_name
  max_size             = var.max_size
  min_size             = var.min_size
  health_check_type    = var.health_check_type
  desired_capacity     = var.desired_capacity
  target_group_arns    = var.lb_target_group_arns
  launch_template {
    id      = aws_launch_template.my-lc.id
    version = "$Latest"
  }
  force_delete         = true
  vpc_zone_identifier  = var.subnets_alb

  tag {
    key                 = "Name"
    value               = var.alb_group_name
    propagate_at_launch = true
  }
  tag {
    key                 = "Environment"
    value               = var.Environment
    propagate_at_launch = true
  }

}

resource "aws_autoscaling_policy" "my-asp" {
  name                   = var.asg_policy_name
  autoscaling_group_name = aws_autoscaling_group.ag.name
  policy_type = var.policy_type


  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = var.predefined_metric_type
    }

    target_value = var.target_value
  }
}