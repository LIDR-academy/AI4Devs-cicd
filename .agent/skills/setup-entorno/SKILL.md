---
name: setup-entorno
description: Experto en configurar el entorno de desarrollo local para proyectos Kubernetes. Detecta el OS y el shell del usuario (PowerShell, CMD, Git Bash, WSL, zsh, bash) e instala docker, kubectl, kind, helm y kagent con el gestor de paquetes correcto. Incluye verificación post-instalación y troubleshooting por OS y terminal.
---

# Setup de Entorno — Kubernetes Local

## Cuándo usar esta habilidad
- Cuando el usuario quiere empezar a trabajar con Kubernetes local por primera vez.
- Cuando se reporta que alguna herramienta (`kind`, `helm`, `kagent`, etc.) no está disponible.
- Cuando hay que preparar el entorno en una máquina nueva.
- Cuando se quiere verificar que todas las herramientas están correctamente instaladas.
- Cuando hay que saber qué comandos ejecutar según el shell activo del usuario.

---

## Paso 0 — Detectar el Shell / Terminal del usuario

Antes de cualquier cosa, identifica **en qué entorno de terminal** está el usuario. Esto determina exactamente qué comandos funcionarán.

### Cómo detectarlo — pregunta al usuario o ejecuta:

```bash
echo $SHELL          # En Unix: /bin/zsh | /bin/bash | /usr/bin/fish
echo $PSVersionTable # En PowerShell: muestra la versión
echo %COMSPEC%       # En CMD: C:\Windows\System32\cmd.exe
```

### Tabla de referencia de shells

| Shell | OS habitual | Detectar | Usa comandos Unix | Notas |
|-------|-------------|----------|-------------------|-------|
| `zsh` | macOS (default desde Catalina) | `echo $SHELL` → `/bin/zsh` | ✅ | El más común en Mac actuales |
| `bash` | Linux, macOS antiguo, Git Bash | `echo $SHELL` → `/bin/bash` | ✅ | Ampliamente compatible |
| `WSL` (bash/zsh) | Windows + Linux | `uname -r` contiene `microsoft` | ✅ | Comporta como Linux |
| `Git Bash` | Windows | `echo $SHELL` → `/usr/bin/bash`, sin `uname -s = Linux` | ✅ Parcial | Falta `apt`, `systemctl`, etc. |
| `PowerShell` | Windows / macOS / Linux | `$PSVersionTable` existe | ❌ | Sintaxis diferente, usar equivalentes PS |
| `CMD` | Windows | `%COMSPEC%` existe | ❌ | Muy limitado, evitar para K8s |

---

### Qué hacer según el shell detectado

#### ✅ zsh / bash / WSL — Compatibilidad total
Todos los comandos del skill funcionan directamente. Procede con normalidad.

```bash
# Verificar herramientas
docker --version && kubectl version --client && kind version
```

#### ⚠️ Git Bash (Windows) — Compatibilidad parcial
Funciona para herramientas que tienen binarios Windows (`kubectl`, `kind`, `helm`), pero **NO** para:
- `apt`, `brew`, `systemctl`
- Scripts con `#!/bin/bash` que usen rutas de Linux sin mapeo
- `pkill`, `lsof`

**Recomendación**: instalar las herramientas vía `winget` o `choco` en PowerShell, y usarlas desde Git Bash.

```bash
# Esto SÍ funciona en Git Bash:
kubectl get pods
kind create cluster --name test
helm version

# Esto NO funciona en Git Bash:
apt install kubectl   # ❌
pkill -f kubectl      # ❌ → usar taskkill en CMD/PS
```

#### 🔵 PowerShell — Sintaxis diferente
Usa equivalentes de PowerShell para los comandos más comunes:

| Unix (bash/zsh) | PowerShell equivalente |
|-----------------|------------------------|
| `export VAR=valor` | `$env:VAR = "valor"` |
| `echo $VAR` | `Write-Host $env:VAR` |
| `pkill -f kubectl` | `Get-Process kubectl \| Stop-Process` |
| `lsof -i :8080` | `netstat -ano \| findstr :8080` |
| `curl -s http://...` | `Invoke-WebRequest -Uri http://... -UseBasicParsing` |
| `cat archivo` | `Get-Content archivo` |
| `mkdir -p dir` | `New-Item -ItemType Directory -Force dir` |
| `&` (background) | `Start-Job { ... }` |

**Instalación de herramientas en PowerShell:**
```powershell
# winget (recomendado, viene con Windows 11)
winget install Docker.DockerDesktop
winget install Kubernetes.kubectl
winget install Helm.Helm

# o chocolatey
choco install kind
choco install kubernetes-helm
```

