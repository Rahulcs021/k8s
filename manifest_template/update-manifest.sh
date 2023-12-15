#!/bin/bash

if [ -z "$ENV_VAR" ]; then
  echo "Environment variable ENV_VAR is not set."
  exit 1
fi

configmap_name="&&build_deployment-env-cm"
configmap_yaml="7-configmap.yaml"

# Split the ENV_VAR into individual key-value pairs
IFS='|' read -ra pairs <<< "$ENV_VAR"

# Generate ConfigMap YAML
cat <<EOF > "$configmap_yaml"
apiVersion: v1
kind: ConfigMap
metadata:
  name: $configmap_name
  namespace: &&build_namespace
data:
EOF

# Loop through each key-value pair, extract keys and values, and append to ConfigMap YAML
for pair in "${pairs[@]}"; do
  IFS='=' read -ra kv <<< "$pair"
  key="${kv[0]}"
  value="${kv[1]}"
  echo "  $key: $value" >> "$configmap_yaml"
done

echo "ConfigMap YAML file $configmap_yaml created successfully!"



sed -i "s|&&build_namespace|$NAMESPACE|g" ./*.yaml
sed -i "s|&&build_deployment|$BUILD_NAME|g" ./*.yaml
sed -i "s|&&alb_name|$ALB_NAME|g" ./*.yaml
sed -i "s|&&ingress_group_name|$ALB_GROUP|g" ./*.yaml
sed -i "s|&&health_port|$HEALTH_PORT|g" ./*-deployment.yaml
sed -i "s|&&health|$HEALTH|g" ./*.yaml
sed -i "s|&&port|$PORT|g" ./*.yaml
sed -i "s|&&account|$ACCOUNT|g" ./*.yaml
sed -i "s|&&region|$AWS_REGION|g" ./*.yaml
sed -i "s|&&nodegroup_name|$NODEGROUP|g" ./*.yaml
sed -i "s|&&mem_request|$MEM_REQUEST|g" ./*.yaml
sed -i "s|&&cpu_request|$CPU_REQUEST|g" ./*.yaml
sed -i "s|&&cpu_limit|$CPU_LIMIT|g" ./*.yaml
sed -i "s|&&mem_limit|$MEM_LIMIT|g" ./*.yaml
sed -i "s|&&max_replica|$MAX_REPLICA|g" ./*.yaml
sed -i "s|&&min_replica|$MIN_REPLICA|g" ./*.yaml
sed -i "s|&&build_repo|$ECR_REPOSITORY|g" ./*.yaml
sed -i "s|PAT_TOKEN|$1|g" ./*.yaml
sed -i "s|&&repo|k8s_deployment|g" ./*.yaml
sed -i "s|&&ORG|TTL-EntArch|g" ./*.yaml
sed -i "s|&&environment|$ENVIRONMENT|g" ./*.yaml
sed -i "s|&&branch|master|g" ./*.yaml
sed -i "s|&&url|$URL|g" ./*.yaml

if [ "$EXTERNAL" = yes ]; then
    sed -i '/ingress/s/^#//g' ./kustomization.yaml
fi

if [ "$ETCD_REQUIRED" = yes ]; then
    sed -i '/etcd/s/^#//g' ./kustomization.yaml
fi

if [ "$NAMESPACE_REQUIRED" = yes ]; then
    sed -i '/namespace/s/^#//g' ./kustomization.yaml
fi

if [ "$SERVICE_MONITOR" = yes ]; then
    sed -i '/service-monitor/s/^#//g' ./kustomization.yaml
fi

if [ "$HEALTH_PORT" != "$PORT" ]; then
    sed -i "s|traffic-port|$HEALTH_PORT|g" ./2-ingress.yaml
fi

