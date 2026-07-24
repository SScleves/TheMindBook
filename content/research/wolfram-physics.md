---
id: wolfram-physics
title: "Is Reality a Computation?"
eyebrow: "The Wolfram Physics Project"
description: "A mechanism-first guide to how simple hypergraph rewrites are proposed to produce space, time, relativity, quantum mechanics, and the ruliad - and where the physics remains unconfirmed."
topics: [computation, hypergraphs, emergence, quantum mechanics, many-worlds, ruliad]
---

**Direct answer:** Stephen Wolfram's Physics Project proposes that the universe can be described at its lowest level by discrete abstract relations repeatedly transformed by simple rules. Space, time, gravity, and quantum behavior are not placed into the starting machinery; the claim is that they emerge from the large-scale structure of the transformations. The project has substantial mathematics behind the behavior of its models, but it has not established that our universe is one of those models, identified a confirmed rule for our universe, or produced a body of distinctive experimental successes.

The question in the title therefore has two different answers. **Can a computation-like rewriting system generate structures that resemble important parts of physics? Yes, in mathematically analyzable model classes. Has nature been shown to be that computation? No.** Keep that boundary visible and the project becomes much easier to understand.

## The one mental model: relation, rewrite, history

Picture reality with all familiar furniture removed. No background grid. No pre-existing distance. No master clock ticking outside the system. What remains is:

1. a collection of abstract elements;
2. relations saying which elements belong together;
3. a rule that replaces one small pattern of relations with another;
4. the complete history of those replacement events.

The shortest form of the machine is:

```text
relations now
    -> find a matching local pattern
    -> replace it according to a rule
    -> obtain new relations
    -> repeat

one state of relations              candidate space
one replacement                     update event
dependencies between replacements   candidate spacetime causality
all legal replacement histories     candidate quantum multiway structure
all possible rules and histories    ruliad
```

Every later concept is a different way of reading this same machine. The hypergraph records **what is related now**. The causal graph records **which update depended on which earlier update**. The multiway graph records **which complete states can follow which**. Branchial space compares states across alternative histories. Rulial space compares histories generated under different rules.

> **Key idea** - Wolfram does not begin with little objects moving through a container called space. He begins with relations changing, then asks whether the container, the objects, and their laws can emerge from that change.

## 1. Begin smaller than space

### Abstract elements and abstract relations

At the model's lowest level, an element has no declared size, position, mass, color, or material. Labels such as `a`, `b`, and `c` are bookkeeping only. Relabel every element consistently and the physical candidate has not changed.

A relation such as `{a, b}` means only that `a` and `b` participate in one relation. It does **not** initially mean that two particles sit one meter apart, that a line physically stretches between them, or even that they live in a space. Those interpretations would smuggle in the geometry the model is supposed to explain.

The word *abstract* carries the weight here: the relation supplies connectivity without presupposing what that connectivity will become.

### Graph versus hypergraph

An ordinary graph edge joins two nodes. It naturally represents a binary relation:

```text
{a, b}    a ---- b
```

A hypergraph generalizes this. One **hyperedge** may join any number of nodes. A ternary relation such as `{a, b, c}` is one three-way relation, not merely the three pairwise edges `{a,b}`, `{b,c}`, and `{a,c}`. Those pairwise edges contain different information.

```text
ordinary graph                 hypergraph

   a ----- b                     a     b
                                  \   /
edge = {a,b}                 hyperedge = {a,b,c}
                                    c
```

Wolfram's technical model allows ordered relations, so the order of elements inside a relation can matter. It also allows repeated elements, self-loops, and multiple relations. The drawings are visual aids; the underlying object is the collection of relations.

<!-- visual:hypergraph-space -->

> **What the mathematics supports:** Graphs and hypergraphs are standard discrete structures. Rewriting them, testing structural equivalence, measuring graph distance, and studying their limiting behavior are precise mathematical operations.
>
> **What Wolfram claims:** The elements may be interpreted as "atoms of space," and the pattern of their relations may be what physical space is made from.
>
> **What remains unconfirmed:** No observation has established these elements or hyperedges as the fundamental ontology of our universe.

## 2. A rule does one local job

A **rewriting rule** has a left side and a right side. The left side says what local pattern to find. The right side says what relations replace it. Variables preserve identities across the replacement; a symbol appearing only on the right denotes a newly created element.

