resource "aws_route53_zone" "my_hosted_zone" {
  name = "tm.juned.co.uk"
}


resource "aws_acm_certificate" "cert" {
  domain_name       = "tm.juned.co.uk"
  validation_method = "DNS"
}


resource "aws_route53_record" "cert_validation_record" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  zone_id = aws_route53_zone.my_hosted_zone.zone_id
  name    = each.value.name
  records = [each.value.record]
  type    = each.value.type
  ttl     = 60
}


resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation_record : record.fqdn]
}


resource "aws_route53_record" "alb_record" {
  zone_id = aws_route53_zone.my_hosted_zone.zone_id
  name    = "tm.juned.co.uk"
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}