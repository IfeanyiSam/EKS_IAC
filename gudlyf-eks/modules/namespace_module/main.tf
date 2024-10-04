resource "kubernetes_config_map" "cluster_config" {
  metadata {
    name      = "cluster-config"
    namespace = "kube-system"
  }

  data = {
    cluster_name = var.cluster_name
  }
}

resource "kubernetes_namespace" "namespaces" {
  for_each = toset(var.namespaces)

  metadata {
    annotations = {
      name = each.key
    }

    labels = {
      mylabel = each.key
    }

    name = each.key
  }

  depends_on = [kubernetes_config_map.cluster_config]
}