Here is a deliberately simplified schematic rule:

```text
{{x, y}, {y, z}}  ->  {{x, y}, {y, w}, {w, z}}
```

Read it literally:

- find two relations that share `y`;
- preserve `x`, `y`, and `z`;
- create a new element `w`;
- replace the matched pair with the three relations on the right.

One application of the rule to one matching region is an **update event**. If the left side consumes two relations and the right side produces three, that event removes two relation instances and creates three. The complete hypergraph after the event is the next state along that history.

<!-- visual:simple-rule -->

### The rule is not inherently random

This is one of the easiest places to misread the project. A fixed rule can be perfectly definite while matching several places in the current hypergraph. The ambiguity is **where or in what order to apply it**, not necessarily a random instruction inside the rule.

There are three different ideas that should not be collapsed:

- **Deterministic local rule:** given a selected match, the replacement is fixed.
- **Multiple legal updates:** several matches may be available, especially when candidate matches overlap.
- **Apparent randomness:** a simple deterministic evolution may be computationally irreducible and therefore look statistically random at larger scales.

A program used to draw one history may impose a scan order. The full model instead studies every legal sequence in a multiway system. No external dice are required to define that total structure.

## 3. How connectivity can become geometry

A raw hypergraph does not come with coordinates. Nevertheless, it has an intrinsic notion of nearness: two elements are near if few relation steps connect them. For distance calculations, the technical introduction commonly treats all elements in one hyperedge as one step apart, ignoring its direction.

The **graph distance** between two nodes is the length of a shortest connecting path. Starting at node $X$, define $V_r(X)$ as the number of nodes reachable within graph distance $r$. This is the discrete counterpart of the volume of a ball of radius $r$.

For a sufficiently large graph approximating $d$-dimensional Euclidean space,

$$
V_r(X) \propto r^d.
$$

This makes dimension measurable from connectivity alone. A line gives growth proportional to $r$; a broad two-dimensional grid gives roughly $r^2$; a three-dimensional lattice gives roughly $r^3$. The slope of $\log V_r$ against $\log r$ supplies an effective dimension.

This is not automatic. A regular tree has exponentially growing $V_r$, so it does not settle to a finite Euclidean dimension by this test. A complete graph has almost no useful range of radii. Small graphs suffer edge effects. Inhomogeneous graphs require spatial averaging, and fractal structures can produce non-integer effective dimensions.

### Emergent geometry

Geometry **emerges** when a sequence of ever-larger or ever-finer hypergraphs develops stable large-scale properties describable by a familiar geometric object. A rewriting rule can generate something that, after coarse-graining, behaves like a two-dimensional surface even though no two-dimensional coordinate grid was supplied.

Curvature can also be read intrinsically. In a curved space, the volume of a geodesic ball deviates from pure $r^d$ growth. Wolfram's framework uses those deviations to connect hypergraph neighborhoods with quantities such as Ricci curvature. Some generated structures approach ordinary manifolds; some appear fractal; some have no familiar geometric limit.

> **What the mathematics supports:** Connectivity alone can encode dimension and curvature in suitable graph sequences. Specific rewrite systems demonstrably generate grid-like, manifold-like, fractal, or non-geometric limits.
>
> **What Wolfram claims:** The hypergraph of relations is physical space, and familiar continuous geometry is its coarse-grained limit.
>
> **What remains unconfirmed:** The observed three-dimensional space, its detailed matter content, and measured constants have not been uniquely recovered from a verified underlying rule.

## 4. Time is the ordering of events

A hypergraph state says what relations exist. It does not yet say which changes caused which later changes.

Suppose update event $A$ creates or modifies relation material later consumed by event $B$. Then $B$ depends causally on $A$. Draw one node for every update event and an arrow $A \to B$ for every such dependency. The result is a **causal graph**.

```text
hypergraph history                     causal graph

state 0 -> event A -> state 1              A
                       |                   / \
                       +-> event B        B   C
                       +-> event C         \ /
                                          D
```

The causal graph discards much of each intermediate hypergraph and retains the dependency skeleton. Events not joined by a causal path can be reordered without one supplying input to the other. Events joined by a directed path cannot.

