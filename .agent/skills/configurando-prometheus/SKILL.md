---
nombre: configurando-prometheus
descripción: Guía para desplegar Prometheus, configurar Alertmanager y gestionar reglas de alerta con integración externa.
---

# Configurando Prometheus y Alertmanager

## Cuándo usar esta habilidad
- Cuando necesites instalar un stack de monitoreo (Prometheus/Alertmanager) en el cluster.
- Cuando quieras configurar el envío de alertas a sistemas externos (n8n, Slack).
- Para solucionar problemas de comunicación entre el servidor de Prometheus y Alertmanager.
- Para ajustar los timeouts de entrega de alertas (necesario para triaje con IA).

## Flujo de trabajo
1. **Instalar**: [ ] Usar `kagent` para desplegar el stack vía Helm.
2. **Alertar**: [ ] Inyectar reglas de alerta (`alerting_rules.yml`).
3. **Notificar**: [ ] Configurar Alertmanager para enviar a n8n/Slack.
4. **Optimizar**: [ ] Ajustar timeouts y DNS para máxima fiabilidad.

## Instrucciones

### 1. Instalación con Kagent
Usa el `helm-agent` para instalar el chart de la comunidad en el namespace `monitoring`.

```bash
kagent invoke --agent "helm-agent" --namespace "kagent" --task "Add prometheus-community repo and install prometheus in monitoring namespace"
```

### 2. Configuración de Reglas de Alerta
Edita el ConfigMap `prometheus-server` para agregar lógica de disparo.

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: prometheus-server
  namespace: monitoring
data:
  alerting_rules.yml: |
    groups:
    - name: Infrastructure
      rules:
      - alert: InstanceDown
        expr: up == 0
        for: 1m
        labels:
          severity: critical
        annotations:
          summary: 'Instance {{ $labels.instance }} down'
```
*Aplica con: `kubectl apply -f rules.yaml` y reinicia el deployment `prometheus-server`.*

### 3. Configuración de Alertmanager (Webhooks Externos)
Para enviar alertas a n8n o sistemas de triaje con IA, debes configurar el receptor en el ConfigMap `prometheus-alertmanager`.

> [!IMPORTANT]
> **Timeout Craneal**: Si el receptor es una IA (Kagent), debes configurar un timeout de al menos **2m**. El valor por defecto (10s) cortará la conexión antes de que la IA genere el triaje.

```yaml
data:
  alertmanager.yml: |
    receivers:
    - name: 'n8n-webhook'
      webhook_configs:
      - url: 'http://n8n.default.svc.cluster.local:5678/webhook/prometheus-alert'
        send_resolved: true
        timeout: 2m  # Necesario para análisis con IA
    route:
      group_by: ['alertname']
      receiver: 'n8n-webhook'
      group_wait: 10s
      group_interval: 10s
      repeat_interval: 1h
```

### 4. Conexión Prometheus -> Alertmanager
Para evitar fallos de resolución DNS entre namespaces, usa siempre el FQDN en el ConfigMap del servidor de Prometheus:

```yaml
# prometheus-server ConfigMap
alerting:
  alertmanagers:
  - static_configs:
    - targets:
      - prometheus-alertmanager.monitoring.svc.cluster.local:9093
```

### Comandos de Mantenimiento
- **Recarga de Configuración**: `kubectl rollout restart deployment prometheus-server -n monitoring`
- **Logs de Alerta**: `kubectl logs -l app.kubernetes.io/name=alertmanager -n monitoring`
- **Estado de Alertas**: `curl http://localhost:9090/api/v1/alerts` (vía port-forward)

---

## Errores Comunes
- **`Context deadline exceeded`**: El timeout en `webhook_configs` es muy bajo. Súbelo a `2m`.
- **`Alertmanager not found`**: Verifica que el target use el nombre DNS completo si están en namespaces distintos.
- **`Rules not loading`**: Verifica la indentación del bloque YAML dentro del ConfigMap.
