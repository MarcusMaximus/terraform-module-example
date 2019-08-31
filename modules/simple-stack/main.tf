# Load Balancer Settings

resource "aws_security_group" "elb_public_sg" {
  name        = "allow_elb_public"
  description = "Allow inbound traffic from the internet to the ELB"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = "0.0.0.0/0"
  }

  egress {
    from_port       = "${var.app_listen_port}" 
    to_port         = "${var.app_listen_port}" 
    protocol        = "TCP"
    security_groups = "${aws_security_group.app_sg.id}"
  }
}


resource "aws_security_group" "app_sg" {
  name        = "allow_app_access"
  description = "Allow inbound traffic to the EC2 on port 5000"

  ingress {
    from_port   = "${var.app_listen_port}" 
    to_port     = "${var.app_listen_port}" 
    protocol    = "TCP"
    security_groups = "${aws_security_group.elb_public_sg.id}"
  }
}


resource "aws_elb" "app_elb"  {
    name               = "${var.app_name}-elb"
    
    # Listen on port 80 for testing
    listener {
        instance_port     = "${var.app_listen_port}" 
        instance_protocol = "http"
        lb_port           = 80
        lb_protocol       = "http"
    }

    # listen on 443
    listener {
        instance_port     = "${var.app_listen_port}" 
        instance_protocol = "http"
        lb_port            = 443
        lb_protocol       = "http"
        # lb_protocol        = "https"
        # ssl_certificate_id = "${var.load_balancer_acm}" 
    }

    health_check {
        healthy_threshold   = 2
        unhealthy_threshold = 5
        timeout             = 5
        target              = "HTTP:${var.app_listen_port}/health"
        interval            = 30
    }
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
resource "aws_autoscaling_attachment" "app_asg_attachment" {
  autoscaling_group_name = "${aws_autoscaling_group.app_asg.id}"
  elb                    = "${aws_elb.app_elb.id}"
}