#!/usr/bin/env bash

set -o errexit

if flux check; then
    exit 0
fi

# Check if GITHUB_TOKEN is already set; if not, use sops to decrypt it
if [ -z "$GITHUB_TOKEN" ]; then
    GITHUB_TOKEN=$(sops -d ./secrets/flux-bootstrap-key)
    export GITHUB_TOKEN
fi

# Creating the sops-age secret for in-cluster secret decryption
kubectl create ns flux-system
sops -d ./secrets/sops-age-key |
    kubectl create secret generic sops-age-key \
        --namespace=flux-system \
        --from-file=sops-age-key=/dev/stdin

# Bootstrapping the cluster using a GitHub PAT
flux bootstrap github \
    --registry=ghcr.io/fluxcd \
    --components=source-controller,kustomize-controller,helm-controller \
    --components-extra=image-reflector-controller,image-automation-controller \
    --owner=$GITHUB_OWNER \
    --repository=$GITHUB_REPOSITORY \
    --branch=$GITHUB_BRANCH \
    --token-auth \
    --path=flux/$CLUSTER_NAME