# PIPELINE.md — how this knowledge base is built

This file is the way-of-working. A fresh Claude Code session on any machine can
continue the project from this document alone (plus the repo contents).

## The stages, per book

1. **Get the text.** EPUBs are zip files: extract, find the OPF spine and
   NCX/nav TOC under `source/<book>/`. MOBI/AZW3 need conversion to EPUB first
   (Calibre, or convert on another machine). `source/` is gitignored
   (copyrighted book text) — on a new machine you need the EPUBs locally only
   to process NEW books; everything already processed lives in `notes/`.
2. **Split into chapters** at the author's own boundaries → plain-text files
   `source/<book>/chapters/NN-slug.txt`. Clean EPUBs: usually one xhtml per
   chapter (see the Simulation Hypothesis case). OCR scans: split on chapter
   title lines, strip running headers/page numbers, re-join hyphen-broken
   paragraphs (see `_build/split-hu.ps1` for the worked example).
3. **Chapter notes** — one subagent per chapter, **effort: high**, all in
   parallel. Each reads its ENTIRE chapter file and writes
   `notes/<book>/NN-slug.md`. Template below.
4. **Verification** — one adversarial subagent per chapter, **effort: high**,
   in parallel. Re-reads the full source, audits the note entry by entry
   (fabrications, conflated examples, wrong numbers, knowledge leakage =
   real-world facts not stated in the chapter), fixes the note in place with
   Edit, adds missing substantive material, reports verdict
   CLEAN / MINOR FIXES / MAJOR PROBLEMS.
5. **Synthesis** — three subagents, **effort: xhigh**, reading ALL verified
   notes of the book: `00-map.md` (thesis, argument arc, chapter index,
   evidentiary strategy, critical-reading section), `90-glossary.md` (merged
   deduplicated concept glossary + people index, chapter pointers),
   `91-qa.md` (50-70 Q&A pairs, every answer with chapter pointers).
6. **Builds + publish**: `_build/build-libros.ps1` (site → libros.html +
   index.html), `_build/build-agent-kit.ps1` (agent-kit/ refresh), then
   commit + push. GitHub Pages auto-redeploys https://sscleves.github.io/TheMindBook/
   from main within ~1 minute.

## Rules that matter (learned, don't relax them)

- Notes use ONLY the chapter text — no outside knowledge, even correct outside
  knowledge. Claims stay attributed ("Talbot reports…"), never endorsed.
- The examples section is the heart: EVERY experiment/case/anecdote, with
  names, years, institutions, numbers, outcomes. Summaries that drop examples
  are the failure mode this project exists to avoid.
- Frontmatter `concepts:` (kebab-case) and `people:` lists power the glossary,
  site chips, and future flashcards — never omit them.
- If the source is OCR: fix obvious OCR typos when quoting; FLAG (inline in
  the note) unrecoverable garbles and lacunae instead of guessing.
- Faithful-to-source beats true-to-world: if the book says something
  historically wrong, the note records what the book says.
- Model: Fable-class for everything that touches book text. Effort: high for
  notes + verification, xhigh for synthesis (set per-agent, not session).

## Chapter-note template (stage 3)

```
---
book: <book-id>
chapter: <N>
title: "<Title>"
part: "<part if any>"
concepts: [kebab-case, every named concept]
people: [every person discussed]
---
# Ch <N> — <Title>
## In one paragraph        (4-6 sentences)
## Core claims             (bullets, attributed, claims-as-claims)
## Concepts                (**concept** — the book's own definition, 1-3 sentences)
## Experiments, examples & case studies   (EVERY one; who/what, year,
                            institution, specifics, numbers, outcome, what the
                            author says it shows)
## Key quotes              (5-12 short verbatim, one line of context each)
## Thread                  (role in the book's argument)
## Connections             (other chapters; cross-book links clearly marked speculative)
```

For non-argument books adapt the skeleton, keep the philosophy:
FAQ/appendix → one entry per question; fiction (Sekret Machines) → synopsis,
characters, themes, claimed-real elements; practice books (Power of Now) →
practices/exercises as the "examples" section.

## Verification prompt (stage 4), in brief

Ground truth = chapter txt, read entirely. Check every claim, definition,
example (names/years/numbers/outcomes), quote (verbatim modulo OCR fixes).
Hunt specifically: fabrications, conflations, wrong attribution, invented
numbers, knowledge leakage. Fix in place (smallest edit), add missing
substantive items in matching style, delete untraceable ones. Report counts +
verdict.

## NEXT SESSION — start here (Opus, effort HIGH everywhere, xhigh retired for cost)

Decision 2026-07-22: remaining work runs on Opus at effort high — including
synthesis (no more xhigh). The templates in this file are the quality carrier;
the verification stage backstops the model change.

Remaining for simulation-hypothesis (notes verified, in repo):
1. Synthesis: 3 agents at HIGH over notes/simulation-hypothesis/ → 00-map.md,
   90-glossary.md, 91-qa.md (same specs as stage 5 above; book id
   simulation-hypothesis, author Rizwan Virk, 2nd ed).
2. `_build/build-libros.ps1`, `_build/build-agent-kit.ps1` (add 'sh' prefix to
   $bookPrefix in build-agent-kit.ps1), commit, push (Pages auto-deploys).
Then next books in order (stages 1-6 per book): my-big-toe (trilogy — treat
each sub-book's parts as chapters), power-of-now (practice template),
american-cosmic, zen-motorcycle, dark-psychology, sekret-machines-war
(fiction template). EPUBs: C:\Libros Mente\ (this machine only).

## Status board

| Book | Split | Notes | Verified | Synthesis | In site/kit |
|---|---|---|---|---|---|
| holographic-universe | done (OCR path) | 10/10 (397 examples) | 10/10, zero major | map+glossary(207c/332p)+qa(70) | yes |
| simulation-hypothesis | done (17 units: foreword+15ch+FAQ) | 17/17 (~493 examples) | 17/17, zero major (all MINOR/CLEAN) | PENDING — next session | chapters only |
| my-big-toe | pending (trilogy — split per book-within-book) | — | — | — | — |
| power-of-now | pending (practice-book template) | — | — | — | — |
| american-cosmic | pending | — | — | — | — |
| zen-motorcycle | pending (novel/philosophy hybrid template) | — | — | — | — |
| dark-psychology | pending | — | — | — | — |
| sekret-machines-war | pending (fiction template) | — | — | — | — |

Audio-only (no text in collection): Maps of Meaning, The Tibetan Book of
Living and Dying, The Holographic Universe audiobook (text done from EPUB),
23 Anti-Procrastination Habits.

## Continuing from a new machine

1. Clone https://github.com/SScleves/TheMindBook — notes, site, kit, scripts
   all come along.
2. Reading/site/agent-kit need nothing else.
3. To process NEW books: copy the EPUBs to a local folder (kept out of git),
   then follow the stages above. Original files live in
   `C:\Libros Mente\` (from `Libros Mente-*.zip`, Google Drive export).
4. The claude.ai Project agent: create Project "TheMindBook", paste
   `agent-kit/00-instructions.md` into Project instructions, upload the other
   agent-kit files as knowledge. Re-upload changed files after each book.

## Roadmap agreed with Santi

- Site v2: interactive layer in the style of the dutch-lessons site (tabs,
  flashcards from glossary concepts/people, self-graded quiz from Q&A,
  streaks + localStorage progress). Data comes from existing note structure;
  build extends `_build/libros-template.html`.
- Remaining books in the order: My Big TOE → Power of Now → American Cosmic →
  Zen → Dark Psychology → Sekret Machines.
