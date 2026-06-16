# Guía de Configuración: n8n para Diagnóstico y Auto-Remediación

Esta carpeta contiene la configuración necesaria para integrar **n8n** con Prometheus, Slack, OpenAI y **Kagent SRE Agent**.

## Contenido de la Carpeta

- [docker-compose.yml](file:///Users/pedroalejandroavila/Documents/lidr/devops/AI4Devs-cicd/n8n/docker-compose.yml): Despliega n8n localmente y monta el archivo `.kube/config` para interactuar con Kubernetes.
- [diagnostico_workflow.json](file:///Users/pedroalejandroavila/Documents/lidr/devops/AI4Devs-cicd/n8n/diagnostico_workflow.json): Definición del primer flujo (Alerta -> Kubectl Logs -> LLM -> Slack).
- [remediacion_workflow.json](file:///Users/pedroalejandroavila/Documents/lidr/devops/AI4Devs-cicd/n8n/remediacion_workflow.json): Definición del segundo flujo (Slack Click -> Kagent Run -> Slack Update).

---

## Paso 1: Levantar n8n Localmente

Para levantar n8n con soporte de comandos de `kubectl` embebidos, ejecuta en tu terminal:

```bash
docker-compose up -d
```

Esto levantará n8n en el puerto `5678`. Puedes acceder a la interfaz gráfica abriendo tu navegador en [http://localhost:5678](http://localhost:5678).

---

## Paso 2: Habilitar Acceso al Controlador de Kagent

El flujo de remediación necesita enviar peticiones HTTP al controlador de Kagent (`kagent-controller`) que gestiona los agentes en Kubernetes. Debes port-forwardear su API al puerto `8083` en tu máquina local:

```bash
kubectl port-forward svc/kagent-controller 8083:8083
```

*(Esto permitirá a n8n comunicarse con `http://127.0.0.1:8083` para disparar el agente `sre-agent` en caliente).*

---

## Paso 3: Importar los Flujos de Trabajo en n8n

1. En la interfaz web de n8n, haz clic en **Workflows** -> **Add Workflow** (o el botón "+").
2. En la esquina superior derecha, abre el menú de tres puntos (`...`) y selecciona **Import from File**.
3. Selecciona el archivo `diagnostico_workflow.json` para importar el primer flujo.
4. Repite el proceso para crear un nuevo flujo e importa `remediacion_workflow.json`.

---

## Paso 4: Configurar Credenciales

Dentro de n8n, deberás configurar las siguientes credenciales en los respectivos nodos:

### 1. OpenAI (para el nodo LLM Chain)
- **Node**: *OpenAI Chat Model*
- **Credencial**: Agrega tu **OpenAI API Key** para poder invocar al modelo `gpt-4o-mini` y realizar el análisis de logs del backend.

### 2. Slack (para enviar y actualizar mensajes)
- **Node**: *Notificar en Slack* / *Actualizar Alerta en Slack*
- **Credencial**: Crea una Slack App en tu espacio de trabajo y genera un **Bot User OAuth Token** con permisos de escritura de mensajes (`chat:write`) y adjuntos. Copia este token en n8n.