#### 🔴 CMD — Evitar para trabajo con Kubernetes
CMD es muy limitado. Solo úsalo para **iniciar WSL2 o PowerShell**:
```cmd
wsl                  :: Abre WSL2
powershell           :: Abre PowerShell
```
Todo el trabajo real hazlo en WSL2 o PowerShell.

---

### Regla de oro por entorno

| Entorno | Recomendación |
|---------|---------------|
| macOS con zsh/bash | ✅ Usa el skill directamente |
| Linux con bash/zsh | ✅ Usa el skill directamente |
| Windows + WSL2 | ✅ Entra a WSL2 primero, luego el skill |
| Windows + Git Bash | ⚠️ Solo para kubectl/kind/helm, instala con winget/choco |
| Windows + PowerShell | ⚠️ Adapta comandos con la tabla de equivalencias de arriba |
| Windows + CMD | ❌ Abre WSL2 o PowerShell primero |

---

## Paso 1 — Detectar el Sistema Operativo

```bash
uname -s   # Darwin = macOS | Linux = Linux
uname -m   # x86_64 | arm64
```

| Resultado | OS | Gestor de paquetes |
|-----------|----|--------------------|
| `Darwin`  | macOS | `brew` |
| `Linux` + `/etc/debian_version` | Ubuntu/Debian | `apt` |
| `Linux` + `/etc/fedora-release` | Fedora/RHEL | `dnf` |
| Windows | WSL2 (Ubuntu recomendado) | `apt` dentro de WSL2 |

> **Windows**: Todo debe ejecutarse dentro de **WSL2**. Instala Docker Desktop con la integración WSL2 activada.

---

## Paso 2 — Verificar herramientas ya instaladas

Antes de instalar, verifica qué ya existe:

```bash
docker --version
kubectl version --client
kind version
helm version
kagent version
```

Si alguna falla con `command not found`, procede a instalarla.

---

## Paso 3 — Instalación por OS

### macOS (Homebrew)

```bash
# Instalar Homebrew si no existe
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Herramientas
brew install docker        # o instalar Docker Desktop desde docker.com
brew install kubectl
brew install kind
brew install helm

# kagent CLI
brew install kagent-dev/tap/kagent
```

### Ubuntu / Debian (apt)

```bash
# Docker
sudo apt-get update
sudo apt-get install -y docker.io
sudo usermod -aG docker $USER   # Evita usar sudo con docker
newgrp docker

# kubectl
curl -LO "https://dl.k8s.io/release/$(curl -sL https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl && sudo mv kubectl /usr/local/bin/

# kind
curl -Lo ./kind https://kind.sigs.k8s.io/dl/latest/kind-linux-amd64
chmod +x ./kind && sudo mv ./kind /usr/local/bin/

# helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# kagent CLI
curl -sSL https://raw.githubusercontent.com/kagent-dev/kagent/main/scripts/install.sh | bash
```

### Fedora / RHEL (dnf)

```bash
# Docker
sudo dnf -y install docker
sudo systemctl enable --now docker
sudo usermod -aG docker $USER

# kubectl, kind, helm: mismos comandos curl que Ubuntu
# kagent: mismo script de instalación
```

### Windows (WSL2)

```powershell
# En PowerShell como administrador:
wsl --install   # Instala WSL2 + Ubuntu por defecto
# Reinicia y luego dentro de WSL2 usa los comandos de Ubuntu
```
Instala **Docker Desktop** → Settings → Resources → WSL Integration → activa tu distro.

---

## Paso 4 — Verificación Post-instalación

```bash
# Verificar binarios
docker run hello-world                  # Docker funciona
kubectl version --client                # kubectl OK
kind create cluster --name test && kind delete cluster --name test  # kind OK
helm version                            # helm OK
kagent version                         # kagent CLI OK

# Verificar que Docker puede crear clusters Kind
kind get clusters
```

---

## Troubleshooting por OS

### 🍎 macOS

**`kind` no puede crear el cluster — "Cannot connect to the Docker daemon"**
```bash
open -a Docker          # Asegura que Docker Desktop está corriendo
docker info             # Verifica que el daemon responde
```

**`kagent dashboard` falla — port-forwards zombies**
```bash
pkill -f "kubectl port-forward"
kagent dashboard
```

**`brew` lento o con errores de certificado**
```bash
export HOMEBREW_NO_AUTO_UPDATE=1
brew install <herramienta>
```

---

### 🐧 Linux

**Permission denied al correr Docker**
```bash
sudo usermod -aG docker $USER
newgrp docker    # o cierra sesión y vuelve a entrar
```

**`kind` no encuentra Docker en Ubuntu con snap**
```bash
# Docker instalado via snap puede tener problemas con kind
# Usa docker.io en vez de snap:
sudo snap remove docker
sudo apt install docker.io
```

