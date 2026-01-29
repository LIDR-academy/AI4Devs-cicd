---
description: despliegue local en kubernetes con verificación de navegador
---

# Workflow: Despliegue y Verificación en Kubernetes Local

Este workflow guía el proceso de entender una aplicación, desplegarla en un cluster Kind local y verificar su funcionamiento usando el navegador.

## Pasos

### 1. Exploración y Comprensión
- Usa `ls -R` y `find` para identificar la estructura del proyecto.
- Busca archivos clave: `Dockerfile`, `docker-compose.yml`, `package.json`, `requirements.txt`, o carpetas de manifiestos `k8s/`, `kubernetes/`.
- Lee el `Dockerfile` para identificar el puerto expuesto y el comando de inicio.

### 2. Preparación de Infraestructura
- Identifica el nombre de la aplicación (usualmente el nombre de la carpeta raíz).
- Usa la habilidad `desplegando-k8s-local` para crear un cluster Kind con el nombre de la aplicación:
  ```bash
  kind create cluster --name <nombre-app>
  ```

### 3. Construcción y Carga de Imagen
- Construye la imagen Docker localmente:
  ```bash
  docker build -t <nombre-app>:latest .
  ```
- Carga la imagen en el cluster Kind:
  ```bash
  kind load docker-image <nombre-app>:latest --name <nombre-app>
  ```

### 4. Generación y Aplicación de Manifiestos
- Si no existen manifiestos, genera uno básico usando la plantilla de la habilidad `desplegando-k8s-local` en `resources/deployment.yaml`.
- Asegúrate de que `imagePullPolicy` sea `IfNotPresent`.
- Aplica los manifiestos:
  ```bash
  kubectl apply -f <ruta-a-manifiestos>
  ```

### 5. Exposición y Verificación del Navegador
- Espera a que los pods estén listos: `kubectl wait --for=condition=ready pod -l app=<nombre-app> --timeout=60s`.
- Ejecuta `kubectl port-forward` en segundo plano (usando `run_command` con `WaitMsBeforeAsync` bajo):
  ```bash
  kubectl port-forward svc/<nombre-servicio> 8080:<puerto-app>
  ```
- Usa el `browser_subagent` para navegar a `http://localhost:8080`.
- Verifica que el contenido de la página coincida con lo esperado de la aplicación.

### 6. Limpieza (Opcional)
- Si la verificación es exitosa, puedes preguntar al usuario si desea mantener el cluster o eliminarlo:
  ```bash
  kind delete cluster --name <nombre-app>
  ```
