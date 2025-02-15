resource "aws_route53domains_registered_domain" "my_route53domains_registered_domain" {
  domain_name = var.domain_name
}

data "aws_route53_zone" "my_aws_route53_zone" {
    name = var.domain_name
}

resource "aws_route53_record" "a_record" {
    zone_id = data.aws_route53_zone.my_aws_route53_zone.id
    name = var.record_name
    type = var.record_type
    
    alias {
      name = var.alb_dns_name
      zone_id = var.zone_id
      evaluate_target_health = true
    }
}
/*
resource "aws_acm_certificate_validation" "my_acm_certificate_validation" {
  certificate_arn         = var.certificate_arn
  validation_record_fqdns = [aws_route53_record.a_record.fqdn]
}
*/