**Puerto ya en uso al hacer port-forward**
```bash
lsof -i :<puerto>       # Ver qué proceso usa el puerto
kill -9 <PID>
```

**`kubectl` no conecta al cluster Kind**
```bash
kubectl config get-contexts
kubectl config use-context kind-<nombre-cluster>
kind get kubeconfig --name <nombre-cluster> > ~/.kube/config
```

---

### 🪟 Windows (WSL2)

**"Rancher Desktop" o "Docker Desktop" no integra con WSL2**
- Docker Desktop → Settings → Resources → WSL Integration → activa la distro correcta.
- Reinicia WSL2: `wsl --shutdown && wsl`.

**`kind` crea el cluster pero `kubectl` no conecta**
```bash
# Dentro de WSL2:
kind get kubeconfig --name <cluster> > ~/.kube/config
export KUBECONFIG=~/.kube/config
```

**Rendimiento lento de I/O en WSL2**
- Coloca los archivos del proyecto dentro del filesystem de Linux (`~/proyecto`), no en `/mnt/c/...`.

---

### 🔧 Troubleshooting General (todos los OS)

**`ImagePullBackOff` en pods**
```bash
kubectl describe pod <pod> -n <namespace>   # Ver el error exacto
# Si es imagen local en Kind:
kind load docker-image <imagen>:latest --name <cluster>
# Verifica imagePullPolicy: IfNotPresent en el Deployment
```

**Pods en `CrashLoopBackOff`**
```bash
kubectl logs <pod> -n <namespace> --previous   # Logs del crash anterior
kubectl describe pod <pod> -n <namespace>       # Ver eventos
```

**Helm install falla con "ClusterRole already exists"**
```bash
# Limpiar recursos huérfanos de instalaciones anteriores:
kubectl get clusterroles,clusterrolebindings | grep <nombre> | awk '{print $1}' | xargs kubectl delete
# Reintentar:
helm upgrade --install <release> <chart> -n <namespace> --create-namespace
```

**`kagent` pods en `ContainerCreating` por mucho tiempo**
```bash
kubectl describe pod <pod> -n kagent   # Ver si está haciendo image pull
# Normal si es primera instalación — las imágenes de cr.kagent.dev son grandes
# Esperar con:
kubectl wait --for=condition=ready pod --all -n kagent --timeout=300s
```

**Port-forward muere solo**
```bash
# Ejecutar en background con logs para diagnóstico:
kubectl port-forward svc/<servicio> -n <namespace> <local>:<remoto> > /tmp/pf.log 2>&1 &
cat /tmp/pf.log   # Ver si hay errores
```

---

## 🚀 Setup Específico — Proyecto AI4Devs-cicd

Este proyecto es una aplicación full-stack compuesta por:
- **Backend**: Node.js 23 + TypeScript + Prisma ORM → puerto **8080**
- **Frontend**: Node.js 22 + React → puerto **3000**
- **Base de datos**: PostgreSQL → puerto **5432**
- **Infra local**: Kind (cluster Kubernetes) + Helm + Kagent

### Requisitos por capa

| Herramienta | Para qué | Versión mínima |
|-------------|----------|----------------|
| Docker Desktop | Construir imágenes, correr Kind | Última estable |
| `kubectl` | Interactuar con el cluster | >= 1.28 |
| `kind` | Cluster Kubernetes local | >= 0.20 |
| `helm` | Instalar kagent | >= 3.x |
| `kagent` CLI | Dashboard y agentes AI | >= 0.7 |
| Node.js | Desarrollo local (opcional si usas Docker) | >= 22 |

---

### Instalación completa por OS y shell

#### 🍎 macOS (zsh / bash)

```bash
# 1. Homebrew (si no lo tienes)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 2. Docker Desktop
brew install --cask docker
open -a Docker   # Espera a que el ícono de la barra esté listo

# 3. Herramientas de Kubernetes
brew install kubectl kind helm

# 4. kagent CLI
brew install kagent-dev/tap/kagent

# 5. Node.js (solo si quieres desarrollar sin Docker)
brew install node@22
```

#### 🐧 Linux — Ubuntu/Debian (bash / zsh en terminal nativa)

```bash
# 1. Docker
sudo apt-get update
sudo apt-get install -y docker.io
sudo usermod -aG docker $USER && newgrp docker

# 2. kubectl
curl -LO "https://dl.k8s.io/release/$(curl -sL https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl && sudo mv kubectl /usr/local/bin/

# 3. kind
curl -Lo ./kind https://kind.sigs.k8s.io/dl/latest/kind-linux-amd64
chmod +x ./kind && sudo mv ./kind /usr/local/bin/

# 4. helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# 5. kagent CLI
curl -sSL https://raw.githubusercontent.com/kagent-dev/kagent/main/scripts/install.sh | bash

# 6. Node.js v22 (via nvm — recomendado)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
source ~/.bashrc   # o ~/.zshrc
nvm install 22 && nvm use 22
```

