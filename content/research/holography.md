---
id: holography
title: "How a Hologram Actually Works"
eyebrow: "Mechanism first"
description: "A wave-by-wave account of how holography records phase, reconstructs a viewable wavefront, and where the optical facts stop."
topics: [holography, interference, phase, Fourier transforms, perception]
---

A photograph can preserve what a scene looked like from one camera position. It cannot preserve the light arriving from that scene well enough to let a later viewer move sideways and see around an object.

The missing information is not merely "more depth." It is the structure of the arriving light.

At every point on an imaginary window in front of a scene, light has an **amplitude**, meaning the size of its oscillation, and a **phase**, meaning where that oscillation is in its repeating cycle. A **wavefront** is a surface joining points at the same phase. Its shape tells us which way the light is travelling. The complete optical field across the window therefore carries both brightness information and direction information.

A camera lens accepts part of that field through its aperture and forms a flat image on a sensor. The sensor records **intensity**, the optical power arriving per unit area, during an exposure. Intensity is proportional to amplitude squared. The sensor does not follow the vastly faster positive and negative oscillations of visible light, so their phase averages away.

The photograph keeps the image produced by the wavefront. It does not keep a wavefront that can be played back.

That is why moving your head in front of a photograph does not reveal a new side of the subject. Perspective cues inside the picture may suggest depth, but the outgoing light does not change as though the original object were still there.

**A hologram records instructions for rebuilding that outgoing light.** Once the wavefront is rebuilt, the eyes can inspect it from different positions much as they would inspect the original scene.

<!-- visual:hologram-vs-photo -->

## The complete machine

Before following any one beam, here is the whole system and the one job assigned to each part.

| Part | What it means | Its one job |
|---|---|---|
| **Coherent light source** | A source whose light maintains a predictable phase relationship across the beam and over the relevant travel time. A laser is the usual source. | Supply waves stable enough to make stationary fine fringes. |
| **Beam splitter** | A partly transmitting, partly reflecting optical element. | Divide one source beam into two paths. |
| **Object beam** | The path sent toward the subject. | Scatter from the subject and carry its optical field to the recording medium. |
| **Reference beam** | The path sent directly to the recording medium. | Supply a known wave against which the object wave's phase can be measured. |
| **Interference** | The pattern produced when overlapping wave amplitudes add and their intensity is recorded. | Turn relative phase into bright and dark spatial fringes. |
| **Recording medium** | A high-resolution photosensitive plate, film, or other material whose optical properties change with exposure. | Preserve the fringe pattern as variations in transmission, absorption, or refractive index. |
| **Reconstruction beam** | Light matched closely to the original reference beam. | Illuminate the developed recording. |
| **Diffraction** | The redirection and spreading of waves by fine structures, edges, or openings. | Make the recorded fringes redirect the reconstruction beam into a copy of the object wave. |
| **Virtual image** | An apparent image location from which rays seem to diverge even though no light actually converges there. | Give the viewer a stable apparent object behind or beyond the plate. |

The complete route is:

```text
                            RECORDING

                              laser
                                |
                         coherent light
                                |
                         [ beam splitter ]
                           /           \
                          /             \
             reference beam             object beam
                    R                         |
                    |                      [ object ]
                    |                         |
                    |                  scattered field O
                    |                         |
                    +------------+------------+
                                 |
                          O and R overlap
                                 |
                     interference intensity I
                                 |
                      [ recording medium ]
                                 |
                         developed hologram


                         RECONSTRUCTION

                 matching reconstruction beam
                                 |
                      [ developed hologram ]
                                 |
                   diffraction by recorded fringes
                                 |
                     reconstructed object field O
                                 |
                              viewer
                                 |
                  virtual image with depth and parallax
```

Nothing in that route requires the material to store a tiny photograph of the object. During recording, it stores a pattern of fringes. During reconstruction, those fringes operate on a new beam of light. The recognizable image exists in the reconstructed wavefront, not as a recognizable picture printed on the plate.

<!-- visual:hologram-recording -->

## The wave vocabulary, without gaps

Light is an electromagnetic wave. At a fixed point in space, its electric and magnetic fields oscillate. For this mechanism, four properties matter:

