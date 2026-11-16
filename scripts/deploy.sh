#!/usr/bin/env bash
set -Eeuo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
for cmd in terraform aws kubectl docker sed; do command -v "$cmd" >/dev/null || { echo "Missing: $cmd" >&2; exit 1; }; done
cd "$ROOT/terraform"
REGION="$(terraform output -raw region)"
CLUSTER="$(terraform output -raw cluster_name)"
PRODUCTS="$(terraform output -raw ecr_products)"
ORDERS="$(terraform output -raw ecr_orders)"
ACCOUNT="$(aws sts get-caller-identity --query Account --output text)"
aws eks update-kubeconfig --region "$REGION" --name "$CLUSTER"
aws ecr get-login-password --region "$REGION" | docker login --username AWS --password-stdin "$ACCOUNT.dkr.ecr.$REGION.amazonaws.com"
docker build -t "$PRODUCTS:demo1" "$ROOT/apps/products"
docker build -t "$ORDERS:demo1" "$ROOT/apps/orders"
docker push "$PRODUCTS:demo1"
docker push "$ORDERS:demo1"
kubectl apply -f "$ROOT/k8s/00-namespace.yaml"
sed -e "s|PRODUCTS_IMAGE_PLACEHOLDER|$PRODUCTS:demo1|g" -e "s|ORDERS_IMAGE_PLACEHOLDER|$ORDERS:demo1|g" "$ROOT/k8s/10-apis.yaml" | kubectl apply -f -
kubectl apply -f "$ROOT/k8s/20-frontend.yaml"
kubectl rollout status deployment/products -n morays --timeout=300s
kubectl rollout status deployment/orders -n morays --timeout=300s
kubectl rollout status deployment/frontend -n morays --timeout=300s
kubectl get pods,svc -n morays
