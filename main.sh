#!/bin/bash
# Set variables
CLUSTER_NAME="dso-test"
NAMESPACE="dsolab"
REGION="us-east-1"
NODE_SIZE=("t3.small" "t3.medium" "t3.xlarge")
VOLUMES=("20" "60" "100")
ZONE="${REGION}a" # Change the zone as needed
HELM_VERSION="v3.7.0"
# Check if NODE_SIZE array is not empty
if [ ${#NODE_SIZE[@]} -eq 0 ]; then
    echo "Error: NODE_SIZE array is empty. Please provide valid node sizes."
    exit 1
fi
# Create EKS cluster
eksctl create cluster \
  --name $CLUSTER_NAME \
  --version 1.29 \   # Updated version to 1.29
  --region $REGION \
  --zones $ZONE \
  --nodegroup-name dso-workers \
  --node-type ${NODE_SIZE[0]} \
  --nodes 3 \
  --node-volume-size ${VOLUMES[0]} \
  --namespace $NAMESPACE
  --node-labels "nodegroup.k8s.amazonaws.com/node-type=node$((i+1))" \
  --node-name "node$((i+1))"
# Install Helm
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh