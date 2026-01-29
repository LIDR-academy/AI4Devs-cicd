---
nombre: ejecutando-kagent
descripción: Guía para operar el CLI de kagent, incluyendo conexión, descubrimiento de agentes e invocación de tareas.
---

# Ejecutando Kagent

## Cuándo usar esta habilidad
- Cuando necesites invocar un agente de kagent desde la terminal local.
- Para solucionar problemas de conexión ("404 page not found") con el CLI.
- Para descubrir qué agentes están disponibles en el sistema.

## Flujo de trabajo
1. **Conectar**: [ ] Establecer `port-forward` al servicio `kagent-controller`.
2. **Descubrir**: [ ] Listar los agentes disponibles para obtener sus nombres correctos.
3. **Invocar**: [ ] Ejecutar la tarea usando los flags `--agent` y `--namespace` correctos.

## Instrucciones

### 1. Establecer Conexión (Prerequisito)
El CLI de kagent necesita comunicarse con el controlador. Por defecto busca en `localhost:8083`.
Debes ejecutar esto en background o en una terminal separada:

```bash
kubectl port-forward svc/kagent-controller -n kagent 8083:8083
```

> **Nota**: Si recibes un error `404 page not found` al ejecutar comandos de kagent, es muy probable que el port-forward no esté ejecutándose o el puerto sea incorrecto.

### 2. Descubrir Agentes
Antes de invocar, verifica el nombre exacto del agente:

```bash
kagent get agents
```
Esto listará agentes como `kagent/k8s-agent`, `kagent/cilium-debug-agent`, etc.
*Ignora el prefijo `kagent/` al usar el flag `--agent` si usas el flag `--namespace`.*

### 3. Invocar un Agente
La sintaxis robusta requiere separar el nombre del agente y el namespace.

**Sintaxis Correcta:**
```bash
kagent invoke --agent "<nombre-agente>" --namespace "<namespace>" --task "<descripción de la tarea>"
```

**Ejemplo:**
```bash
kagent invoke --agent "k8s-agent" --namespace "kagent" --task "List all pods"
```

### Comandos Útiles
- `kagent version`: Verifica la versión instalada.
- `kagent config view`: Muestra la configuración actual (URL, etc).

## Errores Comunes
- **`Error invoking session: ... 404 page not found`**: Verifica el `kubecl port-forward`.
- **`Invalid agent format`**: Asegúrate de usar `--namespace "kagent"` y poner solo el nombre del agente (ej. `k8s-agent`) en `--agent`.

### 4. Interacción y Sesiones
Kagent soporta conversaciones continuas usando IDs de sesión.
- Cuando ejecutas (`invoke`), kagent retorna un `contextId` o `sessionId`.
- Para responder a una pregunta del agente (ej. confirmar instalación), usa el flag `--session`.

**Ejemplo de flujo interactivo:**
1. Invocación inicial:
   ```bash
   kagent invoke --agent "helm-agent" --namespace "kagent" --task "Install prometheus"
   # Salida: "... Do you want to proceed? (Session ID: 383050f3...)"
   ```
2. Respuesta en la misma sesión:
   ```bash
   kagent invoke --agent "helm-agent" --namespace "kagent" --session "383050f3..." --task "Yes, proceed with default values"
   ```

### 5. Agentes Comunes
Algunos agentes útiles que puedes encontrar:
- **`k8s-agent`**: Gestión general de recursos Kubernetes (pods, deployments, services).
- **`helm-agent`**: Gestión de repositorios y releases de Helm. Útil para instalar stacks complejos como Prometheus.
  - *Ejemplo*: `Add prometheus-community repo and install prometheus in monitoring namespace`.
- **`cilium-*`**: Para depuración y gestión de redes Cilium.
