#!/bin/bash
# Set variables for Ingress
INGRESS_NAME="dso-ingress"             # Set the name for your Ingress resource
SERVICE_NAME="dso-service"             # Set the name of your Kubernetes service
HOST="dsolab.net"                   # Set the host/domain for your Ingress
SERVICE_PORT=80                       # Set the port number of your service
NAMESPACE="dsolab"                   # Set the namespace for your resources
# Set variables for HPA
HPA_NAME="dso-hpa"                     # Set the name for your Horizontal Pod Autoscaler (HPA)
DEPLOYMENT_NAME="dso-deployment"       # Set the name of your Kubernetes deployment
MIN_REPLICAS=1                        # Set the minimum number of replicas for your deployment
MAX_REPLICAS=10                       # Set the maximum number of replicas for your deployment
TARGET_CPU_UTILIZATION=50             # Set the target CPU utilization percentage for autoscaling
# Apply Ingress configuration
kubectl apply -f - <<EOF
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: $INGRESS_NAME
  namespace: $NAMESPACE
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
  - host: $HOST
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: $SERVICE_NAME
            port:
              number: $SERVICE_PORT
EOF
# Apply HPA configuration
kubectl apply -f - <<EOF
apiVersion: autoscaling/v2beta2
kind: HorizontalPodAutoscaler
metadata:
  name: $HPA_NAME
  namespace: $NAMESPACE
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: $DEPLOYMENT_NAME
  minReplicas: $MIN_REPLICAS
  maxReplicas: $MAX_REPLICAS
  metrics:
  - type: Resource
    resource:
      name: cpu
      targetAverageUtilization: $TARGET_CPU_UTILIZATION
EOF
