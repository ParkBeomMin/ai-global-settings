---
name: pdf
description: Read, create, or review PDF files where visual layout matters. Use when tasks involve PDF generation, extraction, or formatting validation.
---

# PDF Skill

## When to Use

Tasks involving reading, creating, or reviewing PDFs where visual layout matters.

## Core Workflow

1. Prefer visual review: render PDF pages to PNGs and inspect them
2. Use `reportlab` for generation, `pdfplumber`/`pypdf` for extraction
3. Re-render after updates to verify formatting

## Dependencies

**Python packages:**
```bash
uv pip install reportlab pdfplumber pypdf
# or
python3 -m pip install reportlab pdfplumber pypdf
```

**System tools:**
```bash
# macOS
brew install poppler

# Ubuntu/Debian
sudo apt-get install -y poppler-utils
```

## Rendering for Visual Review

```bash
pdftoppm -png tmp/pdfs/output.pdf tmp/pdfs/output
```

Inspect each generated PNG before delivery.

## Quality Standards

- Polished visual design: consistent typography, spacing, margins, and section hierarchy
- No rendering defects: no clipped text, overlapping elements, or broken tables
- ASCII hyphens only — no Unicode dashes or non-breaking hyphens
- Headers, footers, and page numbering must be clean and consistent

**Do not deliver until the latest PNG inspection shows zero visual or formatting defects.**

## File Conventions

- Intermediate files: `tmp/pdfs/` (delete when done)
- Final outputs: `output/pdf/`
- Keep filenames stable and descriptive

## Source

https://github.com/openai/skills/tree/main/skills/.curated/pdf
