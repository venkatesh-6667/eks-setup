# eks-setup
eks cluster(3 nodes of same namespace) setup along with few deployments,config rbac,hpa,ingress and use lambda to cluster start,stop daily at specific interval.
#all using with bash script.

**EKS Cluster Setup and Application Deployment Guide:**

This guide provides step-by-step instructions for setting up an Amazon EKS cluster with specific node configurations and deploying applications using bash scripts. It covers deployment of SonarQube, Dependency-track, and Defect Dojo along with RBAC, Ingress, Horizontal Pod Autoscaler (HPA), and a Lambda function for cluster management.

**Prerequisites**:

AWS CLI installed and configured with appropriate permissions.
Bash shell environment.

**Step 1**: EKS Cluster Setup

Run the main.sh script to deploy an EKS cluster with a single node group containing three nodes of different sizes: 
Node Group:
Node 1: t3.small (20GB volume)
Node 2: t3.medium (60GB volume)
Node 3: t3.xlarge (100GB volume)

bash

./main.sh

This step ensures that the EKS cluster is set up with a single node group containing three nodes of different sizes as specified, along with their respective volumes and also it installs helm.



**Step 2:** Application Deployment

Deploy applications using the deployments.sh script:

bash

./deployments.sh

This script deploys the following applications:
1.SonarQube with Java dependency in node-1
2.Dependency-track with Java dependency in node-2
3.Defect Dojo with Python3 dependency in node-3

**Step 3:** Cluster Configuration

a. Create RBAC (Service Accounts) using rbac-eks.sh script.

bash

./rbac-eks.sh

b. Apply Ingress and HPA configuration using ingress and hpa-config.sh script

bash

 ./Ingress\ and\ hpa-config.sh 



**Step 4**: Cluster Management

Utilize lambda.sh script to create a Lambda function for starting and stopping the cluster daily at specific interval.

bash

./lambda.sh

**Notes:**

1.Ensure AWS CLI is properly configured with necessary IAM permissions.

2.Verify successful deployment of applications by checking respective pods and services.



