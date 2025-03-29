resource "aws_acm_certificate" "aws-redirect-cert" {
    domain_name       = "${var.subdomain}.joshbarbee.com"
    validation_method = "DNS"
    lifecycle {
      create_before_destroy = true
    }
}

resource "aws_acm_certificate_validation" "aws-rediret-cert-validation" {
    certificate_arn = aws_acm_certificate.aws-redirect-cert.arn
    validation_record_fqdns = [
        aws_route53_record.aws-redirect-cert-validation.fqdn,
    ]
}

resource "aws_route53_record" "aws-redirect-r53-cname" {
    for_each = {
        for dvo in aws_acm_certificate.acm-cert.domain_validation_options : dvo.domain_name => {
        name   = dvo.resource_record_name
        record = dvo.resource_record_value
        type   = dvo.resource_record_type
        }
    }

    allow_overwrite = true
    name            = each.value.name
    records         = [each.value.record]
    ttl             = 360
    type            = each.value.type
    zone_id         = var.hosted_zone_id
}
