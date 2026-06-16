#!/bin/bash

# Script para simular errores en el clúster local de Kubernetes
# Diseñado para el taller de Observabilidad y Kagent

set -euo pipefail

# Directorio base de los manifiestos
K8S_DIR="k8s"

# Ayuda del script
mostrar_ayuda() {
    echo "Uso: $0 [opcion]"
    echo ""
    echo "Opciones disponibles:"
    echo "  oom         Simular fallo de memoria (OOM Killed) en el Pod de Backend"
    echo "  image       Simular fallo de imagen inexistente (ImagePullBackOff) en el Frontend"
    echo "  scale       Simular caída de servicio (escalar a 0 réplicas el Backend)"
    echo "  restore     Restaurar el clúster a su estado saludable original"
    echo "  help        Mostrar esta ayuda"
}

# Comprobar argumentos
if [ $# -lt 1 ]; then
    mostrar_ayuda
    exit 1
fi

case "$1" in
    oom)
        echo "--> Simulando OOM Killed en el Backend..."
        # Inyectar límites de recursos muy bajos en k8s/backend.yaml
        # Agregamos la sección resources debajo de imagePullPolicy/ports
        if ! grep -q "resources:" "$K8S_DIR/backend.yaml"; then
            sed -i.bak '/imagePullPolicy: IfNotPresent/a\
        resources:\
          limits:\
            memory: "10Mi"\
          requests:\
            memory: "10Mi"' "$K8S_DIR/backend.yaml"
        fi
        
        kubectl apply -f "$K8S_DIR/backend.yaml"
        echo "OOM simulado. Verifica el estado del pod con: kubectl get pods -w"
        ;;
        
    image)
        echo "--> Simulando ImagePullBackOff en el Frontend..."
        # Modificar la imagen en k8s/frontend.yaml a una etiqueta inválida
        sed -i.bak 's|image: local/frontend:latest|image: local/frontend:invalid-tag-error|g' "$K8S_DIR/frontend.yaml"
        
        kubectl apply -f "$K8S_DIR/frontend.yaml"
        echo "ImagePullBackOff simulado. Verifica el estado del pod con: kubectl get pods -w"
        ;;
        
    scale)
        echo "--> Simulando Caída de Servicio (Replica 0) en el Backend..."
        kubectl scale deployment/backend --replicas=0
        echo "Backend escalado a 0 réplicas. Verifica con: kubectl get deployments"
        ;;
        
    restore)
        echo "--> Restaurando clúster a su estado saludable..."
        
        # Restaurar archivos desde git o archivos .bak
        if [ -f "$K8S_DIR/backend.yaml.bak" ]; then
            mv "$K8S_DIR/backend.yaml.bak" "$K8S_DIR/backend.yaml"
        else
            git checkout -- "$K8S_DIR/backend.yaml"
        fi
        
        if [ -f "$K8S_DIR/frontend.yaml.bak" ]; then
            mv "$K8S_DIR/frontend.yaml.bak" "$K8S_DIR/frontend.yaml"
        else
            git checkout -- "$K8S_DIR/frontend.yaml"
        fi
        
        # Aplicar manifiestos saludables
        kubectl apply -f "$K8S_DIR/backend.yaml"
        kubectl apply -f "$K8S_DIR/frontend.yaml"
        
        # Asegurar réplicas del backend a 1
        kubectl scale deployment/backend --replicas=1
        
        echo "Clúster restaurado con éxito."
        kubectl get pods
        ;;
        
    help|*)
        mostrar_ayuda
        ;;
esac
