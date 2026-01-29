---
nombre: ejecutando-kagent
descripción: Guía para operar el CLI de kagent, incluyendo conexión, descubrimiento de agentes, configuración de API Key e integración A2A.
---

# Ejecutando Kagent

## Cuándo usar esta habilidad
- Cuando necesites invocar un agente de kagent desde la terminal local.
- Para solucionar problemas de conexión ("404 page not found") con el CLI.
- Para configurar la `OPENAI_API_KEY` en el controlador.
- Para integrar Kagent con otros servicios como n8n via JSON-RPC.

## Flujo de trabajo
1. **Conectar**: [ ] Establecer `port-forward` al servicio `kagent-controller`.
2. **Configurar**: [ ] Asegurar que la `OPENAI_API_KEY` esté configurada.
3. **Descubrir**: [ ] Listar los agentes disponibles.
4. **Invocar**: [ ] Ejecutar la tarea via CLI o API A2A.

## Instrucciones

### 1. Establecer Conexión (Prerrequisito)
El CLI de kagent necesita comunicarse con el controlador. Por defecto busca en `localhost:8083`.
Debes ejecutar esto en background o en una terminal separada:

```bash
kubectl port-forward svc/kagent-controller -n kagent 8083:8083
```

> **Nota**: Si recibes un error `404 page not found`, verifica que el port-forward esté activo.

### 2. Configuración de API Key
Kagent requiere una `OPENAI_API_KEY` para procesar tareas complejas.

```bash
kubectl set env deployment/kagent-controller -n kagent OPENAI_API_KEY=tu-api-key-aqui
```

### 3. Descubrir Agentes
```bash
kagent get agents
```
*Ignora el prefijo `kagent/` al usar el flag `--agent`.*

### 4. Invocar un Agente (CLI)
**Sintaxis Correcta:**
```bash
kagent invoke --agent "<nombre-agente>" --namespace "<namespace>" --task "<descripción de la tarea>"
```

**Ejemplo:**
```bash
kagent invoke --agent "k8s-agent" --namespace "kagent" --task "List all pods"
```

### 5. Integración A2A (n8n / HTTP)
Para llamar a Kagent desde servicios internos:

- **URL Interna**: `http://kagent-controller.kagent.svc.cluster.local:8083/api/a2a/kagent/k8s-agent/`
- **Protocolo**: JSON-RPC 2.0.
- **Body**:
```json
{
  "jsonrpc": "2.0",
  "method": "message/send",
  "params": {
    "message": {
      "role": "user",
      "parts": [{ "kind": "text", "text": "Tu prompt aquí" }]
    }
  },
  "id": 1
}
```

### Comandos Útiles
- `kagent version`: Verifica la versión instalada.
- `kagent config view`: Muestra la configuración actual.

## Errores Comunes
- **`404 page not found`**: Verifica el `port-forward`.
- **`Invalid agent format`**: Usa `--namespace "kagent"` y solo el nombre del agente (ej. `k8s-agent`).
- **`Context deadline exceeded`**: Si la IA tarda mucho, aumenta el timeout del cliente (en n8n o Alertmanager a 2m).