- **Amplitude** is the size of the oscillation. Greater amplitude means greater intensity, with intensity proportional to amplitude squared.
- **Frequency** is the number of complete oscillations passing a point each second. It is measured in hertz. Visible-light frequencies are hundreds of trillions of cycles per second.
- **Wavelength** is the distance over which the wave's pattern repeats. In vacuum, frequency $f$ and wavelength $\lambda$ are connected by $c = f\lambda$, where $c$ is the speed of light. In a material, the same relation uses the wave speed in that material.
- **Phase** is position within one cycle. Two waves can have the same amplitude, frequency, and wavelength while one is at a crest where the other is at a trough. They then differ in phase.

Frequency is repetition in time. Wavelength is repetition in space. Phase says where a particular wave is within that repetition.

Phase also carries direction. Imagine sampling a wave at many positions across a plate. If its phase changes steadily from left to right, the wavefront is tilted. A steeper phase change corresponds to a different arrival angle. A scene sends many such directional components toward the plate at once.

This is the information an ordinary exposure cannot retain directly. Two optical fields can deliver the same intensity at a surface while having different phase patterns and therefore different wavefront shapes. Once phase is discarded, the original field cannot in general be recovered from that one intensity map.

## Why the light must be coherent

For two waves to leave a stable interference pattern, their relative phase must remain predictable while the recording is made. That property is **coherence**.

There are two useful parts to it:

- **Temporal coherence** means the phase remains predictable over a time interval, or equivalently over a difference in path length. A source with a very narrow range of frequencies has a longer coherence time and coherence length.
- **Spatial coherence** means different points across the beam have a stable phase relationship. That allows a broad region of the plate to form clean fringes at once.

A laser is practical because it can provide both kinds. Laser light is also concentrated in a narrow wavelength range, so different colours do not produce mutually blurred fringe systems.

"Coherent" does not mean every point is forever in exactly the same phase. It means the phase relationship is stable and knowable enough for the experiment. The object and reference paths may have different lengths, but their difference must stay within the source's coherence range. The apparatus must also remain still to a small fraction of a wavelength during exposure. A vibration that moves a mirror or plate by a fraction of a micrometre can slide the fringes and wash them out.

## The two paths

The beam splitter does not create free extra energy or make two perfect full-power copies. It divides the incoming optical field. Some energy enters the object path and some enters the reference path.

The **object beam** illuminates the subject. Each illuminated point scatters light toward many positions on the recording medium. By the time this light reaches the plate, its amplitude and phase vary across the surface. Call that complex optical field $O$.

The **reference beam** reaches the plate by a simpler, controlled path. Its amplitude, phase, wavelength, and angle are known from the optical arrangement. Call this field $R$.

The reference beam is the crucial addition. The plate cannot measure the absolute phase of $O$ directly. It can measure how $O$ differs from $R$, because that phase difference changes the intensity where the two fields overlap.

## Interference makes phase visible

When waves occupy the same place, their amplitudes add. They do not bounce off one another like solid objects.

If two crests arrive together, their amplitudes reinforce and the recorded intensity is high. If a crest meets a trough of equal size, they cancel and the intensity is low. Intermediate phase differences produce intermediate intensity. This is **interference**.

Because the object and reference waves arrive at different angles and with spatially varying phase, reinforcement and cancellation occur at different positions across the plate. The result is a dense arrangement of bright and dark fringes. Fringe orientation and spacing encode wave direction; fringe displacement and contrast encode phase and amplitude relative to the reference.

<!-- visual:wave-interference -->

The compact equation for the intensity at one tiny position on the plate is:

$$
I = |O + R|^2
$$

Every mark has a job:

- $I$ is the intensity that drives exposure at that position on the recording medium.
- $O$ is the object wave there. It includes both an amplitude and a phase.
- $R$ is the reference wave there. It also includes an amplitude and a phase, but its origin is controlled.
- $O + R$ means that the two wave amplitudes are added before the detector responds.
- The vertical bars $|\;|$ mean "take the magnitude." Amplitude and phase are conveniently represented together by a complex number, which behaves like a rotating arrow: its length is amplitude and its angle is phase. The magnitude is the arrow's length. This notation does not claim that light is imaginary; it is phase bookkeeping.
- The exponent $2$ converts the magnitude of the combined field into intensity. Optical intensity is proportional to field-amplitude squared.

Expanding the equation shows exactly where the phase information enters:

$$
I = |O|^2 + |R|^2 + OR^* + O^*R
$$

The star means **complex conjugate**. In the rotating-arrow representation, conjugation reverses the phase angle. The first two terms, $|O|^2$ and $|R|^2$, are the intensities each beam would make alone. They carry no recoverable absolute phase.

