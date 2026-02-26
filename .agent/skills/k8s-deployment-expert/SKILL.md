---
name: k8s-deployment-expert
description: Expert in configuring and generating Kubernetes deployment manifests for the application components (backend, frontend, database).
---

# Kubernetes Deployment Expert Skill

I help the user configure, generate, and optimize Kubernetes manifests for their application components.

## When to use this skill
- When the user asks: "How do I deploy this to Kubernetes?"
- When there's a need to generate `Deployment`, `Service`, `StatefulSet`, or `Ingress` manifests.
- When configuring environment variables, secrets, or resource limits for a K8s deployment.

## How to use it

### 1. Analyze Components
Identify the ports, environment variables, and storage requirements for each component:
- **Backend (Node.js)**: Port 8080, requires DB connection string.
- **Frontend (Node.js/React)**: Port 3000.
- **Database (Postgres)**: Requires persistent storage (PVC) and secrets for credentials.

### 2. Generate Manifests
Use the templates in `resources/templates/` as a base. Ensure the following:
- **Labels**: Use consistent labels like `app: <component-name>`.
- **Health Checks**: Include `livenessProbe` and `readinessProbe`.
- **Resources**: Set reasonable `requests` and `limits`.
- **Ingress**: Configure rules to route traffic to the frontend and backend.

### 3. Apply Configuration
Provide instructions for applying the manifests using `kubectl`:
```bash
kubectl apply -f k8s/
```

## Conventions
- Use `k8s/` directory for generated manifests.
- Use `Secrets` for sensitive information (don't hardcode passwords).
- Prefer `StatefulSet` for the database to ensure stable network identifiers and persistent storage.
