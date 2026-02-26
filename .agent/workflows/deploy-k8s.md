---
description: Verify, generate manifests, and deploy the application to the ai4devs-cicd cluster
---

Este workflow automatiza la verificación de la aplicación, la generación de manifiestos de Kubernetes y el despliegue en un cluster local.

### 1. Verificar la aplicación
Primero, nos aseguramos de que tanto el backend como el frontend compilen y pasen sus pruebas.

// turbo
```bash
cd backend && npm install && npm run build && npm test
```

// turbo
```bash
cd frontend && npm install && npm run build && npm test
```

### 2. Generar archivos de despliegue
Utilizamos el script de la skill `k8s-deployment-expert` para generar los manifiestos YAML a partir de las plantillas existentes.

// turbo
```bash
./.agent/skills/k8s-deployment-expert/scripts/generate-manifests.sh latest
```

### 3. Desplegar en el cluster `ai4devs-cicd`
Cambiamos el contexto de Kubernetes al cluster especificado y aplicamos los manifiestos.

// turbo
```bash
kubectl config use-context kind-ai4devs-cicd && kubectl apply -f k8s/
```

### 4. Exponer la aplicación
Finalmente, exponemos el backend en el puerto 8080 y el frontend en el puerto 3000 usando port-forward.

// turbo
```bash
kubectl port-forward service/backend 8080:80 &
```

// turbo
```bash
kubectl port-forward service/frontend 3000:80 &
```

> [!NOTE]
> Los comandos de port-forward se ejecutan en segundo plano. Puedes verificar el estado con `kubectl get pods`.
