output "vpc_id" {
    value = aws_vpc.my_aws_vpc.id
}

output "public_subnet_id" {
    value = aws_subnet.my_aws_public_subnet.id
}

output "public_subnet2_id" {
    value = aws_subnet.my_aws_public_subnet2.id
}

output "private_subnet_id" {
    value = aws_subnet.my_aws_private_subnet.id
}

output "private_subnet2_id" {
    value =  aws_subnet.my_aws_private_subnet2.id
}

output "security_group_ecs_id" {
    value = aws_security_group.my_security_group_ecs.id
}

output "security_group_alb_id" {
    value = aws_security_group.my_security_group_alb.id
}