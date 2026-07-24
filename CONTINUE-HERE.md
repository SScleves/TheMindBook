# TheMindBook Continuation Brief

**State captured:** 2026-07-24  
**Estimated completion:** 77%  
**Repository:** `C:\Repos\personal\TheMindBook`

Read this file before doing any work. It is the temporary authority for the current build. The shelf table in `README.md` is stale and must not be used to infer progress.

## Mission

Finish the teaching and integration layer for *Sekret Machines: Gods* and *Sekret Machines: Man*, then return the completed working tree for a final editorial and technical review by GitHub Copilot.

The goal is not merely to add two books to a list. The site must teach the trilogy clearly, visually, and honestly enough that a reader can build a complete mental model without hidden jumps. Similar vocabulary is not evidence of a shared mechanism, and analogies must never become proof.

## Non-negotiable boundaries

1. Do not edit, rewrite, or expand *Something Doesn't Fit*. It is the user's authored manuscript and primary nontechnical voice exemplar, not a current work item.
2. Do not force books into concept hubs. Add a position or connection only when the verified notes support it and the relationship clarifies a real agreement, disagreement, source lineage, or bounded parallel.
3. Keep author claims attributed. A note records what a book says; it does not certify the claim as true.
4. Keep these evidence levels distinct in prose: documented observation, established mechanism, mainstream interpretation, disputed interpretation, speculative inference, author claim, and editorial synthesis.
5. Preserve the split between the `reality` and `practice` tracks. Practical books can illuminate first-person experience or framing, but they are not evidence for physics or ontology.
6. Never turn a resemblance into identity. In particular, holography, simulation, Wolfram's hypergraph model, Everettian branching, and consciousness-first metaphysics are not interchangeable.
7. Do not discard or rewrite verified chapter notes merely to make synthesis cleaner. Correct a chapter note only when a concrete source or internal-consistency error is demonstrated.
8. Do not add copyrighted source text to git. Raw EPUB-derived text remains under ignored `source/`; only distilled notes belong in the repository.
9. Do not commit, push, publish, or rewrite git history. The working tree is intentionally dirty.
10. Do not remove user work. Generated files may be rebuilt only through the existing generator.

## User's teaching voice

The reader is competent but may not yet be oriented. Explanations must therefore:

1. Begin with the confusion or question a reader actually has.
2. Establish one durable mental model in plain language.
3. Show the complete machine before zooming into components.
4. Define every technical term when it first matters.
5. State where each idea comes from and where it lands in the larger model.
6. Use concrete examples, diagrams, comparisons, and expected observations.
7. Mark the boundary between known mechanism, interpretation, and speculation.
8. End with predictive understanding: the reader should be able to explain what would change if a component or assumption changed.

Use `content/research/holography.md` as the benchmark for mechanism-first pacing. Use the existing *War* map, glossary, and Q&A as structural references, but improve clarity where needed rather than copying their density blindly.

## Verified completed work

### Website and editorial architecture

- The site was redesigned into Explore, Dossiers, Library, and Search modes.
- Hash routes, provenance links, flashcards, quizzes, responsive layouts, and twelve interactive mechanism visuals are implemented in `_build/libros-template.html`.
- `content/concept-atlas.json` contains ten question-led hubs: seven `reality` hubs and three `practice` hubs.
- Practical lenses are represented by bounded `practiceBridges`; they explicitly do not validate an ontology.
- `content/research/holography.md` and `content/research/wolfram-physics.md` are complete.
- `_build/build-libros.ps1` filters absent concepts and people to empty arrays, avoiding the former `[null]` reader crash.
- Fenced ASCII diagrams were repaired with the `.code-block code` CSS override.
- The current generated site validates at 8 books, 257 documents, 10 hubs, and 2 dossiers. Those book/document counts are expected to change after integration.

### New source extraction

- `_build/split-sm-gods.ps1` deterministically extracts 14 publisher-TOC units.
- `_build/split-sm-man.ps1` deterministically extracts 22 publisher-TOC units.
- Raw extracted units are local under ignored `source/` folders.

### New verified notes

- `notes/sekret-machines-gods/` contains 14 detailed unit notes.
- `notes/sekret-machines-man/` contains 22 detailed unit notes.
- All 36 notes received focused adversarial comparison against their complete source units.
- *Gods* endnotes reconcile exactly: 141 of 141, with chapter distribution `32 / 14 / 6 / 9 / 29 / 23 / 18 / 10`.
- Verification removed unsupported quotations, name/title expansions, outside terminology, chronology mistakes, and cross-book leakage.
- Treat these chapter notes as the verified research archive.

## Remaining work, in order

### 1. Build the *Gods* teaching layer

Create:

- `notes/sekret-machines-gods/00-map.md`
- `notes/sekret-machines-gods/90-glossary.md`
- `notes/sekret-machines-gods/91-qa.md`

The map must include: a one-page thesis; how the argument develops; a complete unit index; the book's evidentiary strategy; a critical-reading section; and a short statement of what the book does and does not establish.

