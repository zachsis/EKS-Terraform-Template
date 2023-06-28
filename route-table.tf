resource "aws_route_table" "private" {

  depends_on = [aws_vpc.eks_vpc, aws_nat_gateway.nat]
  vpc_id     = aws_vpc.eks_vpc.id

  route = [{
    cidr_block                 = "0.0.0.0/0"
    nat_gateway_id             = aws_nat_gateway.nat.id
    core_network_arn           = null
    carrier_gateway_id         = null
    destination_prefix_list_id = null
    egress_only_gateway_id     = null
    gateway_id                 = null
    ipv6_cidr_block            = null
    local_gateway_id           = null
    network_interface_id       = null
    transit_gateway_id         = null
    vpc_endpoint_id            = null
    vpc_peering_connection_id  = null
  }]


  tags = {
    Name = "${var.cluster-name}-private"
  }
}

resource "aws_route_table" "public" {

  depends_on = [aws_vpc.eks_vpc, aws_internet_gateway.igw]
  vpc_id     = aws_vpc.eks_vpc.id

  route = [{
    cidr_block                 = "0.0.0.0/0"
    gateway_id                 = aws_internet_gateway.igw.id
    core_network_arn           = null
    nat_gateway_id             = null
    carrier_gateway_id         = null
    destination_prefix_list_id = null
    egress_only_gateway_id     = null
    ipv6_cidr_block            = null
    local_gateway_id           = null
    network_interface_id       = null
    transit_gateway_id         = null
    vpc_endpoint_id            = null
    vpc_peering_connection_id  = null
  }]


  tags = { Name = "${var.cluster-name}-public" }

}

resource "aws_route_table_association" "private-us-west-2a" {

  depends_on     = [aws_vpc.eks_vpc, aws_subnet.private-us-west-2a, aws_route_table.private]
  subnet_id      = aws_subnet.private-us-west-2a.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private-us-west-2b" {

  depends_on     = [aws_vpc.eks_vpc, aws_subnet.private-us-west-2b, aws_route_table.private]
  subnet_id      = aws_subnet.private-us-west-2b.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "public-us-west-2a" {

  depends_on     = [aws_vpc.eks_vpc, aws_subnet.public-us-west-2a, aws_route_table.public]
  subnet_id      = aws_subnet.public-us-west-2a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public-us-west-2b" {

  depends_on     = [aws_vpc.eks_vpc, aws_subnet.public-us-west-2b, aws_route_table.public]
  subnet_id      = aws_subnet.public-us-west-2b.id
  route_table_id = aws_route_table.public.id
}