### Foliation: how an observer cuts the history into "nows"

A **foliation** divides a causal graph into ordered slices. Events inside one slice are treated as a simultaneous spatial configuration; later slices contain events causally downstream. A valid foliation must respect the causal order, but many valid foliations may cut the same graph differently.

That is the proposed bridge to relativity. Different update schedules or foliations act like different reference frames: they disagree on which distant events share a time slice while preserving causal order. A foliation does not create another causal history; it is another consistent way to organize the same history into successive "nows."

<!-- visual:causal-foliation -->

### Causal invariance

A rewrite rule is **causal invariant** when different legal update orders ultimately produce the same causal relationships, up to structural equivalence. In multiway language, histories that diverge because updates were chosen in a different order eventually reconverge, and their causal graphs agree.

Causal invariance is not true of every rule. Wolfram's technical introduction notes that it is guaranteed for certain simple classes, uncommon among some multi-relation rule families, and undecidable in general whether arbitrary branches will ever reconverge. It is a condition with consequences, not a free property of all rewriting.

Within the project, causal invariance does several jobs. It removes the physical significance of an arbitrary update order, supports reference-frame independence, and under suitable continuum and statistical assumptions participates in derivations of relativistic behavior. In the project's treatment of vacuum gravity, preserving a fixed large-scale spacetime dimension constrains averaged curvature and yields the vacuum Einstein equations.

That is a real model-internal result with real assumptions. It is not the same as proving that Einstein's equations came from the actual microscopic rule of nature.

> **What the mathematics supports:** Update events define a partial causal order. Foliations and causal invariance can be studied exactly for finite cases and under stated limiting assumptions. Work in the project derives continuum equations for suitable model classes.
>
> **What Wolfram claims:** Relativistic spacetime and gravity are large-scale descriptions of the causal graph.
>
> **What remains unconfirmed:** Nature's causal structure has not been shown to arise from a Wolfram-model hypergraph, and the continuum derivations do not by themselves select the Standard Model, our constants, or one fundamental rule.

## 5. Why simple rules do not make an easily predictable universe

A system is **computationally irreducible** when predicting its detailed future generally requires essentially following its evolution step by step. The rule may fit on one line while its consequences resist a shortcut.

This explains a crucial difference:

```text
simple rule  !=  simple outcome
known rule   !=  cheaply knowable future
```

The model class can emulate universal Turing machines and cellular automata, so it is capable of universal computation. That establishes that some systems in the class can perform arbitrary computations. Wolfram's broader **Principle of Computational Equivalence** goes further: he argues that systems whose behavior is not obviously simple typically reach comparable maximal computational sophistication.

The first statement has conventional mathematical support through explicit emulations. The broader principle is Wolfram's proposed general law, supported by many examples but not a standard theorem covering nature.

Computational irreducibility leaves **pockets of reducibility**. A gas is too complicated to predict molecule by molecule, yet temperature and pressure obey compact laws. Likewise, Wolfram argues that low-level rewriting can remain irreducible while observers recover reducible large-scale laws such as relativity.

## 6. One rule, every possible history

If several legal updates are available, following only one schedule hides structure. A **multiway system** follows all legal update choices.

- Each node in the multiway graph is a complete state of the system.
- Each directed edge is one update event taking one state to another.
- A path is one possible update history.
- A fork is branching: one state permits inequivalent next states.
- A join is merging: different histories reach states treated as equivalent.

For hypergraphs, equivalent usually means **isomorphic**: the connectivity is the same after arbitrary node labels are ignored.

```text
             state B
            /       \
state A ---           ---> state E
            \       /
             state C
```

This picture contains both branching **and merging**. Treating it as an ever-growing tree misses the joins, and the joins are central. They express that two different orders or histories can land on the same structural state.

<!-- visual:multiway-system -->

### Is this randomness?

Not at the global level Wolfram describes. The rule and initial condition determine the entire multiway graph of possibilities. An observer following a limited thread may experience uncertainty, but the possibility structure itself is fixed. This is why Wolfram says the model is globally deterministic even when it contains many histories.

## 7. Branchial space: distance across alternatives

Take a time slice through a multiway graph. It contains several states on different branches. Connect states that have a recent common ancestor, or more generally relate them by the pattern of branch pairs and causal entanglement. The resulting graph is a **branchial graph**; its large-scale limit is called **branchial space**.

