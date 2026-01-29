---
nombre: ejecutando-kagent
descripción: Guía para operar el CLI de kagent e integrarlo programáticamente (A2A) con otros servicios como n8n.
---

# Ejecutando Kagent

## Cuándo usar esta habilidad
- Cuando necesites invocar un agente de kagent desde la terminal local.
- Para configurar la `OPENAI_API_KEY` en el controlador.
- Para integrar Kagent con otros servicios (n8n, Prometheus) via API A2A.

## Flujo de trabajo
1. **Conectar**: [ ] Establecer `port-forward` al servicio `kagent-controller`.
2. **Configurar**: [ ] Asegurar que la `OPENAI_API_KEY` esté configurada.
3. **Invocar CLI**: [ ] Ejecutar tareas usando el binario `kagent`.
4. **Integrar A2A**: [ ] Configurar HTTP Requests siguiendo el protocolo JSON-RPC 2.0.

## Instrucciones

### 1. Establecer Conexión (CLI Local)
El CLI de kagent busca por defecto en `localhost:8083`.
```bash
kubectl port-forward svc/kagent-controller -n kagent 8083:8083
```

### 2. Configuración de API Key
Kagent requiere una `OPENAI_API_KEY` para que los agentes operen:
```bash
kubectl set env deployment/kagent-controller -n kagent OPENAI_API_KEY=tu-api-key-aqui
```

### 3. Invocación vía CLI
**Sintaxis Robusta:**
```bash
kagent invoke --agent "k8s-agent" --namespace "kagent" --task "List pods in default"
```
*Si la tarea requiere confirmación, usa el flag `--session "<contextId>"` retornado en la primera respuesta.*

### 4. Integración Agente a Agente (A2A)
Para llamar a Kagent desde servicios internos (ej. n8n, scripts de Python):

- **URL Interna (Cluster)**: `http://kagent-controller.kagent.svc.cluster.local:8083/api/a2a/kagent/k8s-agent/`
- **Protocolo**: [JSON-RPC 2.0](https://www.jsonrpc.org/specification).
- **Cuerpo (Body)**:
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

### 💡 Tips para Integración Robusta (n8n/Alertmanager)
1. **Timeouts**: Los LLM pueden tardar. Configura siempre un timeout de **al menos 2 minutos** en el cliente (n8n httpRequest o Alertmanager webhook).
2. **Body Format**: En n8n, envía el JSON como **Objeto JSON** (no String) para evitar errores de escape en el controlador.
3. **Manejo de Respuestas**: Kagent devuelve un objeto con la llave `result.history`. El texto final suele estar en el último elemento con `role: "agent"`.
4. **Tolerancia a Fallos**: Si integras con Slack, usa la opción "Always Output Data" en n8n para asegurar que el pipeline de alertas responda "OK" (200) incluso si la notificación final falla.

## Errores Comunes
- **`404 page not found`**: El port-forward no está activo o la URL A2A tiene un typo.
- **`Invalid agent format`**: No incluyas el prefijo `kagent/` si ya especificas el namespace.
- **`Context deadline exceeded`**: El timeout del cliente es muy corto para la respuesta del LLM.
