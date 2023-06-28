resource "aws_vpc" "eks_vpc" {

  depends_on           = [aws_vpc.eks_vpc]
  enable_dns_hostnames = true
  cidr_block           = "10.23.0.0/16" # Replace with your desired VPC CIDR block
  tags = {
    Name = "${var.cluster-name}-vpc"
  }
}

resource "aws_internet_gateway" "igw" {

  depends_on = [aws_vpc.eks_vpc]
  vpc_id     = aws_vpc.eks_vpc.id

  tags = {
    Name = "${var.cluster-name}-igw"
  }
}

resource "aws_subnet" "private-us-west-2a" {

  depends_on        = [aws_vpc.eks_vpc]
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = "10.23.0.0/19"
  availability_zone = "us-west-2a"

  tags = {
    "Name"                                      = "${var.cluster-name}-private-us-west-2a"
    "kubernetes.io/role/internal-elb"           = "1"
    "kubernetes.io/cluster/${var.cluster-name}" = "owned"
  }
}

resource "aws_subnet" "private-us-west-2b" {

  depends_on        = [aws_vpc.eks_vpc]
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = "10.23.32.0/19"
  availability_zone = "us-west-2b"

  tags = {
    "Name"                                      = "${var.cluster-name}-private-us-west-2b"
    "kubernetes.io/role/internal-elb"           = "1"
    "kubernetes.io/cluster/${var.cluster-name}" = "owned"
  }
}

resource "aws_subnet" "public-us-west-2a" {

  depends_on              = [aws_vpc.eks_vpc]
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = "10.23.64.0/19"
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = true

  tags = {
    "Name"                                      = "${var.cluster-name}-public-us-west-2a"
    "kubernetes.io/role/elb"                    = "1"
    "kubernetes.io/cluster/${var.cluster-name}" = "owned"
  }
}

resource "aws_subnet" "public-us-west-2b" {

  depends_on              = [aws_vpc.eks_vpc]
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = "10.23.96.0/19"
  availability_zone       = "us-west-2b"
  map_public_ip_on_launch = true

  tags = {
    "Name"                                      = "${var.cluster-name}-public-us-west-2b"
    "kubernetes.io/role/elb"                    = "1"
    "kubernetes.io/cluster/${var.cluster-name}" = "owned"
  }
}

