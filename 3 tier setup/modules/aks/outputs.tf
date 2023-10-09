output "aks_cluster_id" {
  value = "${azurerm_kubernetes_cluster.kpmgakscluster.id}"
}

output "aks_cluster_name" {
  value = "${azurerm_kubernetes_cluster.kpmgakscluster.name}"
}

output "aks_cluster_kubernetes_version" {
  value = "${azurerm_kubernetes_cluster.kpmgakscluster.kubernetes_version}"
}