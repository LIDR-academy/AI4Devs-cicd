---
nombre: desplegando-n8n
descripción: Despliega una instancia self-hosted de n8n en un cluster Kubernetes, verificando la conexión y el estado de los pods.
---

# Desplegando n8n

## Cuándo usar esta habilidad
- Cuando el usuario quiera "instalar n8n", "desplegar n8n" o hacer "self hosting de n8n".
- Para integrar capacidades de automatización low-code en el cluster actual.

## Flujo de trabajo
1. **Planificar**: [ ] Verificar que existe un cluster de Kubernetes activo y accesible.
2. **Ejecutar**: [ ] Aplicar los manifiestos de Kubernetes incluidos en los recursos del skill.
3. **Validar**: [ ] Verificar que el pod de n8n esté en estado `Running` y que el servicio sea accesible.

## Instrucciones

### 1. Verificación Previa
Asegúrate de tener contexto de un cluster activo:
```bash
kubectl cluster-info
```

### 2. Despliegue
Aplica el archivo de manifiestos unificado:
```bash
kubectl apply -f .agent/skills/desplegando-n8n/resources/n8n-manifests.yaml
```

### 3. Verificación
Espera a que el pod esté listo (esto puede tardar unos minutos la primera vez mientras baja la imagen):
```bash
kubectl wait --for=condition=ready pod -l app=n8n --timeout=300s
```

Verifica los logs si hay problemas:
```bash
kubectl logs -l app=n8n
```

### 4. Acceso
Para acceder localmente, realiza un port-forward (hazlo en background o en una terminal separada si es para uso continuo):
```bash
kubectl port-forward svc/n8n 5678:5678
```
La URL de acceso será: `http://localhost:5678`

## Recursos
- [Manifiestos n8n](file:///Users/pedroalejandroavila/Documents/lidr/devops/AI4Devs-cicd/.agent/skills/desplegando-n8n/resources/n8n-manifests.yaml)
