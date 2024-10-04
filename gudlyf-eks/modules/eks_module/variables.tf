variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version to use for the EKS cluster"
  type        = string
}

variable "access_entries" {
  description = "Map of access entries for the EKS cluster"
  type        = any
}

variable "cluster_endpoint_public_access" {
  description = "Whether the Amazon EKS public API server endpoint is enabled"
  type        = bool
  default     = true
}

variable "cluster_addons" {
  description = "Map of cluster addon configurations to enable for the cluster"
  type        = any
}

variable "vpc_id" {
  description = "ID of the VPC where the cluster will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "A list of subnet IDs where the EKS cluster will be deployed"
  type        = list(string)
}

variable "eks_managed_node_group_defaults" {
  description = "Map of EKS managed node group default configurations"
  type        = any
}

variable "eks_managed_node_groups" {
  description = "Map of EKS managed node group configurations"
  type        = any
}

variable "enable_cluster_creator_admin_permissions" {
  description = "Whether to enable admin permissions for the cluster creator"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
