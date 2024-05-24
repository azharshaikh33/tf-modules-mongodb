# resource "aws_route53_record" "mongodb" {
#     zone_id = "Z093296193U6R55S5C7L"
#     name    = "www.example.com"
#     type    = "A"
#     ttl     = 300
#     records = [aws_eip.lb.public_ip]
# }