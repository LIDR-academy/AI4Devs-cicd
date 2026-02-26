# Ejecutando Kagent

## Cuándo usar esta habilidad
- Cuando necesites invocar un agente de kagent desde la terminal local.
- Para configurar la `OPENAI_API_KEY` o proveedores de LLM.
- Para gestionar servidores MCP (Model Context Protocol).
- Para integrar Kagent con otros servicios via API A2A.

## Flujo de trabajo Robusto

### 1. Preparar el Entorno (Túneles)
Para que el CLI, el Dashboard y los servidores MCP funcionen correctamente, es vital tener los túneles activos.

**Opción A: Usar `kagent dashboard`** (recomendado)
```bash
# Mata cualquier port-forward zombie antes de ejecutar
pkill -f "kubectl port-forward" 2>/dev/null
kagent dashboard
```
El comando configurará automáticamente los túneles para el controller (8083) y UI (8082).

**Opción B: Configuración manual**
```bash
# Túnel para el Controller y Dashboard
kubectl port-forward svc/kagent-controller -n default 8083:8083 > /dev/null 2>&1 &
kubectl port-forward svc/kagent-ui -n default 8082:8080 > /dev/null 2>&1 &

# Túneles para MCP (Model Context Protocol)
kubectl port-forward svc/kagent-grafana-mcp -n default 8000:8000 > /dev/null 2>&1 &
kubectl port-forward svc/kagent-tools -n default 8084:8084 > /dev/null 2>&1 &
```

### 2. Configuración de MCP (Model Context Protocol) en IDE/Antigravity
Para usar las herramientas de Kagent y Grafana directamente desde el IDE (Antigravity), configura tu `mcp_config.json` usando `@nimbletools/mcp-http-bridge`.

**Configuración recomendada:**
```json
{
  "mcpServers": {
    "kagent-grafana": {
      "command": "npx",
      "args": ["-y", "@nimbletools/mcp-http-bridge", "-e", "http://localhost:8000/mcp", "-t", "tu-token"]
    },
    "kagent-tools": {
      "command": "npx",
      "args": ["-y", "@nimbletools/mcp-http-bridge", "-e", "http://localhost:8084/mcp", "-t", "tu-token"]
    }
  }
}
```

### 3. Invocación vía CLI
```bash
kagent invoke --agent "k8s-agent" -n default --task "List pods in default" --stream --kagent-url http://localhost:8083
```

### 4. Protocolo A2A (Manual HTTP)
Si necesitas integrar Kagent con otros servicios o realizar pruebas manuales sin el CLI, usa el protocolo A2A vía HTTP (JSON-RPC 2.0).

> **IMPORTANTE:** El controller (`8083`) **no** proxea las llamadas A2A. Cada agente expone su propio endpoint en el puerto `8080`. Debes hacer port-forward **directamente al servicio del agente**.

**Paso 1 — Port-forward al agente deseado:**
```bash
kubectl port-forward svc/k8s-agent 19080:8080 -n default &
```

**Paso 2 — Descubrimiento de capacidades (Agent Card):**
```bash
curl -s http://localhost:19080/.well-known/agent.json | jq .
```

**Paso 3 — Invocación Manual (JSON-RPC):**
El método correcto en A2A 0.3.0 es `message/send`.
```bash
curl -s -X POST http://localhost:19080/ \
  -H "Content-Type: application/json" \
  -d '{
    "jsonrpc": "2.0",
    "id": "1",
    "method": "message/send",
    "params": {
      "message": {
        "messageId": "msg-001",
        "role": "user",
        "parts": [{"kind": "text", "text": "List pods in default namespace"}]
      }
    }
  }' | jq .
```

> **Nota:** No incluyas `taskId` para crear una nueva sesión. El agente generará uno automáticamente.
> El método `tasks/send` **no existe** en la versión 0.3.0 — usar `message/send`.
```

## Solución de Problemas
...

### kagent dashboard falla con "exit status 1"
**Causa**: Hay port-forwards zombies de sesiones anteriores bloqueando los puertos.
**Solución**:
```bash
pkill -f "kubectl port-forward"
kagent dashboard
```

### HTTP 404: Not Found (MCP)
- Asegura que el endpoint del bridge termine en `/mcp` (ej. `http://localhost:8084/mcp`).
- No uses los paths `/api/a2a/mcp/...` del controller; conecta directamente a los servicios (`8000` para Grafana, `8084` para Tools).

### Port 8000 Conflict
- El puerto `8000` suele ser usado por entornos de desarrollo (Django, etc.).
- Verifica qué proceso ocupa el puerto: `lsof -i :8000`.
- Detén contenedores que interfieran: `docker stop <container_id>`.

### Unexpected Content Type (MCP)
- Ocurre cuando el bridge intenta conectar a un puerto que no sirve SSE.
- Verifica que el `port-forward` esté activo: `lsof -i :8084`.
