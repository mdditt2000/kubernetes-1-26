#!/bin/bash
#create kubernetes cis container, authentication and RBAC
kubectl delete node bigip1
kubectl delete secret bigip-login -n kube-system
kubectl delete -f bigip-ctlr-clusterrole.yaml
kubectl delete -f f5-bigip-ctlr-deployment.yaml





