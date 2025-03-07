resource "aws_security_group" "LCT-SG" {
  name = "Threat-Composer-Tool-SG"
  description = "Allows Everything"

 ingress {
   from_port   = 0
   to_port     = 0
   protocol    = -1
   cidr_blocks = ["0.0.0.0/0"]
 }

 egress {
   from_port   = 0
   to_port     = 0
   protocol    = -1
   cidr_blocks = ["0.0.0.0/0"]
 }
}


resource "aws_lb_target_group" "TCT-TG" {
  name        = "Threat-Composer-Tool-TG"
  port        = "80"    #port 3000 or port 80 works here
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = "vpc-0574715ac95407694"
}