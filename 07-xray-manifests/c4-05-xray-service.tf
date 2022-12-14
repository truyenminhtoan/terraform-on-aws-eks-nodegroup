resource "kubernetes_service_v1" "xray-service" {
  metadata {
    name      = "xray-service"
    namespace = kubernetes_namespace_v1.amazon_xray.metadata[0].name
  }
  spec {
    selector = {
      app = "xray-daemon"
    }

    port {
      name     = "xray-ingest"
      port     = 2000
    }

    type = "ClusterIP"
  }
}
