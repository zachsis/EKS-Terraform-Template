variable "cluster-name" {
  description = "your cool new EKS cluster"
  type        = string
  default     = "your-eks"
}


variable "region" {
  description = "Region"
  type        = string
  default     = "us-west-2"
}

variable "cluster_public_access_cidrs" {
  description = "Cidrs that are allowed to access the EKS Control Plane"
  default = ["YOURCIDR/32"]
}

variable  "aws_cli_profile" {
  default = "yourProfileHere"
  type        = string
}
