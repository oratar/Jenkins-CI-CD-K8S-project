#!/bin/bash
kubectl apply -f manifests/jenkins/namespaces.yaml
kubectl apply -f manifests/jenkins/volume.yaml
kubectl apply -f manifests/jenkins/jenkins-pod.yaml
kubectl apply -f manifests/jenkins/jenkins-service.yaml
