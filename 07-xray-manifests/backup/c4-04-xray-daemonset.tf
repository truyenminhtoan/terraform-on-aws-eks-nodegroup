# Resource: Daemonset
resource "kubernetes_daemon_set_v1" "xray-daemon" {

  metadata {
    name      = "xray-daemon"
    namespace = kubernetes_namespace_v1.amazon_xray.metadata[0].name
  }

  spec {
    selector {
      match_labels = {
        app = "xray-daemon"
      }
    }

    template {
      metadata {
        labels = {
          app = "xray-daemon"
        }
      }

      spec {

        volume {
          name = "config-volume"
          config_map {
            name = "xray-config"
          }
        }

        container {
          image   = "amazon/aws-xray-daemon"
          name    = "xray-daemon"
          command = ["/usr/bin/xray", "-c", "/aws/xray/config.yaml"]

          port {
            container_port = 2000
          }

          resources {
            limits = {
              cpu    = "512m"
              memory = "64Mi"
            }
            requests = {
              cpu    = "256m"
              memory = "32Mi"
            }
          }

          volume_mount {
            name       = "config-volume"
            mount_path = "/aws/xray"
            read_only  = true
          }
        }
      }
    }
  }
}
