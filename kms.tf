resource "aws_kms_key" "eks" {
  description             = "${var.cluster-name} Secret Encryption Key"
  deletion_window_in_days = 7
  enable_key_rotation     = true

  tags = {
    Name = "${var.cluster-name}-secrets"
  }
}

