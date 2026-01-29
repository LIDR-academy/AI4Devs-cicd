---
nombre: configurando-prometheus
descripción: Guía para desplegar Prometheus usando Kagent y configurar reglas de alerta personalizadas.
---

# Configurando Prometheus y Alertas

## Cuándo usar esta habilidad
- Cuando necesites instalar un stack de monitoreo (Prometheus) en el cluster.
- Cuando quieras agregar reglas de alerta personalizadas (ej. `InstanceDown`).
- Para entender cómo gestionar configuraciones de Prometheus desplegado vía Helm.

## Flujo de trabajo
1. **Instalar**: [ ] Usar `kagent` para desplegar el chart de Prometheus.
2. **Acceder**: [ ] Verificar instalación y establecer acceso local.
3. **Alertar**: [ ] Inyectar reglas de alerta modificando el ConfigMap.

## Instrucciones

### 1. Instalación con Kagent
Usa el `helm-agent` para instalar el chart de la comunidad.

```bash
kagent invoke --agent "helm-agent" --namespace "kagent" --task "Add prometheus-community repo and install prometheus in monitoring namespace"
```

*Confirma la creación del namespace si el agente lo pregunta.*

### 2. Acceso y Verificación
Una vez instalados los pods (verifica con `kubectl get pods -n monitoring`), habilita el acceso:

```bash
kubectl port-forward svc/prometheus-server -n monitoring 9090:80
```
Accede a: `http://localhost:9090`

### 3. Configuración de Alertas
La forma más robusta de agregar reglas es editar directamente el ConfigMap `prometheus-server`, ya que pasar configuraciones complejas por CLI a veces falla.

#### Paso 3.1: Crear archivo de parche
Crea un archivo YAML (ej. `alerts.yaml`) con tus reglas dentro de `data.alerting_rules.yml`:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: prometheus-server
  namespace: monitoring
data:
  alerting_rules.yml: |
    groups:
    - name: CustomAlerts
      rules:
      - alert: InstanceDown
        expr: up == 0
        for: 1m
        labels:
          severity: page
        annotations:
          summary: 'Instance {{ $labels.instance }} down'
```
*(Puedes usar la plantilla en `resources/alerts-patch-template.yaml`)*

#### Paso 3.2: Aplicar el parche
```bash
kubectl patch cm prometheus-server -n monitoring --patch-file alerts.yaml
```

#### Paso 3.3: Recargar configuración
Reinicia el servidor para aplicar los cambios:
```bash
kubectl rollout restart deployment/prometheus-server -n monitoring
```
Verifica en `http://localhost:9090/alerts`.
