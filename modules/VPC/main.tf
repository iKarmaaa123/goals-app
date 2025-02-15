resource "aws_vpc" "my_aws_vpc" {  
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "goalsvpc"
    }
}

resource "aws_subnet" "my_aws_public_subnet" {
  vpc_id     = aws_vpc.my_aws_vpc.id
  cidr_block = var.cidr_block
  availability_zone = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = "albsubnet"
  }
}

resource "aws_subnet" "my_aws_public_subnet2" {
  vpc_id = aws_vpc.my_aws_vpc.id
  cidr_block = var.cidr_block2
  availability_zone = var.availability_zone2
  map_public_ip_on_launch = true

  tags = {
    Name = "albsubnet2"
  }
}


resource "aws_subnet" "my_aws_private_subnet" {
  vpc_id     = aws_vpc.my_aws_vpc.id
  cidr_block = var.cidr_block3
  availability_zone = var.availability_zone

  tags = {
    Name = "private-subnet"
  }
}

resource "aws_subnet" "my_aws_private_subnet2" {
  vpc_id = aws_vpc.my_aws_vpc.id
  cidr_block = var.cidr_block4
  availability_zone = var.availability_zone2

  tags = {
    Name = "private-subnet2"
  }
}

resource "aws_security_group" "my_security_group_ecs" {
  name        = "goals-security-group"
  vpc_id      = aws_vpc.my_aws_vpc.id

  tags = {
    Name = "goals-security_group"
  }
}

resource "aws_security_group_rule" "aws_security_group_ingress_https" {
  type = "ingress"
  from_port = 443
  to_port = 443
  protocol = "TCP"
  description = "Allow inbound traffic from ALB"
  security_group_id = aws_security_group.my_security_group_ecs.id
  source_security_group_id = aws_security_group.my_security_group_alb.id
}

resource "aws_security_group_rule" "my_aws_security_group_egress" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  description = "Allow outbound traffic from ECS"
  security_group_id = aws_security_group.my_security_group_ecs.id
}


resource "aws_security_group" "my_security_group_alb" {
  name = "goals-security-group-alb"
  vpc_id = aws_vpc.my_aws_vpc.id
}


resource "aws_security_group_rule" "aws_security_group_alb_http_ingress" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "TCP"
  cidr_blocks = ["0.0.0.0/0"]
  description = "Allow inbound to ALB from internet through port 80"
  security_group_id = aws_security_group.my_security_group_alb.id
}


resource "aws_security_group_rule" "aws_security_group_alb__https_ingress" {
  type = "ingress"
  from_port = 443
  to_port = 443
  protocol = "TCP"
  cidr_blocks = ["0.0.0.0/0"]
  description = "Allow inbound traffic to ALB from internet over port 443"
  security_group_id = aws_security_group.my_security_group_alb.id
}

resource "aws_security_group_rule" "aws_security_group_alb_egress" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  description = "Allow outbound traffic from ALB"
  security_group_id = aws_security_group.my_security_group_alb.id
}

resource "aws_eip" "my_aws_eip" {
  domain   = "vpc"
}

resource "aws_internet_gateway" "my_aws_internet_gateway" {
  vpc_id = aws_vpc.my_aws_vpc.id

  tags = {
    Name = "goalsinternetgateway"
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
    Name = "route-table2"
  }
}

resource "aws_route" "my_aws_route2" {
  route_table_id            = aws_route_table.my_aws_route_table2.id
  destination_cidr_block    = "0.0.0.0/0"
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