Physical space compares elements within one state. Branchial space compares whole states across alternative histories.

```text
physical space:    node <-> node inside one hypergraph state
branchial space:   state <-> state across branches of the multiway system
```

Nearby branchial states have closely entangled histories. Farther states have diverged more. Wolfram proposes that quantum entanglement is geometry in branchial space, that quantum evolution can be read as motion through it, and that causal invariance helps observers combine many microscopic branches into a stable classical account.

<!-- visual:branchial-space -->

This is related to Everett, but it is not simply Everett with different graphics.

### Everett first, Deutsch later

Hugh Everett's 1957 **relative-state formulation** keeps the universal quantum state evolving unitarily, without a physical collapse that chooses one result. Modern Many-Worlds accounts interpret decohering components of that universal state as branches or worlds associated with different macroscopic records. The underlying machinery is the quantum state in Hilbert space and its unitary dynamics. How branch weights yield experienced probability remains a major interpretive problem.

David Deutsch did **not** write a separate set of fundamental equations that Wolfram adopted. Deutsch is a major modern Everettian and a founder of quantum computation. Among his contributions are arguments about experimental implications of Everett, quantum computation, locality in the Heisenberg picture with Patrick Hayden, and a 1999 decision-theoretic attempt to derive rational use of Born-rule weights. David Wallace later formalized that probability program; it remains debated.

Wolfram's relationship to Everett and Deutsch is therefore:

- like Everett, Wolfram rejects a story in which one fundamental stochastic collapse simply erases all other possibilities;
- like Everettian language, the multiway system contains many histories;
- unlike Everett's starting point, Wolfram starts from hypergraph rewrite events, not the universal wavefunction and Schrodinger equation;
- unlike a simple splitting-worlds picture, Wolfram's histories can merge when states become equivalent;
- Wolfram claims standard quantum formalism should emerge from branchial and multiway structure;
- Deutsch's work is relevant background on Everett and quantum information, not the source of "Deutsch's equations" behind the Wolfram model. There is no such canonical object here.

> **What the mathematics supports:** Multiway graphs branch and merge; branchial graphs summarize relations among states on a slice. Formal work within the project connects aspects of multiway systems to quantum-like structures.
>
> **What Wolfram claims:** Branchial geometry underlies quantum mechanics, and the observer's coarse-grained experience explains definite outcomes without fundamental collapse.
>
> **What remains unconfirmed:** The framework has not independently replaced the full experimentally successful quantum formalism with a distinctive, confirmed microscopic model. The Born rule, measurement, quantum field theory, particle spectrum, and testable departures remain crucial standards.

## 8. The bounded observer is part of the machine

An observer in this framework is not outside the evolving structure. The observer is itself a persistent computational process inside it.

**Bounded** means at least three things:

- finite computational capacity;
- access to only a small part of the underlying evolution;
- a need to aggregate many microscopic details into equivalence classes such as "the same object" or "the same outcome."

Wolfram's gas analogy is useful here. No human tracks every collision in a room. We compress that detail into pressure, temperature, and flow. The claim is that we do something analogous with atoms of space, branches of history, and even possible rules. Our stable world is not a full view from outside; it is the coarse-grained account available to a persistent process inside.

This observer story does real explanatory work, but it also carries a burden. A complete physical theory must specify enough about observers and their coarse-graining to recover quantitative laboratory probabilities, not merely say that limited beings see less.

## 9. Rulial space: compare rules, not only outcomes

An ordinary multiway system applies **one rule** in every possible legal way. A **rulial multiway system** also ranges over different rules.

A time slice through that larger structure defines **rulial space**. As a first approximation, positions in rulial space correspond to different rule-based descriptions. Two regions are near when one rule can emulate the other with relatively little computational translation; they are far when the translation costs more.

This is not the same axis as branchial space:

```text
branchial distance   difference between histories under a rule
rulial distance      difference between rule-based descriptions/computations
physical distance    difference between locations within a state
```

Wolfram argues that universal computation makes translations between sufficiently powerful rule systems possible. His stronger Principle of Computational Equivalence is used to argue that the space is broadly homogeneous and that different computational bases are coordinate systems on one deeper object.

