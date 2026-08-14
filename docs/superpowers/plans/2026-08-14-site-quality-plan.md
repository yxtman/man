# Site Quality Improvements Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Improve accessibility, performance, SEO consistency, and static regression checks for the Man United static site.

**Architecture:** Keep the existing multi-page HTML/CSS/JS architecture. Add behavior in the shared script, metadata/attributes in each page, and a standalone PowerShell checker under `tests/`.

**Tech Stack:** HTML, CSS, vanilla JavaScript, PowerShell.

---

### Task 1: Accessible mobile navigation

**Files:** `js/main.js`, `css/style.css`, all content-page HTML files.

- [x] Add `aria-controls`, `aria-current`, Escape handling, outside-click closing, and body scroll locking.
- [x] Run `node --check js/main.js`.

### Task 2: SEO and image metadata

**Files:** all content-page HTML files.

- [x] Add `og:url`, `og:description`, `og:locale`, and `twitter:card`.
- [x] Add image loading/decoding attributes and intrinsic dimensions.

### Task 3: Static regression checker

**Files:** `tests/check-site.ps1`.

- [x] Check required metadata, navigation attributes, and image loading attributes.
- [x] Run the checker and confirm all HTML pages pass.

### Task 4: Final verification

- [x] Run `git diff --check`.
- [x] Review changed files with `git status --short` and `git diff --stat`.
