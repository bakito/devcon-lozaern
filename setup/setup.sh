#!/usr/bin/env bash
set -euo pipefail

CLUSTER_NAME="kubexporter-demo"
NAMESPACE="kubexporter-test"
SERVICE_PORT=80

# Run relative to this script so k8s/*.yaml paths resolve from any working directory
cd "$(dirname "${BASH_SOURCE[0]}")"

echo "🚀 === KubExporter Demo Setup ==="

if [[ -z "${KILLERCODA_MODE:-}" ]]; then

  # Make sure the kubeconfig directory exists when KUBECONFIG is set (e.g. by devbox)
  if [[ -n "${KUBECONFIG:-}" ]]; then
      mkdir -p "$(dirname "${KUBECONFIG}")"
  fi

  # -------------------------------------------------------------------
  # 1. Create kind cluster
  # -------------------------------------------------------------------
  echo "🐳 [1/3] Creating kind cluster '${CLUSTER_NAME}' ..."
  EXISTING_CLUSTERS="$(kind get clusters 2>/dev/null || true)"
  if grep -qx "${CLUSTER_NAME}" <<<"${EXISTING_CLUSTERS}"; then
      echo "  ♻️  Cluster '${CLUSTER_NAME}' already exists — skipping creation."
  elif ! CREATE_OUTPUT="$(kind create cluster --name "${CLUSTER_NAME}" --config kind-cluster.yaml --wait 60s 2>&1)"; then
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
else
  echo "🐳 [1/3] Using killercoda cluster ..."
  CLUSTER_NAME="KILLERCODA"
fi

# -------------------------------------------------------------------
# 2. Apply KubExporter resources
# -------------------------------------------------------------------
echo "📦 [2/3] Applying KubExporter resources ..."
kubectl apply -f k8s/kubexporter
echo "  ✅ KubExporter resources created."

# -------------------------------------------------------------------
# 3. Deploy OpenTelemetry Collector in cluster
# -------------------------------------------------------------------
echo "📡 [3/3] Deploying OpenTelemetry Collector ..."
kubectl apply -f k8s/otel-collector

# Wait for the collector deployment to be ready (timeout ~60s)
if ! kubectl rollout status deployment/otel-collector -n otel --timeout=60s >/dev/null 2>&1; then
  echo "  ❌ OpenTelemetry Collector failed to become ready." >&2
  kubectl logs -n otel deployment/otel-collector >&2
  exit 1
fi
echo "  ✅ OpenTelemetry Collector deployed (otel-collector:4317)."

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
echo "📡 OpenTelemetry Collector:"
echo "  NodePort endpoint: localhost:32317 (from host)"
echo "  In-cluster service: otel-collector.otel.svc.cluster.local:4317"
if [[ -z "${KILLERCODA_MODE:-}" ]]; then
  echo ""
  echo "🧹 To clean up:"
  echo "  kind delete cluster --name ${CLUSTER_NAME}"
fi
