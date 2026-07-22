# TheMindBook

A personal knowledge base built from books about mind, consciousness and reality.
Each book is read chapter by chapter and distilled into detailed, source-verified
notes: core claims, every experiment and case study with its specifics, concept
definitions, verbatim key quotes, and cross-links.

## What's here

```
notes/<book>/          the knowledge layer (one folder per book)
  00-map.md            book map: thesis, structure, chapter index
  NN-<chapter>.md      one note per chapter (claims, concepts, examples, quotes)
  90-glossary.md       merged concept glossary + people index
  91-qa.md             anticipated questions, answered with chapter pointers
libros.html            the reading site: offline, single file, full-text search
_build/                site generator (build-libros.ps1 + template)
```

The raw book texts live only in a local `source/` folder that is deliberately
not in this repo (see `.gitignore`) — the books are copyrighted; only the notes
travel.

## Using it

- **Read**: open `libros.html` in any browser. Sidebar per book, search box
  top-left, concept chips link into the glossary. Works offline.
- **Rebuild the site** after editing notes:
  `powershell -File _build/build-libros.ps1`
- **Obsidian**: point a vault at `notes/` — the files are plain markdown with
  frontmatter.

## How notes are made

Per book: split the text at the author's own chapter boundaries; one reading
pass per chapter producing the note; an adversarial verification pass per
chapter that re-reads the source and corrects the note (fabrications,
conflated examples, wrong numbers, missing material); then synthesis passes
for the map, glossary and Q&A. Claims stay attributed to the author —
summaries record what the book says, not what is true.

## Shelf

| Book | Status |
|---|---|
| The Holographic Universe — Michael Talbot | notes + verification done; synthesis in progress |
| The Simulation Hypothesis — Rizwan Virk | queued |
| My Big TOE — Thomas Campbell | queued |
| Zen and the Art of Motorcycle Maintenance — Robert M. Pirsig | queued |
| Practicing the Power of Now — Eckhart Tolle | queued |
| American Cosmic — D. W. Pasulka | queued |
| Sekret Machines 3: War — DeLonge & Levenda | queued |
| Dark Psychology and Manipulation — William Cooper | queued |
