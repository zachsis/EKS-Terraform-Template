resource "aws_eip" "nat" {

  domain   = "vpc"

  tags = {
    Name = "${var.cluster-name}-eip"
  }

  depends_on = [aws_internet_gateway.igw]

}

resource "aws_nat_gateway" "nat" {

  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public-us-west-2a.id

  tags = {
    Name = "${var.cluster-name}-nat"
  }

  depends_on = [aws_internet_gateway.igw]
}