## 10. The ruliad is not a shelf of universes

The **ruliad** is Wolfram's proposed limit of all possible computations: all possible rules, all possible initial conditions, applied in all possible ways, for arbitrarily many steps, with equivalent states and histories connected or merged. He calls it the "entangled limit" of everything computationally possible.

That last phrase corrects the common picture. The ruliad is not merely a library shelf where each isolated book is a parallel universe with its own rule. It is the full network of computations **plus the equivalences and emulations that connect them**. Different histories branch, but they also merge. Different rules can emulate one another. What gives the ruliad structure is precisely that the paths are not all separate.

Wolfram claims the limiting object is unique despite different ways of constructing or describing it. Turing machines, string substitutions, cellular automata, and hypergraph rewrites would then be different coordinate systems for the same computational totality. He explicitly acknowledges that the infinite limits and their formal treatment contain unresolved subtleties and that only tiny finite approximations can be explored directly.

### No outside computer is required

Calling the model computational does not entail a laptop beyond the universe, a programmer, a simulation host, or a clock external to reality. In the ontological reading Wolfram proposes, the updating relations are the physical process. The system does not represent a universe being run elsewhere; it is offered as what the universe is.

That does not disprove the simulation hypothesis. It shows only that **simulation theory adds claims the Wolfram model does not need**: an external substrate, an implementing agent or civilization, and usually a purpose for the run.

### Why one rule seems to govern our world

If the ruliad contains all rules, why do we observe regular laws? Wolfram's answer combines computational equivalence with bounded observation. Observers like us occupy and sample only a limited region, conflate many microscopic distinctions, and cannot identify a unique exact rule from finitely many experiments. A range of nearby rules may support the same effective large-scale laws.

This is Wolfram's claim, not an experimentally established fact about observers. It shifts the fundamental-theory question from "Which rule was selected from outside?" to "Why do observers with our limitations perceive this stable rule-equivalence class?"

## What this theory is not

### Not automatically simulation theory

The simulation hypothesis says our experienced world is implemented by some external system, often built by agents. Wolfram's proposal can be read as intrinsic computation: relations update because that is the fundamental ontology. **Computation does not imply simulation.** A simulated Wolfram system is possible; an external simulator is not part of the theory's required mechanism.

### Not the holographic principle

The holographic principle in modern theoretical physics relates information in a gravitational region to a lower-dimensional boundary description, with AdS/CFT as its best-developed realization. Wolfram's core construction instead rewrites abstract hypergraphs and seeks emergent geometry and quantum behavior from their causal and multiway structure.

Both discuss information and fundamental structure. That resemblance does not make them the same theory. The Wolfram project asks separately whether its models are consistent with holographic ideas; it does not derive its name, mechanism, or central mathematics from "the whole in every part."

Michael Talbot's *The Holographic Universe* is farther away still. Talbot synthesizes Bohm's implicate order and Pribram's holographic-brain model, then extends the synthesis to paranormal and mystical claims. That is not the technical holographic principle, and neither version is Wolfram's hypergraph rewriting.

### Not Deutsch's equations

There is no accepted package called "Deutsch's equations" serving as the engine of Wolfram Physics. Deutsch is relevant through Everettian quantum theory, quantum computation, decision-theoretic probability, and locality. Wolfram's engine is graph or hypergraph rewriting and multiway evolution.

### Not a random-rule lottery

A rewrite rule may be deterministic at each selected match. Multiway evolution enumerates every legal update sequence instead of choosing one by fundamental chance. The ruliad expands the scope to all rules, but "all are represented" is not the same statement as "one is randomly picked by an external process."

### Not merely Many-Worlds renamed

Everett begins with unitary quantum mechanics; Wolfram aims to derive quantum mechanics from a different substrate. Everettian branches are usually discussed through decoherence and the universal wavefunction. Wolfram histories arise from rewrite choices, may merge through equivalence, and sit inside a wider structure that also varies rules. The family resemblance is real. Identity is not.

## Theory comparison

<!-- visual:theory-comparison -->

