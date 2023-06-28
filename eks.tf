
resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster-name # Replace with your desired cluster name
  role_arn = aws_iam_role.eks_cluster_role.arn
  version  = "1.25" # Replace with your desired EKS version

  tags = {
    Name = var.cluster-name
  }

  encryption_config {
    provider { key_arn = aws_kms_key.eks.arn }
    resources = ["secrets"]
  }

  enabled_cluster_log_types = [
    "api",
    "audit",
    "authenticator",
  ]

  vpc_config {
    subnet_ids = [
      aws_subnet.private-us-west-2a.id,
      aws_subnet.private-us-west-2b.id,
      aws_subnet.public-us-west-2a.id,
      aws_subnet.public-us-west-2b.id
    ]
    endpoint_public_access  = true
    endpoint_private_access = true
    public_access_cidrs     = var.cluster_public_access_cidrs
  }

  depends_on = [aws_iam_role_policy_attachment.eks_cluster_attachment, aws_vpc.eks_vpc]
}

resource "aws_eks_node_group" "private-nodes" {

  cluster_name    = var.cluster-name
  node_group_name = "${var.cluster-name}-private-nodes"

  capacity_type  = "ON_DEMAND"
  instance_types = ["t3.small"]
  node_role_arn  = aws_iam_role.eks_node_group_role.arn
  subnet_ids = [
    aws_subnet.private-us-west-2a.id,
    aws_subnet.private-us-west-2b.id
  ]

  scaling_config {
    desired_size = 2
    max_size     = 4
    min_size     = 2
  }

  depends_on = [
    aws_eks_cluster.eks_cluster,
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}

