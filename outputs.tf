output "eks_cluster_endpoint" {
  value       = aws_eks_cluster.eks_cluster.endpoint
  description = "EKS cluster endpoint"
}

output "eks_cluster_certificate_authority_data" {
  value       = aws_eks_cluster.eks_cluster.certificate_authority.0.data
  description = "EKS cluster certificate authority data"
}

