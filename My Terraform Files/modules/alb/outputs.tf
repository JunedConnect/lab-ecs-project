output "LCT-ALB-ID" {
    value = aws_lb.LCT-ALB.id
}

output "Listener-ID" {
    value = aws_alb_listener.Listener.id
}

output "ListenerSSL-ID" {
    value = aws_alb_listener.ListenerSSL.id
}
