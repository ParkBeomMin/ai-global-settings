---
name: doc
description: Read, create, or edit .docx documents where formatting or layout fidelity matters. Use when tasks involve Word documents with tables, diagrams, or professional formatting requirements.
---

# DOCX Skill

## When to Use

Apply this skill when dealing with `.docx` files where layout, tables, or diagrams need to be preserved, or when professional formatting is required.

## Workflow

1. **Visual Review First** — Prioritize layout inspection (tables, diagrams, pagination) using conversion tools or the bundled render script
2. **Structured Edits** — Use `python-docx` for professional formatting, styles, and content organization
3. **Iterative Validation** — Re-render and inspect pages after each meaningful modification
4. **Fallback** — Extract text via `python-docx` if visual rendering tools are unavailable
5. **Cleanup** — Remove intermediate files from `tmp/docs/` after final approval

## Dependencies

**Python packages:**
```bash
uv pip install python-docx pdf2image
# or
python3 -m pip install python-docx pdf2image
```

**System tools:**
```bash
# macOS
brew install libreoffice poppler

# Ubuntu/Debian
sudo apt-get install -y libreoffice poppler-utils
```

## Rendering for Visual Review

```bash
soffice --headless --convert-to pdf --outdir tmp/docs/ input.docx
pdftoppm -png tmp/docs/input.pdf tmp/docs/input
```

## Quality Standards

Documents must meet these criteria before delivery:
- Consistent typography, spacing, and margins
- Clear hierarchy with no formatting defects
- No clipped text or broken tables
- ASCII hyphens only (no Unicode dashes)
- All placeholder tokens eliminated

Re-render and inspect **every page at 100% zoom** before final delivery.

## File Conventions

- Intermediate files: `tmp/docs/`
- Final outputs: `output/doc/`

## Source

https://github.com/openai/skills/tree/main/skills/.curated/doc