The other two terms are the interference terms. Writing the fields as amplitudes $A_O$, $A_R$ and phases $\phi_O$, $\phi_R$ turns the same equation into:

$$
I = A_O^2 + A_R^2 + 2A_OA_R\cos(\phi_O - \phi_R)
$$

Here $\phi_O - \phi_R$ is the phase difference between object and reference waves. The cosine converts that difference into a number between $-1$ and $1$. The result raises or lowers the local intensity. Relative phase has become a spatial brightness pattern that a material can record.

This is the central conversion:

```text
object phase, which the plate cannot time directly
                     +
known reference phase
                     |
                     v
stable bright and dark fringes in ordinary intensity
```

The phase is not stored as a numeric phase value at each pixel. It is encoded in where the fringes fall and how they vary across the plate.

## What the recording medium keeps

Classic holography uses a photographic emulsion with grains fine enough to resolve the fringe spacing. Other holograms use materials whose refractive index changes with exposure, and digital holography can capture and process interference patterns electronically. The physical implementation changes; the information job does not.

During exposure, the medium responds to $I$. After chemical or physical processing, the recorded variations affect later light in one or both of two ways:

- an **amplitude hologram** varies how much light is transmitted or absorbed;
- a **phase hologram** varies optical path length, usually through thickness or refractive-index changes, and therefore delays different parts of the later wave by different phase amounts.

Real recording materials are not perfectly linear, and practical holography must manage exposure, contrast, grain size, noise, polarization, vibration, and path length. Those details affect efficiency and image quality. They do not change the core fact: the material preserves a spatial modulation produced by the object-reference interference terms.

To an unaided eye, a developed transmission hologram may look like a cloudy or finely patterned plate. That is expected. The plate contains instructions for changing a suitable incoming wave, not a directly viewable miniature scene.

## Reconstruction: the recording becomes an optical element

Now illuminate the developed hologram with a beam that matches the original reference beam closely in wavelength, direction, and wavefront shape. This is the **reconstruction beam**.

The fine recorded structure acts as an extremely complicated diffraction grating. A simple grating has regularly spaced lines and sends light into a few predictable directions. A hologram has locally changing fringe spacing, orientation, and contrast. Each small region redirects light differently. Together, those local redirections assemble a wavefront.

That redirection is diffraction. It is not the plate "remembering an image" and projecting it. It is ordinary wave propagation through or from a precisely structured optical element.

The algebra contains a useful receipt. In an idealized recording whose optical transmittance $t$ follows the recorded intensity, $t$ is proportional to $I$. Illuminating it with the original reference field produces an outgoing field proportional to $RI$:

$$
RI = R|O|^2 + R|R|^2 + O|R|^2 + O^*R^2
$$

The important term is $O|R|^2$. If the reference amplitude is uniform, $|R|^2$ is only a scale factor. What remains has the same phase structure as the original object field $O$. The plate and reconstruction beam have physically regenerated a version of that field.

The other terms explain why a real hologram can also produce undiffracted background light and a conjugate, or "twin," image. Off-axis recording, where the reference arrives at a deliberate angle, helps separate these outputs so the desired reconstructed wave can be viewed cleanly. The simplified algebra is not a full model of a real emulsion, but it exposes the mechanism the shorter explanation usually hides.

Use a different reconstruction wavelength and the diffraction angles change. Use a different incident angle and the image moves or distorts. Special reflection and rainbow holograms are engineered to work under broader or white-light illumination, but they do so by adding optical constraints, not by escaping the wave mechanism.

<!-- visual:hologram-reconstruction -->

## Why the image appears to occupy space

Suppose the regenerated rays reaching the viewer diverge in exactly the pattern that the original object produced. The eye has no optical test that distinguishes "rays from the object" from "rays rebuilt to match those from the object." Its lens focuses the rays on the retina in the usual way, and the visual system interprets their directions as locations in space.

The apparent object is usually a **virtual image**. Trace the outgoing rays backward and they meet at apparent points behind the hologram, so the object seems to be there. The light does not actually converge at those points, which is why a bare screen placed at the virtual-image location will not catch that image. A mirror image is virtual for the same geometrical reason.

Some holographic arrangements also produce a **real image**, where diffracted rays genuinely converge in front of the plate and can be intercepted on a screen. "Holographic image" does not automatically mean virtual, although the behind-the-plate virtual image is the familiar viewing arrangement.

