# Global Accelerator
resource "aws_globalaccelerator_accelerator" "accelerator" {
  name   = "example-accelerator"
  enabled = true
}

resource "aws_globalaccelerator_listener" "listener" {
  accelerator_arn = aws_globalaccelerator_accelerator.accelerator.id
  client_affinity = "NONE"
  protocol        = "TCP"

  port_range {
    from_port = 80
    to_port   = 80
  }
}


resource "aws_globalaccelerator_endpoint_group" "endpoint_group" {
  listener_arn = aws_globalaccelerator_listener.listener.id  
  endpoint_configuration {
    endpoint_id   = aws_lb.my_alb.arn
    weight        = 128    
  }

  health_check_interval_seconds = 30
  health_check_path             = "/"
  health_check_port             = 80
  health_check_protocol         = "HTTP"
  threshold_count               = 3
  traffic_dial_percentage       = 100
}
