# Stop Bastion Host
Login to AWS Mgmt Console -> EC2 -> hr-dev-Bastion-Host -> Instance State -> Stop 

# Configure kubeconfig for kubectl
aws eks --region <region-code> update-kubeconfig --name <cluster_name>

aws eks --region ap-northeast-1 update-kubeconfig --name tech-dev-eksdemo1

# Verify Kubernetes Worker Nodes using kubectl
kubectl get nodes
kubectl get nodes -o wide
