resource "aws_vpc" "my_aws_vpc" {  
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = var.vpc_tag
  }
}

resource "aws_subnet" "my_aws_public_subnet" {
  vpc_id     = aws_vpc.my_aws_vpc.id
  cidr_block = var.cidr_block
  availability_zone = var.availability_zone

  tags = {
    Name = var.public_subnet_tag
  }
}

resource "aws_subnet" "my_aws_public_subnet2" {
  vpc_id = aws_vpc.my_aws_vpc.id
  cidr_block = var.cidr_block2
  availability_zone = var.availability_zone2

  tags = {
    Name = var.public_subnet2_tag
  }
}

resource "aws_subnet" "my_aws_private_subnet" {
  vpc_id     = aws_vpc.my_aws_vpc.id
  cidr_block = var.cidr_block3
  availability_zone = var.availability_zone

  tags = {
    Name = var.private_subnet_tag
  }
}

resource "aws_subnet" "my_aws_private_subnet2" {
  vpc_id = aws_vpc.my_aws_vpc.id
  cidr_block = var.cidr_block4
  availability_zone = var.availability_zone2

  tags = {
    Name = var.private_subnet2_tag
  }
}

resource "aws_security_group" "my_security_group_ecs" {
  name        = var.ecs_security_group_name
  vpc_id      = aws_vpc.my_aws_vpc.id

  tags = {
    Name = var.ecs_security_group_tag
  }
}

resource "aws_security_group_rule" "aws_security_group_ecs_ingress_https" {
  type = var.ecs_ingress_https_type
  from_port = var.ecs_ingress_https_from_port
  to_port = var.ecs_ingress_https_to_port
  protocol = var.ecs_ingress_https_protocol
  description = var.ecs_ingress_https_description
  security_group_id = aws_security_group.my_security_group_ecs.id
  source_security_group_id = aws_security_group.my_security_group_alb.id
}

resource "aws_security_group_rule" "my_aws_security_group_ecs_egress" {
  type = var.ecs_egress_type
  from_port = var.ecs_egress_from_port
  to_port = var.ecs_egress_to_port
  protocol = var.ecs_egress_protocol
  cidr_blocks = var.ecs_egress_cidr_blocks
  description = var.ecs_egress_description
  security_group_id = aws_security_group.my_security_group_ecs.id
}


resource "aws_security_group" "my_security_group_alb" {
  name = var.alb_security_group_name
  vpc_id = aws_vpc.my_aws_vpc.id

  tags = {
    Name = var.alb_security_group_tag
  }
}

resource "aws_security_group_rule" "aws_security_group_alb_http_ingress" {
  type = var.alb_ingress_type
  from_port = var.alb_ingress_http_from_port
  to_port = var.alb_ingress_http_to_port
  protocol = var.alb_ingress_http_protocol
  cidr_blocks = var.alb_ingress_http_cidr_blocks
  description = var.alb_ingress_http_description
  security_group_id = aws_security_group.my_security_group_alb.id
}


resource "aws_security_group_rule" "aws_security_group_alb_https_ingress" {
  type = var.alb_ingress_type
  from_port = var.alb_egress_from_port
  to_port = var.alb_egress_to_port
  protocol = var.alb_egress_protocol
  cidr_blocks = var.alb_egress_cidr_blocks
  description = var.alb_egress_description
  security_group_id = aws_security_group.my_security_group_alb.id
}

resource "aws_security_group_rule" "aws_security_group_alb_egress" {
  type = var.alb_egress_type
  from_port = var.alb_egress_from_port
  to_port = var.alb_egress_to_port
  protocol = var.alb_egress_protocol
  cidr_blocks = var.alb_egress_cidr_blocks
  description = var.alb_egress_description
  security_group_id = aws_security_group.my_security_group_alb.id
}

resource "aws_eip" "my_aws_eip" {
  domain   = var.eip_domain
}

resource "aws_internet_gateway" "my_aws_internet_gateway" {
  vpc_id = aws_vpc.my_aws_vpc.id

  tags = {
    Name = var.internet_gateway_tag
  }
}

resource "aws_nat_gateway" "my_aws_nat_gateway" {
  allocation_id                  = aws_eip.my_aws_eip.id
  subnet_id                      = aws_subnet.my_aws_public_subnet.id
}

resource "aws_route_table" "my_aws_route_table" {
  vpc_id = aws_vpc.my_aws_vpc.id
}

resource "aws_route" "my_aws_route" {
  route_table_id            = aws_route_table.my_aws_route_table.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.my_aws_internet_gateway.id
}

resource "aws_route_table_association" "my_aws_route_table_public_association" {
  subnet_id      = aws_subnet.my_aws_public_subnet.id
  route_table_id = aws_route_table.my_aws_route_table.id
}

resource "aws_route_table_association" "my_aws_route_table_public_association2" {
    subnet_id    = aws_subnet.my_aws_public_subnet2.id
    route_table_id = aws_route_table.my_aws_route_table.id
  }

resource "aws_route_table" "my_aws_route_table2" {
  vpc_id = aws_vpc.my_aws_vpc.id

  tags = {
    Name = var.route_table2_tag
  }
}

resource "aws_route" "my_aws_route2" {
  route_table_id            = aws_route_table.my_aws_route_table2.id
  destination_cidr_block    = var.destination_cidr_block
  gateway_id = aws_nat_gateway.my_aws_nat_gateway.id
}

resource "aws_route_table_association" "my_aws_route_table_private_association" {
    subnet_id    = aws_subnet.my_aws_private_subnet.id
    route_table_id = aws_route_table.my_aws_route_table2.id
  }

  resource "aws_route_table_association" "my_aws_route_table_private_association2" {
    subnet_id    = aws_subnet.my_aws_private_subnet2.id
    route_table_id = aws_route_table.my_aws_route_table2.id
  }

