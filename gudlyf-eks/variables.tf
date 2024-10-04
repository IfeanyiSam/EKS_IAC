variable "kubernetes_namespace_dev" {
  description = "Kubernetes Namespace and Label"
  default     = "dev"
  type        = string
}

variable "kubernetes_namespace_test" {
  description = "Kubernetes Namespace and Label"
  default     = "test"
  type        = string
}

variable "kubernetes_namespace_prod" {
  description = "Kubernetes Namespace and Label"
  default     = "prod"
  type        = string
}

variable "region" {
  description = "AWS Region for Deployment"
  type        = string
  default     = "us-east-1"
}