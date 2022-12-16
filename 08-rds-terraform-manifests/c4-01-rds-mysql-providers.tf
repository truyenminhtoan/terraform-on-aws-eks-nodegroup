# Terraform AWS Provider Block
provider "aws" {
  region = var.aws_region
}

# Datasource: EKS Cluster Authentication
data "aws_eks_cluster_auth" "cluster" {
  name = data.terraform_remote_state.eks.outputs.cluster_id
}
