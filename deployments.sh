#!/bin/bash

# Add Helm repositories
helm repo add stable https://charts.helm.sh/stable

# Update Helm repositories
helm repo update

# Install Java on node-1
kubectl label nodes node-1 app=java

# Add Java Helm repository
helm repo add bitnami https://charts.bitnami.com/bitnami

# Deploy SonarQube to node-1
helm install sonarqube bitnami/sonarqube --set nodeSelector.app=java,nodeSelector.kubernetes.io/hostname=node-1 --namespace dsolab

# Install Java on node-2
kubectl label nodes node-2 app=java

# Add Dependency-Track Helm repository
helm repo add dependency-track https://dl.bintray.com/owasp/dependency-track

# Deploy Dependency-Track to node-2
helm install dependency-track dependency-track/dependency-track --set nodeSelector.app=java,nodeSelector.kubernetes.io/hostname=node-2 --namespace dsolab

# Install Python3 on node-3
kubectl label nodes node-3 app=python3

# Add Defect Dojo Helm repository
helm repo add defect-dojo https://raw.githubusercontent.com/DefectDojo/django-DefectDojo/master/deploy/kubernetes/helm/defectdojo/

# Deploy Defect Dojo to node-3
helm install defect-dojo defect-dojo/defect-dojo --set nodeSelector.app=python3,nodeSelector.kubernetes.io/hostname=node-3 --namespace dsolab