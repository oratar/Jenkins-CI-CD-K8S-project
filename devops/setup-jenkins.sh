#!/bin/bash
node=$(kubectl get nodes --no-headers | awk '{print $1}')
echo ${node}
sed -i 's/<NODE>/$node/' manifests/jenkins/volume.yaml
kubectl apply -f manifests/jenkins/namespaces.yaml
kubectl apply -f manifests/jenkins/serviceaccount.yaml
kubectl apply -f manifests/jenkins/volume.yaml
kubectl apply -f manifests/jenkins/jenkins-pod.yaml
kubectl apply -f manifests/jenkins/jenkins-service.yaml
