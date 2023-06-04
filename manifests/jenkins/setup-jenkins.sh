#!/bin/bash
kubectl apply -f namespaces.yaml
kubectl apply -f serviceaccount.yaml
kubectl apply -f volume.yaml
kubectl apply -f jenkins-pod.yaml
kubectl apply -f jenkins-service.yaml
