data "tls_certificate" "tls_cert" {
  provider = tls
  url      = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "oidc" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = data.tls_certificate.tls_cert.certificates[*].sha1_fingerprint
  url             = data.tls_certificate.tls_cert.url
}

