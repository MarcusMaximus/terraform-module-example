# Load Balancer Settings
resource "aws_elb" "app_elb"  {
    name               = "${var.app_name}-elb"
    
    # Listen on port 80 for testing
    listener {
        instance_port     = "${var.app_port}" 
        instance_protocol = "http"
        lb_port           = 80
        lb_protocol       = "http"
    }

    # listen on 443
    listener {
        instance_port     = "${var.app_port}" 
        instance_protocol = "http"
        lb_port            = 443
        lb_protocol       = "http"
        # lb_protocol        = "https"
        # ssl_certificate_id = "${var.load_balancer_acm}" 
    }

    health_check {
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 3
        target              = "HTTP:${var.app_port}/health"
        interval            = 30
    }

    # instances                   = ["${aws_instance.foo.id}"]
    # cross_zone_load_balancing   = true
    # idle_timeout                = 400
    # connection_draining         = true
    # connection_draining_timeout = 400

# Tag later
#   tags = {
#     Name = "foobar-terraform-elb"
#   }
}

# ASG Section of mudule
resource "aws_launch_template" "app_lt" {
  name_prefix   = "${var.app_name}" 
  image_id      = "${var.app_ami_id}" 
  # TODO: Possibly make instance type a varialbe
  instance_type = "t2.micro"
}

resource "aws_autoscaling_group" "app_asg" {
  availability_zones = "${var.availability_zones}" 
  desired_capacity   = "${var.asg_desired}" 
  max_size           = "${var.asg_max}" 
  min_size           = 2

  launch_template {
    id      = "${aws_launch_template.app_lt.id}"
    version = "$Latest"
  }
}

# Create a new load balancer attachment
resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = "${aws_autoscaling_group.asg.id}"
  elb                    = "${aws_elb.bar.id}"
}