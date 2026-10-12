# Tiltfile for KubExporter Demo
# Manages the kind cluster and Kubernetes resources for the presentation.
#
# Usage:
#   tilt up          # Start the cluster and apply all resources
#   tilt down        # Tear down the cluster

cluster_name = 'kubexporter-demo'

# Create the kind cluster if it doesn't exist
local('test "$(kind get clusters 2>/dev/null | grep -wx %s)" || kind create cluster --name %s' % (cluster_name, cluster_name))
local('kind export kubeconfig --name %s' % cluster_name)

# Apply Kubernetes manifests for kubexporter-test namespace
k8s_yaml('setup/k8s/namespace.yaml')
k8s_yaml('setup/k8s/configmap.yaml')
k8s_yaml('setup/k8s/secret.yaml')
k8s_yaml('setup/k8s/deployment.yaml')
k8s_yaml('setup/k8s/service.yaml')

# Apply OpenTelemetry Collector resources in otel namespace
k8s_yaml('setup/k8s/otel/namespace.yaml')
k8s_yaml('setup/k8s/otel/otel-collector-configmap.yaml')
k8s_yaml('setup/k8s/otel/otel-collector-deployment.yaml')
k8s_yaml('setup/k8s/otel/otel-collector-service.yaml')

# Port-forward the kubexporter-demo service
k8s_resource('kubexporter-demo', port_forwards=18080)

# Port-forward the otel-collector service
k8s_resource('otel-collector', port_forwards=4317)
