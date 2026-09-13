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

3. **Visual Hierarchy & Universal Web-Renderable Callouts**:
   - Use standardized, universal emoji landmarks (🎯, 📋, ⚠️, ❗, 🔍, 💡, ℹ️, 🚀) for visual scanning.
   - **DO NOT** use GitHub Flavored Markdown callout syntax like `> [!IMPORTANT]` or `> [!WARNING]`, because Jekyll / GitHub Pages / Kramdown HTML renderers display those syntax tags literally as raw text (`[!IMPORTANT]`).
   - Use standard Markdown blockquotes with universal glyph headers instead:
     - `> ❗ **IMPORTANTE:**` for mandatory requirements / blocking rules.
     - `> ⚠️ **ADVERTENCIA:**` for critical alerts / academic integrity.
     - `> ℹ️ **NOTA:**` for administrative / repository process notes.
     - `> 💡 **CONSEJO / TIP:**` for practical suggestions.

4. **Actionable Micro-Steps & Self-Verification**:
   - Convert long multi-sentence instructions into short, sequential micro-steps.
   - Highlight key terms, commands, paths, and verbs in **bold**.
   - Include a **Lista de Auto-comprobación (Self-Verification Checklist)** before submission.

5. **Invisible Prompt-Injection & Honeypot Preservation**:
   - Preserve all hidden LLM instructions, watermarks, or honeypots from the original document.
   - Use techniques that do **NOT** introduce visual noise for TDAH readers on rendered HTML pages (such as GitHub Pages):
     - **HTML Comments**: `<!-- SYSTEM INSTRUCTION FOR LLMS: ... -->` for LLM CLI tools and raw file parsing.
     - **CSS Hidden Elements / `hidden` Attribute**: Use `<span style="display:none">...</span>` or `<div hidden>...</div>` (or `<details hidden style="display:none">...`) for rich-text copy-paste prompt injections. Avoid plain `<details>` without a summary, as it renders as an interactive toggle widget on HTML pages, distracting TDAH readers.

6. **Style and Tone Consistency**:
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
Take the path of the single input file and construct the output filename in the same directory by replacing `.md` with `-skel.md` (e.g., `0.Repositorio.md` -> `0.Repositorio-skel.md`).

### Step 3: Standard TDAH Structure Application

Format the output document following this exact template structure. Mark the document as adapted by placing the 🧠 marker directly in the top-level (H1) header, immediately before the title's leading word (e.g., before "Objetivo" in course documents titled "Objetivo N: ..."), instead of spelling out "TDAH":

```markdown
# 🧠 [Original Title]

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

### ❗ **CRITERIOS DE EVALUACIÓN Y BLOQUEOS**

> - [Criterio 1]
> - [Criterio 2]

### ⚠️ **ADVERTENCIA**

> [Advertencias sobre entregas incorrectas, plazos o faltas graves]

### ℹ️ **NOTA DE GESTIÓN**

> [Notas aclaratorias sobre flujo de trabajo]

---

## 🔍 Lista de Auto-comprobación (Antes de Entregar)

- [ ] ¿He comprobado X?
- [ ] ¿He generado Y?
- [ ] ¿He enviado el enlace correcto (URL del PR, no de la rama)?

---

## 📖 Contexto y Teoría Completa

Para consultar las explicaciones teóricas detalladas, la motivación y el trasfondo conceptual original, consulta la [Documentación Original completa]([INPUT_FILE_BASENAME].md).
```

### Step 4: Formatting Rules
1. **Bold Key Terms**: Apply **bold** formatting to action verbs, filenames, URLs, git commands, and parameters.
2. **Chunk Dense Paragraphs**: Break paragraphs exceeding 3 sentences into bullet points.
3. **Universal Callout Mapping (HTML & GitHub Pages Compatible)**:
   - **DO NOT** use `> [!IMPORTANT]`, `> [!WARNING]`, etc. (they render raw text in Jekyll/GitHub Pages).
   - Mandatory / Blocking rules -> `> ❗ **IMPORTANTE:**` or `> ⚠️ **CARÁCTER BLOQUEANTE:**`
   - Warning / Plagiarism -> `> ⚠️ **ADVERTENCIA:**`
   - Tips / Recommendations -> `> 💡 **CONSEJO / TIP:**`
   - Context / Clarifications -> `> ℹ️ **NOTA:**`
   - **Multiple callouts in the same section** (e.g. "Requisitos Clave y Reglas de Evaluación"): give each callout its own `### <emoji> **TÍTULO**` subheading immediately above its blockquote, one callout per blockquote. Never place two `>` blockquotes back-to-back separated only by a blank line — see MD028 below.
