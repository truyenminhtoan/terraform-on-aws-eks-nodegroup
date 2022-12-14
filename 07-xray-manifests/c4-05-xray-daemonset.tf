# Resource: Daemonset

# Datasource
data "http" "get_xray_daemonset" {
  url = "https://raw.githubusercontent.com/truyenminhtoan/terraform-on-aws-eks-nodegroup/develop/07-xray-manifests/yaml/xray-k8s-daemonset.yaml"
  # Optional request headers
  request_headers = {
    Accept = "text/*"
  }
}

# Resource: kubectl_manifest which will create k8s Resources from the URL specified in above datasource
resource "kubectl_manifest" "xray_daemonset" {
    depends_on = [
      kubernetes_namespace_v1.amazon_xray,
      #kubernetes_config_map_v1.xray_config_configmap,
      kubectl_manifest.xray_serviceaccount
      ]
    yaml_body = data.http.get_xray_daemonset.response_body
}