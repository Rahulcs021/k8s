#!/bin/bash

if [ -z "$ENV_VAR" ]; then
  echo "Environment variable ENV_VAR is not set."
  exit 1
fi

configmap_name="env-cm"
configmap_yaml="configmap.yaml"

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
