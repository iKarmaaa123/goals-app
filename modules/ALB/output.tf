output "target_group_arn" {
    value = aws_lb_target_group.my_aws_lb_target_group.arn
}

output "alb_dns_name" {
    value = aws_lb.my_aws_lb.dns_name
}

output "alb_zone_id" {
    value = aws_lb.my_aws_lb.zone_id
}