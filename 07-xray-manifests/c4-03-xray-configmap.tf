# Resource: X-RAY ConfigMap
resource "kubernetes_config_map_v1" "xray_config_configmap" {
  metadata {
    name      = "xray-config"
    namespace = kubernetes_namespace_v1.amazon_xray.metadata[0].name
  }
  data = {
    "config.yaml" = "${file("${path.module}/yaml/xray-configmap.yaml")}"
  }
}