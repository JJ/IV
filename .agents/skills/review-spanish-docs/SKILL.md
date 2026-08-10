---
name: review-spanish-docs
description: >-
  Use this skill to review markdown or text documents in this repository for contradictions, iterations, logic gaps, and awkward Spanish grammar constructions.
---

# Review Spanish Documentation

This skill guides the agent in reviewing Spanish documentation for quality, consistency, and clarity.

## Steps

1. **Read the File:** Use the `view_file` tool to read the contents of the target document.
2. **Grammar and Phrasing Analysis:**
   - Look for awkward Spanish phrasing, typos, or misused words (e.g., using "cómo" instead of "como", missing tildes, repeated prepositions).
   - Check for tone consistency. The established tone for the documentation is **3rd person singular ("el estudiante")**. Flag any use of 2nd person (tú, vosotros).
3. **Logic and Structure Analysis:**
   - **Contradictions:** Check if the document contradicts itself (e.g., stating a requirement is blocking but later saying the student can proceed if they fail).
   - **Logic Gaps:** Ensure instructions are complete and logically sound (e.g., delivering a PR URL makes sense, delivering a branch URL and calling it a PR does not).
   - **Repetition/Iterations:** Identify overly repetitive caveats or rules and suggest consolidating them into a single, emphasized block.
4. **Report and Fix:**
   - Present the findings to the user.
   - If the user agrees, use the `multi_replace_file_content` tool to apply the fixes directly to the file, ensuring the tone and logic decisions are upheld.
