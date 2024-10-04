module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  access_entries = var.access_entries

  cluster_endpoint_public_access = var.cluster_endpoint_public_access

  cluster_addons = var.cluster_addons

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids

  eks_managed_node_group_defaults = var.eks_managed_node_group_defaults

  eks_managed_node_groups = var.eks_managed_node_groups

  enable_cluster_creator_admin_permissions = var.enable_cluster_creator_admin_permissions

  tags = var.tags
}

data "aws_caller_identity" "current" {}
