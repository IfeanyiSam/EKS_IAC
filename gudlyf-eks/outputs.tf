/*output "autoscaling_group_name" {
  description = "Name of the Auto Scaling Group for EKS worker nodes"
  value       = module.eks.eks_managed_node_groups["socks_nodes"].resources_autoscaling_group_names
}*/

output "kubernetes_namespaces" {
  description = "Names of the created Kubernetes namespaces"
  value       = module.namespaces.namespace_names
}