#### 🪟 Windows + WSL2 (bash dentro de WSL)

```bash
# Primero: desde PowerShell como admin, instala WSL2
# wsl --install
# Luego abre Ubuntu y ejecuta los mismos comandos de Linux de arriba.

# Docker: instala Docker Desktop en Windows y activa WSL2 integration:
# Docker Desktop → Settings → Resources → WSL Integration → activa Ubuntu

# Verifica desde WSL que Docker funciona:
docker info
```

#### 🪟 Windows + PowerShell (sin WSL2)

```powershell
# 1. Docker Desktop
winget install Docker.DockerDesktop

# 2. kubectl
winget install Kubernetes.kubectl

# 3. kind
winget install Kubernetes.kind

# 4. helm
winget install Helm.Helm

# 5. kagent CLI — descarga el binario manualmente:
# https://github.com/kagent-dev/kagent/releases → kagent_windows_amd64.zip
# Extrae y agrega al PATH

# 6. Node.js
winget install OpenJS.NodeJS.LTS
```

#### ⚠️ Windows + Git Bash

```bash
# Las herramientas instaladas via winget/choco en PowerShell
# estarán disponibles en Git Bash si están en el PATH de Windows.

# Verifica que funcionan:
kubectl version --client
kind version
helm version
docker --version
```

> **Nota**: `kagent dashboard` puede fallar en Git Bash por el manejo de procesos en background. Usa PowerShell o WSL2 para esa parte.

---

### Clonar y preparar el proyecto

```bash
git clone <url-del-repo>
cd AI4Devs-cicd

# Copiar variables de entorno
cp .env.example .env   # Si existe, si no el .env ya viene preconfigurado
```

---

### Levantar el entorno — Dos modos

#### Modo 1: Docker Compose (más rápido para desarrollo)

```bash
docker compose up -d
# Backend → http://localhost:8080
# Frontend → http://localhost:3000
# PostgreSQL → localhost:5432
```

#### Modo 2: Kubernetes local con Kind (modo completo del proyecto)

```bash
# 1. Crear el cluster
kind create cluster --name ai4devs-cicd

# 2. Construir imágenes
docker build -t ai4devs-backend:latest ./backend
docker build -t ai4devs-frontend:latest ./frontend

# 3. Cargar en Kind
kind load docker-image ai4devs-backend:latest --name ai4devs-cicd
kind load docker-image ai4devs-frontend:latest --name ai4devs-cicd

# 4. Desplegar
kubectl apply -f k8s/db.yaml -f k8s/backend.yaml -f k8s/frontend.yaml

# 5. Esperar pods
kubectl wait --for=condition=ready pod --all --timeout=120s

# 6. Port-forward
kubectl port-forward svc/backend 8080:8080 &
kubectl port-forward svc/frontend 3000:3000 &
```

#### Modo 3: Instalar Kagent (para agentes AI sobre el cluster)

```bash
# Requiere OPENAI_API_KEY en el entorno
helm upgrade --install kagent oci://ghcr.io/kagent-dev/kagent/helm/kagent \
  -n kagent --create-namespace \
  --set providers.openai.apiKey="${OPENAI_API_KEY}"

# Esperar que todo esté listo
kubectl wait --for=condition=ready pod --all -n kagent --timeout=300s

# Abrir dashboard (configura port-forwards automáticamente)
kagent dashboard
```

---

### Verificación final del entorno

Ejecuta este checklist para confirmar que todo funciona:

```bash
# ✅ 1. Docker
docker run hello-world

# ✅ 2. Cluster
kubectl get nodes

# ✅ 3. App desplegada
curl -o /dev/null -w "%{http_code}" http://localhost:8080  # → 200
curl -o /dev/null -w "%{http_code}" http://localhost:3000  # → 200

# ✅ 4. Kagent (si instalado)
kubectl get pods -n kagent   # Todos Running
curl http://localhost:8082    # Dashboard → 200
```

---

## Convenciones

- Siempre verificar primero con `--version` antes de instalar.
- En Kind, usar `imagePullPolicy: IfNotPresent` para imágenes locales.
- Los port-forwards son temporales — documentarlos o usar `kagent dashboard` para gestionarlos.
- En equipos compartidos, preferir nombres de cluster descriptivos: `kind create cluster --name <proyecto>-<entorno>`.
- Para el proyecto AI4Devs-cicd, priorizar **Modo 2 (Kind)** sobre Docker Compose para reproducir fielmente el entorno de CI/CD.
