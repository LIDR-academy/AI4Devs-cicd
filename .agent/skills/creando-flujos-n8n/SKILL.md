---
nombre: creando-flujos-n8n
descripción: Experto en diseño y creación de workflows de n8n, con especialización en el uso de nodos de código y expresiones complejas.
---

# Creando Flujos n8n

## Cuándo usar esta habilidad
- Cuando el usuario pida ayuda para crear, optimizar o depurar un workflow de n8n.
- Cuando se requiera lógica personalizada compleja que no se pueda resolver con nodos estándar (uso de nodo `Code`).
- Para generar JSONs de workflows listos para importar.

## Flujo de trabajo
1. **Diseñar**: [ ] Definir el disparador (Trigger) y el objetivo del flujo.
2. **Estructurar**: [ ] Seleccionar los nodos necesarios. Si la lógica es compleja, usar el nodo `Code`.
3. **Implementar Código**: [ ] Si se usa el nodo `Code`, escribir JavaScript (o Python) eficiente para manipular la estructura de datos `items`.
4. **Generar JSON**: [ ] Entregar el resultado final como un bloque de código JSON que el usuario pueda copiar y pegar directamente en n8n (Ctrl+V).

## Instrucciones

### Uso del Nodo Code
El nodo `Code` es potente para manipulaciones de datos.
- **Estructura de Datos**: n8n procesa arrays de objetos. Cada objeto tiene una propiedad `json` (datos) y opcionalmente `binary`.
- **Iteración**:
  ```javascript
  // Ejemplo JS para nodo Code
  for (const item of $input.all()) {
    item.json.nuevoCampo = 'valor calculado';
  }
  return $input.all();
  ```
- **Acceso a Nodos Anteriores**: Usa `$('NombreNodo').first().json.campo` para referencias estáticas o itera si necesitas correlación.

### Expresiones
Usa expresiones `{{ ... }}` en los parámetros de los nodos para valores dinámicos.
- Ejemplo: `{{ $json.body.email }}` para acceder a un campo del nodo anterior.

### Compartir Workflows
Para entregar un workflow al usuario:
1. Genera un JSON válido con la estructura `{"nodes": [], "connections": {}}`.
2. Indica al usuario que copie el JSON y lo pegue directamente en el lienzo de n8n.

## Recursos
- [Plantilla Básica JSON](file:///Users/pedroalejandroavila/Documents/lidr/devops/AI4Devs-cicd/.agent/skills/creando-flujos-n8n/resources/workflow-template.json)
