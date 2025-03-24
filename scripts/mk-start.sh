#!/usr/bin/env bash

set -o errexit

minikube start -p $CLUSTER_NAME --nodes 1 --cpus 4 --memory 4g --addons csi-hostpath-driver

minikube config set profile $CLUSTER_NAME

kubectl patch storageclass standard -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'
kubectl patch storageclass csi-hostpath-sc -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'