| View | Fundamental starting point | Why many possibilities appear | Observer's role | Outside computer or creator required? | Scientific position |
|---|---|---|---|---|---|
| **Simulation hypothesis** | An experienced world implemented on another substrate | The simulator may run alternatives, agents, or many simulations | Usually an inhabitant or player receiving a rendered world | Commonly yes for a literal simulation, though versions vary | Philosophical hypothesis; broad versions may be difficult to test |
| **Wolfram Physics Project** | Abstract relations, hypergraph rewrite events, causal and multiway structure | Multiple legal updates; eventually all possible rules in the ruliad | A bounded process inside the structure that coarse-grains it | **No** | Active research program with exact models and proposed physics correspondences; not confirmed as fundamental physics |
| **Holographic principle** | Quantum gravity where bulk information is encoded by lower-dimensional boundary degrees of freedom | Not primarily a branching theory | Ordinary physical observer; boundary/bulk duality is the issue | No | Mainstream theoretical principle with strong support in specific settings such as AdS/CFT, not a complete empirical theory of our cosmology |
| **Everett MWI** | Universal quantum state evolving unitarily | Decoherence produces effectively autonomous branches containing different records | Observer also branches and experiences a relative outcome | No | Serious interpretation of standard quantum mechanics; no consensus, with probability and ontology debated |
| **David Deutsch** | Everettian quantum theory plus work on computation, information, explanation, and locality | Everettian quantum alternatives; interference is central to quantum computation | Agents reason and make decisions across weighted branches | No | Influential physicist and Everett advocate; not a separate replacement physics called "Deutsch's equations" |
| **Thomas Campbell** | Fundamental digital consciousness; The Big Computer renders PMR as a learning simulation | A database of probable states and unactualized alternatives | Consciousness is primary, chooses, learns, and lowers entropy | A larger consciousness system, not necessarily a material computer | Metaphysical system grounded largely in author-reported experience; not established physics |
| **Rizwan Virk** | Information-based rendered reality, framed through video-game architecture | Simulations, possible timelines, rendering, and computational branching | May be an NPC or an external conscious player; Virk favors the player-like RPG version | Usually some larger computational or conscious context | Speculative synthesis and technology argument, not a tested physical theory |
| **Michael Talbot** | Bohm's implicate order plus Pribram's holographic brain, extended by Talbot | Reality unfolds from a deeper order; later claims include parallel futures and mind-shaped phenomena | Mind helps construct or participate in experienced reality | No programmer required; deeper order is fundamental | Controversial 1991 synthesis, especially in its paranormal extensions; not the modern holographic principle |

## Scientific status

The fair assessment needs three shelves, not one verdict.

### 1. Established mathematics and computer science used by the project

- Graphs, hypergraphs, rewriting systems, isomorphism, causal partial orders, foliations, universal computation, undecidability, and graph-based measures of distance and dimension are legitimate formal subjects.
- Particular rules can be executed exactly. Their finite causal graphs, multiway graphs, branchial graphs, branching, merging, and causal-invariance behavior can be computed and checked.
- The model class can emulate universal computation. This supports computational irreducibility and undecidability for appropriately constructed cases, although Wolfram's claim of ubiquity rests on his broader Principle of Computational Equivalence.
- Under stated assumptions and continuum limits, researchers in the project have developed mathematical correspondences to relativity and quantum formalism.

### 2. Supported within the model, conditional on assumptions

- Suitable growing hypergraphs can display stable effective dimension and curvature.
- Causal graphs admit multiple foliations, and causal invariance can make causal structure independent of update order.
- In appropriate continuum, fixed-dimension, causal-invariant, statistically averaged regimes, the project derives forms associated with relativistic physics, including the vacuum Einstein equations.
- Multiway and branchial constructions provide a formal architecture for quantum-like branching, entanglement, measurement frames, and decoherence analogies.

These are more than metaphors. But they are conditional statements: **if** the underlying rule belongs to an appropriate class, **if** the required limits exist, **if** the coarse-graining and statistical assumptions hold, then familiar structures can emerge.

### 3. Unconfirmed as fundamental physics