The three-dimensional experience comes from the reconstructed directions:

- The left and right eyes occupy different positions, so each samples a slightly different part of the outgoing field. That supplies binocular disparity.
- Moving the head changes which rays enter the pupil, revealing a different perspective. That change is **parallax**.
- The eyes can change focus and convergence for different apparent depths when the wavefront supports those cues.
- Occluded features can appear or disappear as the viewing position changes, within the hologram's recorded aperture and angle range.

A full-aperture hologram can provide horizontal and vertical parallax. Some display holograms deliberately preserve mainly horizontal parallax to make white-light viewing practical. The word "hologram" alone does not guarantee every possible depth cue or an unlimited viewing zone.

> **Key idea** - The eye sees depth because the hologram rebuilds direction-dependent light, not because a flat picture contains a special visual trick.

## Where Fourier transforms enter

A **Fourier transform** is a mathematical change of description. It rewrites a pattern as a weighted collection of simple sinusoidal waves. The inverse Fourier transform combines those waves to recover the pattern.

For a one-dimensional example, a broad smooth variation contains mostly low **spatial frequencies**, meaning few cycles of change per millimetre. Fine stripes and sharp edges require higher spatial frequencies, meaning more cycles per millimetre. Spatial frequency describes variation across space. It is not the same as the optical frequency that distinguishes, for example, red light from blue light.

Why is this useful here? A complicated object field can be decomposed into many plane-wave components travelling at different angles. Across a plate, each angle produces a different phase slope. Interfering those components with a reference converts them into fringe components with particular spatial frequencies and orientations. During reconstruction, diffraction sends the corresponding components back into their encoded directions.

In that language, holography does this:

```text
object field
  = many directional wave components superposed

recording with a reference
  = those components shifted into measurable fringe frequencies

reconstruction by diffraction
  = fringe frequencies redirected into wave components again

wave components recombined
  = object wavefront
```

Optical systems can perform this mathematics physically. Under the appropriate approximations, a lens maps an input field to its Fourier transform at a focal plane. Free-space propagation is described by closely related Fresnel or Fraunhofer diffraction transforms. Dennis Gabor's original holographic method used this wave mathematics before lasers made high-quality optical holograms practical.

Not every hologram is specifically a **Fourier hologram**, a geometry in which the recording plane contains a Fourier-domain representation. Fresnel holograms and other arrangements use different propagation geometry. Fourier analysis remains useful because it reveals how distributed fringe frequencies carry and reconstruct the field.

The transform is not a mystical operation and it does not mean every small area holds a perfect miniature copy. It is a reversible way to move between two descriptions: a spatial pattern and the wave components from which that pattern can be built.

## "The whole in every part," stated accurately

For a diffusely reflecting object in a suitable recording geometry, light from each illuminated object point spreads across much of the plate. At any small plate region, the object field is therefore a superposition of contributions from many object points. The reference overlaps all of them. Information about the scene is distributed rather than assigned one object point to one plate point.

Cut the hologram and a fragment can still diffract light corresponding to the whole object. This is the optical fact behind the phrase **whole in every part**.

But the fragment is now a smaller aperture. An aperture is the finite opening through which the useful wavefront passes. Reducing it has consequences:

- **Less brightness.** A smaller area intercepts and diffracts less reconstruction light, so less optical power reaches the useful image.
- **Lower resolution.** A finite aperture cannot reproduce an ideal point as an infinitely small point. Its diffraction blur grows as aperture width $D$ shrinks, with a characteristic angular scale on the order of $\lambda/D$.
- **Narrower viewing angle.** The plate behaves like a window onto the reconstructed scene. A smaller window admits a smaller range of viewing positions and therefore less available parallax.
- **A changed viewpoint.** Different fragments occupy different positions in the original aperture. They can reconstruct the object from different restricted perspectives rather than acting as identical copies.
- **Greater sensitivity to noise and geometry.** Speckle, emulsion defects, occlusion, object directionality, and the exact recording arrangement can make parts of the reconstruction weak or absent.

So the defensible statement is:

> A fragment may retain information from the whole scene because the encoding is distributed, but it does not retain the original aperture or identical image quality.

This is not a minor footnote. Aperture is part of the information available to a viewer. Losing it costs brightness, resolution, and viewing range even when the whole object remains recognizable.

<!-- visual:hologram-fragment -->

