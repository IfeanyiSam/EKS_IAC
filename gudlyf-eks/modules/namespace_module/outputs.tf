output "namespace_names" {
  description = "Names of the created Kubernetes namespaces"
  value       = [for ns in kubernetes_namespace.namespaces : ns.metadata[0].name]
}