- No specific rewrite rule has been empirically established as the rule, or rule-equivalence class, of our universe.
- The framework has not yet derived the observed particle spectrum, Standard Model gauge structure, masses, coupling constants, cosmological parameters, and Born-rule predictions from a confirmed microscopic rule in a way that outperforms current theory.
- Proposed scales and particles in the technical introduction depend on rough estimates and assumptions; they are not detections.
- The ruliad's uniqueness, observer-based inevitability of known laws, and the universal reach of the Principle of Computational Equivalence are Wolfram's claims, not settled results accepted across physics.
- The project hosts post-publication open peer review and includes papers by collaborators. That is not the same as broad independent confirmation or consensus.
- Recovering known equations is necessary but not sufficient. A fundamental theory must also recover known precision results, explain why this observed universe is selected or perceived, and make risky predictions that distinguish it from rivals.

### What would move the status

The strongest progress would be one or more of the following:

1. derive a measured quantity not used to choose the rule;
2. predict a reproducible deviation from general relativity, quantum field theory, or the Standard Model;
3. recover the Born rule and observed particle physics from independently motivated assumptions;
4. show robustness under coarse-graining with transparent, independently checked proofs;
5. identify an observational signature that rival approaches do not also expect.

Until then, the correct description is **an ambitious computational research program with interesting formal results and unverified claims about nature**.

## The whole chain, once more

```text
abstract elements
    -> participate in abstract relations
    -> relations form a hypergraph state
    -> a local rewrite produces an update event
    -> repeated updates grow and reorganize the hypergraph
    -> graph distance and volume growth may yield emergent geometry
    -> dependencies among events form a causal graph
    -> foliations organize that graph into observer-relative time slices
    -> causal invariance can erase dependence on arbitrary update order
    -> computational irreducibility blocks most microscopic shortcuts
    -> all legal updates form a branching-and-merging multiway system
    -> a slice across histories defines branchial space
    -> a bounded observer samples and coarse-grains only part of this structure
    -> allowing different rules defines rulial space
    -> the infinite entangled limit of all rules and histories is the ruliad
```

The chain is coherent. The final identification is still a hypothesis.

> **Final key idea** - Wolfram Physics is not the claim that someone programmed our world. It is the claim that relation and rewrite may be more fundamental than object, space, and equation. The mathematics shows how much can grow from that seed. Experiment must still decide whether nature did.

## Sources

### Official Wolfram Physics sources

- Stephen Wolfram, [*A Class of Models with the Potential to Represent Fundamental Physics*](https://www.wolframphysics.org/technical-introduction/) (2020). Technical introduction and model definitions; also available as [arXiv:2004.08210](https://arxiv.org/abs/2004.08210).
- Stephen Wolfram, ["The Concept of the Ruliad"](https://writings.stephenwolfram.com/2021/11/the-concept-of-the-ruliad/) (2021). Definition of the ruliad, bounded observers, rulial space, and explicit discussion of unresolved limits and formalism.
- Wolfram Physics Project, [Q&A](https://www.wolframphysics.org/questions/). Project statements on computation, predictions, relations to other approaches, and open questions.
- Wolfram Physics Project, [Post-publication open peer review](https://www.wolframphysics.org/peer-review/). Review model and listed technical papers; included here as a status source, not as evidence of scientific consensus.

### Independent and historical sources

- Lev Vaidman, ["Many-Worlds Interpretation of Quantum Mechanics"](https://plato.stanford.edu/entries/qm-manyworlds/), *Stanford Encyclopedia of Philosophy*, substantive revision 2026. Independent standard overview of Everett, decoherence, probability, Deutsch, and continuing disputes.
- Hugh Everett III, "Relative State Formulation of Quantum Mechanics," *Reviews of Modern Physics* 29 (1957): 454-462. Original relative-state paper.
- David Deutsch, "Quantum Theory of Probability and Decisions," *Proceedings of the Royal Society A* 455 (1999): 3129-3137. The decision-theoretic Everett probability program later developed by David Wallace.

### TheMindBook comparison sources

- Rizwan Virk, *The Simulation Hypothesis*, as represented in the source-verified local chapter notes, especially chapters 8, 14, and the FAQ. Virk treats Wolfram as evidence for a computational universe and then makes the additional simulation inference.
- Thomas Campbell, *My Big TOE*, as represented in the source-verified local notes. Campbell proposes a consciousness-first rendering system and probable-state databases, not Wolfram's relation-first physics.
- Michael Talbot, *The Holographic Universe*, as represented in the source-verified local notes. Talbot's Bohm-Pribram synthesis is distinct from both Wolfram hypergraphs and the modern holographic principle.
