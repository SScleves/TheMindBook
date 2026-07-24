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
content/
  concept-atlas.json   curated cross-book concept hubs and typed connections
  atlas-links.json     curated cross-author debates + disclosed cross-section bridges
  appendix-*.md        demoted books kept as a condensed reference summary
  research/*.md        mechanism-first dossiers with interactive visual markers
libros.html            offline single-file knowledge atlas
index.html             identical GitHub Pages entrypoint
_build/                site generator (build-libros.ps1 + template)
```

The raw book texts live only in a local `source/` folder that is deliberately
not in this repo (see `.gitignore`) — the books are copyrighted; only the notes
travel.

## Using the atlas

Open `libros.html` or `index.html` in a browser. The application has five
top-level modes and needs no network connection or external assets:

- **Explore** opens the ten-hub concept atlas, grouped into two sections —
  *Reality & Physics* and *Mind & Meaning* — with a bridge tier (consciousness,
  perception, anomalous experience) that straddles both. Each hub keeps book
  positions, editorial comparisons and exact note provenance visibly separate.
- **Connections** surfaces the atlas's own arguments: the *Key Debates* where
  different books reach the same conclusion by incompatible mechanisms, every
  typed link filterable by relationship, and the disclosed cross-section
  bridges (each labelled a speculative parallel, never proof).
- **Dossiers** renders the research Markdown as long-form guides with section
  navigation and interactive mechanism diagrams.
- **Library** starts with one card per book, split by section. Opening a book
  reveals its table of contents, reader navigation, flashcards and self-graded
  quiz. Demoted books appear as an appendix summary, not a shelf card.
- **Search** groups matches from atlas content, dossier bodies and book notes.

Every view has a URL hash, including `#connections`, `#concept/<id>`,
`#research/<id>`, `#appendix/<id>`, `#book/<book-id>/<doc-id>`,
`#cards/<book-id>`, `#quiz/<book-id>` and `#search/<query>`. Old encoded
book-note hashes continue to resolve. Card, quiz and reading progress remain in
the existing `themindbook` localStorage record.

Rebuild after changing notes, the atlas, a research dossier or the template:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File _build/build-libros.ps1
```

The builder parses `notes/<book>/*.md`, `content/concept-atlas.json`,
`content/atlas-links.json`, every `content/appendix-*.md` and every
`content/research/*.md`, embeds one JSON payload, then writes byte-identical
`libros.html` and `index.html` outputs. A book flagged `demoted` in the
builder's `$bookMeta` is skipped as a shelf book but kept on disk; its
appendix summary carries it.

To validate the generated payload and check that every dossier visual marker has
a builder, run `node _build/validate-generated.js`. To inspect the site in a
browser (the atlas is offline and self-contained, so any static server works),
`node _build/serve-local.js` serves it at `http://127.0.0.1:8765`.

For Obsidian, point a vault at `notes/`; the files remain plain Markdown with
frontmatter.

## How notes are made

Per book: split the text at the author's own chapter boundaries; one reading
pass per chapter producing the note; an adversarial verification pass per
chapter that re-reads the source and corrects the note (fabrications,
conflated examples, wrong numbers, missing material); then synthesis passes
for the map, glossary and Q&A. Claims stay attributed to the author —
summaries record what the book says, not what is true.

## Shelf

Nine shelf books, each with per-chapter notes, an adversarial verification pass,
and a synthesis layer (map, glossary, Q&A). Books are grouped into two sections:
*Reality & Physics* argues about mind and the nature of reality; *Mind & Meaning*
offers first-person or philosophical lenses. Consciousness, perception, and
anomalous experience are treated as bridge hubs that belong to both.

| Book | Section | Status |
|---|---|---|
| The Holographic Universe — Michael Talbot | Reality & Physics | notes + verification + synthesis done |
| The Simulation Hypothesis — Rizwan Virk | Reality & Physics | notes + verification + synthesis done |
| My Big TOE — Thomas Campbell | Reality & Physics | notes + verification + synthesis done |
| American Cosmic — D. W. Pasulka | Reality & Physics (bridge) | notes + verification + synthesis done |
| Sekret Machines 1: Gods — DeLonge & Levenda | Reality & Physics (bridge) | notes + verification + synthesis done |
| Sekret Machines 2: Man — DeLonge & Levenda | Reality & Physics (bridge) | notes + verification + synthesis done |
| Sekret Machines 3: War — DeLonge & Levenda | Reality & Physics (bridge) | notes + verification + synthesis done |
| Practicing the Power of Now — Eckhart Tolle | Mind & Meaning | notes + verification + synthesis done |
| Zen and the Art of Motorcycle Maintenance — Robert M. Pirsig | Mind & Meaning | notes + verification + synthesis done |
| Dark Psychology and Manipulation — William Cooper | Appendix (demoted) | notes on disk; kept as a condensed summary |

*Dark Psychology* is a tactics manual rather than an inquiry into mind or reality,
so it was demoted from the shelf to an appendix summary (`content/appendix-dark-psychology.md`)
that feeds the *Who Shapes Belief?* hub. Its per-chapter notes remain under
`notes/dark-psychology/` but are no longer built into the site.

The three *Sekret Machines* volumes also share a cross-book synthesis dossier
(`content/research/sekret-machines-trilogy.md`).
