#!/bin/bash

# Script simple para configurar un cluster Kind para desarrollo local
CLUSTER_NAME=${1:-local-dev}

echo "🚀 Creando cluster Kind: $CLUSTER_NAME..."

if kind get clusters | grep -q "^$CLUSTER_NAME$"; then
    echo "⚠️ El cluster '$CLUSTER_NAME' ya existe."
else
    kind create cluster --name "$CLUSTER_NAME"
fi

echo "✅ Configurando contexto..."
kubectl config use-context "kind-$CLUSTER_NAME"

echo "ℹ️ Cluster listo. Recuerda cargar tus imágenes con:"
echo "   kind load docker-image <mi-imagen> --name $CLUSTER_NAME"