## What this establishes / What it does not establish

### What this establishes

- Relative optical phase can be converted into a recordable intensity pattern by interference with a known reference wave.
- A sufficiently fine recording can preserve that interference structure.
- Suitable illumination can be diffracted by the recording into a reconstruction of the earlier object wavefront.
- A reconstructed wavefront can provide direction-dependent views, focus cues, and parallax.
- Holographic information can be distributed across the recording, making the image resistant to partial loss while still degrading with lost aperture.
- Fourier analysis gives a precise way to describe the conversion between spatial patterns and their wave components.

### What this does not establish

- It does not establish that memories are literal optical holograms or that every memory exists identically in every brain region.
- It does not establish that the physical universe is an optical projection from a hidden plate.
- It does not turn quantum nonlocality into permission for unrestricted signalling, paranormal effects, or mind-over-matter claims.
- It does not establish that consciousness creates external reality.
- It does not establish that a lower-dimensional physical description is a computer simulation.
- It does not make every fragment equivalent to the original hologram.

An optical mechanism can inspire a model elsewhere. Inspiration transfers a pattern worth investigating. It does not transfer proof.

## Five different meanings of "holographic"

<!-- visual:holographic-meanings -->

The same word now appears in optics, neuroscience, philosophy of physics, quantum gravity, and popular simulation arguments. These uses are related by analogy, not by one continuous chain of evidence.

### 1. Established optical holography

This is the mechanism explained above: coherent waves, a reference beam, interference, a high-resolution record, and diffraction-based reconstruction. It is experimentally established engineering. Its claims can be tested on a plate, an optical bench, or a digital holography system.

### 2. Pribram's controversial brain model

Neuropsychologist Karl Pribram proposed that some brain processing and memory are distributed in a hologram-like, frequency-domain manner. The attraction is understandable: neural signals are distributed, sensory systems can be analysed in spatial-frequency terms, and damage often degrades performance without deleting one neat, isolated memory.

The analogy does not make the brain an optical hologram. There is no reference laser, photographic plate, or demonstrated whole-memory reconstruction mechanism corresponding point for point to optical holography. Modern neuroscience supports distributed representation and frequency-sensitive processing in many contexts, but that is broader than, and does not by itself confirm, Pribram's holonomic brain theory. The model remains historically influential and scientifically controversial.

### 3. Bohm's implicate-order interpretation

Physicist David Bohm used the hologram as a model of **enfoldment**: an apparently disordered local pattern can contain information about a larger whole, which can later unfold into an observable form. His **implicate order** is a proposed deeper order from which the familiar **explicate order** emerges. His preferred term, the holomovement, emphasized that reality is dynamic rather than a static projected image.

This is a physical and philosophical interpretation, not a result derived from making an optical hologram. Bohm's implicate-order writing should also not be silently equated with every result of Bohmian mechanics, the distinct pilot-wave formulation of quantum theory. Optical holography demonstrates enfolded optical information. It does not demonstrate Bohm's proposed ontology of the universe.

### 4. The modern holographic principle

In quantum gravity, the **holographic principle** proposes that the physics within a region containing gravity may be fully encoded by degrees of freedom associated with a lower-dimensional boundary. The motivation includes black-hole entropy, which scales with horizon area rather than enclosed volume. The best-developed example is the AdS/CFT correspondence, where a gravitational theory in an anti-de Sitter bulk is related to a non-gravitational quantum field theory on its boundary.

This is not optical image formation. There is no laser, beam splitter, interference plate, or giant picture projected into space. "Holographic" names a structural resemblance: information about a higher-dimensional description can be represented in a lower-dimensional one. The principle is central to modern theoretical physics and has powerful mathematical evidence in specific settings, but it is not experimentally established as a literal description of our observable universe.

### 5. Simulation analogies

A simulation claim says that experienced reality is generated by computation on some underlying substrate. Holography can make that idea feel intuitive because both involve one description giving rise to another. The resemblance is not an implication.

An information-equivalent boundary theory need not be software. A reconstructed optical field is not a computation of consciousness. A successful mathematical encoding does not identify a programmer, hardware, purpose, or simulated world. Those are additional claims requiring additional evidence.

## Where Michael Talbot's claims belong

In *The Holographic Universe* (1991), Michael Talbot joins two proposals: Pribram's hologram-like model of brain function and Bohm's implicate-order picture of physical reality. Talbot presents the synthesis as a brain that interprets a frequency-like domain within a universe whose visible order unfolds from a deeper one.

