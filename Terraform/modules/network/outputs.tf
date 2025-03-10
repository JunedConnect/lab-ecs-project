output "LCT-SG-ID" {
    value = aws_security_group.LCT-SG.id
}

output "aws_lb_target_group-ID" {
    value = aws_lb_target_group.TCT-TG.id
}

output "certificate_arn" {
    value = aws_acm_certificate.cert.arn
}