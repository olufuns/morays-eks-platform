#!/usr/bin/env bash
set -Eeuo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT/terraform"
REGION="$(terraform output -raw region)"
CLUSTER="$(terraform output -raw cluster_name)"
aws eks update-kubeconfig --region "$REGION" --name "$CLUSTER"
kubectl delete namespace morays --wait=true --timeout=600s || { echo 'Namespace/LB cleanup not confirmed. Investigate before terraform destroy.' >&2; exit 1; }
echo 'Kubernetes resources deleted. Run: cd terraform && terraform destroy'
