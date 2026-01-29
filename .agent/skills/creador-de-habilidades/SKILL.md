---
nombre: creando-habilidades
descripción: Genera directorios de habilidades (.agent/skills/) de alta calidad, siguiendo estándares específicos de estructura, YAML frontmatter y principios de escritura concisa.
---

# Creador de Habilidades

## Cuándo usar esta habilidad
- Cuando el usuario solicita la creación de una nueva "skill" o "habilidad" para Antigravity.
- Cuando se necesita estandarizar o mejorar la documentación de una habilidad existente.

## Flujo de trabajo
1. **Planificar**: [ ] Entender las necesidades del usuario y definir el alcance de la habilidad.
2. **Estructurar**: [ ] Crear la jerarquía de carpetas: `<nombre-de-habilidad>/`, `SKILL.md`, `scripts/`, `examples/`, `resources/`.
3. **Redactar**: [ ] Escribir el `SKILL.md` siguiendo los principios de concisión y divulgación progresiva.
4. **Validar**: [ ] Verificar que el frontmatter YAML sea correcto y que las rutas usen `/`.
5. **Ejecutar**: [ ] Finalizar la creación de archivos y scripts de apoyo.

## Instrucciones

### Estándares de Estructura
- `SKILL.md` es obligatorio y contiene la lógica principal.
- `scripts/`, `examples/` y `resources/` son opcionales pero recomendados para tareas complejas.

### Frontmatter YAML
- **nombre**: Gerundio (p. ej., `analizando-codigo`). < 64 caracteres. Minúsculas, números y guiones. Sin "claude" o "anthropic".
- **descripción**: Tercera persona. < 1024 caracteres. Incluir disparadores.

### Principios de Escritura
- **Concisión**: No expliques conceptos básicos. Enfócate en la lógica única.
- **Divulgación Progresiva**: `SKILL.md` < 500 líneas. Usa enlaces a archivos secundarios si es necesario.
- **Grados de Libertad**:
  - Viñetas: Heurísticas (alta libertad).
  - Bloques de código: Plantillas (libertad media).
  - Comandos Bash: Operaciones frágiles (baja libertad).

### Gestión de Errores y Calidad
- Incluir patrones "Planificar-Validar-Ejecutar".
- Los scripts deben ser "cajas negras" (indicar uso de `--help`).

## Recursos
- [Referencia de Estructura](file:///Users/pedroalejandroavila/Documents/lidr/devops/AI4Devs-cicd/.agent/skills/creador-de-habilidades/)
- [Plantilla SKILL.md](file:///Users/pedroalejandroavila/Documents/lidr/devops/AI4Devs-cicd/.agent/skills/creador-de-habilidades/resources/template.md)

---
