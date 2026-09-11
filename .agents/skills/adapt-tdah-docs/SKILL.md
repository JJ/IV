---
name: adapt-tdah-docs
description: >-
  Adapts Markdown instructional documents into ADHD-friendly (TDAH-friendly) versions.
  Optimizes visual hierarchy, executive function support, action-item chunking, and readability
  while strictly preserving 100% of essential technical details, evaluation criteria, links, and requirements.
---

# Skill: Adapt Documentation for ADHD / TDAH Students

This skill provides a systematic, reproducible methodology for AI agents (Claude, Gemini, ChatGPT, etc.) to transform technical instructional documents in Markdown into versions specifically optimized for students with ADHD (TDAH - Trastorno por Déficit de Atención e Hiperactividad).

---

## 🎯 Pedagogical Principles & Accessibility Objectives

Students with ADHD face cognitive hurdles related to **executive functioning** (working memory, task initiation, prioritization, time estimation, and sustained attention). Dense, text-heavy instructional documents often lead to cognitive fatigue and accidental omission of key steps.

This skill addresses these challenges through five core principles:

1. **Zero Information Loss (Strict Requirement)**:
   - **DO NOT** delete, over-simplify, or summarize away any technical requirement, constraint, link, filename, command line, or evaluation criterion.
   - 100% of the original document's technical and academic substance MUST be retained.

2. **Executive Function Anchors (Scaffolding)**:
   - Provide an **"At a Glance / De un vistazo"** header box summarizing the goal, nature (e.g., blocking/obligatory), deliverable, and prerequisites.
   - Break down complex objectives into a clear, phased action checklist (`- [ ]`).

3. **Visual Hierarchy & Cognitive Noise Reduction**:
   - Use standardized emoji landmarks (🎯, 📋, ⚠️, 🔍, 💡, 🚀) for visual scanning.
   - Use GitHub Markdown callout blocks (`> [!IMPORTANT]`, `> [!WARNING]`, `> [!NOTE]`, `> [!TIP]`).
   - Group long theoretical explanations, motivation, or historical background into collapsible `<details><summary>...</summary></details>` blocks. This allows students to focus immediately on action items while keeping all context 100% accessible.

4. **Actionable Micro-Steps & Self-Verification**:
   - Convert long multi-sentence instructions into short, sequential micro-steps.
   - Highlight key terms, commands, paths, and verbs in **bold**.
   - Include a **Lista de Auto-comprobación (Self-Verification Checklist)** before submission.

5. **Style and Tone Consistency**:
   - Maintain Spanish language with 3rd person singular reference ("el estudiante"), consistent with repository rules.

---

## 📥 Input & Execution Protocol for Agents

This skill **always takes a single Markdown file as input** (e.g. `documentos/proyecto/1.Planificacion.md`). When invoked on a single target file, follow these 5 execution steps:

### Step 1: Read & Inventory the Single Input File
Read the specified single input file completely using `view_file`. Inventory all:
- Key objectives and sub-goals
- Mandatory rules and blocking conditions (*carácter bloqueante*)
- Technical requirements (git commands, PR URL, file formats, branch names)
- Evaluation and grading criteria
- External links and references

### Step 2: Target File Naming & Output Path
Take the path of the single input file and construct the output filename in the same directory by replacing `.md` with `-adapted.md` (e.g., `0.Repositorio.md` -> `0.Repositorio-adapted.md`).

### Step 3: Standard TDAH Structure Application

Format the output document following this exact template structure:

