
module "vpc_module" {
  source = "./vpc_module"

  vpc_cidr_block        = "10.0.0.0/16"
  public_subnet_count   = 3
  private_subnet_count  = 3
  database_subnet_count = 0
  create_nat_gateway    = false

  tags = {
    Name        = "Microservices"
    Terraform   = "true"
    Environment = "dev"
  }
}

module "eks" {
  source = "./modules/eks_module"

  cluster_name    = "socks"
  cluster_version = "1.30"

  access_entries = {
    user-access = {
      kubernetes_groups = []
      principal_arn     = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      policy_associations = {
        admin_user = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  }

  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    aws-ebs-csi-driver     = {}
    vpc-cni                = {}
  }

  vpc_id     = module.vpc_module.vpc_id
  subnet_ids = module.vpc_module.private_subnet_ids

  eks_managed_node_group_defaults = {
    instance_types = ["t3.micro", "t3.small"]
  }

  eks_managed_node_groups = {
    socks_nodes = {
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t3.medium"]
      iam_role_additional_policies = {
        AmazonEBSCSIDriverPolicy  = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
        AmazonEC2FullAccess       = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
        AmazonEKSWorkerNodePolicy = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
        AmazonEKS_CNI_Policy      = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
      }
      min_size     = 2
      max_size     = 3
      desired_size = 2
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}

data "aws_caller_identity" "current" {}


module "namespaces" {
  source       = "./modules/namespace_module"
  cluster_name = module.eks_module.cluster_name
  namespaces   = ["dev", "test", "prod"]

  depends_on = [module.eks]
}

module "monitoring" {
  source = "./modules/monitoring_module"

  sns_topic_name        = "EKS-Alerts"
  email_endpoint        = "samuelnnanna71@gmail.com"
  cpu_threshold         = 80
  memory_threshold      = 75
  evaluation_period     = 5
  autoscaling_group_name = module.eks_module.eks_managed_node_groups["socks_nodes"].node_group_autoscaling_group_names[0]

  depends_on = [module.eks_module]
}