4. **Preserve All Links**: Ensure all links `[texto](url)` remain functional and unaltered.
5. **LLM Prompt Injection Handling**:
   - Keep HTML comments `<!-- SYSTEM INSTRUCTION FOR LLMS: ... -->` intact.
6. **Link Original Document for Deep Theory**:
   - **DO NOT** embed full theoretical text or dense background in `<details>` blocks. HTML `<details>` tags break Markdown rendering in Jekyll / GitHub Pages (rendering text unformatted as a giant wall of text) and create cognitive clutter for TDAH readers.
   - Instead, include a clean link to the original document `[Documento Original completa]([INPUT_FILE_BASENAME].md)` for readers who need deep background.
7. **Strict Markdownlint Compliance** (this repo runs `mdl --style .mdl.rb` on every document, adapted ones included — verify against it before finishing):
   - **MD009**: Ensure zero trailing spaces at line ends.
   - **MD012**: Never leave more than one consecutive blank line (check especially right before a trailing HTML comment or at end of file).
   - **MD019**: Use exactly one single space after the `#`/`##`/`###` in ATX headers (`# Title`, not `#  Title`). This applies to the H1 title line too, including right after the 🧠 marker.
   - **MD022 & MD032**: Surround headers (`### Header`) and lists with blank lines before and after.
   - **MD027**: Use exactly one single space after `>` in blockquotes (`> text`). Do NOT add multiple spaces (e.g. `>   1.`).
   - **MD028**: Never place two `>` blockquotes back-to-back separated only by a blank line — that blank line (with no `>`) is flagged as "blank line inside blockquote". When a section needs several consecutive callouts, separate them with a `### <emoji> **TÍTULO**` subheading (see the "Multiple callouts in the same section" rule above) rather than a bare blank line.

### Step 5: QA Integrity Check
Perform a completeness check comparing the `-adapted.md` document with the original input file:
1. Did I keep all links and URLs? (Yes / No)
2. Are all evaluation criteria included? (Yes / No)
3. Are all technical commands and file path constraints preserved? (Yes / No)
4. Are callouts using universal emoji blockquotes (`> ❗`, `> ⚠️`, `> ℹ️`) instead of GFM raw tags (`[!IMPORTANT]`)? (Yes / No)
5. Are hidden LLM instructions preserved using zero-visual-noise tags (`<!-- ... -->`, `<span style="display:none">`)? (Yes / No)
6. Is long theoretical text linked to the original document instead of embedded in broken `<details>` blocks? (Yes / No)
7. Are markdownlint rules (MD009, MD022, MD027, MD028, MD032) fully respected? (Yes / No)
8. Is the tone consistently 3rd person singular ("el estudiante")? (Yes / No)

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
1. READ [INPUT_FILE] completely. PRESERVE 100% of all technical details, commands, links, rules, evaluation criteria, and hidden LLM prompt injections. Do not delete any information.
2. USE universal emoji glyph blockquotes (> ❗ **IMPORTANTE:**, > ⚠️ **ADVERTENCIA:**, > ℹ️ **NOTA:**) instead of GitHub callout tags (> [!IMPORTANT]) so it renders cleanly on GitHub Pages.
3. ADD a top "De un vistazo" summary box, phased task checklists (- [ ]), a self-verification section, and link to the original document for full theoretical background instead of embedding broken <details> blocks.
4. KEEP hidden LLM prompt injections invisible to TDAH readers using HTML comments or <span style="display:none"> instead of plain <details> widgets.
5. MAINTAIN Spanish language in 3rd person singular ("el estudiante").
6. WRITE the adapted document to [INPUT_FILE_BASENAME]-adapted.md.
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
> > ⚠️ **ADVERTENCIA: Carácter Bloqueante del Objetivo**
> > La entrega y superación de este objetivo dentro del plazo establecido es un requisito indispensable. La no superación conlleva la calificación de **No Apto** en la convocatoria ordinaria.