```markdown
# [Original Title] (Versión Adaptada TDAH)

> 🎯 **DE UN VISTAZO / AT A GLANCE**
> - **Objetivo Principal:** [Resumen de 1-2 frases del objetivo]
> - **Entregable:** [Qué entregar exactamente: p. ej., URL del Pull Request]
> - **Carácter:** ⚠️ [Bloqueante / Obligatorio / Evaluado]
> - **Prerrequisitos:** [Qué tener listo antes de empezar]

---

## 📋 Lista de Tareas Paso a Paso

### Fase 1: Preparación y Comprensión
- [ ] **Paso 1.1:** [Acción concreta]
- [ ] **Paso 1.2:** [Acción concreta]

### Fase 2: Desarrollo y Ejecución
- [ ] **Paso 2.1:** [Acción concreta]
- [ ] **Paso 2.2:** [Acción concreta]

### Fase 3: Verificación y Entrega
- [ ] **Paso 3.1:** [Acción de comprobación]
- [ ] **Paso 3.2:** [Instrucción exacta de entrega]

---

## ⚠️ Requisitos Clave y Reglas de Evaluación

> [!IMPORTANT]
> **Criterios de Evaluación y Bloqueos**
> - [Criterio 1]
> - [Criterio 2]

> [!WARNING]
> [Advertencias sobre entregas incorrectas, plazos o faltas graves]

---

## 🔍 Lista de Auto-comprobación (Antes de Entregar)
- [ ] ¿He comprobado X?
- [ ] ¿He generado Y?
- [ ] ¿He enviado el enlace correcto (URL del PR, no de la rama)?

---

## 💡 Contexto, Teoría y Explicación Detallada
<details>
<summary>📖 Haz clic aquí para desplegar la motivación, teoría y contexto completo del objetivo</summary>

[Inserte aquí todo el texto motivacional, teórico y explicativo original íntegro, sin recortar ni sintetizar]

</details>
```

### Step 4: Formatting Rules
1. **Bold Key Terms**: Apply **bold** formatting to action verbs, filenames, URLs, git commands, and parameters.
2. **Chunk Dense Paragraphs**: Break paragraphs exceeding 3 sentences into bullet points.
3. **Callout Mapping**:
   - Mandatory / Blocking rules -> `> [!IMPORTANT]` or `> [!WARNING]`
   - Tips / Recommendations -> `> [!TIP]`
   - Context / Clarifications -> `> [!NOTE]`
4. **Preserve All Links**: Ensure all links `[texto](url)` remain functional and unaltered.

### Step 5: QA Integrity Check
Perform a completeness check comparing the `-adapted.md` document with the original input file:
1. Did I keep all links and URLs? (Yes / No)
2. Are all evaluation criteria included? (Yes / No)
3. Are all technical commands and file path constraints preserved? (Yes / No)
4. Is the tone consistently 3rd person singular ("el estudiante")? (Yes / No)

---

## 🤖 Cross-Agent Compatibility Guide

### Claude (Anthropic / Claude Code / Antigravity)
- Claude natively supports Markdown artifacts and standard `SKILL.md` files located in `.agents/skills/` or `.claude/skills/`.
- Claude should execute the step-by-step inventory first to ensure zero content omission.

### Gemini (Google Antigravity / Gemini CLI)
- Gemini works smoothly with hierarchical callouts and collapsible HTML `<details>` elements.
- When generating output via Gemini, verify that `<details>` tags close properly and callouts render cleanly.

### Generic System Prompt / LLM Usage (ChatGPT, Custom Instructions, API)
To invoke this skill with any standard LLM on a single input file:

```text
SYSTEM PROMPT:
You are an expert instructional designer specializing in neurodiversity (ADHD/TDAH) and computer science education.
Task: Adapt the single input Markdown document ([INPUT_FILE]) into an ADHD-friendly version according to the adapt-tdah-docs skill rules:
1. READ [INPUT_FILE] completely. PRESERVE 100% of all technical details, commands, links, rules, and evaluation criteria. Do not delete any information.
2. ADD a top "De un vistazo" summary box, phased task checklists (- [ ]), callouts (> [!IMPORTANT]), a self-verification section, and place long theoretical background inside a <details><summary> collapsible section.
3. MAINTAIN Spanish language in 3rd person singular ("el estudiante").
4. WRITE the adapted document to [INPUT_FILE_BASENAME]-adapted.md.
```

---

## 📝 Concrete Transformation Example

### Original Text:
> Es imprescindible que el estudiante lea este documento desde el principio al final. El realizar correctamente este primer objetivo, y hacerlo a tiempo, le permitirá continuar en la asignatura con más fluidez. Este objetivo es bloqueante, si el estudiante no lo supera equivale a un no apto en la convocatoria correspondiente.

### Adapted TDAH Text:
> 🎯 **DE UN VISTAZO**
> - **Carácter:** ⚠️ **BLOQUEANTE** (No superarlo equivale a **No Apto** en la convocatoria ordinaria).
> - **Acción requerida:** Leer detenidamente la especificación completa antes de iniciar el trabajo.
>
> > [!WARNING]
> > **Carácter Bloqueante del Objetivo**:
> > La entrega y superación de este objetivo dentro del plazo establecido es un requisito indispensable. La no superación conlleva la calificación de **No Apto** en la convocatoria ordinaria.
