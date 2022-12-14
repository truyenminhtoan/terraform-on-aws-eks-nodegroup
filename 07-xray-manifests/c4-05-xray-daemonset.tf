# Resource: Daemonset

# Datasource
data "http" "get_xray_daemonset" {
  url = "https://raw.githubusercontent.com/aws-samples/amazon-cloudwatch-container-insights/latest/k8s-deployment-manifest-templates/deployment-mode/daemonset/container-insights-monitoring/cwagent/cwagent-daemonset.yaml"
  # Optional request headers
  request_headers = {
    Accept = "text/*"
  }
}

# Resource: kubectl_manifest which will create k8s Resources from the URL specified in above datasource
resource "kubectl_manifest" "xray_daemonset" {
    depends_on = [
      kubernetes_namespace_v1.amazon_xray,
      kubernetes_config_map_v1.xray_config_configmap,
      kubectl_manifest.xray_serviceaccount
      ]
    yaml_body = data.http.get_xray_daemonset.response_body
}