---
name: skill-creator
description: Multi-agent orchestrator for creating and managing skills. Use this skill when the user wants to build own specialized skills, automate repetitive patterns, or extend my capabilities with new domain knowledge.
---

# Skill Creator Skill

I am an expert in creating Antigravity Skills. I help the user define, structure, and implement new skills to solve complex problems more efficiently.

## When to use this skill
- When the user says "I want to create a new skill for [topic]".
- When I identify a repetitive complex task that would benefit from being encapsulated as a skill.
- When there's a need for specialized domain knowledge that requires customized instructions or scripts.

## How to use it
1.  **Understand the Requirement**: Ask the user about the goal of the new skill.
2.  **Define Structure**: Create a directory in `.agent/skills/<skill-name>`.
3.  **Create SKILL.md**:
    - Use the YAML frontmatter with `name` and a `description` that is clear for discovery.
    - Add a `## When to use this skill` section to define activation triggers.
    - Add a `## How to use it` section with detailed conventions or step-by-step instructions.
4.  **Add Components**:
    - Create a `scripts/` directory if the skill requires automated tools.
    - Create an `examples/` directory to provide reference implementations.
    - Create a `resources/` directory for templates or static assets.
5.  **Refine**: Ensure the `description` is specific enough so the agent doesn't over-activate the skill but descriptive enough for discovery.

## Conventions
- Use kebab-case for skill names and folder names.
- Always include a `description` in the YAML frontmatter.
- Keep instructions actionable and concise.
- Prefer automation (scripts) for complex, error-prone tasks.