Talbot attributes the brain argument to Pribram and the cosmic argument to Bohm, and he reports experiments and observations he believes support each. He also acknowledges that the combined model was controversial, unfinished, and not accepted by most scientists, and that Bohm and Pribram did not endorse every conclusion in his book.

Talbot then goes much further. He argues that the synthesis can explain paranormal and mystical experiences, including telepathy, precognition, psychokinesis, near-death experiences, and synchronicity. Those are **Talbot's claims and extensions**. They are not consequences established by optical holography, Fourier transforms, distributed neural processing, or quantum nonlocality. The distinction remains even if the optical analogy is vivid and even if some broader questions remain open.

The clean hierarchy is:

```text
optical holography
  established mechanism for recording and reconstructing light fields

Pribram
  controversial model using holographic and Fourier-like ideas for brain function

Bohm
  interpretive ontology using holographic enfoldment as a model of deeper order

modern holographic principle
  technical quantum-gravity claim about bulk and boundary descriptions

simulation language
  philosophical or computational analogy requiring its own evidence
```

Do not let the shared word do the arguing. Ask what is encoded, where it is encoded, what reconstructs it, and what observation could prove the claim wrong. Optical holography can answer all four. Every extension must earn its own answers.

## Sources and further reading

### Optical mechanism and wave foundations

- Dennis Gabor, [Nobel Lecture: Holography, 1948-1971](https://www.nobelprize.org/prizes/physics/1971/gabor/lecture/). Gabor's account of the invention, wavefront reconstruction, and the development of holography.
- Encyclopaedia Britannica, [Holography](https://www.britannica.com/technology/holography). A technical overview of recording, interference, and reconstruction.
- Georgia State University HyperPhysics, [Holography](http://hyperphysics.phy-astr.gsu.edu/hbase/optmod/holog.html). Concise optical diagrams and the recording/reconstruction geometry.
- OpenStax, [Young's Double-Slit Interference](https://openstax.org/books/university-physics-volume-3/pages/3-1-youngs-double-slit-interference). The wave-superposition basis of bright and dark fringes.
- OpenStax, [Circular Apertures and Resolution](https://openstax.org/books/university-physics-volume-3/pages/4-5-circular-apertures-and-resolution). Why reducing an aperture reduces resolving power.
- MIT OpenCourseWare, [2.71 Optics](https://ocw.mit.edu/courses/2-71-optics-spring-2009/). University-level material on diffraction, Fourier optics, coherence, and imaging.

### The broader uses of "holographic"

- Karl Pribram, [Holonomic brain theory](http://www.scholarpedia.org/article/Holonomic_brain_theory), *Scholarpedia*. A first-person technical overview of the brain model; it should be read as the model's case, not as scientific consensus.
- David Bohm, [*Wholeness and the Implicate Order*](https://www.routledge.com/Wholeness-and-the-Implicate-Order/Bohm/p/book/9780415289795). The primary book-length source for implicate order and holomovement.
- Stanford Encyclopedia of Philosophy, [Bohmian Mechanics](https://plato.stanford.edu/entries/qm-bohm/). Technical context for Bohm's pilot-wave theory and why it should not be collapsed into his later implicate-order philosophy.
- Michael Talbot, [*The Holographic Universe*](https://archive.org/details/holographicunive00talb). An archival catalogue and lending record for the source of the Pribram-Bohm synthesis and the broader claims attributed to Talbot above.
- Gerard 't Hooft, [Dimensional Reduction in Quantum Gravity](https://arxiv.org/abs/gr-qc/9310026). An early technical statement of the modern holographic idea.
- Leonard Susskind, [The World as a Hologram](https://arxiv.org/abs/hep-th/9409089). A foundational formulation of the holographic principle in quantum gravity.
- Juan Maldacena, [The Large N Limit of Superconformal Field Theories and Supergravity](https://arxiv.org/abs/hep-th/9711200). The original AdS/CFT correspondence paper.
- Raphael Bousso, [The Holographic Principle](https://arxiv.org/abs/hep-th/0203101), *Reviews of Modern Physics*. A detailed review of the principle's motivation, formulations, and limits.

> **The sentence to keep** - A photograph records an intensity image made by light; a hologram uses a reference wave to encode relative phase as fringes, then uses diffraction to rebuild the light itself.