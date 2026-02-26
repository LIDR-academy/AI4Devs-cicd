#!/bin/bash

# Configuration script for generating K8s manifests
# Usage: ./generate-manifests.sh <IMAGE_TAG>

if [ -z "$1" ]; then
  echo "Usage: $0 <IMAGE_TAG>"
  exit 1
fi

IMAGE_TAG=$1
TEMPLATES_DIR="$(dirname "$0")/../resources/templates"
OUTPUT_DIR="k8s"

mkdir -p "$OUTPUT_DIR"

echo "Generating manifests in $OUTPUT_DIR..."

for template in "$TEMPLATES_DIR"/*.yaml; do
  filename=$(basename "$template")
  echo "Processing $filename..."
  sed "s/<IMAGE_TAG>/$IMAGE_TAG/g" "$template" > "$OUTPUT_DIR/$filename"
done

echo "Done! Manifests are ready in the '$OUTPUT_DIR' directory."
echo "Next steps:"
echo "1. Create your db-secrets:"
echo "   kubectl create secret generic db-secrets --from-literal=database-url=... --from-literal=postgres-user=... --from-literal=postgres-password=... --from-literal=postgres-db=..."
echo "2. Apply the manifests:"
echo "   kubectl apply -f $OUTPUT_DIR/"
