# Resource: Service Account, ClusteRole, ClusterRoleBinding

# Datasource
data "http" "get_xray_serviceaccount" {
  url = "https://raw.githubusercontent.com/aws-samples/amazon-cloudwatch-container-insights/latest/k8s-deployment-manifest-templates/deployment-mode/daemonset/container-insights-monitoring/cwagent/cwagent-serviceaccount.yaml"
  # Optional request headers
  request_headers = {
    Accept = "text/*"
  }
}

# Datasource: kubectl_file_documents 
# This provider provides a data resource kubectl_file_documents to enable ease of splitting multi-document yaml content.
data "kubectl_file_documents" "xray_docs" {
    content = data.http.get_xray_serviceaccount.response_body
}

# Resource: kubectl_manifest which will create k8s Resources from the URL specified in above datasource
resource "kubectl_manifest" "xray_serviceaccount" {
    depends_on = [kubernetes_namespace_v1.amazon_xray]
    for_each = data.kubectl_file_documents.xray_docs.manifests
    yaml_body = each.value
}


