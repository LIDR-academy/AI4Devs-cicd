---
nombre: desplegando-k8s-local
descripción: Experto en despliegue de aplicaciones en clusters de Kubernetes locales (Kind, Minikube). Gestiona la creación de clusters, construcción de imágenes y despliegue de recursos.
---

# Desplegando en Kubernetes Local

## Cuándo usar esta habilidad
- Cuando necesites desplegar una aplicación en un entorno de Kubernetes local para desarrollo o pruebas.
- Cuando utilices herramientas como Kind, Minikube, MicroK8s o Docker Desktop.

## Flujo de Trabajo

### 1. Pre-vuelo (Preparación)
- [ ] Verificar herramientas instaladas: `kubectl`, `docker` y el proveedor de cluster (`kind`, `minikube`).
- [ ] Verificar si existe un cluster activo: `kubectl cluster-info`.

### 2. Infraestructura Local
- [ ] Si no hay cluster, crear uno (priorizando Kind): `kind create cluster --name local-dev`.
- [ ] Configurar el contexto de `kubectl` al cluster local.

### 3. Empaquetado y Carga
- [ ] Construir la imagen Docker de la aplicación.
- [ ] **Importante para Kind**: Cargar la imagen en el cluster: `kind load docker-image <imagen>:<tag> --name local-dev`.

### 4. Despliegue
- [ ] Aplicar manifiestos: `kubectl apply -f k8s/`.
- [ ] Verificar estado: `kubectl get pods -w`.
- [ ] Probar acceso: `kubectl port-forward <pod-name> 8080:80`.

## Heurísticas y Solución de Problemas
- **ImagePullBackOff**: Asegúrate de que `imagePullPolicy: IfNotPresent` esté configurado en el Deployment si estás cargando imágenes localmente en Kind.
- **Contexto incorrecto**: Siempre verifica `kubectl config current-context` antes de aplicar cambios.
- **PersistentVolumes**: En entornos locales, usa `Standard` storage class o verifica la disponibilidad de aprovisionadores locales.

## Recursos Disponibles
- [Plantilla de Deployment](file:///Users/pedroalejandroavila/Documents/lidr/devops/AI4Devs-cicd/.agent/skills/desplegando-k8s-local/resources/deployment.yaml)
- [Script Setup Kind](file:///Users/pedroalejandroavila/Documents/lidr/devops/AI4Devs-cicd/.agent/skills/desplegando-k8s-local/scripts/setup-kind.sh)

---
