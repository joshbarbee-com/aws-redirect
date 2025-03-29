resource "aws_cloudfront_distribution" "aws-redirect-cloudfront-distribution" {
    origin {
        domain_name = var.redirect_domain
        origin_id   = "redirect-origin"
    }

    enabled = true
    is_ipv6_enabled = true
    comment = "Redirect ${var.subdomain} to ${var.redirect_domain}"

    default_cache_behavior {
        target_origin_id       = "redirect-origin"
        viewer_protocol_policy = "redirect-to-https"

        allowed_methods = ["GET", "HEAD"]
        cached_methods  = ["GET", "HEAD"]

        forwarded_values {
            query_string = false
            cookies {
                forward = "none"
            }
        }
    }

    custom_error_response {
        error_code            = 404
        response_code         = 302
        response_page_path    = "/"
    }

    restrictions {
        geo_restriction {
            restriction_type = "none"
        }
    }

    viewer_certificate {
        acm_certificate_arn = aws_acm_certificate.aws-redirect-cert.arn
        ssl_support_method  = "sni-only"
    }
}