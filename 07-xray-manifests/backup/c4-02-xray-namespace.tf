## Resource: Namespace
resource "kubernetes_namespace_v1" "amazon_xray" {
  metadata {
    name = "amazon-xray"
  }
}