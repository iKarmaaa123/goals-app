output "zone_id" {
    value = data.aws_route53_zone.my_aws_route53_zone.id
}

output "record_name" {
    value = aws_route53_record.a_record.name
}