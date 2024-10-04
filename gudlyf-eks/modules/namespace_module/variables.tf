variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "namespaces" {
  description = "List of Kubernetes namespaces to create"
  type        = list(string)
  default     = ["dev", "test", "prod"]
}
