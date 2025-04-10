#!/usr/bin/env bash

set -o errexit

minikube start -p $CLUSTER_NAME --cni cilium --nodes 3 --cpus 2 --memory 2g --addons csi-hostpath-driver

minikube config set profile $CLUSTER_NAME

kubectl patch storageclass standard -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'
kubectl patch storageclass csi-hostpath-sc -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'