The glossary must define recurring concepts and people using only verified notes, with note-unit pointers. The Q&A must anticipate both orientation questions and skeptical questions, with pointers and explicit attribution.

### 2. Build the *Man* teaching layer

Create the same three files under `notes/sekret-machines-man/`.

Give special care to the transitions among genetics, consciousness, brain models, anomalous experience, and human-machine symbiosis. Do not let the book's accumulation of examples make different evidence classes appear equivalent.

### 3. Create the trilogy synthesis

Create a clearly named synthesis document in `content/research/` or another existing editorial-content location that the generator can load without inventing a parallel content system. If it is a dossier, give it valid research frontmatter and integrate it through the existing dossier loader.

Teach the trilogy as three linked lenses:

- **Gods:** religion, myth, ancient contact, and the proposed `Ur-contact` layer.
- **Man:** genetics, consciousness, the brain, anomalous experience, and technological convergence.
- **War:** national security, secrecy, information control, strategic uncertainty, and conflict.

The synthesis must include:

- One whole-trilogy map before details.
- What each volume contributes that the others do not.
- Shared premises versus later extrapolations.
- Internal tensions and unresolved questions.
- A claim/evidence ladder showing where documentary history ends and interpretation or speculation begins.
- At least one visual comparison when it materially improves understanding. Reuse the existing visual-marker architecture; do not add decoration for its own sake.

Do not present the trilogy's framework as verified ontology or verified alien contact.

### 4. Integrate the two books

Add metadata to `$bookMeta` in `_build/build-libros.ps1`:

- `sekret-machines-gods`
- `sekret-machines-man`

Both belong on the `reality` shelf. Confirm exact display titles, authors, and publication years from the verified note/source metadata before writing them.

Update `content/concept-atlas.json` selectively. Every added book position or connection must:

- Cite existing note paths in `sourceDocs`.
- Preserve author attribution.
- Use an existing relationship type: `direct-citation`, `shared-source`, `parallel`, `complements`, `reframes`, `tension`, or `contradiction`.
- Explain why the relationship is bounded.
- Avoid making two books look mutually confirming merely because both discuss consciousness or anomalous phenomena.

Do not add either book to every hub. Absence is preferable to a weak connection.

### 5. Rebuild documentation and generated output

Update `README.md` so the shelf accurately shows all ten books and their real status. Preserve its concise operational purpose.

Rebuild with:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File _build/build-libros.ps1
```

Update `_build/validate-generated.js` expected book/document/dossier counts to the actual final values. Do not weaken its null-metadata, missing-builder, script-syntax, or identical-output checks.

Delete `.tmp-validate-gods-notes.cjs`. Keep `_build/serve-local.js` only if it remains the documented, useful browser-validation server; otherwise remove it as temporary tooling.

## Acceptance checks

Run these from `C:\Repos\personal\TheMindBook` after all edits:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File _build/build-libros.ps1
node _build/validate-generated.js
git diff --check
git status --short
```

Also verify:

1. Every `sourceDocs` path in `content/concept-atlas.json` exists.
2. Every dossier visual marker has a matching visual builder.
3. `index.html` and `libros.html` are byte-identical.
4. There are exactly ten books after integration.
5. No document contains null concepts or people.
6. Desktop and 390px mobile views have no incoherent overlap or body-level horizontal overflow.
7. Explore, each modified concept hub, the trilogy dossier, both new library books, Search, Cards, and Quiz routes render without console errors.
8. Code/ASCII diagrams remain readable and scroll locally on narrow screens when necessary.
9. Keyboard navigation and visible focus remain usable for newly added controls.
10. The generated site still works offline with no required external assets.

If browser automation is available, use Playwright screenshots at desktop and mobile sizes and inspect the actual result. Passing a payload validator alone is not sufficient for final frontend acceptance.

## Current working-tree warning

At capture time, the repository already contained these intentional changes:

```text
 M README.md
 M _build/build-libros.ps1
 M _build/libros-template.html
 M index.html
 M libros.html
?? .tmp-validate-gods-notes.cjs
?? _build/serve-local.js
?? _build/split-sm-gods.ps1
?? _build/split-sm-man.ps1
?? _build/validate-generated.js
?? content/
?? notes/sekret-machines-gods/
?? notes/sekret-machines-man/
```

Do not revert these files. Work with them. Before editing a file, inspect its current contents rather than assuming the last committed version is current.

## Required completion report

When implementation and validation are complete, stop before committing or publishing and report:

1. Files created or changed.
2. Final counts for books, documents, hubs, dossiers, visual markers, and builders.
3. Which atlas hubs gained *Gods* or *Man*, with one-sentence justification each.
4. Validation commands and exact pass/fail outcomes.
5. Browser routes and viewport sizes tested.
6. Any remaining uncertainty, weak source relationship, or editorial judgment call.
7. Confirmation that *Something Doesn't Fit* was untouched.

Then return the project to GitHub Copilot for the promised last review. That review should inspect the diff, sample the synthesis against verified notes, test the generated site, and fix local defects before the user treats the project as complete.