#!/usr/bin/env bash
set -euo pipefail

CLUSTER_NAME="kubexporter-demo"
NAMESPACE="kubexporter-test"
SERVICE_PORT=80

# Run relative to this script so k8s/*.yaml paths resolve from any working directory
cd "$(dirname "${BASH_SOURCE[0]}")"

# Make sure the kubeconfig directory exists when KUBECONFIG is set (e.g. by devbox)
if [[ -n "${KUBECONFIG:-}" ]]; then
    mkdir -p "$(dirname "${KUBECONFIG}")"
fi

echo "🚀 === KubExporter Demo Setup ==="

# -------------------------------------------------------------------
# 1. Create kind cluster
# -------------------------------------------------------------------
echo "🐳 [1/6] Creating kind cluster '${CLUSTER_NAME}' ..."
EXISTING_CLUSTERS="$(kind get clusters 2>/dev/null || true)"
if grep -qx "${CLUSTER_NAME}" <<<"${EXISTING_CLUSTERS}"; then
    echo "  ♻️  Cluster '${CLUSTER_NAME}' already exists — skipping creation."
elif ! CREATE_OUTPUT="$(kind create cluster --name "${CLUSTER_NAME}" --wait 60s 2>&1)"; then
    if grep -q "already exist" <<<"${CREATE_OUTPUT}"; then
        echo "  ♻️  Cluster '${CLUSTER_NAME}' already exists — skipping creation."
    else
        echo "❌ ${CREATE_OUTPUT}" >&2
        exit 1
    fi
else
    echo "${CREATE_OUTPUT}"
    echo "  ✅ Cluster created."
fi

# Ensure kubeconfig context is set
KUBECONFIG_CONTEXT="kind-${CLUSTER_NAME}"
kind export kubeconfig --name "${CLUSTER_NAME}" >/dev/null
kubectl config use-context "${KUBECONFIG_CONTEXT}"
echo "  🔗 Using context: ${KUBECONFIG_CONTEXT}"

# -------------------------------------------------------------------
# 2. Apply Namespace
# -------------------------------------------------------------------
echo "📁 [2/6] Applying Namespace ..."
kubectl apply -f k8s/namespace.yaml
echo "  ✅ Namespace ready."

# -------------------------------------------------------------------
# 3. Apply ConfigMap
# -------------------------------------------------------------------
echo "⚙️  [3/6] Applying ConfigMap ..."
kubectl apply -f k8s/configmap.yaml
echo "  ✅ ConfigMap created."

# -------------------------------------------------------------------
# 4. Apply Secret
# -------------------------------------------------------------------
echo "🔐 [4/6] Applying Secret ..."
kubectl apply -f k8s/secret.yaml
echo "  ✅ Secret created."

# -------------------------------------------------------------------
# 5. Apply Deployment
# -------------------------------------------------------------------
echo "📦 [5/6] Applying Deployment ..."
kubectl apply -f k8s/deployment.yaml
echo "  ✅ Deployment created."

# -------------------------------------------------------------------
# 6. Apply Service
# -------------------------------------------------------------------
echo "🌐 [6/6] Applying Service ..."
kubectl apply -f k8s/service.yaml
echo "  ✅ Service created."

# -------------------------------------------------------------------
# Done
# -------------------------------------------------------------------
echo ""
echo "🎉 === Setup complete ==="
echo "🐳 Cluster  : ${CLUSTER_NAME}"
echo "📁 Namespace: ${NAMESPACE}"
echo ""
echo "📋 Resources:"
kubectl get all,configmap,secret -n "${NAMESPACE}"
echo ""
echo "🔌 To port-forward the service:"
echo "  kubectl port-forward -n ${NAMESPACE} svc/kubexporter-demo ${SERVICE_PORT}:${SERVICE_PORT}"
echo ""
echo "🧹 To clean up:"
echo "  kind delete cluster --name ${CLUSTER_NAME}"
