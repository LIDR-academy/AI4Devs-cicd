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
kubectl port-forward svc/kagent-controller -n kagent 8083:8083 > /dev/null 2>&1 &
kubectl port-forward svc/kagent-ui -n kagent 8082:8080 > /dev/null 2>&1 &

# Túneles para MCP (Model Context Protocol)
kubectl port-forward svc/kagent-grafana-mcp -n kagent 8000:8000 > /dev/null 2>&1 &
kubectl port-forward svc/kagent-tools -n kagent 8084:8084 > /dev/null 2>&1 &
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
kagent invoke --agent "k8s-agent" --namespace "kagent" --task "List pods in default"
```

### 4. Protocolo A2A (Manual HTTP)
Si necesitas integrar Kagent con otros servicios o realizar pruebas manuales sin el CLI, usa el protocolo A2A vía HTTP (JSON-RPC 2.0).

**URL Base del Agente:**
`http://localhost:8083/api/a2a/{namespace}/{agent-name}/`

**Descubrimiento de Capacidades:**
Para ver qué habilidades (skills) tiene un agente:
```bash
curl -s http://localhost:8083/api/a2a/default/k8s-agent/.well-known/agent.json | jq .
```

**Invocación Manual (JSON-RPC):**
El método correcto es `message/send`.
```bash
curl -s -X POST -H "Content-Type: application/json" \
  -d '{
    "jsonrpc": "2.0",
    "id": "1",
    "method": "message/send",
    "params": {
      "message": {
        "kind": "message",
        "parts": [{"kind": "text", "text": "List pods"}],
        "role": "user"
      }
    }
  }' \
  http://localhost:8083/api/a2a/default/k8s-agent/ | jq .
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
