# Dimensional Crossover and Thermo-Optic Interaction in Photon Bose-Einstein Condensates - Freie Universität Berlin

# Dimensional Crossover and Thermo-Optic Interaction in 

# Photon Bose-Einstein Condensates 

### – Dissertation – 

## Enrico Stein November 2022

## Dimensional Crossover and Thermo-Optic Interaction in 

## Photon Bose-Einstein Condensates 

– Dissertation – 

Enrico Stein 

Vom Fachbereich Physik der Technischen Universität Kaiserslautern zur Verleihung des akademischen Grades 

” Doktor der Naturwissenschaften“ genehmigte Dissertation 

Betreuer: Priv.-Doz. Dr. Axel Pelster Zweitgutachter: Prof. Dr. Michael Fleischhauer 

Datum der wissenschaftlichen Aussprache: 09. November 2022 

DE-386

Meinen Eltern und meiner Familie. Für die lange Unterstützung. 

I met a traveller from an antique land Who said: “Two vast and trunkless legs of stone Stand in the desert. Near them, on the sand, Half sunk, a shattered visage lies, whose frown, And wrinkled lip, and sneer of cold command, Tell that its sculptor well those passions read Which yet survive, stamped on these lifeless things, The hand that mocked them and the heart that fed: And on the pedestal these words appear: “My name is Ozymandias, king of kings; Look on my works, ye Mighty, and despair!” Nothing beside remains. Round the decay Of that colossal wreck, boundless and bare The lone and level sands stretch far away.” 

Percy Bysshe Shelley, ”Ozymandias”

## List of Publications 

[P1] E. Stein, F. Vewinger and A. Pelster, ‘Collective modes of a photon Bose–Einstein condensate with thermo-optic interaction’, New J. Phys. 21, 103044 (2019). 

[P2] E. Stein and A. Pelster, ‘Thermodynamics of trapped photon gases at dimensional crossover from 2D to 1D’, New J. Phys. 24, 023013 (2022). 

[P3] E. Stein and A. Pelster, ‘Photon BEC with thermo-optic interaction at dimen-sional crossover’, New J. Phys. 24, 023032 (2022). 

[P4] E. Stein and A. Pelster, ‘Quantum Mechanical Description of Thermo-Optic In-teraction’, arXiv: 2203.16955 (2022). 

[P5] E. Stein and A. Pelster, ‘Exact Diagonalisation of Photon Bose-Einstein Con-densates with Thermo-Optic Interaction’, arXiv: 2204.08818 (2022). 

i

ii

Abstract 

Photons in dye-filled microcavities resemble thermalised gases of massive particles in two dimensions. The photons develop a standing wave along the optical axis, reducing their spatial dimension from three to two and providing a finite photon mass. The shape of the mirror surface yields an effective potential for these particles. Finally, the in-teraction with the dye molecules allows the photon gas to thermalise and to undergo Bose-Einstein condensation. However, the dye molecules not only introduce thermalisa-tion into the system, but also mediate a photon-photon interaction. The latter is due to the heating of the dye solution as a result of the dye molecules converting absorbed photons into molecular excitations. This leads to a change of the refractive index and, thus, to the thermo-optic photon-photon interaction. In contrast to a contact inter-action, the thermo-optic interaction relies on the heat diffusion inside the die cavity. Consequently, it is non-local in space and retarded in time. Although experiments on photon-Bose-Einstein condensates have been carried out since 2010, concrete experi-mental investigations of the thermo-optic interaction are still lacking. Therefore, this thesis focuses on a theoretical description of the thermo-optic photon-photon interaction close to the experimental setup. The aim is to determine possibilities to increase the thermo-optic interaction and to pave the way for high-resolution meas-urements of its strength. To this end, working out the detailed heat diffusion inside the dye cavity is the first step. This allows linking the time constant of the diffusion along the optical axis to the remaining two-dimensional diffusion. The strength of the thermo-optic interaction turns out to depend on the geometry of the cavity mirrors. A second study investigates the dimensional crossover of the photon gas from two dimensions to a single dimension by introducing a large trap anisotropy. As a result, the effective dimen-sion of an ideal Bose gas at the dimensional crossover depends on the thermodynamic temperature of the gas and the trap-aspect ratio. Afterwards, a variational approach reveals the behaviour of the thermo-optic interaction at the dimensional crossover. The thermo-optic interaction behaves differently than a contact interaction at the crossover, as the former saturates for larger trap aspect ratios. This behaviour is due to a compe-tition of the diffusion length scale with the condensate length scale. Finally, the last step combines the thermodynamic investigation with a detailed interaction study to obtain a Hartree-Fock analogue theory for the thermo-optic interaction. This theory allows pre-dicting the energy shifts of the different eigenmodes due to the thermo-optic interaction and suggests performing high-precision spectroscopic measurements for determining the strength of the effective photon-photon interaction. In conclusion, this thesis provides further understanding of the thermo-optic photon-photon interaction and first insights into the dimensional crossover of thermalised photon gases. The theoretical results are close to the experiments, such that the relevant experi-mental parameter regimes can be identified. In addition, the thesis suggests determining the strength of the effective photon-photon interaction via high-resolution spectroscopic measurements. 

iii

iv

Zusammenfassung 

Photonen in farbstoffgefüllten Mikrokavitäten ähneln thermalisierten Gasen aus massi-ven Teilchen in zwei Dimensionen. Die Photonen entwickeln eine stehende Welle entlang der optischen Achse, wodurch sich ihre räumliche Dimension von drei auf zwei redu-ziert und eine endliche Photonenmasse entsteht. Die Spiegeloberfläche fungiert hierbei als ein effektives Potential für diese Teilchen. Schließlich ermöglicht die Wechselwirkung mit den Farbstoffmolekülen die Thermalisierung des Photonengases und dessen Bose-Einstein-Kondensation. Allerdings führen die Farbstoffmoleküle nicht nur zur Thermali-sierung, sondern vermitteln auch eine Photon-Photon-Wechselwirkung. Letztere ist auf die Erwärmung der Farbstofflösung zurückzuführen. Hierbei wandeln die Farbstoffmo-leküle absorbierte Photonen in molekulare Anregungen um. Dies führt zu einer Änderung des Brechungsindexes, was eine thermo-optische Photon-Photon-Wechselwirkung zur Folge hat. Im Gegensatz zu einer Kontaktwechselwirkung beruht die thermo-optische Wechselwirkung auf der Wärmediffusion innerhalb der Kavität, sodaß diese nichtlokal im Raum und in der Zeit retardiert ist. Obwohl Experimente zu Photonen-Bose-Einstein-Kondensate schon seit 2010 durchgeführt werden, fehlen konkrete experimentelle Unter-suchungen zur thermo-optischen Wechselwirkung. Daher konzentriert sich diese Arbeit auf eine experimentnahe, theoretische Beschrei-bung dieser thermo-optischen Wechselwirkung mit dem Ziel, Möglichkeiten zu ihrer Verstärkung zu finden und hochauflösende Messungen der Stärke zu ermöglichen. Hierzu wird in einem ersten Schritt die Wärmediffusion im Inneren der Farbstoffkavität detail-liert untersucht. Dies ermöglicht es, die Zeitkonstante der Diffusion entlang der optischen Achse mit der übrigen zweidimensionalen Diffusion zu verknüpfen. Dabei zeigt sich, daß die Stärke der thermo-optischen Wechselwirkung von der Geometrie der Spiegel abhängt. In einem zweiten Schritt wird der dimensionale Übergang des Photonengases von zwei Di-mensionen zu einer einzigen durch Einführung einer großen Fallenanisotropie untersucht. Hierbei wird die effektive Dimension eines idealen Bose-Gases am Dimensionsübergang bestimmt, die sowohl von der thermodynamischen Temperatur des Gases als auch dem Verhältnis der Fallenfrequenzen abhängt. Anschließend wird mithilfe eines Variationsan-satzes das Verhalten der thermo-optischen Wechselwirkung am dimensionalen Übergang bestimmt. Die thermooptische Wechselwirkung verhält sich am Übergang anders als eine Kontaktwechselwirkung, da erstere bei größeren Fallenaspektverhältnissen in Sättigung geht. Dieses Verhalten läßt sich durch einen Vergleich der Diffusionslängenskala mit der Kondensatlängenskala verstehen. Im letzten Schritt wird die thermodynamische Untersu-chung mit der Wechselwirkungsstudie kombiniert und eine Hartree-Fock ähnliche Theo-rie für die thermo-optische Wechselwirkung aufgestellt. Der Vorteil dieser Theorie liegt in der Möglichkeit, die Energieverschiebungen der verschiedenen Eigenmoden aufgrund der thermo-optischen Wechselwirkung vorherzusagen. Sie ermöglicht daher hochpräzise spektroskopische Messungen zur Bestimmung der Stärke der effektiven Photon-Photon-Wechselwirkung. Zusammenfassend lässt sich sagen, daß diese Arbeit einen weiteren Einblick in die thermo-optische Wechselwirkung und einen ersten Einblick in den Dimensionsübergang von thermalisierten Photonengasen gibt. Die theoretischen Modelle liegen nahe an den Experimenten, sodaß die interessanten experimentellen Parameterregime bestimmt wer-den können. Darüber hinaus werden in der Arbeit Möglichkeiten vorgeschlagen, die Stärke der effektiven Photon-Photon-Wechselwirkung durch hochauflösende spektrosko-pische Messungen zu bestimmen. 

v

## Contents 

Motivation and Outline ix 

1. Introduction 1 1.1. Laser . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 2 1.2. Exciton-Polariton BECs . . . . . . . . . . . . . . . . . . . . . . . . . . . . 12 1.3. Photon Bose-Einstein Condensates . . . . . . . . . . . . . . . . . . . . . . 17 

2. Collective Modes of a Photon Bose–Einstein Condensate with Thermo-Optic Interaction 43 

3. Thermodynamics of Trapped Photon Gases at Dimensional Crossover from 2D to 1D 57 

4. Photon BEC with Thermo-Optic Interaction at Dimensional Crossover 75 

5. Quantum Mechanical Description of Thermo-Optic Interaction 91 

6. Exact Diagonalisation of Photon Bose-Einstein Condensates with Thermo-Optic Interaction 107 

7. Conclusion 127 

8. Outlook 131 8.1. Thermodynamics . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 131 8.2. Projected Gross-Pitaevskii Equation . . . . . . . . . . . . . . . . . . . . . 135 8.3. Vortices . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 136 8.4. P-Function Representation for Photon Bose-Einstein Condensate . . . . . 138 8.5. Dye Bleaching . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 140 

A. Harmonic Oscillator Coupled to a Bosonic Heat Bath 143 A.1. Born-Markov Master Equation . . . . . . . . . . . . . . . . . . . . . . . . 143 A.2. Master Equation of Lindblad Form . . . . . . . . . . . . . . . . . . . . . . 145 

B. Effective Steady State of Temperature 147 

C. Derivation of Microscopic Model 149 C.1. Molecular Hamiltonian . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 149 C.2. Photon BEC Master Equation . . . . . . . . . . . . . . . . . . . . . . . . 150 

Bibliography 155 

Acknowledgement 165 

vii

## Motivation and Outline 

Γνῶθι Σεαυτόν 

know thyself 

Oracle of Delphoi 

It was at the island Aiaia, the home of the witch Kirke, that Odysseus and his com-panions landed on during the ten years homecoming struggle after the Troian war. A group of the companions soon found Kirke’s palace, when they scouted the island. In thought of defending herself, she invited the foreigners to a meal, which she used for transforming the men into pigs. She turned everyone into pigs except Eurylochos who stayed outside and witnessed the whole spectacle. Scared from what he saw, he ran back to the ships and reported to Odysseus. Odysseus called together the remaining fellows and set about freeing the prisoners. Underway, the god Hermes, the Olympian messenger, handed a herb to Odysseus to circumvent Kirke’s magic. Figure 1 a) shows Kirke receiving Odysseus to her palace and inviting him and his men to dinner — but Hermes’ herbs prevent their transformation into pigs this time. Instead, Odysseus drew his sword and threatened Kirke. Recalling Odysseus from a message, that Hermes de-livered to her, she promised Odysseus to transform his men back—from pigs to human beings. After sleeping with Odysseus, she did as she promised. The Troians lived for a whole year freely on the island, before continuing the journey home. Who would have thought that nearly 2000 years later, this story from the Odyssey [1, 2] still occupies the minds of humanity. It shows the strong human interest in observing and explaining the transformation of different things into each other. Nearly every founda-tional myth invented by humanity is a story about transformations [6]. Transformations of human beings into animals and back, transformations of gods into humans, animals or whatever seemed rational to them. Even the creational chaos itself transformed into some order, as the Latin poet Ovid sings about at the beginning of the Metamorphosis, a whole Epos dedicated to the description of transformations. Even possible scientific explanations of these myths are discussed [7]. This fascination not only found its expression in the storytelling setting of myths, but it also came down to practical worshipping cults. Throughout the pre-Christian antiquity, humanity has invented whole new gods and goddesses, whose cults wandered through the Mediterranean area [8]. Some of them have syncretised into new ones. The most famous example of this happening is Serapis, the state god of the Ptolemaic Egypt [9]. Serapis, as depicted in figure 1 b), is a mixture between the Egyptian gods Osiris and Apis and the Greek gods Zeus and Hades [8], as shown in figure 1 c). Ptolemaios I. Soter ordered this cult to be created to preserve the Ptolemaic rule over Egypt. In the course of this, Serapis became one of the most important gods in the Hellenic Egypt and, later on, also in the Roman Empire [10, 11]. But not only in the mythical and cultic realm did transformations help humanity to understand the world. With the work of the pre-Socratic philosophers these ideas found their way into the description of nature. Thales from Miletos, who the scientific reader knows through his famous theorem, was the first to cross the bridge from the mytho-

ix

Motivation and Outline 

## a) 

## b) c) 

Fig. 1: a) “Circe Offering the Cup to Ulysses” [3], John William Waterhouse, Oil on canvas, 1891. b) Serapis as Osiris-Apis [4]. The back shows the Apis bull, whereas the front shows the human look-alike of Osiris. c) Serapis as Zeus with the characteristic kalathos (basket) on his head [5], Roman copy of Bryaxis. The pictures are public domain. 

x

logical description of nature to a more scientific one [12]. For Thales the kind of main matter (ἀρχή), which lays at the foundation of all matter being, is water. According to Aristotle, Thales has deduced this insight from the observation of food being wet combined with food being transformed into heat, which allows for life. Also, the seeds of life, either vegetable or animal, are wet. Hence, water is the ἀρχή of life and, therefore, of everything. But from observations he deduced further that water does not only stay as water, it can also transform into other things, like smoke and fire. Through these transformations, water can form the whole of creation. With his theory, Thales started to question the aphoristic, but admonitory words of the Γνῶθι Σεαυτόν (know thyself) emblazoned on the walls of Apollos’ temple at Delphoi. The modern reader might now ask: Why are these old mythological and philosophical theories still relevant today, and why do they stand at the beginning of a PhD thesis in physics? Because the main thinking has not changed during the period of the last two thousand years. Still, the modern physical description of the world is founded upon elementary particles transforming into each other, like a photon decaying into an electron-positron pair. According to quantum mechanics, particles change their beha-viour, being either particle-like or wave-like. Just as Thales declared water as being the kind of matter from which everything being is deduced, scientists nowadays search for the fundamental particles of matter and how they constitute all the known mat-ter. Reference [13] gives an account of this thinking by simulating quantum systems by other quantum systems. Thinking of transformations between different manifestations of things was and is always guiding human thinking [6]. To underscore this statement, the remainder of this section follows the development of understanding and describing light. In Ancient Greece, the natural philosophers thought that light developed in the eyes and strayed as rays out of the eye, allowing for animals and human beings to see. This theory held until the mechanistic description of Newton arose at the end of the 17th century. Newton mentioned light as being small particles with different masses, accounting for different colours [14]. He was able to explain the light propagation in free space, as well as refraction and reflection. But this corpuscular theory does not describe light inter-ference, as this is an intrinsic feature of waves. The wave theory of light, first proposed by Huygens [15], explained the latter. He was able to describe refraction, reflection, and interference effects as well, but he failed in the description of free-space propaga-tion. Therefore, in order to deliver a complete theory, Newton mixed some wave-like behaviour, which Huygens proposed, into his corpuscular theory, showing that light is described by some new kind of hybrid theory — hybrid in the sense of light being indis-pensably both a wave and a massive particle. Until the 19th century, these two theories existed side-by-side. But experimental find-ings by Young and Faraday, amongst others, resulted in Maxwell formulating his famous equations describing electromagnetism [16]. These equations support wave solutions, which were soon identified to represent light. Therefore, the pointer strongly moved in favour of the wave theory of light. As the experiments by Michelson and Morley suppor-ted by the theory of Einstein revealed light to propagate in vacuum [17], the common view was that light is fully understood, apart from minor problems like the black-body radiation and the photoelectric effect. However, these so-called small problems of physics at the edge of the 19th and 20th centuries held the potential to completely revolutionise physics. The first step in this direction was Planck working on the black-body radiation problem [18–20]. By that 

xi

Motivation and Outline 

time, the only existing laws describing the spectral distribution of a black-body radi-ator were the Wien and the Rayleigh-Jeans law. These were either able to describe the short or the long wavelength regime, but never the whole spectrum. By assuming finite energy quanta of the light field, Planck was able to derive a formula describing black-body radiation at the whole spectrum with the correct short and long wavelength limits. In the same manner, Einstein successfully described the photoelectric effect also by introducing discrete quanta for the light field, the photons [21]. These fundamental discoveries led to the Nobel Prizes for Planck in 1918 and for Einstein in 1921. But it is noteworthy that discrete energy quanta are more in favour of a particle-like behaviour of light, standing in slight contradiction to the thinking developed in the former century of light being a wave. Nevertheless, the up-coming quantum mechanics solved this riddle by anticipating the wave-particle duality, where the spread of a particle is described as a wave until measurement, which collapses the wave into the measurement result [22, 23]. Interference effects are in this theory understood probabilistically, such that a whole ensemble of measurements results in the well-known interference patterns. Nowadays in physics, the wave-like behaviour of matter is a well known phenomenon from the Bose-Einstein condensation of ultracold atomic gases. Hereby, atoms macro-scopically occupy the ground state of the given ensemble, provided the system is below a certain critical temperature. Consequently, the ground-state atoms are coherent with each other, behaving like a large matter-wave. In the present thesis, this thinking is kind of taken upside down and reminds of the Shakespearian comedy “What you Will”, where Viola, the main role, which at that time a man played, disguises herself as a man. Thus, it is a man playing a woman pretending to be a man. Photons in a dye-filled cavity represent nearly the same situation, as such a cavity modifies the photons to behave like massive particles. Since a microcavity contains the photons, their three-dimensional wave behaviour turns into that of two-dimensional massive particles. These are tweaked to thermalise and to effectively resemble a system of atoms, just to be turned into a wave-like Bose-Einstein condensate again. This shows that transforming things into each other is still the driving force of modern thinking [13]. 

Outline 

The main topic of this thesis is to develop an experiment-near theory for photon Bose-Einstein condensates (BECs). In the course of the following chapters, the developed theories mainly concern the arising effective photon-photon interaction. The results pay special attention to the differences between this effective photon-photon interaction and the contact interaction in atomic condensates, in such a way that the corresponding results can be compared to the experiment. With the same spirit to support planned experiments in Kaiserslautern, the dimensional crossover of photon BECs from 2D to 1D is also worked out. To this end, chapter 1 introduces the reader to the topic of phase transitions of light. The section provides an overview of the first known phase transition of light, namely the laser phase transition. Afterwards, it touches upon the topic of exciton-polariton condensates, which are the first condensates involving photons. It concludes with a detailed discussion of the principles of dye-cavity photon gases and discusses both the state-of-the-art theoretical modelling and the current experimental status. The description and the implications of the effective photon-photon interaction are at the focus of chapter 2. First, it introduces a heuristic model for describing the thermo-optic 

xii

photon-photon interaction. This model contains a detailed description of the temperat-ure diffusion through the entire cavity structure. As this is a three-dimensional set-up, the first main effort consists in reducing the diffusion equation to an effectively two-dimensional problem, such that both the temperature diffusion and the photon BEC are described on the same footing. This theoretical model allows investigating the effect of the thermo-optic interaction upon the collective excitations of the photon BEC. The next two chapters treat the dimensional crossover of the photon BEC from 2D to 1D. The idea is to strongly confine the gas in a single direction, such that the degrees of free-dom in this direction freeze out. Hence, only the degrees of freedom in the non-squeezed direction remain occupied by the system, and it effectively behaves as one-dimensional. In this context, chapter 3 answers the question of the effective dimensionality of the sys-tem along the crossover. For this purpose, it analyses the thermodynamics of an ideal Bose gas in a harmonic confinement, where one of the two directions is squeezed. As a result, the specific heat defines the effective dimension in both the condensate and the thermal phase. Chapter 4 connects to this study and determines the influence of the effective photon-photon interaction upon the photon BEC ground state at the dimensional crossover. It turns out that the interaction increases as the trap anisotropy increases. Here, the inter-play of the length scales set by the temperature diffusion and the condensate diameter becomes relevant. If the latter is smaller than the first, the thermo-optic interaction saturates. This saturation effect is the main difference to a corresponding setting for a standard contact interaction. As the chapters 3 and 4 either focus on the thermodynamics without interaction or on the interaction without thermodynamics, the question arises how to unify these two points of view. Hence, the next two chapters cover this question by deriving a Hartree-Fock analogue for the thermo-optic interaction. For this purpose, chapter 5 works out the basic theory for describing the thermo-optic interaction during a single experimental cycle. The main difference between a stand-ard Hartree-Fock method for a contact interaction and the one worked out here, lies in the effect of the time scales. As the temperature diffusion and, therefore, the photon-photon interaction develop on a much longer timescale than the lifetime of a single experiment, the theory takes into account the temperature diffusion adiabatically. As a result, the Hamiltonian describing the photon-photon interaction takes the form of a time-dependent matrix. Chapter 6 analyses the implications of this description in greater detail. To this end, a photon gas inside a harmonic trap is investigated by using exact diagonalisation for the Hamiltonian matrix derived previously in chapter 5. First, the study verifies that the method is able to reproduce formerly derived results. Chapter 4 already points out the increasing interaction strength at the dimensional crossover. This implies that in the Hartree-Fock case, the coupling to the thermal cloud also increases. Along this line, the chapter concludes by pointing out the deviations, the thermal cloud introduces, com-pared to former approaches used in the literature. Chapter 7 summarises the findings in the thesis, whilst chapter 8 provides an outlook for further interesting topics and presents selected preliminary results. 

xiii

## 1. Introduction 

... eritis sicut deus scientes bonum et malum. ... ye shall be as god, knowing good and evil. 

Genesis 3, 5 

Nowadays, Bose-Einstein condensation of atomic clouds is a well understood macro-scopic quantum phenomenon and an often used experimental platform [24–26], resulting in complex machines. Optical experiments, on the other hand, are conceptionally much easier. Thus, the question arises, whether light can undergo phase transitions just like atomic systems. However, there are two fundamental differences between an ensemble of atoms and one of photons. Firstly, in contrast to atomic ensembles, photons do not interact with each other, preventing light ensembles from thermalising [27]. Due to a vanishing chemical potential, the photon number itself is not conserved, which leads to the second difference. Usually, experiments with light as a platform constitute a highly open-dissipative environment. Hence, the light ensemble is less likely to be in a thermal state. Thus, which features known from phase transitions in atomic ensembles survive in light ensembles? In particular, the phase transition to a Bose-Einstein condensate (BEC) is of interest. In ideal gases at thermal equilibrium, the most striking feature of a BEC is a macroscopic occupation of the system’s ground state [24, 25]. Due to this macroscopic occupation, a long-range coherence builds up in the system. A more formal way to understand and to classify this phase transition consists of using the concept of spontaneously breaking the U(1) symmetry of the complex-valued matter field in the condensed phase [26]. In atomic systems, these considerations are well known and understood, even in the realm of interacting systems. The application of these concepts to open-dissipative systems began with the invention and successful theoretical description of the laser, which section 1.1 recaps. However, this system consists, in principle, only of a single mode and is highly open-dissipative, such that from the above listed criteria only the spontaneous symmetry breaking argu-ment can be used, but no thermal state evolves. Section 1.2 treats a second example of a highly non-equilibrium condensation phe-nomenon, the exciton-polariton condensate. In this system, the condensing particles are polaritons, which are hybrid particles of excitons, i.e., particle-hole excitations con-fined in a quantum well, and photons from the cavity surrounding the quantum well. Due to the strong light-matter coupling in this system, the photons and the excitons form polaritons. Therefore, no condensation of real photons is observed. Moreover, the large matter part of the polaritons is responsible for a large interaction in these condensates. Although, they are the opposite to the original thought of BEC in an ideal Bose gas, they constitute an interesting platform for investigating the definition of Bose-Einstein condensation and for non-equilibrium dynamics. Finally, section 1.3 concludes this chapter with an extensive overview of BECs of pure 

1

1. Introduction 

photons. Here, photons coupled to dye molecules resemble a thermal steady state inside a dye-filled cavity. The photons inherit their thermalisation from the thermalised dye vi-brations through spontaneously emitted photons. Therefore, the spontaneous emission plays a key role in achieving a photon BEC. Due to this setup, the effective photon-photon interaction is quite weak and this kind of BEC is much closer to the ideal gas case. However, it is still a non-equilibrium system, since cavity losses have to be com-pensated by a laser, but the strength of the non-equilibrium effects can be controlled by appropriately tuning the coupling between photons and dye. The section gives an overview of the involved physical concepts and the existing literature in both theory and experiments, as well. 

1.1. Laser 

This section introduces and discusses the description of a single-mode laser, which is the first example of light undergoing a phase transition in this thesis. In the simplest approximation, a laser consists of an ensemble of two-level atoms coupled to a single light field. In addition, the former is subject to an external pump and spontaneous decays into non-cavity modes, whereas the latter experiences a cavity decay. Hence, the laser is an open-dissipative system at heart. The book [28] provides a complete review of laser theory, whilst reference [29] summarises the main points and techniques. 

1.1.1. Rate Equations 

The easiest approach for understanding laser dynamics is based on rate equations. This set of equations only accounts for the population dynamics of the ground and the excited state of the two-level system and a single light mode as well. It neglects all coherences in the system, which is in general a bad approach, since quantum mechanics is built upon the emergence of coherences. In an open-dissipative system, however, these coherences are usually destroyed by the external pump. Brought to simple words, this means, the more open the system, the better such a “classical” description becomes. This subsection follows the main points of reference [29]. 

Equations The rate equation for the population N↑ of excited-state atoms reads 

Ṅ↑ = Γ↑N↓ − Γ↓N↑ +B (N↓ −N↑)n , (1.1) 

where the first term describes the external pump with rate Γ↑ and ground-state occupa-tion N↓, the second one the non-radiative decays with rate Γ↓ and excited-state occupa-tion N↑. The last term introduces the induced emission and absorption of photons. Both processes happen according to Einstein at the same rate B [30] and are proportional to the photon population n. Figure 1.1 depicts these different processes. The rate equation for the ground-state occupation simply follows the one of the upper population 

Ṅ↓ = −Ṅ↑ , (1.2) 

such that the total number of atoms N = N↑+N↓ is conserved. The photon population n inherits the interaction term from (1.1) with the cavity decay κ in addition: 

ṅ = − [B (N↓ −N↑) + κ]n . (1.3) 

2

1.1. Laser 

Fig. 1.1: Different processes accounted for in the rate equations (1.1)–(1.3). The two atom levels are denoted by |↓⟩ , |↑⟩, and the light-matter interaction is depicted in solid blue, while the external processes are in dashed red. 

In the system (1.1)–(1.3) the external pump rate Γ↑ serves as a control parameter, whereas all the other parameters are fixed. The population inversion D = N↑ − N↓ summarises equations (1.1) and (1.2) to a single one, as the total atom number N is conserved due to (1.2). In most experimental settings, the matter degrees of freedoms evolve on a faster timescale than the photon degrees of freedom. Consequently, the former can be adiabatically eliminated, such that the population inversion takes the form 

D = D0 

1 + n/n̄ , (1.4) 

where D0 = N(Γ↑ − Γ↓)/(Γ↑ + Γ↓) denotes the population inversion solely due to the pump and relaxation processes and n̄ = (Γ↑+Γ↓)/(2B) is the saturation-photon number. Inserting the population inversion (1.4) into (1.3) yields the photon population equation 

ṅ = 

( C 

1 + n/n̄ − 1 

) κn , (1.5) 

with the cooperativity C = BD0/κ, which compares the light-matter coupling B with the external influences. The remainder of this subsection works out the non-equilibrium properties of the photon equation (1.5). 

Steady States and Their Stability In the steady state, characterised by ṅ = 0, equation (1.5) yields two solutions for the steady-state photon number n0, namely the trivial steady state 

ntriv0 = 0 , (1.6) 

and the non-trivial steady state 

n0 = n̄ (C − 1) , (1.7) 

which only exists for a large enough cooperativity C ≥ 1. In physical terms, this means the external pump has to overcome the losses for supporting a finite photon number. A linearisation of the photon equation (1.5) near the two steady states of the form n = n0 + δn allows investigating their linear stability. For the trivial case (1.6) the linearised equation takes the form 

δṅ = (C − 1)κδn , (1.8) 

3

1. Introduction 

0.0 0.5 1.0 1.5 2.0 C 

0.0 

0.2 

0.4 

0.6 

0.8 

1.0 

n 0 /n 

Fig. 1.2: Stable steady states from (1.6) and (1.7) (solid line) compared to the linearised steady state (1.12) (dashed line). 

which is only stable for C < 1, i.e., as long as the non-trivial steady state (1.7) does not exist. On the other hand, linearising near the non-trivial steady state (1.7) results in 

δṅ = 

( 1 

C − 1 

) κδn , (1.9) 

indicating the non-trivial steady state to be stable, when the trivial one is unstable. 

Phase Transition Near the phase transition, meaning the transition from the trivial to the non-trivial steady state, equation (1.5) can be expanded in orders of the photon number. Due to the small photon number, a truncation of this expansion after the second order is justified. The resulting equation is of the form 

ṅ ≈ −∂V ∂n 

, (1.10) 

with the potential 

V = −α 2 n2 + 

β 

3 n3 . (1.11) 

The two constants in the potential (1.11) are given by α = (C−1)κ and β = Cκ/n̄. Thus, the question of linear stability is reduced to the question of finding minima and maxima of the potential (1.11). As in the former paragraph, the potential (1.11) supports two extrema, the trivial state ntriv0 = 0 and the non-trivial state 

nlin0 = α/β . (1.12) 

However, compared to the original expressions (1.6) and (1.7), these two steady-states are only valid in the immediate vicinity of the phase transition, as figure 1.2 pictures. The latter exists provided that both α ≥ 0 and β > 0. The second derivative 

∂2V 

∂n2 = −α+ 2βn (1.13) 

yields for the trivial steady state −α, which results for α < 0 in a minimum and, thus, a stable state, whereas for α > 0 the minimum turns into a maximum, which indicates an unstable state. For the non-trivial state nlin0 = α/β the second derivative (1.13) takes the value of α and, thus, the non-trivial state is always stable, if it exists. 

4

1.1. Laser 

1.1.2. Master Equation and Stochastic Treatment 

As already mentioned, rate equations are a simplified description of an open-dissipative quantum system, which already yield a first view into the system dynamics. A more fundamental approach consists in using a master equation. The advantages of this microscopic approach are to link the ad-hoc parameters from the rate equation approach to microscopic parameters and to provide a full quantum mechanical picture of the system. 

Master Equation The Jaynes-Cummings Hamiltonian [28, 31] describes the dynamics of a single cavity mode with photon-matter detuning δ, which coherently interacts with an ensemble of N two-level atoms 

ĤJC = ℏδâ†â+ g N∑ 

i=1 

( â†σ̂−i + âσ̂+i 

) , (1.14) 

where â (â†) denotes the photon annihilation (creation) operator and σ̂±i stand for the atomic raising/lowering operators. The parameter g quantifies the coherent light-matter interaction. In the following, a master equation of Lindblad type takes into account open-dissipative effects like external pumping und cavity decay. Appendix A discusses the derivation and the generic form of this kind of equation. With the cavity decay rate κ, the external pump rate Γ↑, the radiationless decay rate Γ↓ and the Jaynes-Cummings Hamiltonian (1.14), the laser master equation takes the form 

˙̂ρ = − i 

ℏ 

[ ĤJC, ρ̂ 

] − 1 

2 

{ κL[â] + Γ↑ 

N∑ 

i=1 

L[σ̂+i ] + Γ↓ N∑ 

i=1 

L[σ̂−i ] } ρ̂ , (1.15) 

with the Lindblad superoperator 

L[x̂]ρ̂ = x̂†x̂ρ̂+ ρ̂x̂†x̂− 2x̂ρ̂x̂† , (1.16) 

as derived in appendix A. There are several methods for solving the master equation (1.15). One analytical way consists in calculating the hierarchy of the expectation values, i.e., the first-order expect-ation values couple to the second-order ones, etc. This hierarchy has to be truncated at a certain level. Considering only the first-order expectation values ⟨â⟩, 

〈 σ̂−i 〉 and ⟨σ̂zi ⟩ leads 

to the so-called semiclassical laser equations, the treatment of which is outlined, e.g., in references [28, 29, 32]. However, one drawback of this approach is to neglect the spon-taneous emission. The second-order expectation values contain this effect again. The authors of reference [33] work this out for the photon BEC case, but it can be adopted for the laser case as well. Alternatively, a Monte-Carlo wave-function approach [34, 35] provides numerical insight into the system dynamics. For instance, the Julia quantum optics package [36] provides a simple to use, but highly sophisticated library for directly implementing the master equation (1.15). Within the Monte-Carlo approach, the co-herent system evolution with the Jaynes-Cummings Hamiltonian (1.14) gets enriched with stochastic quantum jumps according to the Lindblad part of the master equation (1.15). Another method for treating the master equation (1.15) uses the P -function representation [37–39] of the photon field together with an adiabatic elimination of the matter degrees of freedom [40]. P -functions are based on a coherent-state expansion of 

5

1. Introduction 

the density matrix. Therefore, they are defined in the phase space and allow for a map-ping of the quantum-mechanical operators to stochastic variables. On formal grounds, the P -function is a quasiprobability distribution for normal-ordered averages. In the following, this method is worked out in more detail for the laser master equation (1.15). 

P-Function Representation This method results in a Fokker-Planck equation for the photon field. The present thesis works out the P -function method in greater detail than originally proposed in reference [40], where this method is based upon a projector formalism. However, in reference [40] the method is not treated rigorously, since the spontaneous emission is not included in the matter equations and the photon popula-tion is not included in the strength of the spontaneous emission. Therefore, in reference [40] the formalism cannot reproduce the rate equations including spontaneous emission. The remainder of this section rederives this method using equations for the expecta-tion values of the matter based upon the master equation itself. Later, all appearing partial derivatives, which do not fit into the form of a Fokker-Planck equation, are con-sistently neglected. This procedure results in the spontaneous emission to be included self-consistently in the description. Before starting with the details of the derivation, note that all the two-level systems are assumed to be equivalent, such that the corresponding index at the Pauli matrices is dropped, and the sums 

∑N j=1 = N are carried out. Moreover, the master equation 

(1.15) is first transformed into a frame rotating with a yet unknown frequency Ω by the transformation 

ρ̂→ eiΩt(â†â+σ̂z/2)ρ̂e−iΩt(â†â+σ̂z/2) . (1.17) 

Transformation (1.17) ensures that the system can break the U(1) symmetry leading to a large occupation in the photon mode. It produces an additional term−iℏΩ 

[ â†â+ σ̂z/2, ρ̂ 

] 

on the right-hand side of the master equation (1.15). The first step consists in writing the density matrix ρ̂ in the form 

ρ̂ = 

∫ d2α |α⟩ ⟨α| χ̂(α, α∗), (1.18) 

where |α⟩ denotes coherent photon states and χ̂ is the P -representation for the photonic degrees of freedom but still a density matrix for the atomic degrees of freedom. Due to this the following correspondences with respect to the photon operators can be used [40] 

âρ̂↔ αχ̂, (1.19a) 

ρ̂â↔ ( α− ∂ 

∂α∗ 

) χ̂, (1.19b) 

α̂†ρ̂↔ ( α∗ − ∂ 

∂a 

) χ̂, (1.19c) 

ρ̂â† ↔ α∗χ̂ , (1.19d) 

where α is a stochastic variable linked via the eigenvalue equation â |α⟩ = α |α⟩ to the photon coherent states. Using the representation (1.18) for the density matrix and the correspondence rules (1.19), the resulting equation of motion for χ̂ decomposes into three parts: 

˙̂χ = (LF +NLM +NLMF) χ̂, (1.20) 

6

1.1. Laser 

where the first part 

LFχ̂ = 

[ ∂ 

∂α α ( iδ̄ + 

κ 

2 

) + 

∂ 

∂α∗α ∗ ( −iδ̄ + κ 

2 

)] χ̂ (1.21) 

describes the pure evolution of the electromagnetic field with δ̄ = δ−Ω being the photon detuning in the rotating frame. The matter evolution is governed by 

LMχ̂ = − iΩ 2 

[σ̂z, χ̂]− 1 

2 

( Γ↑L[σ̂+] + Γ↓L[σ̂−] 

) χ̂. (1.22) 

Lastly, the coupling of matter and field is summarised by the last term in (1.20) 

LMFχ̂ = −ig { α∗ [σ̂−, χ̂ 

] + α 

[ σ̂+, χ̂ 

] − ∂ 

∂α σ̂−χ̂+ 

∂ 

∂α∗ χ̂σ̂ + 

} . (1.23) 

In the following, the density matrix χ̂ is assumed to be the direct product 

χ̂ ≈ Pχ̂M (1.24) 

with P = trMχ̂ denoting the Glauber-Sudarshan P -function for the photon field and χ̂M = trFχ̂ is the density matrix for the matter. In both cases, M/F indicates the trace with respect to the matter/photon field, respectively. This approximation neglects the correlations of light and matter, which may be included in an approach based on a combined P -function representation for both photon field and matter [41, 42]. Another approach uses the truncated Wigner function for both matter and light field [43]. With the same argumentation as in the preceding subsection, the matter degrees of freedom are adiabatically eliminated, meaning the density matrix χ̂M is assumed to be in its steady state, which still depends on the photon degrees of freedom. 

Fokker-Planck Equation The next step is to derive a Fokker-Planck equation for the P -function and the necessary matter expectation values from the master equation (1.20). The Fokker-Planck equation is a partial differential equation and summarises the evol-ution of a probability density subject to a deterministic drift and a stochastic diffusion. Reference [44] gives a detailed overview on the Fokker-Planck equation. Tracing out the matter degrees of freedom in (1.20) yields directly the equation of motion for the P -function 

Ṗ ≈ { LF + igN 

[ ∂ 

∂α 

〈 σ̂− 〉 M − ∂ 

∂α∗ 〈 σ̂+ 〉 M 

]} P, (1.25) 

where the matter expectation value is defined by ⟨•⟩M = trM (• χ̂M) and the approxim-ation stems from the ansatz for the density matrix (1.24). Note that the field equation (1.25) couples to the matter expectation values ⟨σ̂±⟩M. As the matter is in its steady state, the matter expectation values are calculated by 

0 = trM 

( σ̂± ˙̂χ 

) , (1.26) 

where the fluctuations in the stochastic variables α, α∗ are neglected. Due to the Liouville equation (1.20), expression (1.26) reduces to 

0 = trM [ σ̂± (LM + LMF) χ̂ 

] . (1.27) 

7

1. Introduction 

Hence, the expectation value ⟨σ̂−⟩M follows from 

0 = 

[ (−γ̄ + iΩ) 

〈 σ̂− 〉 M + igα ⟨σ̂z⟩M − ig 

∂ 

∂α∗ 1 + ⟨σ̂z⟩M 

2 

] P, (1.28) 

where the abbreviation γ̄ = (Γ↑ + Γ↓)/2 has been introduced. Moreover, in order to avoid derivatives, which cannot be treated analytically, the simplification 

trM 

( σ̂− 

∂ 

∂α∗ χ̂σ̂ + 

) ≈ ∂ 

∂α∗ 〈 σ̂+σ̂− 

〉 M P (1.29) 

has been used [40]. This is valid, if σ̂− does not depend strongly on the photon field. The conjugated equation (1.28) holds for the σ̂+ expectation value. Subsequently, the aim is to adiabatically eliminate the matter degrees of freedom. In a first step, the adiabatic elimination of ⟨σ̂−⟩M yields with (1.28) 

〈 σ̂− 〉 M P ≈ ig 

−iΩ+ γ̄ 

[ α ⟨σ̂z⟩M − ∂ 

∂α∗ 1 + ⟨σ̂z⟩M 

2 

] P. (1.30) 

Note that equation (1.30) contains both a coupling to the population inversion ⟨σ̂z⟩M and a derivative with respect to α∗. Therefore, inserting (1.30) and the conjugated equation for ⟨σ̂+⟩M into the P -function equation (1.25) results in 

Ṗ = 

{ ∂ 

∂α α 

[ κ 

2 + iδ̄ − 

( iΩg2 

Ω2 + γ̄2 + B 

2 

) N ⟨σ̂z⟩M 

] + c.c. +BN 

∂2 

∂α∂α∗ 1 + ⟨σ̂z⟩M 

2 

} P . 

(1.31) 

with the microscopically determined Einstein coefficient, c.f., (1.1), 

B = 2g2γ̄ 

Ω2 + γ̄2 . (1.32) 

Although, equation (1.31) for the P -function is already of the form of a Fokker-Planck equation, the expectation value ⟨σ̂z⟩M still needs to be calculated. As equation (1.31) contains already a second derivative of ⟨σ̂z⟩M, in the following all derivatives of the form ∂α(•P ) and ∂α∗(•P ) are neglected. Therefore, demanding as in (1.27) 0 = trM[σ̂z(LM + LMF)χ̂] the population inversion follows the equation 

0 = [ Γ↑ − Γ↓ − 2γ̄ ⟨σ̂z⟩M + 2ig 

( α∗ 〈σ̂− 

〉 M − α 

〈 σ̂+ 〉 M 

)] P. (1.33) 

Inserting (1.30) and its complex conjugate into (1.33) results in 

0 = 

{ Γ↑ − Γ↓ − 2γ̄ ⟨σ̂z⟩M − 4g2γ̄ 

Ω2 + γ̄2 |α|2 ⟨σ̂z⟩M 

+2g2 ( 

α∗ 

−iΩ+ γ̄ 

∂ 

∂α∗ + α 

iΩ+ γ̄ 

∂ 

∂α 

) 1 + ⟨σ̂z⟩M 

2 

} P . 

(1.34) 

In the second line of (1.34) the appearing derivatives are turned into the form ∂α(•P )+R, where R is some remainder, which is kept, while the appearing derivative is neglected. Using the product rule of differentiation this yields the approximation 

α∗ ∂ 

∂α∗ 1 + ⟨σz⟩M 

2 P ≈ −1 + ⟨σz⟩M 

2 P . (1.35) 

8

1.1. Laser 

Hence, considering definition (1.32) both the bare population inversion ⟨σ̂z0⟩M = (Γ↑ − Γ↓−B)/(2γ̄+B) and the saturation photon number n = (γ̄+B/2)/B are now modified by the spontaneous emission, compared to subsection 1.1.1. Therefore, the population inversion takes the form 

⟨σ̂z⟩M ≈ ⟨σ̂z0⟩M 1 + |α|2/n . (1.36) 

Thus, the population inversion (1.36) contains consistently the spontaneous emission in contrast to the rate-equation population inversion (1.4), which represents the main improvement of this derivation, compared to [40]. Note that the number of two-level systems N is not included in (1.36), as it appears explicitly in equation (1.31). Conclusively, equation (1.31) is indeed a Fokker-Planck equation for the field amplitudes α and α∗, since the expectation value ⟨σ̂z⟩M only depends on these. With the Gaussian noise ξ fulfilling ⟨ξ⟩ = 0 and ⟨ξ∗(t)ξ(t′)⟩ = δ(t−t′), the Itô stochastic differential equation (SDE) corresponding to the Fokker-Planck equation (1.31) reads 

α̇ = 

[ −1 

2 − i 

δ̄ 

κ + 

( i ∆ 

κ + C̄ 

2 

) N 

1 + |α|2/n 

] κα+ 

√ BN 

2 

( 1 + 

⟨σz0⟩M 1 + |α|2/n 

) ξ , (1.37) 

with the frequency shift ∆ = Ωg2 ⟨σz0⟩M / ( Ω2 + γ̄2 

) and the modified cooperativity 

C̄ = B ⟨σz0⟩M /κ. This equation can also be derived starting from the rate equation (1.5) and enriching it with the spontaneous emission in order to write down the corresponding quantum mechanical equation [39]. As a final remark, note that it is important to take into account the spontaneous emission, since optical experiments always start with an empty cavity. In order to achieve the lasing state, some photons need to be already in the cavity, which usually stem from the noise associated with the spontaneous emission. 

Coherent Evolution In the course of analysing the SDE (1.37), the investigation of the coherent evolution governed by the equation 

˙̃α = 

[ −1 

2 − i 

δ̄ 

κ + 

( i ∆ 

κ + C̄ 

2 

) N 

1 + |α̃|2/n 

] κα̃ (1.38) 

grants deeper insight, where α̃ = ⟨α⟩ denotes the coherent part of the stochastic variable α. Note that equation (1.38) is the same equation, as it results from the semiclassical 

treatment outlined in [29]. The Madelung representation α̃ = √ ñ e−iϕ̃ yields from the 

real part of (1.38) an equation for the photon number 

˙̃n = 

( −1 + 

C̄N 

1 + ñ/n 

) κñ , (1.39) 

which directly corresponds to the rate equation (1.5), but contains the spontaneous emis-sion in the cooperativity parameter. The imaginary part, on the other hand, determines the phase 

˙̃ ϕ = δ̄ − ∆N 

1 + ñ/n . (1.40) 

The steady state of the equations (1.39) and (1.40) allows for calculating the unknown frequency Ω. Equation (1.39) leads to the steady state 

ñ = n(C̄N − 1) , (1.41) 

9

1. Introduction 

Fig. 1.3: a) Potential (1.43) describing the coherent evolution of the laser for a resonant cavity, i.e., δ = 0. The red line shows the steady state (1.41). The blue line shows the cut, which b) depicts. The cross marks the minimum value. 

which is formally equivalent to the corresponding one (1.7) from the rate-equation treat-ment. Inserting (1.41) in (1.40) and taking the microscopic expression for the Einstein coefficient (1.32) into account yields 

Ω = δ 

1 + κ/(2γ̄) . (1.42) 

Note that the laser frequency (1.42) does neither depend on the photon number nor on the coherent-coupling strength g. Remarkably, the coherent evolution (1.38) is summarised by the potential 

V = κ 

[( 1 

2 + i 

δ̄ 

κ 

) |α̃|2 − nN 

( i ∆ 

κ + C̄ 

2 

) ln 

( 1 + 

|α̃|2 n 

)] . (1.43) 

Figure 1.3 shows this potential for the case of a resonant cavity, i.e., δ = 0. According to (1.42), the potential (1.43) is real-valued in this case. The potential shows the steady-state solution (1.41) to be a stable solution of the coherent evolution. Note that in this plot, not only the external pump parameter Γ↑ is varied, but also the light-matter coupling g is changed to achieve a constant Einstein coefficient (1.32), as it is common in the literature [29, 40]. Otherwise, the Einstein coefficient decays with increasing external pump and the system leaves the lasing regime for too large pumping strength. Thus, equation (1.41) yields with (1.36) for ñ = 0 for the critical pump 

Γc ↑ = (Γ↓ +B) 

BN + κ 

BN − κ . (1.44) 

Thus, not only the losses due to radiationless decay, but also due to the spontaneous emission have to be compensated, before a coherent occupation can develop. 

Stochastic Evolution In the following, the cavity detuning is assumed to vanish. Con-sequently, from equation (1.42) follows Ω = 0, so that also ∆ = 0. Hence, the SDE (1.37) simplifies to 

α̇ = 1 

2 

[ −1 + 

C̄N 

1 + |α|2/n 

] κα+ 

√ BN 

2 

( 1 + 

⟨σz0⟩M 1 + |α|2/n 

) ξ . (1.45) 

10

1.1. Laser 

0 10 20 30 40 50 C 

0 

10 

20 

30 

40 

50 

| |2 0 2 4 

C 

0 

5 

| |2 

Fig. 1.4: Mean photon number 〈 |α|2 

〉 calculated from the SDE (1.45) in blue for a single 

two-level system. The error bars denote the standard deviation. For a compar-ison, the rate equation steady state (1.7) is plotted in orange. The inset zooms at the phase transition. 

Figure 1.4 compares the rate equation solution from subsection 1.3.2 with the results of the solution of the SDE (1.45). The main difference is the inclusion of the spontaneous emission, which introduces a finite photon population also in the trivial regime. Close to the phase transition, the photon number is very small, such that the photon number dependency of the noise can be neglected. Thus, the SDE (1.45) with multiplicative noise turns approximately into a SDE with additive noise. Therefore, with the potential (1.43) the P -function of the form [45] 

P = N e−V/Q , (1.46) 

where Q = BN 2 

( 1 + ⟨σz0⟩M 

) denotes the noise and N the normalisation constant, can be 

calculated explicitly 

P = N ( 1 + 

|α|2 n 

)κnC̄N/(2Q) 

e−κ|α|2/(2Q) . (1.47) 

As the P -function only depends on the absolute of α, the phase transition fixes merely the photon number, but not the phase. As photons can, indeed, undergo phase transitions, the next step is to investigate other possible phase transitions. In view of atomic systems, of particular interest is the phase transition to a Bose-Einstein condensate. The next subsection grants an overview of exciton-polariton condensation, which is the first evidence for light undergoing Bose-Einstein condensation. 

11

1. Introduction 

1.2. Exciton-Polariton BECs 

Light in a non-linear bulk medium is able to resemble the behaviour of a bosonic quantum gas [46, 47]. Usually, the non-linearity stems from a medium, where the refractive index contains a third-order susceptibility χ(3). This means, the refractive index depends on the intensity of the light itself [48]. As a consequence, the light obeys a Gross-Pitaevskii type of equation in the case of a paraxial approximation, as it is often used in wave-guide and fibre optics. In these systems, typical non-linear effects like vortices [49, 50] and superfluidity [51] can be observed. Even the semiclassical laser equations can be mapped onto a complex Gross-Pitaevskii equation [52]. Therefore, light-based exper-imental platforms permit the investigation of many properties of bosonic many-body physics. However, the question remains whether light can undergo Bose-Einstein con-densation. The first reported BEC of light was prepared in the realm of polariton-exciton condensates. In these systems, however, it is not light itself that forms a condensate, but only the light coupled to excitons forming polaritons. In the following, this section provides a concise overview of the field of exciton-polariton condensates. To this end, subsection 1.2.1 covers selected experiments, whereas subsec-tion 1.2.2 gives a short insight into the theoretical description of these condensates on a mean-field level. A full review on this topic can be found in [46, 53, 54]. 

1.2.1. Short Experimental Overview 

The first observation of polaritons in 1992 [55] laid the foundation for exciton-polariton condensates. As pictured in figure 1.5, microcavity polaritons form two bands, the upper and lower polariton branch, which are a mixture of both the quadratic photon dispersion relation and the constant exciton dispersion relation [56]. The lower branch can undergo Bose-Einstein condensation at the dispersion minimum. Since the effective mass in the lower branch is very small at 10−5 times the electron mass, the critical temperature for BEC extends up to room temperature [54]. 

Creation of Exciton-Polariton BECs Observing stimulated polariton photolumines-cence in a cadmium telluride (CdTe) filled microcavity was the first experimental step to-wards polariton lasers and BECs [57]. The first real exciton-polariton BEC was achieved in a gallium arsenide (GaAs) microcavity [58]. Here, a laser beam creates excitons with a large wave vector. These excitons then form polaritons together with the microcav-ity photons. These polaritons emit phonons by scattering via the excitonic component. Due to this, they thermalise into a quasi-thermal distribution at the centre of the lower polariton branch. As a result, the thermalised polaritons are not coherent to the initial pump beam. A measurement of the temporal g(2) function defined by 

g(2)(t1, t2) = 

〈 â†(t1)â†(t2)â(t2)â(t1) 

〉 

⟨â†(t1)â(t1)⟩ ⟨â†(t2)â(t2)⟩ , (1.48) 

where â, â† are the ground-state creation and annihilation operators, respectively, re-vealed the Bose-Einstein condensation of the polaritons. Reference [59] provides more detailed evidence for exciton-polariton BEC, as figure 1.5 shows. Here, the authors ana-lysed the light leaking out of the cavity once in real space and once in energy space, proving the spatial coherence of the condensate. In contrast to the original experiment [58], reference [59] does not pump resonantly on the outer part of the polariton branch, 

12

1.2. Exciton-Polariton BECs 

a) 

b) 

Fig. 1.5: Exciton-Polariton condensation from experiment [59]. a) Principle of exciton-polariton BEC. The external pump laser creates free carriers which relax back into the exciton branch, from where the excitation finally relaxes into the lower polariton branch. The solid black lines denote the upper and lower polariton branch, while the black dashed lines depict the uncoupled photon and exciton dispersion. b) Colour-coded polariton density as a function of the energy and the in-plane wave vector for different external pump strengths. If the external pump strength is large enough, a sharp condensate peak arises at the dispersion minimum. Figure reprinted from [59] with permission from Springer Nature. Copyright © 2006, Nature Pub-lishing Group. 

but creates free carriers which relax into the polariton states. Figure 1.5 a) sketches this principle. In order to observe well thermalised exciton-polariton BECs, a high finesse cavity is necessary, as reference [60] demonstrates. A second way for creating exciton-polariton condensates relies on the strong interaction in the system. Here, a laser pumps the system resonantly at the inflection point of the lower polariton branch. This allows to scatter two polaritons, one at the dispersion minimum at k = 0, the so-called signal mode, and another one in an excited state with twice the pump wave vector, which is named idler mode and appears due to energy and momentum conservation [61]. Above a certain critical pump strength, a paramet-ric oscillation yields a coherent, macroscopic occupation in the ground state [62, 63]. However, this excitation scheme does not allow for thermalisation to happen, since no thermal cloud is present at all. 

Vortices and Superfluidity As the interaction in exciton-polariton condensates is large due to the electronic part of the polariton, the interplay of superfluidity and external drive turns out to be interesting. Reference [64] reports the creation of quantised vor-tices in non-resonantly driven exciton-polariton BECs created in disorder potentials. The vortex itself is detected by means of interferometry, where it appears as a fork in the interferometer fringes, as figure 1.6 a) shows. Accompanying this, figure 1.6 b) plots the condensate phase along a circle around the vortex, which turns out to be quantised and to have a difference 2π. Experiment [65] proves the superfluidity of exciton-polariton BECs. There, an excitation laser resonantly drives an exciton-polariton condensate such that it inherits the wave vec-tor of the excitation laser and starts to flow. For probing the superfluidity, the condensate 

13

1. Introduction 

a) b) 

Fig. 1.6: Experimental observation of vortices in exciton-polariton BECs [64]. a) Inter-ferogram of the exciton-polariton condensate. The fork indicating the vortex is in the red circle. b) Phase winding along a circle around the vortex. Figure reprinted from [64] with permission from Springer Nature. Copyright © 2008, Nature Pub-lishing Group. 

is sent over a defect. Figure 1.7 depicts the condensate density while flowing across the obstacle for different densities and condensate momenta. In the low-momentum regime, the backscattering from the defect is suppressed, provided the condensate density and, thus, the mean-field interaction is large enough. On the other hand, if the condensate flows faster than its sound velocity, a broad backscattering shows the system to be in the Čerenkov regime. 

1.2.2. Theoretical Description 

The theoretical modelling of exciton-polariton BECs can be divided into three different levels of varying complexity. Review [46] gives a detailed account on the different kinds of modelling. The most fundamental, yet also most complex, description relies on a field-theoretic treatment of both the polariton and the cavity-light field. This kind of model allows, e.g., to understand the creation schemes of exciton-polariton BECs. From the microscopic theory, a stochastic framework based on c-fields for the polariton field can be derived [66]. Finally, and in view of the topics of the present thesis most relevant, is the mean-field model developed in [67]. 

Mean-Field Model Figure 1.8 a) sketches the idea of the mean-field model. In this model, an open-dissipative Gross-Pitaevskii equation describes the condensate wave function ψ: 

i ∂ψ 

∂t = 

{ − ℏ∇2 

2mLP + i 

2 [R (nR)− γ] + g|ψ|2 + 2g̃nR 

} ψ . (1.49) 

Here, mLP denotes the polariton mass of the lower branch, R(nR) the incoherent pump of the condensate by the exciton density nR and γ stands for the cavity decay. Due to the electronic part of both the polariton and the exciton, the polariton-polariton interaction with strength g and the polariton-exciton interaction denoted by g̃ are included in the description. On the other hand, the exciton density obeys the reaction-diffusion equation 

∂nR ∂t 

= P − γRnR −R (nR) |ψ(r)|2 +D∇2nR , (1.50) 

14

1.2. Exciton-Polariton BECs 

Fig. 1.7: Superfluid flow of exciton-polariton BEC in experiment [65]. The upper row shows the real space pictures and the lower row the Fourier space pictures. The condensate density increases from left to right. On the left, the system is in the normal fluid regime, while on the most right pictures the system is superfluid. Figure reprinted from [65] with permission from Springer Nature. Copyright © 2009, Nature Pub-lishing Group. 

where P is the external pump, γR the exciton decay and D the diffusion constant. The coupling of the complex-valued condensate wave-function ψ to the real-valued reservoir density nR introduces a complex valued dispersion relation, as figure 1.8 b)-e) show. 

Bogoliubov Spectrum The Bogoliubov spectrum is the linearised excitation spectrum of system (1.49), (1.50) and well known from ultracold atomic gases to yield first insights into the behaviour of the system [24–26]. For large wave vectors, it turns into that of a free particle, apart from an additional imaginary frequency indicating a steady decay of the excitations. In the small wave vector limit, on the other hand, the spectrum changes drastically, which is due to the open-dissipative terms in (1.49). In the limit k → 0 there is always a single mode, where both the real and the imaginary part of the frequency vanish. This corresponds to the massless Goldstone mode, which is due to the broken U(1) symmetry in the condensate phase. For larger, but still small k values there exists a diffusive regime, where the real part of the spectrum vanishes. As figure 1.8 reveals, the imaginary part is either always negative if the reservoir relaxes much faster than the condensate, or it bears a dynamical instability if the damping of the reservoir is comparable to the damping of the condensate. 

Vortices and Superfluidity This mean-field model allows for understanding the effects like vortices and superfluidity. Despite the simpleness of the model, it successfully de-scribes the experimental findings mentioned in the preceding subsection 1.2.1. Figure 1.9 shows a single vortex described by the mean-field model (1.49), (1.50) from study [68]. As the system is open-dissipative, the vortex behaves differently than in standard Gross-Pitaevskii theory [24, 25], as the flux j = ℏ/mIm(ψ∇ψ∗) has not only a tangen-tial, but also a radial component. The latter implies that the vortex does not preserve the particle number, but it acts as a “particle cannon”. The corresponding supercurrent 

15

1. Introduction 

Fig. 1.8: Mean-field model (1.49), (1.50) from [67]. a) Basic idea of the model. The black solid lines represent the two polariton branches. The reservoir is pumped externally with a rate P , and decays into the condensate, c.f., (1.50). The condensate sits at the dispersion minimum of the lower polariton branch. b)– e) Corresponding Bogoliubov spectrum, where the coupling to the real-valued reservoir density introduces a complex frequency. The dashed lines depict the standard Bogoliubov spectrum for comparable interaction strength. b), c) Strongly damped reservoir γR ≫ γ with stable condensate. d), e) Reservoir and condensate damping rates are equal, γR = γ yielding dynamical instabilit-ies. Reprinted figure with permission from [67]. Copyright (2007) by the American Physical Society. 

Fig. 1.9: Vortex in strongly non-equilibrium exciton-polariton condensate from [68]. The arrows indicate the flux j = ℏ/mIm (ψ∗∇ψ) of the exciton polariton condens-ate. The right-hand picture is a zoom into the vortex core, as indicated by the red box. The figure reprinted from [68] is licensed under CC-BY-3.0. 

16

1.3. Photon Bose-Einstein Condensates 

flows also yield an acceleration of the vortex, meaning it starts to move around in the simulation box. This generates interesting interaction effects of several vortices with each other. For instance, vortex-antivortex pairs do not annihilate each other in the presence of strong non-equilibrium, but they rather repel each other. These findings come together with a numerical investigation of the normal and super-fluid fractions in random potentials, where the standard definitions of these fractions are tested [69]. It turns out that the common definition of superfluid fraction, e.g., via syn-thetic gauge fields, fail, as even in the case without external gauge fields superfluid fluxes are present. The latter are due to the open-dissipative character of the system. Sub-tracting these zero-field fluxes results in definitions for normal and superfluid fractions which do not add up to the total flux, provided the system is in a strong non-equilibrium state. However, the question arises whether condensation of pure photons can be achieved. The following section carefully introduces the reader to the phenomenon of photon Bose-Einstein condensation. 

1.3. Photon Bose-Einstein Condensates 

This section presents the concept of photon BECs as realised in dye-filled microcavities [70, 71]. For this purpose, subsection 1.3.1 introduces the basic ideas for creating photon BECs, whereas subsection 1.3.2 depicts the basic principles of photon thermalisation by considering a simple model based on rate equations. It is able to show, how the thermalisation of the photon gas happens. Afterwards, subsection 1.3.3 introduces the intriguing physics of the effective photon-photon interaction emerging in the dye-cavity photon BEC. As a rare feature, the so-called thermo-optic photon-photon interaction is not only non-local in space, but also retarded in time, as it is based on temperature diffusion through the cavity setup changing the refractive index. The subsection closes with how the temporal retardation changes the lowest-lying collective excitations of the photon condensate. The different theoretical models for photon condensates are the topic of subsection 1.3.4. These approaches span the range from a microscopic modelling of both the cavity photon modes and the molecular spectra relying on a Lindblad ansatz via a Gross-Pitaevskii like equation for describing the effective photon-photon interaction up to a phasor model for describing the vortex physics in arrays of cavity photon BECs. Subsection 1.3.5 closes the introduction of the photon BEC by summarising all experiments, which the different groups conducted up to now. The tutorial [72] also yields an experimental introduction into the topic. 

1.3.1. Basic Concept 

A typical dye-cavity photon BEC setup consists of three parts, namely the cavity, the dye solution, which provides both a heat and a particle reservoir for the photons, and the external pump laser, exciting the dye molecules [70, 73]. 

Experimental Setup Figure 1.10 a) shows a picture of the experimental setup. Due to the cavity mirrors, a standing wave emerges along the optical axis. As the dis-tance between the two mirrors is only of the order of a few micrometers, the different longitudinal eigenmodes are well separated. Therefore, the selection of only a single of these eigenmodes provides a finite ground-state energy. Via the Einstein relation 

17

1. Introduction 

Fig. 1.10: a) Cavity used in the experiments [73]. The external laser pumps the dye me-dium, which is placed between the mirrors. The latter are spherically shaped and, therefore, provide a harmonic trapping potential for the photons. b) Photon dispersion inside the cavity. The cavity changes the linear free-space dispersion to a quadratic dispersion with a finite energy cut-off. Figure a) taken by Frank Vewinger and modified with his friendly permission. Figure b) based on [70] with permission from Springer Nature. Copyright © 2010, Nature Publishing Group. 

ℏωcutoff = mc2/n2, with n being the refractive index of the dye solution, yields a finite mass for the photons, see figure 1.10 b). The Dirichlet boundary conditions on the cavity mirrors link the cutoff frequency and, thus, the effective photon mass via the dispersion relation ωcutoff = µπc/(nL0), with µ ∈ N, to the length L0 of the cavity at the optical axes. The longitudinal mode index µ amounts in most experiments to µ = 7, 8. In addition, this selection freezes out the motion of the photons along the optical axis, reducing the dimension from 3D to 2D. As the aim consists in achieving a Bose-Einstein condensate of photons, also an external potential is necessary, as otherwise the Mermin-Wagner-Hohenberg theorem [74, 75] for-bids the Bose-Einstein condensation in homogeneous gases in lower dimensions. Here, the surface shape of the mirrors becomes important. As the inset in figure 1.10 sketches, the paraxial approximation only accounts for light rays near the optical axis and trans-lates the surface shapes of the mirrors into an effective potential for the cavity photons. Standard photon BEC experiments use spherically grinded mirrors, which the paraxial approximation turns into a harmonic potential for the photons, as figure 1.10 b) indicates. The trapping frequency Ω is again linked to the cavity geometry via Ω = c/n 

√ 2/(L0R) , 

where R stands for the radius of curvature of the cavity mirrors. Hence, confining light in a cavity maps this very light onto a massive gas of two-dimensional bosons in a given potential. 

Thermalisation Thus, the question, how photons thermalise, remains open. As photons do not interact with each other, matter has to introduce the thermalisation of the 2D photon gas via absorption and emission processes. It is important that the matter not only possesses pure electronic transitions, as it is, i.e., the case for simple atoms, but also states, with much smaller energy spacing on top of these. If the latter are thermal-ised, the Kennard-Stepanov relation [76, 77] predicts a Boltzmann factor to connect the absorption and emission spectra. So the photon gas inherits this thermalisation by ab-sorption and re-emission cycles, provided the mean photon lifetime is much larger than the absorption/re-emission time. In standard photon BEC experiments, a dye solution fulfils these requirements. Here, the vibronic degrees of freedom of the dye molecules 

18

1.3. Photon Bose-Einstein Condensates 

400 450 500 600 650 700 

400 450 500 550 600 650 700 

TEM6mn TEM TEM8mn7mn 

(THz) 

AbsorptionEmission d e g e n e ra 

cy re 

la ti 

v e  s 

tr e n g 

th 

### cavity spectrum 

### dye spectrum 

Fig. 1.11: Top) Cavity spectrum. Bottom) Corresponding spectrum of Rhodamine 6G as used in all the state-of-the-art experiments. Figure reprinted from [71] with permission from Springer Nature. Copyright © 2011, Springer-Verlag. 

thermalise to the surrounding solvent molecules. Figure 1.11 depicts the corresponding absorption and emission spectrum together with the corresponding cavity modes. 

Analysing the Photon Gas The advantage of the dye-cavity photon BEC lies within the possibility to analyse the light leaking out of the cavity in two ways: once spatially by directly taking a picture of the light and, on the other hand, by sending the light through a spectrometer. Therein, panels a) and b) in figure 1.12 show the spatial photon distribution, below and above the BEC threshold, respectively. As these two pictures are plotted using real colours, they clearly show the photon thermalisation, as the higher energy photons (green) are distributed in the outer region, whereas the lower energy photons (orange) concentrate in the trap centre. Therefore, the photon BEC, which is the bright spot in panel b), appears in the trap centre. The spectra shown in panel c) support these findings, as they follow the Bose-Einstein distribution at room temperature. Once the pump power is large enough, the spectra show a large occupation of the ground state. 

Timescales All the different ingredients of the experimental setup yield a rich plethora of timescales, as figures 1.13 a), c) visualise. The fastest timescale in the system stems from the interaction between the dye molecules and the solvent molecules. As a result of these collisions, the vibronic degrees of freedom of the dye molecules relax on a sub-picosecond timescale, such that these are in thermal equilibrium just before both photon absorption and photon emission happens. This is the crucial point in generating a thermal photon gas, as it is discussed in greater detail in the next section on the bases of rate equations. The absorption and re-emission cycles of photons by the dye molecules set the next faster timescale at 10 ps. In addition, these cycles also set the timescale for photon thermalisation, which typically lasts for a few absorption and re-emission cycles. The by far largest timescale is the heating of the cavity during an experiment, taking place at a timescale of 0.1 s. This heating stems from non-perfect absorption/re-emission cycles, meaning that some electronic excitations of the dye are not re-emitted as 

19

1. Introduction 

a) 

b) 

c) 

Fig. 1.12: Bose-Einstein condensation of Photons. a), b) Spatial photon distribution below and above the BEC threshold, respectively. The colour code in the picture is the real colour of the photons leaking out of the cavity. The bright spot in the centre of panel b) is the photon BEC. c) Spectrum of the light leaking out of the cavity for different pump powers P . Figure reprinted from [70] with permission from Springer Nature. Copyright © 2010, Nature Pub-lishing Group. 

time 

### single experimental cycle 

### experimental sequence 

external pump: 500 ns 

photon population 

thermalisation: 10 ps 

cavity decay: 

1 ns 

temperature decay: 0.1 s 

### a) b) 

### heating ch 

### an gi 

### nge ff 

### e c ti 

### v e  i n 

### te ra 

### c ti 

### o n 

fast 

slow 

### c) 

Fig. 1.13: Different timescales in dye-cavity photon BECs. a) Timescales in a single experiment. The lifetime of the condensate is given by the external pump pulse (green). Consequently, the photon gas inside the cavity thermalises (grey) and on very long scales the temperature (red) builds up. b) Emergence of the effective photon-photon interaction. The photon condensate heats the dye medium, which leads to a change ∆n of the refractive index. This change acts back on the condensate. c) Embedding of a single experiment in a whole experimental cycle, within which the temperature can reach its effective steady state. Picture reprinted from own publication [P4], distributed under arXiv license. 

20

1.3. Photon Bose-Einstein Condensates 

photons, but are converted into vibronic excitations of the dye molecules. These vibronic excitations can effectively be seen as the temperature of the dye molecules rising. Due to collisions with the surrounding solvent molecules, this temperature diffuses through the whole dye solution and even through the cavity mirrors, as study [P1] shows in detail. At the end, this process changes the refractive index and results in an effective photon-photon interaction, as figure 1.13 pictures, and subsection 1.3.3 discusses in detail. Figure 1.13 a) shows that the temperature cannot reach an equilibrium state during a single pump pulse. Dye bleaching limits the lifetime of a single condensate in most experiments by 500 ns. If the external pump laser runs too long, it pumps the dye molecules into a metastable triplet state and, therefore, these molecules are useless for the ongoing experiment. A possible workaround is putting a whole experimental cycle together, like depicted in figure 1.13 c), such that the temperature produced in the former experiment still influences the next experiment. In this way, the temperature can reach its maximal value. Appendix B covers the details of this. However, before coming to the details of the interaction, the next subsection explains how a photon BEC emerges in detail by using rate equations. 

1.3.2. Rate Equations 

Rate equations provide a simple but profound understanding of the thermalisation pro-cess of the photon gas and can be derived from microscopic models [78]. This model consists of the electronic ground and excited state, which are labelled by ↓, ↑, respect-ively, and of the different photon modes with frequencies denoted by ωl with mode index l. Figure 1.14 summarises all the effects, which the rate equation model takes into ac-count. The absorption and emission coefficients B↑↓(ωl) contain the influence of the dye vibrations and vary with the mode frequency ωl. The Kennard-Stepanov relation [76, 77] 

B↓(ωl) = B↑(ωl)e −ℏ(ωl−ωZPL)/(kBT ) (1.51) 

connects the absorption and emission coefficients by a Boltzmann factor, c.f., subsection 1.3.1 and figure 1.11. This factor stems directly from the assumption that the vibronic degrees of freedom are thermalised right before photon absorption and photon emission, respectively. Changing the detuning to the so-called zero-phonon-line frequency ωZPL, varies the thermal contact of the photons to the dye. Moreover, as the cavity mirrors are not perfect, the photons are subject to a cavity loss κ. For compensating this loss, an external laser pumps the dye molecules with the rate p. In addition, the dye molecules can undergo a radiationless decay by the rate γ. Therefore, the rate equation for the population N↓ of ground-state molecules reads 

Ṅ↓ = γN↑ − pN↓ + ∑ 

l 

[B↓(ωl)N↑ −B↑(ωl)N↓]nl + ∑ 

l 

B↓(ωl)N↑ . (1.52) 

Here, the first two terms are due to radiationless decay and external pumping. The next two terms, which are proportional to the photon occupation nl of the lth mode, describe the stimulated emission and absorption processes. The last term accounts for the spontaneous emission, which turns out to be crucial for thermalising the photon gas. Neglecting dye bleaching effects, the excited state population N↑ follows the rate equation 

Ṅ↑ = −Ṅ↓ . (1.53) 

21

1. Introduction 

Fig. 1.14: Rate equation model. The circle marks a single molecule, with the black solid lines showing the pure electronic levels and the yellow rectangles standing for the vibronic degrees of freedom. The external pump and decay processes as well as the cavity losses are marked in red. The arrows symbolise the absorption and emission processes taken into account with the corresponding rates. 

Finally, the photon population of the lth cavity mode is governed by 

ṅl = [B↓(ωl)N↑ −B↑(ωl)N↓ − κ]nl +B↓(ωl)N↑ . (1.54) 

The steady state ṅl = 0 of the photon population nl amounts from (1.54) to 

nl = 1 

κ B↓(ωl)N↑ 

+ B↑(ωl)N↓ B↓(ωl)N↑ 

− 1 . (1.55) 

The first term in the denominator compares the cavity lifetime 1/κ with the emission time 1/(B↓(ωl)N↑), whereas the second term is the ratio of the absorption and emission rate. The Kennard-Stepanov relation (1.51) brings the latter into the form 

B↑(ωl)N↓ B↓(ωl)N↑ 

= e(ℏωl−µ)/(kBT ) , (1.56) 

where the chemical potential is identified to be 

µ = −kBT ln N↓ N↑ 

+ ℏωZPL . (1.57) 

The latter can be defined due to the chemical equilibrium established by the dye-photon interaction. Hence, for obtaining a Bose-Einstein distribution the first term in the de-nominator of equation (1.55) has to be sufficiently small, meaning that the photon lifetime has to be larger than the re-emission cycle. Experimentally, this amounts to use cavity mirrors with a high reflectivity, e.g., in experiment [70] the mirrors had a reflectivity larger than 99.997. In this case, the steady-state distribution (1.55) turns into a Bose-Einstein distribution 

nl ≈ 1 

e(ℏωl−µ)/(kBT ) − 1 , (1.58) 

22

1.3. Photon Bose-Einstein Condensates 

with the chemical potential (1.57). Solving (1.52) in the steady state results in 

N↓ N↑ 

= γ + 

∑ lB↓(ωl)(nl + 1) 

p+ ∑ 

lB↑(ωl)nl , (1.59) 

revealing the photon number dependency of the chemical potential (1.57). Comparing to the laser rate equations investigated in subsection 1.1.1 the photon BEC rate equa-tions consider many modes in order to achieve a thermal photon distribution. As the fundamental ingredient is the Kennard-Stepanov relation (1.51), also the absorption and emission rates for a single mode vary, whereas for a laser these are the same. On phys-ical grounds, this is due to the laser relying on a two-level description of atoms, whilst the photon BEC works with vibrating dye molecules. Finally, the spontaneous emission turns out to be crucial in the photon BEC as otherwise no thermalisation can happen, whereas for a laser the spontaneous emission is usually neglected in order to work out the critical behaviour of the laser rate equations. In conclusion, this subsection shows that although light in a cavity is a highly open-dissipative system, its steady-state resembles the thermodynamic equilibrium expecta-tion values. Beneath the thermalisation dynamics, the photons also bear an effective interaction, which is the subject of the next section. 

1.3.3. Effective Photon-Photon Interaction 

Consider a general plane-wave dispersion relation ω2 = k2c2/n2 in a dye solution with refractive index n showing the photon energy to depend on the refractive index itself. For the case of the dye-filled cavity, the diploma thesis [79] works it out in detail. If the photons change the refractive index, a corresponding change in the energy accompanies this, which results in an effective photon-photon interaction. As the dye solution is mainly made up of the solvent molecules, they also determine its refractive index. The photons modify the refractive index of the solvent in two distinct ways, by the so-called Kerr effect and via the thermo-optic effect. The first one is a non-linear effect, where the refractive index n changes directly with the photon intensity. The latter, on the other hand, is a temperature dependent shift of the refractive index, compare to figure 1.13 b). The photons produce a temperature difference, which diffuses through the whole cavity setup. Therefore, spoken in terms of a Gross-Pitaevskii type of equation, the Kerr effect yields a contact interaction, whereas the thermo-optic interaction is non-local in space and retarded in time. Experimental measurements [70, 71] reveal that the thermo-optic interaction strength is the dominating interaction mechanism. The thermo-optic interaction and its implications on the photon BEC dynamics was already at the focus of the author’s diploma thesis [79]. It uses as a minimal model the modified two-dimensional Gross-Pitaevskii equation 

iℏ∂tψ = 

( − ℏ2 

2m ∇2 + 

mΩ2 

2 r2 + gK |ψ|2 + gT∆T 

) ψ , (1.60) 

which reference [80] similarly states for the homogeneous case. Here, r = √ x2 + y2 

denotes the radius in the plane orthogonal to the optical axis, gK the strength of the Kerr interaction, gT the thermal energy shift and ∆T the temperature difference the photons produce. The last two terms directly describe the energy shift due to the Kerr and thermal non-linearity of the refractive index, respectively. In the diploma 

23

1. Introduction 

Fig. 1.15: Lowest-lying collective excitations of a photon BEC. The solid lines stem di-rectly from (1.63), whereas the dashed lines are the corresponding results from a plain Gross-Pitaevskii equation with the same interaction strength. The markers show numerical results. The sketches on the right depict and colour code the various excitation modes. The picture is modified from [P1] under the licence CC-BY-3.0. 

thesis [79], also some imaginary non-linearities are added for simulating the external pump and decay. However, these terms turned out to be highly artificial, since they do not stem from the interaction with the matter itself. Hence, this section describes the effective photon-photon interaction in a coarse-grained picture, where the absorption and emission processes of photons with the dye molecules are not resolved. The temperature shift ∆T , the photons produce, obeys the diffusion equation 

∂t∆T = 

( D∇2 − 1 

τ 

) ∆T +B|ψ|2 , (1.61) 

where D denotes the thermal diffusion constant of the solvent, τ the relaxation due to the diffusion along the optical axis and B the heating coefficient of the solvent. The system (1.60) and (1.61) is formally equivalent to the system (1.49) and (1.50) describing the exciton-polariton condensate in the mean-field description. The diploma thesis [79] compares the two systems in great detail. Chapter 2 revisits the derivation of equation (1.61) and puts it on more rigorous physical and mathematical grounds, as the approach there also takes the temperature diffusion in the mirrors into account. The Green’s function 

G(x, t) = 1 

4πDt exp ( − x2 

4Dt − t 

τ 

) (1.62) 

directly solves the diffusion equation (1.61). Inserting the Green’s function (1.62) into the photon Gross-Pitaevskii equation (1.60) yields 

iℏ∂tψ = 

( − ℏ2 

2m ∇2 + 

mΩ2 

2 r2 + gK |ψ|2 

+gTB 

∫ d2x′ 

∫ t 

0 dt′ G(x− x′, t− t′)|ψ(x′, t′)|2 

) ψ , 

(1.63) 

24

1.3. Photon Bose-Einstein Condensates 

revealing that the thermo-optic interaction is non-local in space and retarded in time. Equation (1.63) is now the starting point for calculating the lowest lying collective excita-tions of the photon condensate subject to the thermo-optic interaction. A modified vari-ational approach allows for calculating the lowest-lying collective excitations as dipole, breathing, and quadrupole mode. However, as the photon BEC is an open-dissipative system, no Hamilton principle exists as an anchor for the variational approach. Instead, this variational approach relies on directly calculating the cumulants of the trial wave function of the condensate, including the open-dissipative terms [81]. Figure 1.15 pictures the resulting lowest-lying collective excitations described by (1.63). Compared to the collective excitations of a standard Gross-Pitaevskii equation, the thermo-optic interaction shifts all the collective frequencies to lower ones. This be-haviour is most dominant for the so-called Kohn mode, which describes a centre-of-mass oscillation of the condensate [82]. A contact interaction does not couple to the centre-of-mass coordinate, whereas a temporally retarded interaction does. As a result, the oscillation frequency gets smaller. The physical reason behind this are the different timescales of the photon-condensate motion and the temperature diffusion. On times-cales of the temperature, the condensate stays on average in the trap centre. Hence, the raising temperature effectively changes the trapping potential at this place by creating a slight Gaussian peak. Due to this obstacle, the collective frequencies of the condensate decrease. 

1.3.4. Theoretical Modelling of Photon BECs 

Photon Bose-Einstein condensates are complex systems made out of many subsystems like the photons themselves, the two-level systems describing the electronic transition and the molecule vibrations leading to the thermalisation. As figure 1.16 summarises, many ways of theoretically describing these BEC exist, ranging from microscopic mas-ter equations to stochastic classical fields. This section reviews the different levels of describing photon BECs. 

Microscopic Model The most fundamental way of analysing the system is based on a microscopic treatment of the molecular Hamiltonian coupled to the cavity modes. Ap-pendix C shows the derivation of this Hamiltonian. Reference [83] was the first to work out such a microscopic model, which was further developed in [84]. However, a more de-tailed investigation [33] improved several shortcomings of this first model, like neglecting the coherent photon–matter interaction. In particular, reference [33] also included these terms consistently in order to be able to describe the transition between the operation of the cavity as a laser and a true photon BEC. Due to that, this section only shortly intro-duces the latter model; the differences to the first are more hidden in the details and are explained in detail in the derivation in appendix C. Within this model, the molecules are described as two-level-systems coupled to the phonons arising from the normal-modes of the dye molecules. Subsequently, these molecules are coupled to the cavity-photon modes by a Jaynes-Cummings like interaction Hamiltonian. A polaron transformation simplifies the Hamiltonian and ensures a treatment of the electron-phonon coupling up to infinite order, as single-phonon processes prevent a thermalisation of the radiation. Afterwards, the phonons are assumed to be in a thermal state and are traced out from the dynamics by means of a Lindblad-master equation approach, details on which are in appendix A. Along this line also external pump, radiationless decays and dephasing are 

25

1. Introduction 

Microscopic Model 

 Fundamental description [83, 84] 

 Spatial degrees of freedom [85] 

 Polarisation [86] 

 Crossover laser ⇔ BEC [33] 

Rate-Equation Model 

 Thermalisation [83] 

 Fluctuations [87] 

 Mode competition [88, 89] 

 Non-hermitian phase transition [90] 

Mean-Field Model 

 Thermo-optic interaction and superfluidity [80] 

 Coordinate dependent mass [91, 92] 

 Thermo-optic interaction in harmonic trap [P1] 

 Dimensional crossover [P3] 

 Quantum mechanical thermo-optic interaction [P4, P5] 

Stochastic Model 

 C-field model [93] 

 Vortices in photon BECs [94] 

 BKT-like physics [95, 96] 

Fig. 1.16: Different ways of theoretical modelling. This thesis mostly focuses on the mean-field description. 

introduced. The resulting master equation, which appendix C derives, reads 

˙̂ρ =− i 

  

M∑ 

m=1 

δmâ † mâm + gβ 

M∑ 

m=i 

N∑ 

j=1 

( â†mσ̂ 

− j + âmσ̂ 

+ j 

) , ρ̂ 

  

− 

   

M∑ 

m=1 

κ 

2 L[âm] + 

N∑ 

j=1 

(γ↑ 2 L[σ̂+j ] + 

γ↓ 2 L[σ̂−j ] + 

γϕ 2 L[σ̂zj ] 

)    ρ̂ 

− 

   

M∑ 

m=1 

N∑ 

j=1 

( γ+m 2 L[âmσ̂+j ] + 

γ−m 2 L[â†mσ̂−j ] 

)  ρ̂ . 

(1.64) 

The first line of (1.64) describes the coherent Jaynes-Cummings interaction of the cavity photons with the plain two level systems. The cavity detuning is denoted by δm. The phonon dressing appears in the coupling strength gβ depending on the thermodynamic inverse temperature β. The second line describes the external dissipative processes by means of the Lindblad superoperator 

L[x̂]ρ̂ = x̂†x̂ρ̂+ ρ̂x̂†x̂− 2x̂ρ̂x̂† . (1.65) 

These include, in order of appearance, the cavity decay, the external pump laser, the radiationless decay and the dephasing of the two-level systems with the corresponding rates κ, γ↑, γ↓ and γϕ, respectively. These two lines together are already enough for describing a multimode laser. The last line introduces the photon thermalisation by non-coherent absorption and re-emission processes. The coupling to the phonon bath determines corresponding absorption and emission rates γ+m and γ−m, respectively. As the 

26

1.3. Photon Bose-Einstein Condensates 

a) b) 

Fig. 1.17: Photon spectra for different cavity decays taken from [83]. The dots are the numerical results from their rate equations, while the solid lines are fits of the Bose-Einstein distribution to the thermal tail. a) Spectrum for the experi-mental parameters b) Spectrum for a larger cavity decay. Reprinted figure with permission from [83]. Copyright (2013) by the American Physical Society. 

a) b) 

Fig. 1.18: Photon intensity oscillations after an off-centre pump pulse. a) For a cutoff frequency of 3200 THz. b) The same for a cutoff of 3250 THz. Reprinted figure with permission from [85]. Copyright (2016) by the American Physical Society. 

phonon bath is assumed to be thermal, the rates γ+m and γ−m fulfil the Kennard-Stepanov relation (1.51). Since the latter are dominant in the photon BEC regime, the authors of references [83, 84] argue to neglect the coherent coupling, as it appears in the first line in the master equation (1.64). From this point of view, the authors of reference [83] derive the rate equations, which section 1.3.2 uses as a starting point. They discuss, especially, under which circumstances their model yields the photon distribution to be a Bose-Einstein distribution, see figure 1.17. They figure out that a too large cavity decay prevents the thermalisation of the photon gas, as explained in subsection 1.3.2. In reference [84] the authors investigate how the photon thermalisation breaks down once leaving the experimental parameter regime. They also go beyond the rate-equation model and investigate both the second-order coherence function and the emission line width in the single mode approximation. Later on, the Kirton-Keeling model has been further improved. In one branch, also the spatial degrees of freedom were included for describing the influence of the spatial extent of the photon gas inside the cavity and the resulting varying coupling to the molecules [85]. Hence, they are able to describe the effect of a finite sized pump spot and its implication at the relaxation of the photon gas into the thermal condensate as well, the results are depicted in figure 1.18. These show that thermalisation after an off-centre 

27

1. Introduction 

Fig. 1.19: Colour-coded the polarisation P of the photon BEC in dependency of the pump laser polarisation Ppump and the ratio of pump and decay rate Γ↑/Γ↓. Reprinted figure with permission from [86]. Copyright (2017) by the American Physical Society. 

a) b) 

Fig. 1.20: Steady-state photon occupation from the model (1.64) with the cumulants approach from [33]. a) BEC phase. b) the laser-like state. The picture is reprinted from [33] under the license CC-BY-3.0. 

pump pulse happens provided the coupling to the dye medium is large enough, as it is the case in figure 1.18 b). If this coupling is too small, no thermalisation happens and the photon oscillations are nearly undamped, see figure 1.18 a). In a second branch, the model has been extended for describing the polarisation of the photon gas inside the cavity in dependency on the pump polarisation [86]. The results, shown in figure 1.19, clearly prove the thermal gas to be unpolarised, but once entering the condensate regime the condensate itself follows the pump polarisation. Still, the model from study [83] suffers from not taking into account the coherent light-matter coupling. Thus, it is not able to properly describe the transition of the system from the photon BEC to the laser regime. The authors of reference [33] elaborate on this problem and take into account both the coherent light-matter coupling and the corrections due to the phonon dressing, and derive under these circumstances the master equation (1.64). Based on this, the reference works out in detail the crossover from a laser-like state to the photon BEC state and how the photon-distribution changes. The latter is shown in figure 1.20 once for the BEC case and once for the laser-like case. Moreover, it determines the strength of the effective photon-photon interaction arising from the coherent light-matter interaction. Finally, the model (1.64) also serves as a starting point for calculating the rate equations governing the fluctuations of the photon condensate [87]. Here, it turns out that the 

28

1.3. Photon Bose-Einstein Condensates 

Fig. 1.21: Non-hermitian phase transition, as worked out in [90]. The top row shows two 

exemplary measurements of the g(2) function, while the lower plot shows the phase diagram for the behaviour of the g(2) function. From [90]. Reprinted with permission from AAAS. 

fluctuation dynamics is different from what is predicted by the standard equilibrium statistical mechanics, since the g(2) function (1.48) shows an oscillatory behaviour in the BEC regime, as depicted in figure 1.21 top row on the right. This is surprising in that the photon distribution follows the Bose-Einstein distribution and, thus, corresponds to thermal equilibrium. Reference [90] refines these findings in more detail by figuring out an exceptional point separating a bi-exponential BEC phase, see figure 1.21 top row on the left, from the oscillatory BEC phase. The latter is reached, when the photon loss is increased, effectively corresponding to a smaller thermalisation rate, just before the crossover to the laser regime occurs for even larger photon numbers, as figure 1.21 bottom indicates. Hence, these microscopic findings clearly reveal that the photon BEC does not result from a real equilibrium phase transition, but is rather described as the steady state of an open-dissipative system, where the particle distribution mimics a thermal equilibrium. 

Stochastic Field Modelling Stochastic fields constitute the second pillar for describing lattices of photon BECs [93–96]. These models are built upon the stochastic open-dissipative Schrödinger equation for a lattice of coupled cavities. They consider the Kennard-Stepanov relation (1.51) by replacing the condensate frequency with the time derivative, i.e., ω → −i∂t [93]. However, this approximation bears the problem to figure out the parameter regime where the approximation is valid. Hence, it is crucial to work with an array of flat mirror cavities, corresponding to a lattice of photon BECs. In this 

29

1. Introduction 

Fig. 1.22: Vortex physics in plain cavity arrays as calculated in [94]. The top row shows the vortex motion and the bottom row the corresponding phase distribution of the BEC. The relevant parameters are written below the bottom row. Modified figure with permission from [94]. Copyright (2020) by the American Physical Society. 

situation, the site-dependent complex order parameter ψ takes the form 

i ∂ 

∂t ψ = (1− iκ)T̂ψ + 

i 

2 B21 

( M2 − eβ∆M1 − γ 

) ψ , (1.66) 

where T̂ denotes the hopping matrix, B21 the emission coefficient, γ the cavity loss, β = 1/kBT the inverse temperature, ∆ the cavity-molecule detuning, M1,2 the number of molecules in the ground and excited state, respectively, and κ = βB21e 

β∆M1 the re-laxation rate. The latter gives rise to an imaginary part in the hopping matrix element. In this model, a stochastic unit-length phase models the spontaneous emission into the photon condensate. Firstly, this model is applied to two coupled cavities realising a Josephson junction [93]. It turns out that the tailoring of the reservoir, which determ-ines whether the condensate appears in a canonical or a grand-canonical environment, and the accompanying change of the photon fluctuations have a high impact on the resulting effective tunnelling rate. The vortex physics in a 2D box-shaped cavity array lies at the focus of the studies [94– 96]. Here, the first result was to figure out the vortices behaving like centres of particle creation, as it is the case for polariton-exction condensates in subsection 1.2.2. The spiral phase pattern supports this interpretation, c.f., figure 1.22 bottom row. Thus, like in the case of exciton-polariton condensates, the vortex shoots particles [68]. Due to this, the vortex also shows some self-acceleration behaviour leading to a circular motion of the vortex core itself, see top row of figure 1.22. These two findings are attributed to the presence of spontaneous emission. The most important finding in reference [94] is the existence of a stable vortex without having an explicit photon-photon interaction in (1.66). Instead, the vortex is stabilised by the absorption and re-emission processes of photons with the dye molecules. This interpretation is supported by the fact that a reduction of the emission coefficient B21 yields the vortex to become unstable. As a 

30

1.3. Photon Bose-Einstein Condensates 

Fig. 1.23: Time evolution of vortex-pair density σ in photon BEC arrays for different emission coefficients B21 as calculated in [96]. Modified figure with permission from [96]. Copyright (2022) by the American Physical Society. 

result of this, the follow-up study [95] relates the latter to a BKT-like phase transition in photon condensates and works out the critical cavity-cavity coupling strength in depend-ency on both, the relaxation rate κ and the on-site photon population. Here, BKT-like transition refers to the Berezinskii–Kosterlitz–Thouless transition in 2D systems, which is a phase transition of infinite order, where for temperatures larger than a certain crit-ical temperature unbound vortex-antivortex pairs destroy the order in the system [97– 100]. In this respect, reference [96] deals with the vortex-antivortex annihilation. To this end, a quench into the condensate phase first creates the vortex pairs and, subsequently, the vortex-pair density σ, i.e., the number of vortices per cavity site, is investigated afterwards. Figure 1.23 depicts the time evolution of the vortex-pair density. After a short metastable vortex-pair density at the beginning, this density starts to decay, cor-responding to vortex-antivortex annihilation. Interestingly, this annihilation dynamics stays in competition with the motion of the vortices, leading for special configurations to another metastable vortex configuration. Finally, the vortex-pair density decays faster for increasing emission coefficient B21 as this corresponds to a faster thermalisation of the condensate. 

Mean-Field Gross-Pitaevskii Model Apart from microscopic and stochastic models, also effective ones based on a Gross-Pitaevskii equation are considered for describing the thermo-optic photon-photon interaction as subsection 1.3.3 discusses it. Publication [80] is the first to work with such a model. There, the authors investigate the Bogoliubov spectrum of the free photon condensate subject to the thermo-optic interaction and the resulting sound velocity. However, this model can only be understood as a local approximation in the centre of the trap, as homogeneous BECs in 2D are forbidden by the Mermin-Wagner-Hohenberg theorem [74, 75]. Nevertheless, this kind of model proves to be convenient for describing the interaction effects and, thus, builds the cornerstone of the present thesis, c.f., figure 1.16. But the thesis adopts this model for a harmonically trapped case, such that Bose-Einstein condensation is well-defined. A comparison to subsection 1.2.2 shows that these models are formally equivalent to corresponding models for the exciton-polariton BEC. This comparison is worked out in detail in reference [79]. 

31

1. Introduction 

Further Modelling Further studies investigate the mode competition by using modified rate equations [88, 89]. Here, the rate equations have basically the form from subsection 1.3.2, but the equation for the dye also includes the spatial distribution of the excitations of the dye molecules. In reference [88] the authors work out the influence of an off-centred external pump beam for both the harmonic and the double-well potential. In both cases, they determine which mode grants a macroscopic occupation in dependency on the pump-beam centre and the pump strength as well. Moreover, for large enough pump strength more than one mode can gain macroscopic occupation. In reference [89] they continue this investigation and derive a phase diagram for the macroscopically occupied modes in dependency of both the pump and the thermalisation strength. Moreover, in the phase, selecting the ground mode, the numerically obtained mode occupations are compared to the Bose-Einstein distribution in order to examine the conditions for having a photon BEC. Another minor line of studies examines the effect of coordinate-dependent masses [91, 92]. Here the mass depends on the spatial coordinate inside the microcavity according to the mirror surface. Therefore, the coordinate-dependency of the mass generalises the interpretation of the mirror surface variation as a potential. However, the corrections to the mass are small for current experimental parameters, such that the potential interpretation is physically sufficient and preferable due to the minor computational effort. 

1.3.5. Experimental tour d’horizon 

This subsection summarises all the experimental progress in achieving and examining photon condensates up to summer 2022. Map 1.30 on page 40 grants an overview of the different experimental publications. Mainly three different groups are active on this topic, the Weitz group at the University of Bonn, which created the first photon BEC, then the Nyman group at Imperial College in London and, lastly, the Klaers group at the University Twente. Map 1.30 differentiates between these three groups and mentions also the sporadic contributions by other groups to the field. 

Creation of Photon BECs As a first step to photon condensation reference [73] reports the thermalisation of a photon gas in the dye-cavity setup by using techniques and ideas introduced in subsection 1.3.1. This setup, sketched in figure 1.24, has proven to be a favourable environment for creating the first photon condensates [70, 71]. As already pointed out in subsection 1.3.1 one of the advantages of this setup is the possibility to observe the photon gas in-situ by measuring the light leaking out of the cavity. This light is available for both spatial and spectral analysis at the same time, as figure 1.24 shows. Instead of having a liquid dye solution inside the cavity, also the possibility of confining the dye molecules inside a polymer was studied [101]. However, the major problem of the polymer setup is the ongoing photodegradation of the polymer, such that it cannot be used for detailed studies. Dye-filled cavities are not the only possible experimental setup for obtaining photon BECs. Also, one-dimensional photon condensates in optical fibre cavities have been realised [102, 103]. These experiments bear the advantage that the cavity temperature can be varied more easily than in the dye-cavity setups, as the fibre cavity is much smaller. However, this comes with the problem that the Kennard-Stepanov relation 

32

1.3. Photon Bose-Einstein Condensates 

Fig. 1.24: Sketch of experimental setup used in the most experiments in the Bonn group, e.g., [71]. The cavity is filled with a dye medium, which is pumped externally by a Nd:YAG laser. The light leaking out of the cavity is either analysed spatially by directly taking a picture of the light beam or analysed spectrally by sending upon a diffraction grating. The picture is reprinted from [71] with permission of Springer Nature. Copyright © 2011, Springer-Verlag. 

(1.51) is worse fulfilled than by using Rhodamine 6G molecules. Especially in the latter experiment [103], the 1D condensate is possible due to the sublinear photon dispersion, for which the fibre is fabricated and not due to a certain photon potential. 

Photon Potentials A second technical exploration of photon condensates lies within the creation of different trapping potentials for the photon gas. The first technique developed consists of bringing a thermosensitive polymer into the dye solution [104]. Figure 1.25 a) shows the experimental setup for this technique. The polymer undergoes a sharp, reversible phase transition at a temperature of 305 K. The higher temperat-ure phase of the polymer possesses an increased refractive index, such that the optical length between the mirrors increases. As this corresponds to a larger wavelength, i.e., to a smaller photon energy, this technique is able to produce effective photon potentials. However, this method lacks controllability, since both the transversal temperature dif-fusion and the build-up time of the potential represent non-negligible effects. The first effect limits the lateral resolution to 3µm. A second way, builds upon this delamination technique, but instead of relying on a poly-mer inside the dye solution, the dielectric coating of the mirrors is steadily deformed [105]. A highly absorptive silicon layer directly below the dielectric coating, which ex-pands when heated by a laser, introduces a static deformation of the dielectric coating, as figure 1.25 b) sketches. In addition, this method lacks from a limited writing resol-ution, which is due to the thickness of the laser beam and the heat diffusion inside the mirrors again up to 3µm. However, this method allowed for the first photon condensate in a double-well potential [106], as shown in figure 1.25 c), and in a box potential [107]. Focused ion beam milling prospects another way for creating photon potentials [108]. The essential advantage of this method is the increased writing resolution of about 

33

1. Introduction 

a) 

b) 

c) 

Fig. 1.25: Comparison of different delamination techniques. a) Potential via thermo-sensitive polymer as described in [104]. b) Potential via steady deformation of the dielectric coating by heating an absorption layer of silicone as described in [105]. c) Example for eigenmodes in double-well potential written via the steady deformation technique. The x-direction is integrated out and the y-dependency of the different modes is shown. The top plot demos the photon gas below condensation threshold, while the bottom plot is above condensa-tion threshold. The picture stems from [106]. Figure a) reprinted from [104] with permission from Springer Nature. Copyright © 2017, Nature Publishing Group. Figure b) reprinted from [105] with permission from EPL Association. Figure c) reprinted from [106] with permission from AAAS. 

34

1.3. Photon Bose-Einstein Condensates 

a) b) c) 

Fig. 1.26: Application of controllable potentials for photon BECs. a) Controllable Josephson junction from [113]. The above plot shows the mirror height map, where the rectangular surrounding is written by the delamination technique developed in [105], whereas the barrier height is controlled by the polymer technique from [104]. The bottom plot shows a slice through the centre of the junction. b) Mach-Zehnder interferometer for photon BECs from [114]. The above plot shows the cavity mirrors with the dye-polymer solution in between. The bottom plot is the height map of the nanostructured mirror, yielding the photon potential. On the most left point, the condensate is created and the time delay of one of the arms is controlled by locally heating the dye-polymer solution. The intensities on the right are then detected. c) Intensity distribu-tions in the Mach-Zehnder interferometer from b) for different time delays. Figure a) reprinted from [113] and b), c) reprinted from [114], both under the CC-BY-4.0 licence. 

300 nm, but at the same time bears the disadvantage of having a large mirror surface roughness. The latter yields the problem of an increased cavity decay, preventing the photon gas inside the cavity to thermalise for higher photon intensities and, thus, to condense. In a current line of study, where the experiments are just built up in Kaiserslautern, the microstructuring of mirrors via 3D laser writing stands in the foreground [109–112]. The advantage of this technique is the high writing resolution in the sub-µm regime, such that potentials with a larger anisotropy can be produced, whilst the mirror-surface roughness gets not too large. The aims consists in realising effectively one-dimensional photon condensates and in studying the corresponding dimensional crossover from 2D to 1D. 

Controllable Potentials In the track of the Twente experiments, see map 1.30 on 40, the static delamination method developed in reference [105] is combined with the dy-namical polymer-based method used in reference [104]. In experiment [113] this led to a construction of a controllable Josephson junction, where the delamination technique creates the static confining potential and the polymer method controls the height of the potential barrier. Figure 1.26 a) shows the details of the prepared potential. The latter allows controlling the height of the barrier by modulating the power of the external heat-ing laser. The same idea has led to the creation of a Mach-Zehnder interferometer for photon BECs [114]. Here, the paths of the interferometer are statically written and the delay in one of the paths is externally controlled by heating the polymer inside the dye medium, see figure 1.26 b). As a result, figure 1.26 c) shows the intensity distribution in such a Mach-Zehnder interferometer for different delay times. 

35

1. Introduction 

a) b) c) 

Fig. 1.27: Statistical physics of photon condensate. a) Fluctuation catastrophe of the photon BEC from [115]. The plot shows that at each time the condensate van-ishes, the phase of the latter randomly jumps and stays constant for the “new” condensate that emerges. b) Coherence length of the photon condensate along the phase transition from thermal gas to condensate (black line) according to [116]. The green dashed line shows the thermal de-Broglie wavelength, which is the coherence length in the thermal regime. The blue line depicts the width of the ground-state mode, which yields in the trapped system the threshold coherence length for the photon condensate. The dashed black line is the theoretically expected coherence length, while the black solid line takes cor-rections to the finite resolution of the apparatus into account. The dots show the measurement. c) Specific heat of the photon condensate as measured in [117]. The solid lines show the theoretical prediction for an ideal Bose gas with different particle numbers, whereas the dots represent the measurement. Reprinted figure a) with permission from [115]. Copyright (2016) by the American Physical Society. Figure b) reprinted from [116] and figure c) reprinted from [117], both under the CC-BY-4.0 licence. 

Statistical Physics and Thermodynamics Another branch of experiments investig-ates the statistical physics and thermodynamics of photon condensates. The coupling to a sizeable reservoir is one of the most important differences to atomic condensates. This allows photon condensates to be tuned continuously between canonical and grand-canonical ensembles [118]. The recent study [119] confirms this finding by investigating the fluctuation-dissipation relation [27]. Statistical physics predicts for a grand-canonical ideal Bose gas the fluctuations of the photon number to be at the same order of mag-nitude than the condensate occupation itself, if the gas is Bose-Einstein condensed [27]. This effect is called fluctuation catastrophe [120]. As this results in the condensate dis-appearing and reappearing randomly, the fluctuation catastrophe has been considered for a long time as a consequence of the grand-canonical description without any physical relevance. Reference [121], however, revealed for the first time the physical evidence of the fluctuation catastrophe, as the photon condensate represents a grand-canonical en-semble. Measuring the interference signal of a photon BEC with a dye laser supports the same findings [115]. In this study, the phase jumps accompanying the vanishing of the photon condensate are explicitly measured, showing that the condensate breaks down and reappears again, see figure 1.27 a). In this respect also the first-order coherence function 

g(1)(r,−r; τ) = 

〈 Ê†(r, t)Ê(−r, t+ τ) 

〉 

√〈 Ê(r, t)|2 

〉〈 |Ê(−r, t+ τ)|2 

〉 , (1.67) 

36

1.3. Photon Bose-Einstein Condensates 

with Ê being the electric-field operator, was measured [116]. Here, the authors determ-ined both the thermal de-Broglie wavelength in the thermal regime and the correlation length of the condensate in the BEC regime. They paid particular attention to how coherence develops during the phase transition to the BEC phase, which is depicted in figure 1.27 b). But not only the local statistics lies within the focus of the experiments, several one examinate the thermodynamic properties of the dye-cavity photon gas. Measurements of the thermodynamics in large condensates revealed the photon gas to behave as an ideal 2D gas in a harmonic potential [117]. The photon spectrum allows for determining thermodynamic quantities like the condensate fraction, serving as an order parameter for the phase transition, and the specific heat as well, shown in figure 1.27 c). Note that these experiments vary the particle number N instead of changing the temperature T , as it is the case in atomic BECs. In a 2D system, the mapping T/Tc = 

√ Nc/N allows for 

transforming a change of the particle number into a change of the temperature. Here Tc and Nc stand for the critical temperature and the critical particle number, respectively, Meanwhile, also the thermodynamics of a photon gas in a box potential is investigated, including its compressibility [107]. The latter is measured by imposing a linear potential gradient on the condensate, such that a constant force acts on the photon gas. 

Microcondensates However, so far only the standard definition for a BEC has been used for classifying the phase of the system. This relies on having a macroscopic oc-cupation in the ground state accompanied by a Bose-Einstein distribution of the oc-cupation numbers and a long-range coherence within the condensate. The question of what actually discriminates a photon BEC from a laser-like state is answered by sev-eral experiments conducted by the Nyman group [122–124]. They ask, what happens if the parameter ℏΩ/(kBT ) is equal or larger than 1 by varying the harmonic trapping frequency Ω. In this case, only the ground state of the photon gas can be occupied, and no phase transition is observed [122]. Hence, a microlaser cannot be distinguished from a photon BEC. In the work [123] they succeeded in creating a photon condensate with only seven photons. However, in this experiment they face the problem that the condensate does not thermalise to the solvent molecules, but discuss not further where this behaviour stems from. Figure 1.28 a) depicts the situation by comparing the meas-ured high resolution spectrum to a fitted Bose-Einstein distribution. They compare the experimental data to two different models, once to a corresponding Bose-Einstein distri-bution and once to a microlaser model and find that both explain the measurement of the mode population. As a second part, also a condensation of many modes is investig-ated. If the cavity is detuned, such that not only the ground state but also excited states are near to the emission maximum of the dye medium, nearly every mode can gain a macroscopic occupation. This situation is shown in figure 1.28 b) and c). Whereas in b) still a standard BEC is observed, the situation changes in c) due to an increased mirror spacing, corresponding to a larger cut-off wavelength, such that the first two modes are condensed. In [124] the different phases of these multimode condensates are investigated quantitatively by using an AI-supported algorithm. With this, they are able to work out the complex phase diagram of these condensates. 

Non-Equilibrium Properties The last major track of experiments investigates the non-equilibrium properties of dye-cavity photon gases. As already shown in subsection 1.3.2 

37

1. Introduction 

a) b) c) 

Fig. 1.28: Formation of microcondensates according to [123]. a) High-resolution spec-trum of the microcondensate. The blue line is above the threshold, whereas the pink line depicts the thermal situation. Note that in the latter, the scaling indicates a mode occupation less than one. The green dashed line compares to a Bose-Einstein distribution at T = 150 K. b), c) Mode occupation in dependency of the external pump power. The inset shows in both situations the condensate fraction. In b) the cavity is tuned, such that the ground state condenses. In c) the cavity length supports a multimode condensation. Figures reprinted from [123] with permission from Springer Nature. Copyright © 2018, The Au-thor(s). 

photons in a dye filled cavity represent a highly open-dissipative system resembling thermal-equilibrium expectation values. Hence, some experiments aimed at the intrinsic non-equilibrium properties of the photon condensate. Reference [125] delivered the first investigation in this respect. This study focuses on the influence of a pump beam outside the trap centre and how the photon gas thermalises into the condensate phase. Here, too, the advantage of the photon BEC setup pays off in that it can be measured simul-taneously in real and Fourier space. In real space, the photon gas relaxes into the trap centre, provided the cavity-dye detuning is small enough to allow for thermalisation. Figure 1.29 a) depicts the results of this experiment. In Fourier space, a BEC forms right at the cavity cutoff under the same circumstances. Not only the place, where the pump beam is injected is relevant, but also the geometry of the pump spot itself influ-ences the shape of the photon gas [127]. The size of the pump spot directly yields the size of the photon gas, if the former is smaller than the thermal size of the gas. Reference [126] investigates the condensate formation after an initial pump pulse. If the latter is strong enough, a condensate forms after a certain time and then decays again into a thermal gas before it vanishes. In this respect also the temporal fluctuations were subject to measurements via the temporal g(2) function (1.48), pictured in figure 1.29 b). The basic observation consists in the ground-state being correlated along the diagonal and being anti-correlated at off-diagonal times. Since the diagonal correlation function g(2)(t, t) corresponds to the particle number fluctuations, this behaviour is interpreted as the condensate formation. As the latter can only happen with spontaneously emitted photons in the ground state, the condensate can only form, when fluctuations are large enough, but once it is formed, it dominates the dynamics. Hence, the anti-correlation at off-diagonal times (t1, t2) vanish, when the condensate exists. The same correlation function (1.48) is at the focus of the studies [87, 90], which were already discussed in the theory section 1.3.4. According to figure 1.21, this measurement shows the most striking features of the open-dissipative character of the photon BEC in contrast to atomic BECs. 

38

1.3. Photon Bose-Einstein Condensates 

a) b) 

Fig. 1.29: Non-equilibrium dynamics of the photon BEC. a) Relaxation dynamics of an off-centre photon gas for different cut-off wavelengths according to [125]. For smaller cut-off wavelength (most right picture) the thermal coupling to the dye medium is enhanced compared to the larger cut-off wavelength (left picture), such that the photon gas can condense into the trap centre. b) Measurement 

of the g(2) function (1.48) for different pump powers above the BEC threshold from [126]. Red indicates the correlated regimes along the diagonal, whereas black denotes the uncorrelated regimes at the off-diagonal part. Reprinted figure a) with permission from [125]. Copyright (2015) by the American Physical Society. Figure b) reprinted from [126] under the CC-BY-4.0 licence. 

Miscellaneous Experiments Finally, some loosely connected experiments are also re-ported in the literature. At first, the Nyman group investigated the phase-space dis-tribution of the photon gas [128]. This means, they measured both the momentum and spatial distribution dependent on the photon wavelength below, slightly above and far above the BEC threshold. In the latter case, they already reached the multimode condensed phase. By fitting the thermal cloud, they also report the photon-gas temper-ature to depend on the size of the pump spot. Also, the van-Oosten group in Utrecht was able to create photon BECs. One publication [129] focuses on the density profile of the photon cloud inside the dye-filled cavity with the aim to investigate the behaviour of the photon temperature by varying the numerical aperture of the collecting lens. A second publication [130] analyses the width of the photon condensate for measuring the strength of the effective photon-photon interaction, c.f., subsection 1.3.3. However, the reported values are an order of magnitude larger than in comparable experiments by the Weitz group [70]. Furthermore, they seem to indicate counter-intuitively that a reduced dye-molecule concentration leads to an increased photon-photon interaction strength. Lastly, they succeeded in determining the polarisation of the photon BEC by determining the four Stokes parameters [131], which uniquely define the polarisation. The thermal cloud turns out to be unpolarised, whereas the polarisation of the photon BEC appears to follow the one of the pump laser. Thus, these results seem to agree with the theoretical study [86]. 

39

1. Introduction 

Experimental Overview 

Creation of Photon BECs 

Thermalisa-tion and 

condensation [70, 73] 

Experimental setup [71] 

Thermalisa-tion in 

polymeric matrix [101] 

Fiber cavities [102, 103] 

Photon Potentials 

Delamination technique [104, 105] 

Ion-beam milling [108] 

Double well [106] 

Box [107] 

Controllable Potentials 

Josephson junction [113] 

Mach-Zehnder interferometer 

[114] 

Coupled BECs [132] 

Statistical Physics and 

Thermodynam-ics 

Statistical physics [118, 

121] 

Coherence [115, 116] 

Thermody-namics [117] 

Compressibil-ity [107] 

Microcondens-ates Towards small 

condensates [122] 

Condensates smaller than ten photons 

[123] 

Phases [124] 

Non-Equilibrium Properties 

Relaxation dynamics [125] 

Inhomogen-eous pumping 

[127] 

Multimode condensates 

[128]Second order correlation 

[126] 

Non-hermitian phase 

transition [87, 90] 

Fluctuation-dissipation 

relation [119] 

Miscellaneous 

Density profile [129] 

Photon-photon 

interaction [130] 

Polarisation [131] Weitz group (Bonn) 

Nyman group (London) 

Klaers group (Twente) 

van Oosten (Utrecht) and Fischer (Haifa) group 

Fig. 1.30: Experimental overview. The different colours denote the different experi-mental groups, compare to the listing on the right-hand side. 

40

1.3. Photon Bose-Einstein Condensates 

Experimental Overview 

Creation of Photon BECs 

Thermalisa-tion and 

condensation [70, 73] 

Experimental setup [71] 

Thermalisa-tion in 

polymeric matrix [101] 

Fiber cavities [102, 103] 

Photon Potentials 

Delamination technique [104, 105] 

Ion-beam milling [108] 

Double well [106] 

Box [107] 

Controllable Potentials 

Josephson junction [113] 

Mach-Zehnder interferometer 

[114] 

Coupled BECs [132] 

Statistical Physics and 

Thermodynam-ics 

Statistical physics [118, 

121] 

Coherence [115, 116] 

Thermody-namics [117] 

Compressibil-ity [107] 

Microcondens-ates Towards small 

condensates [122] 

Condensates smaller than ten photons 

[123] 

Phases [124] 

Non-Equilibrium Properties 

Relaxation dynamics [125] 

Inhomogen-eous pumping 

[127] 

Multimode condensates 

[128]Second order correlation 

[126] 

Non-hermitian phase 

transition [87, 90] 

Fluctuation-dissipation 

relation [119] 

Miscellaneous 

Density profile [129] 

Photon-photon 

interaction [130] 

Polarisation [131] Weitz group (Bonn) 

Nyman group (London) 

Klaers group (Twente) 

van Oosten (Utrecht) and Fischer (Haifa) group 

41

## 2. Collective Modes of a Photon Bose–Einstein Condensate with Thermo-Optic Interaction 

Versuch ich wohl, euch diesmal festzuhalten? Fühl ich mein Herz noch jenem Wahn geneigt? Shall I attempt to hold you fast once more?//Heart’s willing still to suffer that illusion? 

J. W. Goethe, Faust I, ll. 3-4 

This study directly builds upon the results discussed in section 1.3.3 and examines the effect of the thermo-optic photon-photon interaction on the lowest-lying collective fre-quencies. The theory works with a cumulants’ expansion together with proper ansatzes for both the condensate wave function and the temperature distribution based on refer-ence [81]. A discussion with experimental colleagues revealed the importance of the mirrors for describing the temperature diffusion. Here, it turns out that not only the temperature diffusion inside the cavity, but also the temperature diffusion inside the mirrors needs to be taken into account properly. The appendix of the paper describes how to reduce the dimension of the temperature-diffusion equation from 3D to 2D by including the cavity mirrors. Therefore, the whole appendix, which is important to link the theory with the experiment, has been developed in the doctorate. Additionally, the discussion unveiled the difference between the experimental pump scheme and the one used in the theoretical analysis in [79]. While the experiments work with a pulsed pump scheme, which is characterised by the duty cycle σ, i.e., the ratio of the time between two single experiments and the duration of a single experi-ment, the theory uses a continuous pump. For being consistent, the theory has to use the number of photons σN that are on average in the photon BEC. Appendix B covers some additional details on this. These additional findings were crucial for estimating the correct order of magnitude for the effective photon-photon interaction. As a last modification in comparison to the diploma thesis, this study uses a more soph-isticated numerical scheme based on a finite-difference discretisation of the Laplacian operator of the kinetic energy. This change has increased both the simulation speed and its precision. Hence, the new contributions move the mean-field model closer to the experiments. As it builds the fundamental block to describe the thermo-optic photon-photon interaction, the model is of high relevance to the remaining results achieved in the present thesis. 

Here, I have worked out all the details of the analysis of both the variational approach and the reduction of the dimension of the fundamental equations, in particular for the 

43

2. Collective Modes of a Photon Bose–Einstein Condensate with Thermo-Optic Interaction 

temperature degree of freedom as described above. Further on, together with Antun Balaž, I adapted the numerical scheme from references [133–135] to the description of the thermo-optic interaction, as the latter was originally developed for a Gross-Pitaveskii equation. Afterwards, I have performed the necessary simulations and have implemented the analysis script for the obtained numerical data. Finally, I have also prepared the first draft of the manuscript. The co-authors contributed to the manuscript during the review process. 

44

PAPER 

### Collective modes of a photon Bose–Einstein condensate with thermo-optic interaction 

Enrico Stein1,3 , FrankVewinger2 andAxel Pelster1 

1 Department of Physics andResearchCenterOPTIMAS, TechnischeUniversität Kaiserslautern, Erwin-Schrödinger Strasse 46, D-67663 Kaiserslautern, Germany 

2 Institut für Angewandte Physik, Universität Bonn,Wegelerstrasse 8,D-53115 Bonn,Germany 3 Author towhomany correspondence should be addressed. 

E-mail: estein@rhrk.uni-kl.de, vewinger@iap.uni-bonn.de and axel.pelster@physik.uni-kl.de 

Keywords: open dissipative quantum systems, photon–photon interaction, photon Bose–Einstein condensate 

Abstract Although for photon Bose–Einstein condensates themainmechanismof the observed photon– photon interaction has already been identified to be of a thermo-optic nature, its influence on the condensate dynamics is still unknown.Here amean-field description of this effect is derived, which consists of an open-dissipative Schrödinger equation for the condensate wave function coupled to a diffusion equation for the temperature of the dye solution.With this system at hand, the lowest-lying collectivemodes of a harmonically trapped photon Bose–Einstein condensate are calculated analytically via a linear stability analysis. As a result, the collective frequencies and, thus, the strength of the effective photon–photon interaction turn out to strongly depend on the thermal diffusion in the cavitymirrors. In particular, a breakdownof the Kohn theorem is predicted, i.e.the frequency of the centre-of-mass oscillation is reduced due to the thermo-optic photon–photon interaction. 

1. Introduction 

In recent yearsmany theoretical and experimental results have contributed to a basic understanding of quantum fluids of light [1], wheremany photons propagate in nonlinear optical systems. The corresponding collective features are due to effective photon–photon interactions, which are induced by the nonlinearmatter. The hydrodynamic behaviour of light in a cavity, first noted by Lugiato and Lefever in 1987 [2], was theoretically brought forward in [3] by deriving aGinzburg–Landau equation for laser light inside a cavity. These theoretical workswere complemented by the experimental proof of superfluidity of light via the pioneering observation of stable quantised vortices by Swartzlander and Law in 1992 [4].With this the natural question arose, whether light could also undergo the equilibriumphase transition of Bose–Einstein condensation. This intriguing questionwas partly answered in 2002when thefirst exciton-polariton condensate was realised [5]. However, such condensates have turned out to be not of a Bose–Einstein type, as their life time is shorter than the intrinsic equilibration time. In contrast to that an equilibriumBose–Einstein condensate (BEC) of pure light was achieved in Bonn in 2010 [6]. Although this is still a driven-dissipative system like the exciton-polariton condensates, the favourable time scale ratio allows for the observation of equilibrium effects [7]. 

The experimental setup to create a BECof photons consists of amicrocavity filledwith a dye solution. There the cavity provides awell-defined ground state for the effective two-dimensional photon gas, as can be seen from the paraxial approximation, and the dye leads to a thermalisation of the photon gas via absorption and emission processes of the photons [8]. As the corresponding absorption and emission rates are related via a Boltzmann factor according to theKennard–Stepanov relation [9–12], the photon gas inherits the thermalisation from the dyemolecules. Provided that the pumping power is large enough in order to compensate unavoidable cavity losses and thermalisation proceeds faster than these losses, the photon gas can undergo an equilibriumBose– Einstein phase transition [13]. 

OPEN ACCESS 

RECEIVED 

15 July 2019 

REVISED 

18 September 2019 

ACCEPTED FOR PUBLICATION 

4October 2019 

PUBLISHED 

23October 2019 

Original content from this workmay be used under the terms of the Creative CommonsAttribution 3.0 licence. 

Any further distribution of this workmustmaintain attribution to the author(s) and the title of thework, journal citation andDOI. 

© 2019TheAuthor(s). Published by IOPPublishing Ltd on behalf of the Institute of Physics andDeutsche PhysikalischeGesellschaft 

45

Furthermore, the absorption and emission processes lead to effective photon–photon interaction mechanisms, see figure 1.One is the Kerr effect, where a nonlinear susceptibility causes the refractive index of the dye solution to be proportional to the intensity of the electric field in the cavity [14]. Note that amicroscopic theory of theKerr interaction in a photon BEC is based on a Lindbladmaster equation [15–17]. A second interaction effect is due to the heating of the dye solution, as the quantum efficiency of the dye is below 100%. This leads to a shift of the refractive index of the solvent [14] and correspondingly to a thermo-optic photon– photon interaction. As the latter ismediated by the temperature diffusing through the dye solution, it is non-local in space and retarded in time. So far the strength of the effective photon–photon interaction has been experimentally determined bymeasuring the increase of the condensate widthwith the photon number [6, 13]. From this it is concluded, that themain contribution of the interaction is due to the thermo-optic effect. The strength of the interaction, which can be defined to be dimensionless in two spatial dimensions [18, 19], is measured to have values up to = ´ -˜ ( )g 7 3 10 4 [6, 13], where the precise value depends on the detailed experimental configuration. An interaction strength of the same order was observed in another experiment in London in 2016 [20]. 

From atomic BECs it is known that observing the condensate dynamics represents a valuable diagnostic tool tomeasure systemproperties in general and two-particle interaction strengths in particular. For instance, observing collective frequencies of trapped condensates is a precise way tomeasure the strength of the contact interaction up to an astonishing precision of1‰ [21]. Therefore, observing the collective frequencies of a photonBEC is expected to yield additional profound information about the nature and the strength of the effective photon–photon interaction. Thismotivates to analyse in the following the lowest-lying collective modes of a photon BECunder the influence of the thermo-optic interaction in view of future experiments. 

2.Model 

Aminimalmean-field description of the thermo-optic interaction consists of two equations [22–24]. One is a nonlinear Schrödinger equation that accounts for the evolution of the electric field inside the cavity, which is assumed to be linearly polarised. The second equation describes the diffusion of the temperature, produced by the non-perfect absorption processes of photons. 

As the experiment takes place inside amicrocavity, the electric field can be treated in paraxial approximation [14, 25–28]which allows us tomap the three-dimensionalmassless photon gas in a sphericalmirror geometry to a two-dimensional gas of bosonic particles. These particles possess amass w= ( )m n ccutoff 0 

2, where the cavity-cutoff frequency is denoted byωcutoff and the light velocity in the dye solution is c/n0. Furthermore, these particles are trapped in a harmonic potential with frequency W = ( )c L R n2 0 0, that is determined by the cavity length L0 and the radius of curvatureR of themirror [6, 13, 29]. Thus, the evolution of the condensate wave function y ( )tr, , i.e.the electricfield normalised to the photon number, is described by an open-dissipative Schrödinger equation of the form [23, 29–31] 

Figure 1. Scheme of effective photon–photon interactionmechanisms. The electric field, here represented by the condensatewave functionψ, couples in twoways to the refractive index n. Once via theKerr effect, which is due to the non-vanishing third-order susceptibilityχ(3), and, secondly, also an increase of the dye-solution temperatureT due to the heating coefficientB is present. This yields via the thermo-optic coefficientβ a changeΔn of the refractive index. 

2 

46

   

y b y¶ = - + 

W + D + - G + 

+ G D 

⎧⎨⎩ ⎡ ⎣⎢ 

⎤ ⎦⎥ 

⎫⎬⎭( ) ( ) ( ) ( ) ( )t m 

m g T t p 

p 

n T t tr r r r ri , 

2 2 , 

i 

2 , , . 1t T 

2 2 2 2 

0 

Here, the remaining transversal degrees of freedom are denoted by = ( )r rr , T 1 2 . The thermo-optic effect is 

described by the nonlinearity in (1) involving the temperature differenceD ( )T tr, between the actual intra-cavity temperature and the room temperature. Here the coupling coefficient gT=−βmc2/n0 with the thermo-optic coefficientβ quantifies the energy shift due to the heating. As discussed above, it is justified to neglect the much smaller Kerr interaction. Due to the unavoidable cavity losses, the photon BEC is intrinsically an open system. Following [32], an incoherent pump scheme ismodelled by the imaginary part in (1). The pump is described by the coefficient p and the losses by the decay rateΓ. Note that the emission and absorption processes, which do not lead to a loss of photons, i.e.the coherent ones that are proportional to the quantum efficiency η, are not considered here. Thus, the loss rateΓ is only proportional to 1−η and gives rise to a heating of the dye solution as discussed below. Furthermore, the effects of a coordinate dependentmass and interaction strength [33, 34] are not taken into account, as these effects are negligible within the experimental parameter range. 

On the other hand the temperature differenceD ( )T tr, follows a diffusion equation. Reducing it from three to two spatial dimensions by the procedure described in appendix yields 

t y¶ D =  - D +⎜ ⎟⎛ 

⎝ ⎞ ⎠( ) ( ) ∣ ( ) ∣ ( )T t D T t B tr r r, 

1 , , , 2t 0 

2 2 

where the temperature diffusion constant is denoted byD0=λw/(cpρ). It depends on the thermal conductivity λw, the specific heat cp and the density ρ of the solvent [35]. The heating coefficient of the dye solution is given by 

r= G ( )B mc L n cp 2 

0 0 [24].Moreover, the temperature relaxation is governed by the time scale τ, which depends in general on the length scales of both the cavity and themirrors, see appendix.Note that in [22] only the limiting case t  ¥ is treated. 

A formally similarmean-fieldmodel was already establishedwithin the realmof exciton-polariton condensates [32], where the exciton bath plays a role comparable to the temperature for the photon BEC. However, the time scales of the two systems are inverted. In an exciton-polariton condensate the relaxation of the exciton reservoir is fast compared to the dynamics of the condensate, allowing its adiabatic elimination. In contrast to that, the photon BECdynamics, which is determined by the trap frequencyΩ, occurs on amuch faster time scale than the dynamics of the temperature, whose time scale is given by the large relaxation time τ. Thus, the resulting thermo-optic photon–photon interaction yields such a significant temporal retardation that no influence on any condensate dynamics is expected. 

Nevertheless, in the following it is shown that the collective frequencies of the photonBEC turn out to be modified by the thermo-optic photon–photon interaction. The reason is that, in the steady state, the refractive index near the trap centre ismodified, so the collectivemodes exploring its neighbourhood experience effectively a changed potential. Or, put differently, the temperature profile can be considered as themotional history of the condensate and, thus, the condensate effectively scatters with its ownhistory. 

3.Methods 

An analytical and a numerical evaluation of the system (1), (2) is performed.Whereas the analyticalmethod relies on aGaussian ansatz for both the condensate wave function and the temperature difference in order to reduce the PDE system to a set ofODEs, the numerical technique is based on afinite-differencemethod. Both methods are explained in detail below. 

3.1. Analyticalmethod The usual variational approach for dealingwith collective excitations in ultracold quantumgases is based on Hamilton’s principle [36–38]. As the photonBEC is intrinsically an open system, however, no such principle exists, as the energy is not a conserved quantity. This problem can be circumvented by considering the equations ofmotion of the cumulants [39, 40], i.e. calculating the evolution equations for the centre-of-mass and for the widths. Due to the openness of the system also the photon number ò y=( ) ∣ ( )∣N t r trd ,2 2 represents an additional variational parameter. For finding an ansatz for the photonwave function it is worthwhile noting that the ground state of the non-interacting system is a simpleGaussian function. As the interaction in the photon BEC ismeasured to be small, it is justified to consider the condensate wave function to be ofGaussian shape, where thewidth is used as a variational parameter. Note, that this ansatz still holds true for small pump and loss parameters [41]. Therefore, the ansatz for the condensate wavefunction is chosen to be of the form: 

3 

47

åy s p 

= - + - + = 

⎪ ⎪ 

⎪ ⎪ 

⎧ ⎨ ⎩ 

⎡ ⎣ ⎢⎢ 

⎤ ⎦ ⎥⎥ 

⎫ ⎬ ⎭ 

( ) ( ) ( ) ( ) ( ) ( ) [ ( )] ( ) ( )t N t 

q t q t q t A t r x t r C tr, exp 

1 

2 i i , 3 

j j 

j j j j j 

1 2 1,2 2 0 

2 

where the centre-of-mass coordinates are denoted by x0j(t)with the phasesCj(t), whereas qj(t) describe the condensate widths, and theAj(t) stand for the corresponding phases. The different coordinate directions are indicated by j=1, 2. Since all current photonBEC experiments are workingwith a particular pump sequence [6, 13], the duty cycleσmodels a continuous pump in the ansatz. Thus, the number of photons present on average in the cavity is given byσN. This averaging coarse-grains the dynamics, and for the steady-state values considered later the ansatz turns out to be reasonable. As the temperature difference is induced by the photons, it is justified to assume also aGaussian shape for its distribution, which solves by itself the homogeneous part of the diffusion equation (2): 

åp D = 

D -

-

= 

⎪ 

⎪ 

⎪ 

⎪ 

⎧ ⎨ ⎩ 

⎫ ⎬ ⎭( ) ( ) 

( ) ( ) [ ( )] 

( ) ( )T t T t 

s t s t 

r y t 

s t r, exp . 4 

i 

i i 

i 

0 

1 2 1,2 

0 2 

2 

HereΔT0(t) denotes the amplitude of the temperature difference, y0i(t) describes the centres of the distribution and si(t) their widths. The aim is now to calculate the equations ofmotion for the amplitudes, the centre-of-masses and thewidths, as well as their phases, following the procedure of [40]. 

Themean-field equations (1), (2) are solvedwith the ansatz (3), (4) for condensate wave function and temperature difference by applying the cumulant approach [40]. After eliminating the phases, the evolution of the remaining dynamical variables is described by the following set of equations 

b¶ = - G + D + G y[ ( ) ] ( )N p T p G N a, 5t T0 

¶ = ¶ + ¶ - - W - D -

+ y( ) ( ( ) ) ( ) 

( ) ( )x R q q I q R x T G g y x 

m q s bln 2 , 5t i t i i t i i i i i T 

T i i 

i i 

2 0 

2 2 2 0 0 

0 0 

2 2 

 ¶ = ¶ - + ¶ + - W 

- D -

+ -

+ y 

⎡ ⎣ ⎢⎢ 

⎤ ⎦ ⎥⎥ 

( ) ( ) 

( ) ( ) ( ) ( ) 

q q I q I q q q I m q 

q 

g 

m G T 

y x q 

s q 

q 

q s c 

2 

4 

2 , 5 

t i i t i i i i t i i i 

k k 

T T 

i i i 

i i 

i 

i i 

2 2 5 2 2 

2 3 2 

0 0 0 

2 

2 2 2 2 2 

t s¶ D = -

D + ( )T 

T BN d, 5t 0 

0 

s ¶ = 

D -( ) ( )y 

BN 

T x y e, 5t i i i0 

0 0 0 

s s ¶ = + 

D - + 

D -

⎛ ⎝⎜ 

⎞ ⎠⎟) ( ( )s D 

BN 

T q s 

BN 

T x y f4 2 . 5t i i i i i 

2 2 

0 

2 2 

0 0 0 

2 

Here, the overlap of the temperature-difference distribution and the condensate is described by 

å 

p = 

-

+ y 

= -

+ 

= 

⎡ ⎣⎢ 

⎤ ⎦⎥ 

( ) ( ) 

( ) 

G q s 

exp . 6T 

i 

x y 

s q 

i i i 

1,2 

1,2 2 2 

i i 

i i 

0 0 2 

2 2 

Furthermore 

b = 

-

+ -

+ y 

⎡ ⎣ ⎢⎢ 

⎤ ⎦ ⎥⎥ 

( ) ( ) ( ) ( )I 

T G 

n 

y x 

s q s q 

2 1 

2 7i 

T i i 

i i i i 

0 

0 

0 0 2 

2 2 2 2 2 

accounts for the pump and loss influence on thewidths, whereas 

b= -+ 

+ D + G -

+ y ( ) ( ) ( )R p 

x 

q s T G p 

y x 

n q s 8i 

i 

i i T 

i i 

i i 

0 2 2 0 

0 0 

0 2 2 

are the corresponding ones for the centre-of-mass. 

3.2. Numericalmethod The numerics performed in the present work is based on themethod developed in [42–44]. Here, the propagation of the two equations (1) and (2) is done via a split-stepmethod. First, both the condensate wave function and the temperature difference distribution are propagatedwith respect to the spatial derivatives by a Crank–Nicholson scheme. Afterwards the evolution regarding the remaining (non)linear equations is performed by infinitesimal exponential propagation. The space-time discretisation is chosen such that the calculational effort and the discretisation errors are well balanced. As initial wave function the steady state wave 

4 

48

functionwith slightly perturbedwidth and finite centre-of-mass is used.Due to this all threemodes, which are calculated analytically, are excited. From the calculatedwave function both the centre-of-mass and thewidth of the photon density are extracted and analysed by using a fast Fourier transformation. From thismethod the oscillation frequencies of the different collectivemodes can be read off. 

4. Steady state 

From the equations ofmotion of the cumulants (5a), it follows that the temperature evolution is determined by the condensate. So the steady state is completely described by the latter. Furthermore, due to the trap isotropy the condensate shape is also isotropic. Accordingly, the dependence of the equilibrium condensate width q0 on the equilibriumphoton numberN0 is described by 

p t = - + 

+ ˜ 

( ) ( ) q l 

gN 

q D 0 

1 1 2 

2 , 9 

0 4 

osc 4 

0 

0 2 

0 2 

where = W( )l mosc denotes the oscillator length.Moreover, the dimensionless interaction strength turns out to be 

 s t=˜ ( )g 

m g B, 10T2 

showing that the interaction strength is determined by the properties of the used dye solution, the geometry of themicrocavity, as well as by the pump scheme.Note, that this result is comparable to that in [24]. In addition, the effective photon–photon interaction can directly be controlled via the relaxation time τ by changing the geometry of the cavitymirrors, see (A.11). However, it turns out that in the experimental situation, where the longitudinal and the transversal extension of themirrors are of the order L1∼1 cm and L⊥∼1 mm, the temperature relaxation inside the cavity is governed by the transversal temperature diffusion in themirrors and (A.11) simplifies to 

t p 

= ^ ( )L 

D2 , 11 

2 

2 1 

with the diffusion constantD1 of themirror. In case of a large diffusion constant of the solvent, i.e. t D q0 0 2, 

the condensate width q0 approaches the non-interacting value losc. This results from a suppression of the thermo-optic interaction as all the temperature excitations are quickly transported through the dye solution. In the opposite case the behaviour p= +[ ˜ ( )]q l N g1 20 osc 0 

1 4 is reproduced, which is well known from2D atomic BECs [45]. 

The numerical solution of (9) is shown infigure 2, where the values of the Bonn experiment with the solvent ethylene glycol are used [13, 46, 47]. The dye solution is characterised by 

l r b= = = = = - ´- - - - - -n c1.46, 0.26 W m kg , 144.5 J mol K , 1110 kg m , 4.68 10 Kw p0 1 1 1 1 3 6 and 

G = 1 s. The cavity geometry is given by = ´ =-L R1.5 10 K and 1 m0 6 . The pump scheme yields a duty 

cycle ofσ=1/16 000. The effectivemirror diffusion constantD1 is of the order of - -10 m s6 2 1, thus yielding the relaxation time t ~ 0.1 s.With this the value of the dimensionless interaction constant is calculatedwithin the mean-fieldmodel to be 

Figure 2. Steady state (9) of the system (1), (2)with the ansatz (3), (4) for two different values of the diffusion constantD. The red line (circles) corresponds to the experimental value = ´ - -D 9.16 10 m s0,exp 

8 2 1 and the green one (diamonds) to the larger value = ´D D 100 0,exp 

2. Themarkers indicate the full numerical solution of the system (1) and (2) as explained in section 3.2. 

5 

49

~ -˜ ( )g 10 , 124 

which is in remarkable agreementwith the experimental value [6, 13, 20]. 

5. Linearised dynamics 

Linearising the equations ofmotionwith respect to small elongations out of the equilibrium yields a decoupling of the centre-of-mass from thewidth dynamics. Therefore, the dipolemode, which is a pure centre-of-mass motion, can be discussed separately from the breathing and the quadrupolemode, which are in- or out-of-phase width oscillations, respectively. Atfirst the investigation aims for the dipolemode, which can be described by the vector d d d= ( ˙ )x x yv , ,i i i i 

T 0 0 0 , where δ denotes small perturbations of the steady state and i=1, 2 indicates the 

respective coordinate directions. The linearised equation ofmotion is given by =˙ Sv vi idipole . The eigenvalues of Sdipole are complex due to the pumping and the coupling to the diffusion equation. The real parts describe the oscillation frequency of the dipolemode, whereas the imaginary parts represent the corresponding damping rates, which are discussed below. The frequencies are shown infigure 3, where the dashed lines are the results of a variational solution of the plainGross–Pitaevskii equation [36]. In atomic BECs the dipolemode frequency equals the trap frequency, which corresponds to a centre-of-massmotion in a harmonic potential, according to theKohn theorem [38]. In the present case of a temporal non-local interaction, however, a shift to smaller frequencies is observed, which shows that the aforementioned scattering of the condensate with its own history leads, indeed, to a slowing down of the condensatemotion and, thus, to the breakdown of theKohn theorem. Furthermore, a stronger temperature diffusion in the solvent leads to a smaller frequency shift. This shows again that the diffusion suppresses the thermo-optic interaction. 

The equations ofmotion describing the breathing and the quadrupolemode are coupled equations of the temperature and the condensate widths in both directions aswell as the photon number and the temperature amplitude, which are summarised in the vector d d d d d d d d= ( ˙ ˙ )T N q q r q q rw , , , , , , , T 

1 1 1 2 2 2 . The evolution of these quantities is described by =˙ Sw wwidths , where the real part of the eigenvalues of Swidths is shown in figure 3. Again, the frequencies are shifted to smaller values compared to a contact interaction. Even the breathingmode frequency, which turns out to be always twice the trap frequency for a contact interaction irrespective of the particle number and the strength of the contact interaction [45], gets shifted to smaller values. As before, wefind that a larger diffusion strength yields a smaller frequency shift. 

Infigure 4 the damping rates corresponding to the oscillation frequencies are plotted. As only a thermo-optic damping effect and no damping stemming from thematter is taken into account, these rates turn out to be quite small and also slightly positive. However, compared to the pulse duration, which is about 500ns, the instability occurs on amuch larger time scale of W ~-10 10 s6 4 . Nevertheless, this instability reflects the missingmatter degree of freedomof the presentmean-field theory. 

Figure 3.Oscillation frequencies obtained from real parts of the eigenvalues of Sdipole describing the dipolemode oscillation (green, squares) and of Swidths describing the quadrupole (blue, diamonds) and the breathingmode (red, circles) for the experimental value of the diffusion constant = ´ - -D 9.16 10 m s0,exp 

8 2 1. For the larger diffusion constant = ´D D 100 0,exp 2 the dipolemode frequency 

is visualised by the light blue (left triangles), the one of the quadrupolemode by the grey line (lower triangles) and the breathingmode by the pink (upper triangles) line. The dashed ones result from a variational evaluation of a simple Gross–Pitaevskii equationwith a harmonic trapping potential. Themarkers visualise the results of a numerical evaluation of system (1) and (2) as explained in section 3.2. 

6 

50

However, the damping rates are expected to be of the order of the reabsorption time, i.e.of the order of 10ps to 100ps [7]. Thus, in view of a trap frequency of pW = ´2 37 GHz, a few oscillations should be experimentally observable. 

6. Summary and experimental perspective 

In this paper the influence of a thermal shift of the refractive index on the photon BECdynamics is worked out. This shift yields an effective photon–photon interactionwhich is non-local in space and retarded in time. Due to the geometry dependence of the temperature diffusion, the strength of the effective photon–photon interaction can be controlled by the shape of themirrors.Moreover, due to the retardation in time, theKohn theoremdoes not hold in the present case and the dipolemode frequency is shifted to frequencies smaller than the trap frequency. Additionally, the temperature diffusion of the solvent has a large influence on the effective photon– photon interaction. The same happens to the breathing and the quadrupolemode. However, the damping rates of the collectivemodes are supposed to be larger once amore detailed theory takes the absorption and emission behaviour of the dye properly into account. 

The above predicted features can, in principle, bemeasured in twoways. Thefirst one relies on a direct observation of the collectivemodes. The dipolemode, e.g. can be excited by using two lasers, where the first one pumps the cavity homogeneously and the second one creates a BEC via an off-centre pulse. The excitedmode can then be observed bymeasuring spatially the light leaking out of the cavity. As the dipolemode oscillation frequencies are expected to be of the order of the trap frequency, a streak camera is necessary in order to resolve these extreme time scales. The experiment performed in [7] can be seen as a proof of principle in this respect. The secondmethod is an indirectmeasurement via the eigenfrequencies of the cavity [48]. In case of small interaction, which is the case in the photonBEC, the dipolemode corresponds to the difference of the lowest two cavity eigenfrequencies. Due to the interaction and the corresponding condensate broadening the third lowest energy state is also partially populated. This allows us to examine the breathing-mode by spectrally resolving the cavity emission. 

Acknowledgements 

We thankHadisehAlaeian, AntunBalažErik Busley,Wassilij Kopylov, ChristianKurtscheid, RobertNyman, MilanRadonjić, Julian Schmitt, Dries vanOosten, Georg von Freymann andMartinWeitz for interesting and useful discussions. Furthermore, we acknowledge support and funding by theDeutsche Forschungsgemeinschaft (DFG,GermanResearch Foundation)Project number 277625399—TRR185. 

Appendix. Temperature diffusion inmirrors 

The purpose of this appendix is to derive the diffusion behaviour of the temperaturewithin the cavity setup depicted infigure A1. The geometry is simplified by assuming planarmirrors in comparison to the original geometry, which consists of spherically curvedmirrors. 

A.1. Formulation of boundary value problem The complete cavity ranges from z=−L/2 to z=L/2, whereas themirrors extend from the boundaries up to z=−L0/2 and z=L0/2, respectively. The temperature diffusion constants of the dye solution filling the space 

Figure 4.Damping rates of the eigenmodes of Sdipole and Swidths. The green solid line corresponds to the damping of the dipolemode, whereas the green dashed line belongs to the temperature-difference oscillation. The remainder visualises the damping rates of the breathingmode (red, dashed), the quadrupolemode (blue, short dashed), the temperature-difference amplitude (brown, dashed– dotted), the temperature-difference breathingmode (orange, dotted) and one of the photon number (dashed-double-dotted). 

7 

51

between themirrors and of themirrors themselves are denoted byD0 andD1, respectively. Thus, the corresponding diffusion equation for the temperature differenceΔT between the actual temperature of the experimental setup and the room temperature reads [49] 

¶ D =  D +· [ ( ) ] ( )T D z T S, A.1t 

with the function q= + - -( ) ( ) (∣ ∣ )D z D D D z L 20 1 0 0 containing the respective diffusion constants and S being a source termwith support only inside the cavity. Due to the symmetry of the considered geometry in figure A1, it is sufficient to consider only the non-negative z half space togetherwith the vonNeumann boundary condition 

¶ D ==∣ ( )T 0. A.2z z 0 

On the other hand, the temperature difference obeys theDirichlet condition 

D = =( ) ( )T z L 2 0 A.3 

at the border of themirror. Furthermore, at z=L0/2, i.e.the contact of themirror and the dye solution, the temperature difference is continuous: 

    D - = D + 

  ⎜ ⎟ ⎜ ⎟⎛ ⎝ 

⎞ ⎠ 

⎛ ⎝ 

⎞ ⎠ ( )T 

L T 

L lim 

2 lim 

2 . A.4 

0 

0 

0 

0 

Integrating (A.1) in the neighbourhood of thematerial transition yields a jump condition for the first derivative of the temperature difference 

  

 ¶ D = ¶ D 

 = -

 = +∣ ∣ ( )D T D Tlim lim . A.5z z L z z L0 

0 2 1 

0 20 0 

A.2. Dimensional reduction of boundary value problem The aim is now to derive an effective equation for the transversal diffusion of the temperature difference within the cavity. Due to the piecewise defined diffusion functionD(z), the ansatz for the temperature difference is chosen to be 

D = D D^ ^ ( ) ( ) ( )T T t T zr , A.60 0 0 

inside the cavity and 

D = D Dt-^ ^ ( ) ( ) ( )T T T zre A.7t 

1 1 1 

for themirror. Bywriting down these two ansatzes three assumptions have beenmade. First, the transversal component inside the cavityDT̂ 0 varies on a time scale set by the photon condensate. This scale ismuch faster than the intrinsic scale of the diffusion process and, therefore, this component acts on its own time scale. The second assumption accounts for the steady state of the diffusion process in themirror. Accordingly, the ansatz (A.7) involves only an exponential time dependencewith the relaxation time τ. Lastly, only the lowest temperature differencemode is considered, as thismode decays least and has, therefore, the largest amplitude. With the two ansatzes (A.6), (A.7) the diffusion equation (A.1) reduces to one equation for each region, which are linked via the boundary conditions (A.2)–(A.5). 

Solving the diffusion boundary value problem leads to the following results. The relaxation time τ in the mirrors consists of the decay time of the transversal diffusion process 

Figure A1. Simplified geometry of the cavity setupwith flatmirrors.Within the region  -L z L2 20 0 the diffusion constant takes the valueD0, whereas in the outer region  ∣ ∣L z L2 20 the diffusion constant is given byD1. 

8 

52

t p 

=^ ^ ( )L 

D4 A.8 

2 

2 1 

and the longitudinal relaxation time twhich is determined by the transcendental equation 

t t t t = 

  

⎛ ⎝⎜ 

⎞ ⎠⎟ 

⎛ ⎝ ⎜⎜ 

⎞ ⎠ ⎟⎟ ( )D L 

D 

D L 

D tan 

2 cot 

2 . A.90 0 

0 

1 1 

1 

Here, themirror length is denoted by L1=L−L0. Furthermore, we assume that the relaxation time of the longitudinal diffusion inside the cavity occurs at the same time scale as the diffusion process inside themirrors. In the limit of amicrocavity, i.e. L L0 1, one finds 

t p 

= ( )L 

D . A.101 

2 

2 1 

Therefore, the totalmirror decay time τ is given by 

t p p 

= + ^ 

( )D 

L 

D 

L 

1 4 . A.11 

2 1 

2 

2 1 

1 2 

This result is plotted infigureA2 for the parameters of the Bonn experiment, where thewidth of themirrors is given by =L̂ 1 mm, whereas the length of themirror L1 is of the order of 1cm. Thus, in that cases (A.11) simplifies to (11). As a consequence, the effective longitudinal relaxation time of the temperature difference inside the cavity is provided by the transversal temperature difference diffusion in themirrors. Finally, the resulting two-dimensional diffusion equation for the transversal temperature difference within the cavity turns out to be 

t ¶ D =  - D +^ ^ ^ ^⎜ ⎟⎛ 

⎝ ⎞ ⎠ ( )T D T S 

1 , A.12t 0 0 

2 0 

which coincides with (2) in themain part. Note that the remaining source term takes the form 

### ò= D^ ^ ^ ( ) ( ) ( ) ( )S t 

L 

z S z t T zr r, 2 

d , , . A.13 L 

0 0 

2 

0 

0 

ORCID iDs 

Enrico Stein https://orcid.org/0000-0003-4820-7126 

References 

[1] Carusotto I andCiuti C 2013Quantum fluids of lightRev.Mod. Phys. 85 299–366 

Figure A2.Plot of the relaxation time (A.11) for the parameter region relevant in the Bonn experiment. The contour lines and the colour code provide the value of τ. The red crossmarks the current values of the Bonn experiment. 

9 

53

[2] Lugiato LA and Lefever R 1987 Spatial dissipative structures in passive optical systems Phys. Rev. Lett. 58 2209–11 [3] Staliunas K 1993 LaserGinzburg–Landau equation and laser hydrodynamics Phys. Rev.A 48 1573 [4] Swartzlander GA Jr and LawCT1992Optical vortex solitons observed inKerr nonlinearmediaPhys. Rev. Lett. 69 2503 [5] DengH,WeihsG, Santori C, Bloch J andYamamoto Y 2002Condensation of semiconductormicrocavity exciton polaritons Science 

298 199 [6] Klaers J, Schmitt J, Vewinger F andWeitzM2010 Bose–Einstein condensation of photons in an opticalmicrocavityNature 468 545–8 [7] Schmitt J, DammT,DungD,Vewinger F, Klaers J andWeitzM2015Thermalization kinetics of light: from laser dynamics to 

equilibrium condensation of photonsPhys. Rev.A 92 0116 [8] Klaers J, Vewinger F andWeitzM2010Thermalization of a two-dimensional photonic gas in a ‘white wall’ photon boxNat. Phys. 6 

512–5 [9] Kennard EH1918On the thermodynamics offluorescence Phys. Rev. 11 29–38 [10] Kennard EH1926On the interaction of radiationwithmatter and onfluorescent exciting powerPhys. Rev. 28 672–83 [11] Stepanov B I 1957Universal relation between the absorption spectra and luminiscence spectra of complexmoleculesDokl. Akad.Nauk 

112 839–41 [12] Kazachenko L P and Stepanov B I 1957Mirror symmetry and the shape of absorption and luminescence bands of complexmolecules 

Opt. Spektrosk. 2 339–49 [13] Klaers J, Schmitt J, DammT,Vewinger F andWeitzM2011 Bose–Einstein condensation of paraxial lightAppl. Phys.B 105 17–33 [14] BoydRW2008NonlinearOptics 3rd edn (NewYork: Academic) [15] Kirton P andKeeling J 2013Nonequilibriummodel of photon condensationPhys. Rev. Lett. 111 1004 [16] Kirton P andKeeling J 2015Thermalization and breakdown of thermalization in photon condensates Phys. Rev.A 91 0338 [17] RadonjićM,KopylovW, BalažAand Pelster A 2018 Interplay of coherent and dissipative dynamics in condensates of lightNew J. Phys. 

20 055014 [18] Bloch I, Dalibard J andZwergerW2008Many-body physics with ultracold gasesRev.Mod. Phys. 80 885–964 [19] Hadzibabic Z andDalibard J 2011Two-dimensional Bosefluids: an atomic physics perspectiveRiv. Nuovo Cimento 34 389 [20] Marelic J,Walker BT andNymanRA2016 Phase-space views into dye-microcavity thermalized and condensed photons Phys. Rev.A 

94 063812 [21] Stamper-KurnDM,MiesnerH-J, Inouye S, AndrewsMR andKetterleW1998Collisionless and hydrodynamic excitations of a Bose– 

Einstein condensate Phys. Rev. Lett. 81 500–3 [22] van derWurff EC I, de LeeuwA-W,DuineRA and StoofHTC2014 Interaction effects on number fluctuations in a Bose–Einstein 

condensate of lightPhys. Rev. Lett. 113 135301 [23] AlaeianH, SchedensackM, Bartels C, PeterseimD andWeitzM2017Thermo-optical interactions in a dye-microcavity photonBose– 

Einstein condensateNew J. Phys. 19 115009 [24] DungD,Kurtscheid C,DammT, Schmitt J, Vewinger F,WeitzM andKlaers J 2017Variable potentials for thermalized light and 

coupled condensatesNat. Photon. 11 565–9 [25] LaxM, LouisellWHandMcKnightWB1975 FromMaxwell to paraxial wave optics Phys. Rev.A 11 1365–70 [26] Landau LD and Lifšic EM1975Electrodynamics of ContinuousMedia (Course of Theoretical Physics) vol 8 (Oxford: Pergamon) 1st Engl. 

edn, repr. edn [27] Jackson JD 1999Classical Electrodynamics 3rd edn (NewYork:Wiley) [28] Zangwill A 2013Modern Electromagnetism 1st edn (Cambridge: CambridgeUniversity Press) (https://doi.org/10.1017/ 

CBO9781139034777) [29] NymanRA andWalker BT 2018 Bose–Einstein condensation of photons from the thermodynamic limit to small photon numbers 

J.Mod.Opt. 65 754–66 [30] Calvanese StrinatiM andConti C 2014 Bose–Einstein condensation of photonswith nonlocal nonlinearity in a dye-doped graded-

indexmicrocavityPhys. Rev.A 90 43853 [31] Stein E 2018Open-dissipativemean-field theory for photon Bose–Einstein condensatesDiplomaThesis TechnischeUniversitāt 

Kaiserslautern [32] WoutersM andCarusotto I 2007 Excitations in a nonequilibriumBose–Einstein condensate of exciton polaritons Phys. Rev. Lett. 99 

140402 [33] BermanOL, Kezerashvili R Y and Lozovik Y E 2017OnBose–Einstein condensation and superfluidity of trapped photonswith 

coordinate-dependentmass and interactions J. Opt. Soc. Am.B 34 1649–58 [34] VoronovaNS andLozovik Yu E 2018On the position-dependent effectivemass in Bose condensates of photons and polaritons in an 

opticalmicrocavity trap JETP Lett. 108 791–5 [35] Landau LD and Lifšic EM1987 FluidMechanics (Course of Theoretical Physics)Vol 6 2nd Engl. edn. (Oxford: Pergamon) [36] Pérez-García VM,MichinelH, Cirac J I, LewensteinMandZoller P 1996 Low energy excitations of a Bose–Einstein condensate: a 

time-dependent variational analysisPhys. Rev. Lett. 77 5320–3 [37] Pérez-García VM,MichinelH, Cirac J I, LewensteinMandZoller P 1997Dynamics of Bose–Einstein condensates: variational 

solutions of theGross–Pitaevskii equations Phys. Rev.A 56 1424–32 [38] Fetter A L andRokhsarD 1998Phys. Rev.A 57 1191–201 [39] BuschT, Cirac J I, Pérez-García VMandZoller P 1997 Stability and collective excitations of a two-component Bose–Einstein 

condensed gas: amoment approach Phys. Rev.A 56 2978–83 [40] MannN, BakhtiariMR, Pelster A andThorwartM2018Nonequilibriumquantumphase transition in a hybrid atom-optomechanical 

systemPhys. Rev. Lett. 120 063605 [41] Keeling J and Berloff NG 2008 Spontaneous rotating vortex lattices in a pumped decaying condensate Phys. Rev. Lett. 100 250401 [42] MuruganandamP andAdhikari SK 2009 Fortran programs for the time-dependent Gross–Pitaevskii equation in a fully anisotropic 

trapComput. Phys. Commun. 180 1888–912 [43] VudragovićD,Vidanović I, BalažA,MuruganandamP andMuruganandamSK 2012Cprograms for solving the time-dependent 

Gross–Pitaevskii equation in a fully anisotropic trapComput. Phys. Commun. 183 2021–5 [44] Young-S L E, VudragovićD,MuruganandamP, Adhikari S K andBalažA2016OpenMP fortran and c programs for solving the time-

dependentGross–Pitaevskii equation in an anisotropic trapComput. Phys. Commun. 204 209–13 [45] GhoshTK and Sinha S 2002 Splitting between quadrupolemodes of dilute quantumgas in a two-dimensional anisotropic trapEur. 

Phys. J.D 19 371–8 [46] NymanRA2017Absorption and fluorescence spectra of rhodamine 6Ghttps://doi.org/10.5281/zenodo.569817 [47] EthyleneGlycol,MEGlobal Product Guide 

10 

54

[48] NymanRA2018 private communication [49] Murray JD 2002Mathematical Biology (Interdisciplinary AppliedMathematics) vol 18 (Berlin: Springer) corr. 2. p edn (https://doi.org/ 

10.1007/b98868) 

11 

55

## 3. Thermodynamics of Trapped Photon Gases at Dimensional Crossover from 2D to 1D 

O Captain! my Captain! our fearful trip is done! The ship has weathered every wrack, the prize we sought is won, The port is near, the bells I hear, the people all exulting. 

W. Whitman, O Captain! My Captain!, ll. 1-3 

New experimental techniques for microstructuring the cavity mirrors [109–112], which subsection 1.3.5 describes, suggest shifting the focus of the photon BEC studies towards the dimensional crossover from 2D to 1D. Confining the photon gas in highly anisotropic trapping potentials allows for treating the gas as being effectively one dimensional, since the motion in the squeezed direction is frozen out. Here, the main task is to define the effective dimension of the system along the dimensional crossover. Although lower-dimensional quantum gases have already been realised in atomic BECs, e.g. [136, 137], no proper definition of the effective system dimension across the dimensional crossover exists in the literature. To this end, this paper works out the behaviour of the thermodynamic quantities like the critical particle number, the condensate fraction and the specific heat at the dimen-sional crossover for an ideal Bose gas in a harmonic trap. As the effective photon-photon interaction is measured to be quite small [70], photon BECs are able to resemble ideal Bose gases [116]. The calculation itself builds upon reference [138] and is arranged such that it determines the one-dimensional quantities exactly, but only approximates the second dimension. The specific heat CN for a fixed particle number N turns out to be the most conveni-ent quantity for defining the effective system dimension. In the thermal phase, the gas obeys the Dulong-Petit law and the specific heat per photon is directly proportional to the number of degrees of freedom. For a harmonic trapping potential the latter corres-ponds to the dimension of the system. In the condensed regime, the situation is slightly more complicated. Here, the slope of the specific heat for varying temperature T is pro-portional to the dimensionality of the system. Hence, the double-logarithmic derivative ∂ lnCN/∂ lnT yields the effective dimensionality. Conclusively, this paper defines the effective system dimension to be the specific heat per photon in the thermal phase and the double-logarithmic derivative in the condensed regime. Moreover, finite-size effects turn out to be crucial for this investigation, since in the ther-modynamic limit no BEC exists in a 1D harmonic trapping potential, as references [139, 140] calculate in detail. For finite-size systems, which are the only ones of experimental 

57

3. Thermodynamics of Trapped Photon Gases at Dimensional Crossover from 2D to 1D 

interest, a one-dimensional condensate exists, which is consistent with the calculation in reference [141] and the experiments [102, 136]. Therefore, this study carefully determ-ines the finite-size corrections. 

For this study, I performed the analytical calculation and wrote the complete manu-script. The co-author significantly contributed to the extensive reviewing process. 

58

**OPEN ACCESS **

**RECEIVED **

17 March 2021 

**REVISED **

17 January 2022 

**ACCEPTED FOR PUBLICATION **

25 January 2022 

**PUBLISHED **

11 February 2022 

Original content from this work may be used under the terms of the Creative Commons Attribution 4.0 licence. 

Any further distribution of this work must maintain attribution to the author(s) and the title of the work, journal citation and DOI. 

**PAPER **

### Thermodynamics of trapped photon gases at dimensional crossover from 2D to 1D 

Enrico Stein∗ and Axel Pelster Department of Physics and Research Center OPTIMAS, Technische Universität Kaiserslautern, Erwin-Schrödinger-Straße 46, 67663 

Kaiserslautern, Germany ∗ Author to whom any correspondence should be addressed. 

**E-mail: estein@rhrk.uni-kl.de **and **axel.pelster@physik.uni-kl.de **

**Keywords: **photon BEC, dimensional crossover, thermodynamics 

**Abstract **Photon Bose–Einstein condensates are characterised by a quite weak interaction, so they behave nearly as an ideal Bose gas. Moreover, since the current experiments are conducted in a microcavity, the longitudinal motion is frozen out and the photon gas represents effectively a two-dimensional trapped gas of massive bosons. In this paper we focus on a harmonically confined ideal Bose gas in two dimensions, where the anisotropy of the confinement allows for a dimensional crossover. If the confinement in one direction is strong enough so that this squeezed direction is frozen out, then only one degree of freedom survives and the system can be considered to be quasi-one dimensional. In view of an experimental set-up we work out analytically the thermodynamic properties for such a system with a finite number of photons. In particular, we focus on examining the dimensional information which is contained in the respective thermodynamic quantities. 

**1. Introduction **

The question of Bose–Einstein condensation in lower dimensions got already tackled quite early in the post-war era of physics. Soon it was found out that in the case of lower dimensional systems without trapping potential no long-range order can emerge [1, 2] and, thus, no Bose–Einstein condensation in such systems is possible. Later on in the early 1990s but prior to the experimental realisation of Bose–Einstein condensates (BECs), the authors of reference [3] worked out that, with the aid of an external trapping potential, the excited states of lower-dimensional ideal Bose gases can saturate, meaning that Bose–Einstein condensation is possible, whereas in three spatial dimensions this is also possible for the non-trapped case. In the thermodynamic limit they showed for a trapping potential, which is stronger confining than a box in the sense of a monomial spatial dependence ∼xα, that a condensation in 2D can occur, whilst in a 1D setting a potential more confining than a quadratic potential is necessary. Soon after this a full quantum mechanical follow-up study [4] revealed that for the harmonically trapped 1D-Bose gas with a finite number of particles BEC is possible. Furthermore, reference [5] generalised the semiclassical ansatz from reference [3] and showed, that these improved results agree with the corresponding finite-size results from [4]. After the experimental realisation of BECs [6, 7] naturally the question came up, how to achieve systems with an effective dimension lower than three. 

In the experimental work of reference [8] the question of the effective dimensionality of the system is reduced to a comparison of different length scales, which are in a 3D axially symmetrically trapped Bose gas the in-plane radius, the axial width, the scattering length, and the healing length. A system is effectively 2D, if the healing length is larger than the axial width, and effectively 1D, if the healing length is larger than the in-plane radius with the axial width being still larger than the healing length. As the healing length is inversely proportional to the square root of both the density and the scattering length, one can control the effective dimension either by changing the density, as is done in reference [8], or by changing the 

© 2022 The Author(s). Published by IOP Publishing Ltd on behalf of the Institute of Physics and Deutsche Physikalische Gesellschaft 

59

interaction strength itself via a Feshbach resonance [9]. Nowadays, harmonically trapped 1D and 2D condensates can not only be found in atomic systems [10] but also in condensates of light created in 1D-fiber cavities [11]. 

Another possibility of tuning the effective dimension of a system is to modify the kinetic energy in a certain direction. This can be achieved in lattice systems by changing the hopping matrix amplitude, e.g. by changing the lattice depth in a certain direction. One possible experimental realisation is to use coupled 2D BECs in order to perform a crossover from 2D to 3D [12]. A more recent experiment [13], which is described by the theoretical works [14, 15], consists of 2D arrays of coupled 1D Bose gases. Decreasing the 2D lattice depth yields an increase of the hopping amplitude and thus gives rise to a dimensional crossover to higher dimensions. 

In the following, however, we dedicate our discussion for the sake of concreteness on photon BECs as realised in reference [16–18]. As these kinds of experiments are conducted in a microcavity, the direction along the optical axis is already frozen out, since it corresponds to a standing wave along this very direction. Therefore, these systems are intrinsically two-dimensional. On the one hand experiments have found an effective photon–photon interaction [16, 19], which is explained by a thermo-optic effect, and also theoretical investigations [20–22] have revealed the influence of this kind of interactions on the photon BEC. Contrarily to that experimental measurements have also figured out that the thermodynamical behaviour of this system is not affected by this kind of interaction [23]. In this respect the photon BEC can be seen as a realisation of an ideal Bose gas. Thus, the question remains how to define and how to determine the effective dimension of the gas when changing from an isotropic harmonic confinement to a highly anisotropic confinement giving rise for a dimensional crossover from a two-dimensional gas to a quasi-1D gas. To this end, we work out how the thermodynamic quantities change as a function of the trap-aspect ratio. In particular, we carefully analyse not only the thermodynamic limit but also the respective finite-size corrections similarly to a corresponding seminal study in 3D [24], whose predictions where experimentally confirmed despite of systematic measurement errors for thermodynamic quantities in [25]. As we find in this work that these finite-size corrections increase by lowering the dimension of the system, we expect that they can also be confirmed in the dimensional crossover of photon BECs. Furthermore, in this setting the detection of finite-size effects is even more straight-forward than for atomic BECs, as these effects are not masked by interaction effects. As so far photon BEC experiments have only been performed in an isotropic setup, this theoretical paper paves the way towards future experiments with strongly anisotropic harmonic trapping potentials. Such potentials can be achieved, for instance, by ellipsoidally grinding the mirrors or by heat induced mirror surface delamination [26, 27] which allows, however, only for traps with small anisotropies due to the limited resolution. Thus, in view of achieving stronger anisotropies it is more promising to use direct laser writing [28–30] or focused ion beam milling [31] as a microstructuring technique, as it is then possible to create potential landscapes with spatial variations of the order of the wavelength of the photons. 

This paper is organised as follows. Section 2 introduces the setting and provides an analytical expression for the thermodynamic potential of an ideal Bose gas at the dimensional crossover from 2D to 1D. Equipped with this, section 3 specialises to the photon gas and derives expressions for the critical particle number as well as for the condensate fraction. Afterwards, the specific heat of the photon gas is discussed in section 4, which is finally used to define the effective dimension of the system in section 5. 

**2. Grand-canonical potential **

At first we analyse the thermodynamic properties of an ideal Bose gas at the dimensional crossover between 2D and 1D. To this end we consider a two-dimensional harmonic trap for bosons, where the trapping frequency in y-direction can be altered. Thus, with the quantum numbers j, n in the respective dimensions the energy levels are given by: 

Ejn(λ) = Ω 

( j + λn + 

1 + λ 

2 

) , (1) 

where Ω stands for the trapping frequency in x-direction and λ = Ωy/Ω denotes the trap-aspect ratio. We remark, that for a isotropic 2D oscillator, which we will call the 2D case in the following, we have λ = 1, whereas the one-dimensional case is approached in the limit λ → ∞. In this paper we always fix the trapping frequency Ω in x-direction and increase the trap-aspect ratio λ, corresponding to a squeezing in the y-direction. Intuitively, the gas can already be considered to be effectively one dimensional, if the energy 

2 60

spacing λΩ in y-direction is larger than the thermal energy kBT, which leads for the trap-aspect ratio to the condition 

λ > λ1D. (2) 

Here we define the effective one-dimensional trap-aspect ratio λ1D, which depends on the temperature T of the system and comprises the Boltzmann constant kB as well as the reduced Planck constant : 

λ1D = kBT 

Ω . (3) 

Again we point out that regarding the experimental findings in [23] it is a very good approximation to neglect the effective photon–photon interaction for discussing the thermodynamic properties of the photon BECs. 

Taking into account the energy levels (1), we have with the chemical potential μ, the inverse temperature β = 1/(kBT), and the degeneracy g, which takes for photons the two polarisation degrees of freedom into account, the grand-canonical potential [32] 

Π = − g 

β 

∞∑ 

j,n=0 

∞∑ 

k=1 

e−β[Ejn(λ)−μ]k 

k , (4) 

where we have used the series representation of the logarithm ln(1 + x) = −∑∞ k=1(−x)k/k. Performing the 

sum over the energy levels in the non-squeezed direction, which are labelled by j, allows us to write the potential Π in the form of a dimensional expansion 

Π = Π1D + ΔΠ(λ). (5) 

Here the one-dimensional grand-canonical potential reads 

Π1D = −g Ω 

b I (μ̃, b, −1) , (6) 

where we introduced the dimensionless variables b = βΩ and μ̃ = (1 + λ)/2 − μ/(Ω) as well as the auxiliary function 

I(a, b, l) = 

∞∑ 

k=1 

kl e−abk 

1 − e−bk , (7) 

cf reference [33]. The correction ΔΠ(λ) to the 1D potential, which takes the second dimension into account, depends on the trap-aspect ratio λ via 

ΔΠ(λ) = −g Ω 

b 

∞∑ 

n=1 

I (μ̃ + λn, b, −1) . (8) 

The auxiliary function I(a, b, −1) appearing in (6) and (8) is determined in appendix A in the form (A.16) and (A.20), respectively. Therefore, we find for the total grand-canonical potential analytically: 

Π = −g Ω 

b 

{ f (μ̃) + 

1 

b ζ2 

( e−μ̃b 

) + 

1 

2 ζ1 

( e−μ̃b 

) + 

b 

12 ζ0 

( e−μ̃b 

)} 

− g Ω 

b 

{ 1 

λb2 ζ3 

( e−(μ̃+λ)b 

) + 

1 

2λb ζ2 

( e−(μ̃+λ)b 

) + 

1 

12λ ζ1 

( e−(μ̃+λ)b 

) + 

1 

λ 

∫ ∞ 

μ̃+λ 

dy f (y) 

+ 1 

2 

[ f (μ̃ + λ) + 

1 

b ζ2 

( e−(μ̃+λ)b 

) + 

1 

2 ζ1 

( e−(μ̃+λ)b 

) + 

b 

12 ζ0 

( e−(μ̃+λ)b 

)]} + · · · . (9) 

Here, ζl(x) = ∑∞ 

k=1xk/kl denotes the polylogarithm [34] and f (μ̃) is defined in equation (A.17). The dots indicate here and in the following terms of order b2 and higher. We remark, that the one-dimensional limit is given by λ → ∞, which corresponds to the vanishing of the last two lines in equation (9). 

In the following we discuss the thermodynamic consequences of the grand-canonical potential (9) for a general ideal Bose gas, but for illustrating the functional dependencies of the thermodynamic quantities we specialise these general results to the photon BEC experiments in Bonn [16, 23]. There, we have to take into account the two polarisational degrees of freedom of the photons resulting in the degeneracy g = 2. For typical values, i.e. T0 = 300 K and Ω = 2π × 40 GHz, the system can be considered to be effectively one dimensional, if the trap-aspect ratio fulfills condition (2) with λ1D ≈ 156. Moreover, since the photon BEC 

3 61

experiment is performed at room temperature T0 [16, 23], the approximation of small b is well fulfilled, as we have then b0 ≡ Ω/kBT0 ≈ 6 × 10−3. Note, that the same order of magnitude is also obtained for the atomic BEC case, when taking the experimental parameters from [7]. 

**3. Particle number **

By calculating the derivative N = −∂Π/∂μ, we find from the potential (9) for the total particle number 

N = g 

{ −1 

b f ′(μ̃) + 

1 

b ζ1 

( e−μ̃b 

) + 

1 

2 ζ0 

( e−μ̃b 

) + 

b 

12 ζ−1 

( e−μ̃b 

) 

+ 1 

λb2 ζ2 

( e−(μ̃+λ)b 

) + 

1 

2λb ζ1 

( e−(μ̃+λ)b 

) + 

1 

12λ ζ0 

( e−(μ̃+λ)b 

) + 

1 

λb f (μ̃ + λ) 

+ 1 

2 

[ −1 

b f ′(μ̃ + λ) + 

1 

b ζ1 

( e−(μ̃+λ)b 

) + 

1 

2 ζ0 

( e−(μ̃+λ)b 

) + 

b 

12 ζ−1 

( e−(μ̃+λ)b 

)]} + · · · . (10) 

This explicit expression allows to determine the critical particle number, the critical temperature and, likewise, the condensate fraction as will be derived in sections 3.1–3.3, respectively. Already here, we mention that we will indeed find a critical particle number and critical temperature in the 1D case in accordance with references [4, 5, 33, 35]. For further detail, we refer to the discussion at the beginning of section 3.2. 

**3.1. Critical particle number **In order to calculate the critical particle number, we consider the deep condensate limit μ̃ → 0. We remark, that this limit corresponds to the order parameter approach, as worked out in reference [33], where the ground-state particle number is used as an order parameter for the BEC phase transition and only the excited states are treated in a thermodynamic way. This approach corresponds to describing the Bose gas in the thermodynamic limit. In the present work, however, we treat all states, including the ground state, thermodynamically as this description is closer to the experimental situation, where the system is finite. With this the particle number (10) can be written in the form 

N ≈ N0 + Nc, (11) 

with the ground-state particle number 

N0 = g 

eμ̃b − 1 , (12) 

which acquires in the limit μ̃ → 0 the form N0 ≈ g/(μ̃b), and the critical particle number 

Nc = g γ − ln(b) 

b + g 

{ 1 

λb2 ζ2 

( e−λb 

) + 

1 

2λb ζ1 

( e−λb 

) + 

1 

12λ ζ0 

( e−λb 

) + 

1 

λb f (λ) 

+ 1 

2 

[ −1 

b f ′(λ) + 

1 

b ζ1 

( e−λb 

) + 

1 

2 ζ0 

( e−λb 

) + 

b 

12 ζ−1 

( e−λb 

)]} + O 

( (μ̃b)0 

) , (13) 

with the Euler–Mascheroni constant γ ≈ 0.577. Note that, due to the limit process involved, this result is only accurate up to order O 

( (μ̃b)0 

) , but it is still accurate to all orders of λb. Moreover, we note the same 

structure as for the grand-canonical potential in equation (5), namely the bare one-dimensional quantity in the first line gets modified by the terms in the other two lines, which depend on the trap-aspect ratio and describe the influence of the second dimension, see figure 1(a). Note that the first line in (13) follows from the first line in equation (10) by applying the Robinson formula [36], 

ζl 

( e−a 

) = 

(−a)l−1 

(l − 1)! 

{ l−1∑ 

k=1 

1 

k − ln a 

} + 

∞∑ 

k=0 k	=l−1 

(−a)k 

k! ζ(l − k), (14) 

where ζ(l) denotes the Riemann-ζ function and a > 0, in order to expand the occurring polylogarithms with positive integer index l and by using for the corresponding polylogarithms with negative index the representation 

ζ−l 

( e−a 

) = 

1 

(1 − e−a)l+1 

l−1∑ 

k=0 

〈 l 

k 

〉 e−(l−k)a (15) 

with the Eulerian numbers 〈 

l k 

〉 [37]. 

4 62

**Figure 1. **(a) Critical particle number (13) at room temperature T0 for varying trap-aspect ratio (blue/solid line). The green (dashed dotted) line illustrates the 1D limit (16). (b) Critical particle number (13) for different trap-aspect ratios λ as a function of the temperature T normalised to the room temperature T0. The blue (solid) line represents the isotropic 2D case, i.e. λ = 1, the orange (dashed) line is for λ = kBT0/Ω ≡ λ1D, and the green (dash–dotted) depicts the 1D limit, i.e. λ → ∞. 

From (13) we find for the 1D critical particle number 

Nc,1D = g kBT 

Ω 

[ γ − ln 

( Ω 

kBT 

)] . (16) 

Near two dimensions, meaning small anisotropy λ 
 1/b, the critical particle number (13) reads 

Nc,≈2D = Nc,1D + g 

{ ζ(2) 

λ(Ωβ)2 + 

1 

2Ωβ 

[ ln(Ωβ) + 

ln Γ(λ) − ln(2πΩβ) 

λ − ψ0(λ) 

]} , (17) 

where Γ(x) = ∫∞ 

0 dt tx−1 e−t denotes the Γ-function and ψ0(x) = ∂x ln Γ(x) is the digamma function. In two dimensions, i.e. λ = 1, this reduces to 

Nc,2D = Nc,1D + g 

{ ζ(2) 

( kBT 

Ω 

)2 

+ kBT 

2Ω [γ − ln(2π)] 

} . (18) 

At first, a comparison with reference [33] shows that equation (16) is exact, whereas the corresponding expression for the two-dimensional critical particle number (18) contains the last term in addition. This difference is solely due to our approach, where we calculate at first the one-dimensional quantities and approximate afterwards the corresponding two-dimensional ones. As the leading order of the relative deviation of our result (18) compared to the corresponding one in references [33, 38] is of the order of the magnitude of b itself, the difference for the experimental parameter regime, i.e. room temperature T0 = 300 K and Ω = 2π × 40 GHz, is of the order b0 ≈ 6 × 10−3 and, thus, negligible for all practical purposes. 

Already here, we also encounter a qualitative difference between the two special cases of dimensions. In 1D the critical particle number (16) depends linearly on the temperature, apart from the logarithmic term, whereas in 2D the leading order in equation (18) is quadratic in the temperature. In figure 1(b) we plot the critical particle number (13) as a function of the temperature for different trap-aspect ratios λ. Neither in the 2D case, λ = 1, nor in the 1D case, which amounts to the limit λ → ∞, the functional dependence of the critical particle number on the temperature changes. However, we note the different exponents one and two in accordance with (16) and (18), which can be interpreted as a sign for the corresponding dimension. For an intermediate trap-aspect ratio of λ = kBT0/(Ω) ≡ λ1D the temperature dependence changes qualitatively for T ≈ T0. For smaller temperatures the curve coincides with the 1D curve, while for larger temperatures the orange curve gets parallel to the 2D curve. This means, that in the former case the system behaves effectively one dimensional, whereas in the latter case the system reveals a two-dimensional behaviour. This observation completely agrees with the criterion (2) for quasi one-dimensionality. 

**3.2. Critical temperature **Finally, we also solve the critical particle number N(Tc) for the critical temperature Tc in the respective dimension. In 1D, we obtain from directly inverting equation (16) the implicit equation 

Tc,1D = Ω 

gkB 

N 

γ − ln(Ω/kBTc,1D) . (19) 

5 63

In [3] it is derived, that no Bose–Einstein condensation is possible for a harmonic confining potential in one spatial dimension, as the critical temperature tends to zero in this limit. In contrast to that, we find in (19) a finite critical temperature and, thus, the possibility for a BEC. The difference between the approach in [3] and our approach is, that the former work is performed entirely in the thermodynamic limit, whereas we always assume a finite system size. A further difference is that the approach in [3] relies on the density of states, whereas we directly evaluate the appearing sum in (4). Therefore, on a mathematical basis the divergent value ζ(1), which is obtained by [3] in the limit of a harmonic trapping potential, is in our calculation resolved by the logarithm appearing in (19) due to our finite-size ansatz. Furthermore, we emphasise that our result is also obtained in [33], where an order-parameter approach has been used, and similar results, which are also based on a full thermodynamic approach, but with a less systematic application of the Euler–Maclaurin formula, are found in [35]. Finally, we remark that due to this finite-size behaviour, we will refer to the one-dimensional condensed phase still as BEC in accordance with references [4, 5, 8]. 

In order to figure out an approximate solution to the transcendental equation (19) we iterate (19) once and neglect the further logarithmic dependencies. For large photon numbers N we have then a leading term of the critical temperature in 1D, which is already determined by an inverse logarithmic dependence 

TL.T. c,1D ≈ Ω 

gkB 

N 

ln(N/g) . (20) 

We remark, that this critical temperature in 1D can be derived by a generalisation of the semiclassical approach used in [3] as has been shown in [5] and is backed up experimentally, e.g. [10, 11]. However, we emphasise here, that the thermodynamic limit relies on a finite Tc. Thus, according to the numerator of (20) this implies ΩN = const. Therefore, from the denominator of (20) we have then Tc → 0 in the limit N → ∞. With this we rederive the results of [3] from our finite-size considerations in accordance with [5]. Consequently, in the thermodynamic limit, indeed, no Bose–Einstein condensation is possible at any finite temperature. However, in the realistic experimental settings, where the particle number N may be large but finite, Bose–Einstein condensation can always be observed in a one-dimensional harmonic trap. 

The finite-size corrections we define by 

ΔTF.S. c,• = 

Tc,• − TL.T. c,• 

TL.T. c,• 

, (21) 

where the bullet stands for the corresponding dimension. In 1D we have for the finite-size corrections (21) 

ΔTF.S. c,1D = 

ln(γ) − γ 

ln(N/g) , (22) 

which is also determined by a logarithm. In nearly two dimensions we find by iterating equation (17) once for bλ 
 1 as leading term 

TL.T. c,≈2D = 

Ω 

kB 

√ λN 

gζ(2) , (23) 

which reduces in 2D to 

TL.T. c,2D = 

Ω 

kB 

√ N 

gζ(2) . (24) 

The finite-size corrections (21) near 2D are given by 

ΔTF.S. c,≈2D = − λ 

4ζ(2) 

√ gζ(2) 

λN 

⎡ ⎣2γ − ψ0(λ) + 

ln Γ(λ) − ln ( 

2π √ 

gζ(2)/(λN) ) 

λ − 1 

2 ln 

( gζ(2) 

λN 

)⎤ ⎦ (25) 

simplifying in 2D to the form 

ΔTF.S. c,2D = − 1 

4ζ(2) 

√ gζ(2) 

N 

[ 3γ − ln 

( 2π 

gζ(2) 

N 

)] . (26) 

6 64

**Figure 2. **Finite-size corrections (21) to the critical temperature in 2D (blue), for finite trap-aspect ratio λ = 10 (orange, dashed) and in the 1D case λ → ∞ (green, dashed–dotted) according to (22), (25) and (26), respectively. 

Comparing equations (20) and (24) we note the following two differences between the two limiting cases of the dimension. At first, in 1D the total particle number contributes with the exponent one to the critical temperature, whereas in 2D it appears with a square root. A second difference between 1D and 2D is the occurrence of the logarithm. In 1D the logarithm shows up already in the leading term (20) of the critical temperature, while in 2D the logarithm determines the first finite-size correction (26). 

In figure 2 we compare the contribution of the finite-size corrections of the critical temperature in 1D (22) with the corrections for the near 2D and 2D critical temperature (25) and (26), respectively. We see directly, that in two dimensions the finite-size corrections are one order of magnitude smaller than in the 1D case. Thus, we deduce that when performing the crossover from 2D to 1D the importance of the finiteness of the system increases, as the finite-size corrections increase. 

**3.3. Condensate fraction **In this section we calculate the condensate fraction N0/N, where N0 is the ground-state particle number, in the deep condensate limit, i.e. for N  Nc. Thus, using equation (11) we have 

N0 

N ≈ 1 − Nc 

N . (27) 

In 1D we find for the fraction Nc/N by using the critical particle number (16) 

( Nc 

N 

) 

1D 

= T 

Tc 

[ 1 − ln 

( T/Tc 

) 

γ − ln(Ω/kBTc) 

] , (28) 

so we have in leading order a linear temperature dependence. In contrast to this, when we approach two spatial dimensions, using the corresponding expression (17), we find in the leading order a quadratic dependence on the temperature 

( Nc 

N 

) 

≈2D 

= 

( T 

Tc 

)2 

+ 1 

2ζ(2) 

√ gζ(2) 

N 

⎧ ⎨ ⎩ 

[ T 

Tc − ( 

T 

Tc 

)2 ] 

× 

⎡ ⎣−1 

2 ln 

gζ(2) 

N + 

ln Γ(λ) − ln ( 

2π √ 

gζ(2)/N ) 

λ − ψ0(λ) + 2γ 

⎤ ⎦+ 

T 

Tc 

( 1 + 

1 

λ 

) ln 

T 

Tc 

⎫ ⎬ ⎭ . 

(29) 

In the two-dimensional limit equation (29) reduces to 

( Nc 

N 

) 

2D 

= 

( T 

Tc 

)2 

+ 

√ gζ(2) 

N 

{[ T 

Tc − ( 

T 

Tc 

)2 ] 

3γ − ln(2πgζ(2)/N) 

2ζ(2) − T ln(T/Tc) 

Tcζ(2) 

} . (30) 

Figure 3 shows a numerical calculation of the temperature dependence of the condensate fraction for an experimentally realistic number of N = 100 000 photons for different values of the trap-aspect ratio λ. 

7 65

**Figure 3. **Condensate fraction N0/N for fixed particle number N = 100 000. The blue (solid) line represents the isotropic 2D case, i.e. λ = 1, the orange (dashed) line is for λ = 500, and the green (dash–dotted) line shows the 1D limit λ → ∞. The red crosses are experimental values with the corresponding errors for the 2D case [39]. 

The numerical calculation of the condensate fraction is done as follows. At first, we invert the particle number equation (10) in order to extract the dimensionless chemical potential μ̃. We then use this value to calculate the ground-state population N0 and, thus, the condensate fraction. We note that the isotropic 2D curve is in good agreement with the experiment of reference [39]. The discrepancy in the thermal phase is attributed to the finite resolution of the experimental apparatus. Moreover, we observe the inverted parabolic temperature dependence (30). Also in the 1D case the curve agrees with the linear temperature dependence predicted in (28). For the curve with an intermediate trap-aspect ratio of λ = 500 the curve shows characteristics of both the 1D curve and as the temperature increases also of the 2D curve, meaning that here the effective dimension of the system changes from 1D to 2D. 

To conclude this discussion, we remark that in the experimental situation of photon BECs the temperature is always fixed to the room temperature T0, but the usual way for measuring thermodynamic quantities is to change the temperature T. So far this problem has been experimentally circumvented by varying the particle number and using that for integer dimensions D = 1, 2 an analytic correspondence is available in the form T/Tc = (Nc/N)1/D [23]. Thus, we see already here, that this procedure is not well suited for a dimensional crossover, where one deals with non-integer dimensions. The second problem is that due to the finite system size also the thermodynamic quantities change with the particle number N. Instead of this, we propose to change the parameter b via the trapping frequency Ω. This is possible, since from its very definition we have bc/b = T/Tc and also bc/b = Ωc/Ω. 

Finally, we estimate the experimentally achievable regions of T/Tc in photon BECs for realistic total particle numbers of Nmin ∼ 102 up to Nmax ∼ 105 in both 2D and 1D. We find in 2D that the order of magnitude of the fraction T/Tc ranges from 0.1 up to 10, whereas in 1D we have the range from 0.1 to 1. As all calculated quantities depend smoothly on the trap-aspect ratio, we expect that for a certain value of the trap-aspect ratio the reachable values of T/Tc lie in between the corresponding 2D and 1D ratio, such that the phase transition is always observable. 

**4. Specific heat **

In the following we calculate the specific heat CN for a constant particle number N from the internal energy U = Π + TS + μN [32], where S denotes the entropy, according to 

CN = ∂U 

∂T + 

∂U 

∂μ 

( ∂μ 

∂T 

) 

N 

, (31) 

where the second term takes the condition of a fixed particle number into account. However, due to the complexity of the resulting formula, we restrict the discussion to the deeply condensed case at first. In this approximation we find for the internal energy 

U ≈ E0(N0 + Nc) + ΩλΔN + g Ω 

b 

[ f ′(λ) 

2 − f (λ) 

λ 

] 

+gΩ 

[ ζ(2) 

b2 − 1 

2b + 

2 

λb3 ζ3 

( e−λb 

) + 

λ + 1 

2λb2 ζ2 

( e−λb 

) + 

1 

24 ζ0 

( e−λb 

)] , 

(32) 

8 66

**Figure 4. **Temperature dependence of specific heat CN for the particle number N = 100 000. The blue (solid) line covers the isotropic 2D case, i.e. λ = 1, the orange (dashed) line is for λ = 2000, the pink (dotted) line represents λ = 500 000, and the green (dash–dotted) line is for λ → ∞. The red crosses are experimental values with the corresponding errors for the 2D case from reference [23]. 

where ΔN = N − N1D. We note, that in this limit we have ∂μ/∂T ≈ 0, so the specific heat in the leading order of 1/b reads 

CN ≈ gkB 

[ 2ζ(2) 

b + 

6 

λb2 ζ3 

( e−λb 

) + 

3λ + 1 

b ζ2 

( e−λb 

)] . (33) 

Therefore, taking into account equation (19), in the one-dimensional limit the specific heat is given by 

CN ,1D = NkB 2ζ(2) 

γ − ln(Ω/kBTc) 

T 

Tc , (34) 

and in leading order in b near 2D we obtain from equation (23) together with equation (25) 

CN ,≈2D ≈ 6λNkB 

( T 

Tc 

)2 ζ(3) 

ζ(2) 

⎧ ⎨ ⎩1 − 1 

2ζ(2) 

√ gζ(2) 

λN 

× 

⎡ ⎣2γ − ψ0(λ) − 

ln Γ(λ) − ln ( 

2π √ 

gζ(2)/λN ) 

λ − 1 

2 ln 

gζ(2) 

λN 

⎤ ⎦ ⎫ ⎬ ⎭ . (35) 

In two dimensions equation (35) reduces to 

CN ,2D ≈ 6NkB 

( T 

Tc 

)2 ζ(3) 

ζ(2) 

{ 1 − 1 

2ζ(2) 

√ gζ(2) 

N 

[ 3γ − ln 

( 2π 

gζ(2) 

N 

)]} . (36) 

After deriving these analytic formulas in the deeply condensed case, we discuss now the obtained results and compare them with the experimental results of reference [23]. In figure 4 we plot the full specific heat for different values of the trap-aspect ratio λ as a function of the temperature T. In the two-dimensional case we find the expected λ-like transition with the high-temperature limit of CN = 2NkB, where the latter is in accordance with the Dulong–Petit law. Note, that in our case of a finite system the specific heat does not undergo a jump at the critical point as it occurs in the thermodynamic limit [33]. Instead, it remains a continuous function. Furthermore, we point out that in 1D the specific heat is always a continuous function at the phase transition which explicitly includes the thermodynamic limit, cf [33]. However, as we increase the trap-aspect ratio, we see that this characteristic λ-shaped behaviour near the critical temperature Tc 

gradually washes out and a plateau emerges just above the critical temperature. This plateau has the value CN = NkB and, thus, resembles the one-dimensional Dulong–Petit law, meaning that here the system, indeed, behaves as one-dimensional. By further increasing the temperature the system approaches again the 2D Dulong–Petit law. However, the dotted line in figure 4 is slightly above CN = NkB since here the system undergoes the crossover from 2D to 1D producing the corresponding λ-like form near the crossover temperature. The reason for the described behaviour is as follows. The temperature can be seen as 

9 67

**Figure 5. **(a) Phase diagram of the ideal Bose gas at the dimensional crossover by plotting colour coded the specific heat (33) as a function of both the temperature and the trap-aspect ratio. (b) Effective dimension of the BEC phase according to the definition (37). In both plots the solid white line shows the critical temperature following from inverting (13), whereas the dashed white curve depicts the criterion (2) of being quasi 1D. Both calculations have been performed for N = 1000 particles. 

a measure for which states can be occupied, namely as the temperature raises also states with higher energies are populated. Therefore, we can invert the 1D condition (2) and define for a fixed trap-aspect ratio λ the effective 1D temperature T1D = λΩ/kB. We note, that the system is in the 1D regime if T < T1D, as here the occupation in the excited states in the squeezed direction is exponentially suppressed, and otherwise in the 2D regime, since then the thermal energy is large enough to have also states in the squeezed direction populated. 

A similar behaviour is well known in the literature, e.g. for the thermodynamics of molecular gases [32]. At low temperatures only the translational degrees of freedom of the molecules can be thermally excited and, thus, only those can contribute to the specific heat. Increasing the temperature above a certain threshold allows the molecules to rotate such that these degrees of freedom additionally contribute to the specific heat. Increasing the temperature even further allows also the vibrational modes of the molecules to be thermally excited. 

We note the different behaviour of the specific heat in the low-temperature limit, which is worked out in equations (34) and (36). Thus, in contrast to the condensate fraction and the critical particle number, using the specific heat can be instrumental to define and to determine the effective dimension of the system both in the low and the high temperature limit. 

**5. Phase diagram and effective dimension **

Finally, we analyse how the phase diagram of the system changes as a function of the trap aspect ratio λ and the temperature T by plotting the specific heat CN in figure 5(a). However, due to numerical reasons we are forced to use a small particle number of N = 1000 photons, as otherwise we are not able to cover such a large range of parameters λ and kBT/Ω. At first we note that the phase transition from the BEC to the thermal phase happens at the critical temperature Tc, which is calculated by inverting the critical photon number (13) with the limiting cases (19) and (24). Moreover, in the thermal phase, we can directly read off the effective dimension of the system according to the respective Dulong–Petit law, as is explained at the end of section 4. The dashed white line depicting the lower bound λ1D = kBT/Ω of criterion (2), discriminates between the different dimensional behaviour. However, therefrom we can only learn about the effective dimension in the thermal phase. From equations (34) and (36), though, we read off, that in the condensed regime the effective dimension follows from the polynomial dependency of the specific heat on the temperature. Therefore, we suggest to define as the effective dimension in the BEC phase the double-logarithmic derivative 

dBEC = − 1 

NkB 

∂ ln CN 

∂ ln b . (37) 

Figure 5(b) shows the corresponding results as a function of both the temperature T and the trap aspect ratio λ. We note that in the thermal phase this definition yields a constant value of 0 due to the Dulong–Petit law except right at the crossover from 2D to 1D. Thus, this definition cannot be used in the thermal case to determine the effective system dimension. In the BEC phase, however, we find values between 1 and 2 according to the limiting cases deduced from equations (34) and (36). Near the phase transition, however, this definition fails as here the quantitative behaviour of the specific heat changes 

10 68

**Figure 6. **Effective dimension d of the ideal Bose gas at the dimensional crossover as defined by (38) as a function of both the temperature and the trap-aspect ratio. The solid white curve shows the critical temperature obtained by inverting (13), whereas the dashed white line indicates the quasi-1D criterion (2). The calculation has been performed for N = 1000 particles. 

yielding e.g. negative values of dBEC. The precise value of the BEC dimension is determined by the temperature and trap-aspect ratio. We see that, for an increasing trap-aspect ratio, the system behaves, indeed, quasi one-dimensional. 

Summarising the two observations from figure 5, we suggest to define the effective dimension of the system by 

d = 

{ CN/(NkB), in the thermal phase, 

dBEC, in the BEC phase, (38) 

where dBEC is defined in (37). With this we are able to describe the effective dimension of the system in both the Bose-condensed and the thermal regime. In figure 6 we plot the definition (38) in dependence of both the temperature and the trap aspect ratio. However, as figure 6 shows, the definition (37) yields a non-continuous effective dimension at the phase boundaries as here the slopes of the specific heat change. This can be read off from the reddish area in the plot. Nevertheless, we also note, that the effective dimension of the system changes from 2D to effective 1D in agreement with the criterion (2). We remark, that in the crossover region both the temperature and the trap-aspect ratio determine the effective dimension of the system. Finally, we point out that trap-aspect ratios up to λ ∼ 103 are experimentally realisable, which is due to the expected resolution of the mirror fabrication method [40]. Consequently, according to figure 6 the onset of the effective 1D region is reachable at room temperature, where we have kBT0/Ω ≈ 160. 

**6. Conclusions **

In this paper we present an analytical description of the dimensional crossover from 1D to 2D for an ideal Bose gas in terms of a dimensional expansion, see equation (5). We find the same structure for all investigated thermodynamic quantities, such as the critical particle number, the condensate fraction, and the specific heat, namely that the 1D expression gets corrected by terms yielding the 2D result. Furthermore, from the specific heat we are able to define an effective dimension d, given by equation (38), in both the BEC and the thermal phase. This definition shows a change of the effective dimension, which is consistent with the criterion (2). But we also note, that this definition has a minor drawback as it produces a non-continuous behaviour of the effective dimension near the phase boundary, as can be seen in figure 6. However, our results allow to determine the effective dimension of the system for a given temperature and trap-aspect ratio. We especially focus on how to determine the effective dimension by examining the polynomial dependency of the specific heat in the BEC case and by observing the Dulong–Petit law in the thermal regime. We remark, that our calculational approach, which is based on an expansion in the smallness parameter Ω/(kBT), is especially suitable for photon gases, where this value is of the order of a few per mille. 

The present work could be extended to also determine the spatio-temporal behaviour of the correlation function of the ideal Bose gas at the dimensional crossover, which has already been measured for an isotropic two-dimensional photon gas [41]. Concerning the fact, that in the 2D photon BEC experiments a retarded thermo-optic interaction is dominant, despite of an additional negligible contact interaction [16, 

11 69

22, 42], it is an interesting question, whether this is still true in the quasi-1D case. Moreover, for a more realistic modelling of the experiments, one needs to include also the pump and the decay processes, as a photon gas in a dye-filled microcavity is intrinsically an open system. A recent study [43] indeed shows that due to the open-dissipative character of the system the higher correlation function shows a phase transition, which does not exist in closed systems. In a second attempt one should also include the effective photon–photon interaction, as it is known, that e.g. contact interactions increase along a dimensional crossover. Another research direction would be to investigate in view of the dimensional crossover different potential landscapes, such as potentials with arbitrary exponents, cf [3], or even anharmonic potentials [44]. 

**Data availability statement **

All data that support the findings of this study are included within the article (and any supplementary files). 

**Acknowledgments **

We thank Antun Balaž, Erik Busley, Georg von Freymann, Milan Radonjić, Julian Schulz, Kirankumar Karkihalli Umesh and Frank Vewinger for insightful discussions. ES and AP acknowledge financial support by the Deutsche Forschungsgemeinschaft (DFG, German Research Foundation) via the Collaborative Research Center SFB/TR185 (Project No. 277625399). 

**Appendix A. Cutoff regularisation **

The aim of this appendix is to work out the behaviour of the auxiliary functions I(a, b, l) defined in equation (7) for integer l and a, b > 0 and also to provide a procedure allowing to approximate these functions analytically. First we start with two recursion relations obeyed by the auxiliary functions. For increasing the integer l we have 

I(a, b, l + 1) = −1 

b 

∂ 

∂a I(a, b, l), (A.1) 

whereas decreasing l yields correspondingly 

I(a, b, l − 1) = b 

∫ ∞ 

a dx I(x, b, l). (A.2) 

Thus, from the analytical knowledge of one particular I(a, b, l∗) all other functions I(a, b, l) can be calculated analytically. 

**A.1. Special case ****l∗ **= **0 **It turns out, that the case l∗ = 0 can be calculated analytically for small values of b. According to the definition (7) we start with 

I(a, b, 0) = 

∞∑ 

k=1 

e−abk 

1 − e−bk . (A.3) 

In order to calculate expression (A.3), we follow reference [33] and perform an expansion for small values of b. However, the first step is to include also the k = 0 term in the summation (A.3). As this is a divergent term, we add and subtract the first three terms of the corresponding Laurent series. Note, that in reference [33] only the first term of the Laurent series is introduced yielding an approximation up to O(b0). However, here we need higher order terms for obtaining a converging result for the two-dimensional case. Thus, we have 

I(a, b, 0) = 

∞∑ 

k=0 

e−abk 

( 1 

1 − e−bk − 1 

bk − 1 

2 − bk 

12 

) + 

∞∑ 

k=1 

e−abk 

( 1 

bk + 

1 

2 + 

bk 

12 

) + O(b2). (A.4) 

12 70

In the first term we replace the summation by an integral using the Euler–Maclaurin formula for a smooth function f(n) 

∞∑ 

n=0 

f (n) ≈ ∫ ∞ 

0 dn f (n) + 

1 

2 

[ f (0) + f (∞) 

] . (A.5) 

Due to the construction of expression (A.4), all higher terms in the Euler–Maclaurin series (A.5) vanish exactly. In the second term we recognise the polylogarithmic functions ζn(x) with n = −1, 0, +1. Thus, we have 

I(a, b, 0) = 

∫ ∞ 

0 dk e−abk 

( 1 

1 − e−bk − 1 

bk − 1 

2 − bk 

12 

) 

+ 1 

b ζ1 

( e−ab 

) + 

1 

2 ζ0 

( e−ab 

) + 

b 

12 ζ−1 

( e−ab 

) + O(b2). (A.6) 

Whereas in reference [33] the remaining integrals are solved by using a dimensional regularisation, we introduce here an infrared cutoff Λ as the integrands are divergent for k → 0: 

I(a, b, 0) = lim Λ→0 

∫ ∞ 

Λ 

dk e−abk 

( 1 

1 − e−bk − 1 

bk − 1 

2 − bk 

12 

) 

+ 1 

b ζ1 

( e−ab 

) + 

1 

2 ζ0 

( e−ab 

) + 

b 

12 ζ−1 

( e−ab 

) + O(b2). (A.7) 

First, we obtain ∫ ∞ 

Λ 

dk (bk)n e−abk = 1 

an+1b Γ(n + 1, abΛ), (A.8) 

where Γ(s, x) is the upper incomplete Γ function. For small Λ we find in leading order 

Γ(0, abΛ) ≈ −γ − ln(abΛ) 

b , (A.9) 

whereas the incomplete Γ functions with indices n  1 simply reduce to the standard Γ functions: 

Γ(n, abΛ) ≈ Γ(n), n  1. (A.10) 

In the remaining first integral of equation (A.7) we substitute x = e−bk and calculate by using the incomplete beta function, 

B(x; a, b) = 

∫ x 

0 dt ta−1(1 − t)b−1, (A.11) 

the integral ∫ ∞ 

Λ 

dk e−abk 

1 − e−bk = 

1 

b B(ebΛ; a, 0). (A.12) 

This yields in the limit of small Λ 

B(e−bΛ; a, 0) ≈ − ln(bΛ) − γ − ψ0(a). (A.13) 

Inserting equations (A.9), (A.10) and (A.13) into equation (A.7) we finally have 

I(a, b, 0) = 1 

b 

[ ln(a) − ψ0(a) − 1 

2a − 1 

12a2 

] + 

1 

b ζ1 

( e−ab 

) + 

1 

2 ζ0 

( e−ab 

) + 

b 

12 ζ−1 

( e−ab 

) + O(b2), (A.14) 

which coincides with the result in reference [33], apart from the additional higher order terms. In the following we calculate I(a, b, −1) from applying the recurrence relation (A.2). To this end we use the Stirling formula [34], 

ln Γ(z) ≈ z(ln z − 1) − 1 

2 ln(2πz), (A.15) 

13 71

**Figure A1. **Relative error of analytical approximation of the one-dimensional sum (A.14) with respect to the numerical evaluation of equation (A.3) (orange line). The blue line shows the relative error by using the approximation performed in reference [33]. 

for regularising the upper integration limit in equation (A.2), and obtain 

I(a, b, −1) = f (a) + 1 

b ζ2 

( e−ab 

) + 

1 

2 ζ1 

( e−ab 

) + 

b 

12 ζ0 

( e−ab 

) + O(b2), (A.16) 

where we defined 

f (a) = 1 

2 ln ( a 

2π 

) − a [ln(a) − 1] + ln Γ(a) − 1 

12a . (A.17) 

This result is still correct to order O(b2), because the recurrence relation (A.2) preserves the corresponding order. 

**A.2. Resummation for second dimension **In (8) we have seen, that we also need to calculate a sum over the auxiliary functions (7). With the result (A.16) we can also analytically approximate the sum 

S = 

∞∑ 

n=1 

I(a + λn, b, −1) (A.18) 

by using again the Euler–Maclaurin series (A.5). Thus, we obtain the approximation 

S ≈ ∫ ∞ 

1 dn I(a + λn, b, −1) + 

1 

2 I(a + λ, b, −1). (A.19) 

Taking equation (A.16) into account, we have 

S = 1 

λb2 ζ3 

( e−(a+λ)b 

) + 

1 

2λb ζ2 

( e−(a+λ)b 

) + 

1 

12λ ζ1 

( e−(a+λ)b 

) + 

1 

λ 

∫ ∞ 

a+λ 

dy f (y) 

+ 1 

2 I(a + λ, b, −1) + O(b2). (A.20) 

We note that the error, stemming from the Euler–Maclaurin approximation in equation (A.19), cannot be evaluated in a systematic way. However, we show in the next section, that the performed approximation yields errors, which are small in the relevant parameter regime of photon gases. 

**A.3. Analytical vs numerical summation **Finally, we compare the analytical results from the preceding sections with a numerical summation of equation (A.3) itself. Figure A1 shows the relative error of the numerical approximation (A.14) with respect to the direct numerical evaluation of the sum (A.3). The orange line shows our result, whereas the blue line 

14 72

**Figure A2. **Relative error of analytical approximation of the correction terms leading to the second dimension (A.20) with respect to the numerical evaluation in equation (A.21). 

shows the accuracy achieved in reference [33]. At first, we note that both results yield a good approximation as b tends to 0. However, as we use additional terms from the Laurent series in equation (A.4), the accuracy of our result is increased compared to the result from reference [33]. 

In order to analyse the error of the 2D result we first note that the sum (A.18) can also be performed by using the definition (A.3) and interchanging the summation signs, which yields 

S2D = ∞∑ 

k=1 

e−abk 

k(1 − e−bk)(eλbk − 1) . (A.21) 

Note, that due to the factor 1/k this expression cannot be treated analytically along the philosophy of reference [33] and this appendix. However, expression (A.21) can be used as a numerical comparison with the analytical approximation obtained in (A.20). The relative error of the approximation of the two-dimensional sum (A.18) is shown in figure A2. It reveals, as suspected, the same overall behaviour as the approximation of the one-dimensional sum, namely that the approximation gets better at small b and worse at large values of b. 

**ORCID iDs **

Enrico Stein https://orcid.org/0000-0003-4820-7126 Axel Pelster https://orcid.org/0000-0002-5215-0348 

**References **

[1] Mermin N D and Wagner H 1966 Absence of ferromagnetism or antiferromagnetism in one- or two-dimensional isotropic Heisenberg models Phys. Rev. Lett. **17 **1133 

[2] Hohenberg P C 1967 Existence of long-range order in one and two dimensions Phys. Rev. **158 **383 [3] Bagnato V and Kleppner D 1991 Bose–Einstein condensation in low-dimensional traps Phys. Rev. A **44 **7439 [4] Ketterle W and van Druten N J 1996 Bose–Einstein condensation of a finite number of particles trapped in one or three 

dimensions Phys. Rev. A **54 **656 [5] Yukalov V I 2005 Modified semiclassical approximation for trapped Bose gases Phys. Rev. A **72 **033608 [6] Anderson M H, Ensher J R, Matthews M R, Wieman C E and Cornell E A 1995 Observation of Bose–Einstein condensation in a 

dilute atomic vapor Science **269 **198 [7] Davis K B, Mewes M-O, Andrews M R, Van Druten N J, Durfee D S, Kurn D M and Ketterle W 1995 Bose–Einstein condensation 

in a gas of sodium atoms Phys. Rev. Lett. **75 **3969 [8] Görlitz A et al 2001 Realization of Bose–Einstein condensates in lower dimensions Phys. Rev. Lett. **87 **130402 [9] Chin C, Grimm R, Julienne P and Tiesinga E 2010 Feshbach resonances in ultracold gases Rev. Mod. Phys. **82 **1225 

[10] Lausch T, Widera A and Fleischhauer M 2018 Role of thermal two-phonon scattering for impurity dynamics in a low-dimensional Bose–Einstein condensate Phys. Rev. A **97 **033620 

[11] Weill R, Bekker A, Levit B and Fischer B 2019 Bose–Einstein condensation of photons in an erbium–ytterbium co-doped fiber cavity Nat. Commun. **10 **747 

[12] Cennini G, Geckeler C, Ritt G, Salger T and Weitz M 2006 Two-dimensional Bose–Einstein condensates in a CO2-laser optical lattice Fortschr. Phys. **54 **719 

15 73

[13] Vogler A, Labouvie R, Barontini G, Eggert S, Guarrera V and Ott H 2014 Dimensional phase transition from an array of 1D Luttinger liquids to a 3D Bose–Einstein condensate Phys. Rev. Lett. **113 **215301 

[14] Cazalilla M A, Ho A F and Giamarchi T 2006 Interacting Bose gases in quasi-one-dimensional optical lattices New J. Phys. **8 **158 [15] Irsigler B and Pelster A 2017 Dimensionally induced one-dimensional to three-dimensional phase transition of the weakly 

interacting ultracold Bose gas Phys. Rev. A **95 **043610 [16] Klaers J, Schmitt J, Vewinger F and Weitz M 2010 Bose–Einstein condensation of photons in an optical microcavity Nature **468 **

545 [17] Walker B T, Flatten L C, Hesten H J, Mintert F, Hunger D, Trichet A A P, Smith J M and Nyman R A 2018 Driven-dissipative 

non-equilibrium Bose–Einstein condensation of less than ten photons Nat. Phys. **14 **1173 [18] Greveling S, Perrier K L and van Oosten D 2018 Density distribution of a Bose–Einstein condensate of photons in a dye-filled 

microcavity Phys. Rev. A **98 **013810 [19] Keijsers G, Geng Z, Peters K J H, Wouters M and Rodriguez S R K 2020 Steady-state superfluidity of light in a tunable cavity at 

room temperature (arXiv:2012.13463) [20] van der Wurff E C I, de Leeuw A-W, Duine R A and Stoof H T C 2014 Interaction effects on number fluctuations in a 

Bose–Einstein condensate of light Phys. Rev. Lett. **113 **135301 [21] Alaeian H, Schedensack M, Bartels C, Peterseim D and Weitz M 2017 Thermo-optical interactions in a dye-microcavity photon 

Bose–Einstein condensate New J. Phys. **19 **115009 [22] Stein E, Vewinger F and Pelster A 2019 Collective modes of a photon Bose–Einstein condensate with thermo-optic interaction 

New J. Phys. **21 **103044 [23] Damm T, Schmitt J, Liang Q, Dung D, Vewinger F, Weitz M and Klaers J 2016 Calorimetry of a Bose–Einstein-condensed photon 

gas Nat. Commun. **7 **11340 [24] Grossmann S and Holthaus M 1995 On Bose–Einstein condensation in harmonic traps Phys. Lett. A **208 **188 [25] Gerbier F, Thywissen J H, Richard S, Hugbart M, Bouyer P and Aspect A 2004 Critical temperature of a trapped, weakly 

interacting Bose gas Phys. Rev. Lett. **92 **030405 [26] Kurtscheid C, Dung D, Busley E, Vewinger F, Rosch A and Weitz M 2019 Thermally condensing photons into a coherently split 

state of light Science **366 **894 [27] Kurtscheid C, Dung D, Redmann A, Busley E, Klaers J, Vewinger F, Schmitt J and Weitz M 2020 Realizing arbitrary trapping 

potentials for light via direct laser writing of mirror surface profiles Europhys. Lett. **130 **54001 [28] Maruo S, Nakamura O and Kawata S 1997 Three-dimensional microfabrication with two-photon-absorbed photopolymerization 

Opt. Lett. **22 **132 [29] Deubel M, von Freymann G, Wegener M, Pereira S, Busch K and Soukoulis C M 2004 Direct laser writing of three-dimensional 

photonic-crystal templates for telecommunications Nat. Mater. **3 **444 [30] Hohmann J K, Renner M, Waller E H and von Freymann G 2015 Three-dimensional μ-printing: an enabling technology Adv. 

Opt. Mater. **3 **1488 [31] Walker B T, Ash B J, Trichet A A P, Smith J M and Nyman R A 2021 Bespoke mirror fabrication for quantum simulation with 

light in open-access microcavities Opt. Express **29 **10800 [32] Schwabl F 2006 Statistical Mechanics 2nd edn (Berlin: Springer) [33] Klünder B and Pelster A 2009 Systematic semiclassical expansion for harmonically trapped ideal Bose gases Eur. Phys. J. B **68 **457 [34] Gradshteyn I S and Ryzhik I M 2007 Table of Integrals, Series, and Products 7th edn (New York: Academic Press) [35] Haugset T, Haugerud H and Andersen J O 1997 Bose–Einstein condensation in anisotropic harmonic traps Phys. Rev. A **55 **2922 [36] Robinson J E 1951 Note on the Bose–Einstein integral functions Phys. Rev. **83 **678 [37] Olver F W J et al (ed) NIST digital library of mathematical functions http://dlmf.nist.gov/, release 1.0.28 of 15 Sep 2020 [38] Xie M 2018 Bose–Einstein condensation temperature of finite systems J. Stat. Mech. 53109 [39] Liang Q 2014 Calorimetry of a Bose–Einstein condensed photon gas Master’s Thesis University of Bonn [40] Vewinger Frank and von Freymann Georg 2020 Private communication [41] Damm T, Dung D, Vewinger F, Weitz M and Schmitt J 2017 First-order spatial coherence measurements in a thermalized 

two-dimensional photonic quantum gas Nat. Commun. **8 **158 [42] Radonjíc M, Kopylov W, Balaž A and Pelster A 2018 Interplay of coherent and dissipative dynamics in condensates of light New J. 

Phys. **20 **055014 [43] Öztürk F E, Lappe T, Hellmann G, Schmitt J, Klaers J, Vewinger F, Kroha J and Weitz M 2021 Observation of a non-Hermitian 

phase transition in an optical quantum gas Science **372 **88 [44] Balaž A, Vidanovíc I, Bogojevíc A and Pelster A 2010 Ultra-fast converging path-integral approach for rotating ideal 

Bose–Einstein condensates Phys. Lett. A **374 **1539 

16 74

## 4. Photon BEC with Thermo-Optic Interaction at Dimensional Crossover 

ἀλλ᾿ ἄνδρα, κεἴ τις ᾖ σοφός, τὸ 

μανθάνειν 

πόλλ᾿, αἰσχρὸν οὐδὲν καὶ τὸ μὴ 

τείνειν ἄγαν. 

There is no shame in a man learning more, // Be he ever so wise, nor in remaining flexible. 

Sophokles, Antigone l. 710f 

While chapter 3 discusses in detail the dimensional crossover for an ideal Bose gas and works out the effective dimension along the crossover, the present chapter covers the influence of both the thermo-optic and the Kerr interaction upon the condensate ground state at the dimensional crossover. The starting point consists of coupled equations for both the photon condensate in a mean-field description and the temperature diffusion describing the thermo-optic photon-photon interaction, as introduced in subsection 1.3.3 and used in chapter 2. This study utilises the Green’s function of the diffusion equation to eliminate the temperature degree of freedom, such that only a single equation for the photon-condensate ground state remains. As the total photon-photon interaction is weak, a variational approach yields approximate results for the condensate wave function. With the trapping potential being harmonic, the trial function for the photon condensate wave function is of Gaussian form, with its widths being the variational parameters. A minimisation of the corresponding energy functional with respect to these widths yields their defining equations. This chapter explores performing the crossover in two ways, either by fixing the x-direction and by squeezing the y-direction, or by loosening the trap in x-direction while simultaneously increasing the trapping potential in y-direction. In the first setup, a saturation of the thermo-optic interaction appears. This stems from the competition between the length scale of the temperature distribution and the length scale of the condensate in the squeezed direction. In case the condensate width gets smaller than the diffusion length scale, a certain part of the temperature created by the condensate diffuses to regions where no condensate is present. Therefore, it cannot contribute to the photon-photon interaction. In this situation the Kerr interaction, which grows linearly with the trap-aspect ratio, takes over for large trap anisotropies. In the second setup, the simultaneous elongation of the condensate in the x-direction prevents this from happen-ing and the thermo-optic interaction increases during the entire dimensional crossover. 

Within this study, I worked out the theory, performed the necessary calculations and prepared the complete manuscript for submission. I also implemented the numerical calculations by using a Fourier split-step algorithm in imaginary time, as well as the scripts for data analysis. All authors were engaged with the reviewing process of the manuscript. 

75

4. Photon BEC with Thermo-Optic Interaction at Dimensional Crossover 

76

OPEN ACCESS 

RECEIVED 

1 October 2021 

REVISED 

14 January 2022 

ACCEPTED FOR PUBLICATION 

4 February 2022 

PUBLISHED 

24 February 2022 

Original content from this work may be used under the terms of the Creative Commons Attribution 4.0 licence. 

Any further distribution of this work must maintain attribution to the author(s) and the title of the work, journal citation and DOI. 

PAPER 

### Photon BEC with thermo-optic interaction at dimensional crossover 

Enrico Stein∗ and Axel Pelster Department of Physics and Research Center OPTIMAS, Technische Universität Kaiserslautern, Erwin-Schrödinger-Straße 46, 67663 

Kaiserslautern, Germany ∗ Author to whom any correspondence should be addressed. 

E-mail: estein@rhrk.uni-kl.de and axel.pelster@physik.uni-kl.de 

Keywords: photon Bose–Einstein condensate, Gross–Pitaevskii equation, dimensional crossover 

Abstract Since the advent of experiments with photon Bose–Einstein condensates (phBECs) in dye-filled microcavities in 2010, many investigations have focussed upon the emerging effective photon–photon interaction. Despite its smallness, it can be identified to stem from two physically distinct mechanisms. On the one hand, a Kerr nonlinearity of the dye medium yields a photon–photon contact interaction. On the other hand, a heating of the dye medium leads to an additional thermo-optic interaction, which is both delayed and non-local. The latter turns out to represent the leading contribution to the effective interaction for the current 2D experiments. Here we analyse theoretically how the effective photon–photon interaction increases when the system dimension is reduced from 2D to 1D. To this end, we consider an anisotropic harmonic trapping potential and determine via a variational approach how the properties of the phBEC in general, and both aforementioned interaction mechanisms in particular, change with increasing anisotropy. We find that the thermo-optic interaction strength increases at first linearly with the trap aspect ratio and later on saturates at a certain value of the trap aspect ratio. Furthermore, in the strong 1D limit the roles of both interactions get reversed as the thermo-optic interaction remains saturated and the contact Kerr interaction becomes the leading interaction mechanism. Finally, we discuss how the predicted effects can be measured experimentally. 

1. Introduction 

Ultracold atomic quantum systems in dimensions lower than three bear interesting physics [1, 2]. In 2D an 

interacting Bose gas can undergo a crossover from a Bose–Einstein condensate to a Berezinskii–Kosterlitz–Thouless phase [3–5], where vortex and anti-vortex pairs are produced and can 

move through the gas. In one-dimensional systems large phase fluctuations are detected [6], which induce 

an algebraic decay of the correlation function, in contrast to an exponential decay in higher dimensions. 

Moreover, it is also known that the effective interaction strength increases by reducing the dimension of the system [7]. For systems of bosonic atoms the dimensional crossover has already been investigated broadly 

from 3D to 2D [8] and even down to 1D [9, 10]. The question of the effective system dimension can be 

reduced to a discussion of the relevant length scales [11]. Provided that the healing length of a three-dimensional condensate confined by an axially symmetrical trap is larger than the axial width, the 

system is effectively two-dimensional. In case that the in-plane radius is smaller than the healing length, the 

system is quasi-1D. 

For photon Bose–Einstein condensates (phBEC) [12], however, such a dimensional crossover has so far not been realised. As these kinds of experiments are conducted in a microcavity, they turn out to be already 

two-dimensional. It is expected that the crossover to 1D can be achieved experimentally by writing an 

anisotropic harmonic confining potential directly on the mirror [13–15]. This should yield a simple control 

of the trap anisotropy, which then allows to freeze out the higher dimension as has already been shown in 

© 2022 The Author(s). Published by IOP Publishing Ltd on behalf of the Institute of Physics and Deutsche Physikalische Gesellschaft 

77

Figure 1. Sketch of the interaction mechanisms mediated by the dye solution. The change Δn of the refractive index n of the dye solution stems from both a Kerr nonlinearity χ(3) and thermo-optics described by the coefficient β. Reproduced from [22]. CC BY 4.0. 

the theoretical study [16]. Thus, such photonic systems constitute a useful platform to investigate the crossover from higher to lower dimensions. 

Following this line of reasoning necessitates a glimpse into whether a true Bose–Einstein condensate in the one-dimensional harmonic trap exists at all. Although in an early work [17] it was shown via a semiclassical ansatz, that an ideal gas cannot Bose–Einstein condense in such a trap, a full quantum mechanical investigation has, indeed, shown the existence of such a condensate [18]. In the later work [19] these two former results have been brought together by generalising the semiclassical ansatz from [17], see also [16] for a detailed discussion. However, in this paper we focus on the T = 0 situation for a weakly interacting Bose gas. In the realm of quantum degenerate Bose gases in 1D it has been pointed out in [20], that for T = 0 one always deals with a true Bose–Einstein condensate. Therefore, we will always use the term BEC throughout this paper. 

In the corresponding experimental set-up, photons are trapped in a dye-filled cavity and, due to the contact with the dye, the photon gas is allowed to thermalise [21] and finally to Bose–Einstein condense [12]. Moreover, the dye solution leads also to an effective photon–photon interaction via two mechanisms, as is depicted in figure 1. One is the Kerr effect, which is due to a nonlinearity χ(3) of the solvent molecules, where a change of the refractive index Δn ∝ |ψ|2 leads to an effective contact interaction. The second mechanism for the effective photon–photon interaction is the thermo-optic effect. Since the quantum efficiency of the dye lies below one, some electronic excitations of the dye molecules are converted into phononic excitations due to the electron–phonon coupling in the molecule. Since these are also distributed through the solvent, this leads to a net heating of the dye solution. This changes the refractive index of the dye solution according to the thermo-optic coefficient β and, thus, contributes to the effective photon–photon interaction. 

It turns out that the thermo-optic interaction is the leading contribution in the current 2D experiments, whereas the Kerr interaction is completely negligible in this situation. However, the total interaction strength is still quite small as the dimensionless interaction strength amounts to about g̃ = mg/�2 ∼ 10−4 

[12, 23]. Therefore, effects of stronger interaction like superfluidity are not yet observable and even the thermodynamics turns out to be not affected by the interaction [24]. This finding motivated our previous study [16], where we investigated as a first step the dimensional crossover of a non-interacting photon BEC from 2D to 1D by determining its thermodynamic properties and by extracting from them the effective system dimension for a given temperature and trap aspect ratio. In a second step, it is now crucial to search for mechanisms to increase the effective photon–photon interaction. In this respect we already found in the former theoretical study [22] the intriguing result that the strength of the thermo-optic interaction increases quadratically with the lateral extension of the cavity mirrors. However, as this would be quite laborious to achieve experimentally, we explore here an alternative mechanism, which relies on increasing the effective photon–photon interaction strength by reducing the system dimension from 2D to 1D. As it is already known that this increases effectively the contact interaction [25], our main focus lies hereby on the question how the dimensional crossover modifies the thermo-optic interaction. 

To this end, we start by introducing in section 2 a coupled system of mean-field equations describing the steady state of both the phBEC ground state and the temperature, which is produced by the phBEC and which conversely affects the photon–photon interaction. Instead of straight-forwardly solving this coupled system of equations by numerical means, we construct an approximate solution within a semi-analytic procedure as follows. At first, we eliminate the temperature degrees of freedom by using the corresponding Green’s function and determine with this the resulting energy functional for the condensate. As the profile 

2 78

of the photon condensate wave function is a Gaussian in the non-interacting case, it is reasonable to assume that this profile remains to be valid also in the mutual presence of both Kerr and thermo-optic interaction. Therefore, within a variational approach, we minimise the condensate energy function with respect to the widths of the used Gaussian trial function in section 3. Solving the corresponding self-consistency conditions for these widths, it turns out that the dimensional crossover can physically be divided into three different regimes. The first one corresponds to small trap aspect ratios λ and shows, as expected, an increase of the thermo-optic interaction strength. In the second regime for intermediate λ, the thermo-optic interaction turns out to saturate, as here the condensate width in the squeezed direction is smaller than the characteristic length scale of the temperature diffusion. Finally, in the third regime for large λ the contact Kerr interaction turns out to take over the leading role in the effective photon–photon interaction. At the end, we discuss that the respective strengths of Kerr and thermo-optic interaction can not only be extracted from the condensate widths but also from analysing the energy in the quasi 1D regime. To conclude this work, we also apply this method in section 4 to the crossover in a potential, where in addition to the tightening of the confinement in a single direction the potential in the second direction is loosened. This potential bears the advantage of a constant particle density in the trap centre, since by only tightening a single direction the photon density in the trap centre steadily increases, which yields in the experimental situation to mirror loss processes and, consequently, to multimode condensates. Here we find, that both the thermo-optic and the Kerr interaction increase linearly with the trap-aspect ration, such that a much larger effective photon–photon interaction strength might be achieved. With this we demonstrate how the dimensional crossover depends on the details of the chosen potential. 

2. General equations 

Our starting point for describing the photon BEC ground state is the mean-field theory worked out in reference [22], see figure 1. There we used a set of two coupled equations in order to describe both the photon BEC wave function in the microcavity and the heat diffusion in the dye solution inducing the thermo optics. However, for the current purpose, we consider two modifications of this mean-field theory. On the one hand, we neglect the imaginary part of the equation for the condensate wave function, as this simply determines the photon number N. On the other hand, we also need to take the Kerr effect into account, which gives rise to an additional contact interaction term in the equation for the photon BEC wave function. In total, the steady state of the condensate is, thus, described by 

μψ = 

 −�2∇2 

2m + V + gK|ψ|2 + γΔT 

 ψ, (1) 

where m represents the effective photon mass and V describes the external potential. The strength of the Kerr interaction is given by gK and the energy shift due to the temperature difference ΔT between the actual intracavity temperature and the room temperature is intermediated by the parameter γ, which is proportional to the thermo-optic coefficient β from figure 1 [22]. Furthermore, the photon BEC wave function is normalised according to 

 d2x|ψ|2 = N. 

The steady state of the temperature difference ΔT, which is produced by the photon condensate due to non-perfect absorption–reemission cycles and which diffuses through the cavity, is described by the diffusion equation 

ΔT = τD∇2 ΔT + στB|ψ|2. (2) 

Here τ denotes the longitudinal relaxation time stemming from the diffusion along the optical axis, see reference [22] and the appendix therein, D stands for the diffusion coefficient of the temperature, and the heating of the dye solution is modelled via the heating rate B. Furthermore, the duty cycle σ describes that the experiment operates with a pulsed pump laser, whereas our theoretical description works with a continuous pump for reaching the steady state. This modification is needed here, as the temperature necessitates several experimental cycles to achieve its steady state [22]. 

2.1. Elimination of temperature difference As a first step, we eliminate the temperature difference as a degree of freedom from our description. To this end, we formally solve the diffusion equation (2) according to 

ΔT(x) = στB 

 d2x G(x − x)|ψ(x)|2, (3) 

3 79

where we have introduced the Green’s function G(x). Its Fourier transform G̃(k) reads 

G̃(k) = 1 

τDk2 + 1 , (4) 

so we conclude for the real space 

G(x) = 

 d2k 

4π2 

eik·x 

τDk2 + 1 . (5) 

In order to evaluate the integral we use the Schwinger parametrisation [26]  ∞ 

0 dt e−at = 

1 

a , (6) 

and have then 

G(x) = 

 ∞ 

0 dt 

 d2k 

4π2 e−(1+τDk2)t+ik·x. (7) 

As the integral over k represents now a Gaussian, we can calculate it and find 

G(x) = 

 ∞ 

0 dt G(x, t), (8) 

with the integrand 

G(x, t) = e−x2/(4l2difft)−t 

4πl2difft . (9) 

Here ldiff = √ τD represents the diffusion length and the Schwinger parameter t corresponds physically to 

the time in units of the longitudinal relaxation time τ . We recognise expression (9) to be the Green’s function of the time-dependent diffusion equation. Whereas at initial time the Green’s function (9) reduces to the delta function, i.e. 

G(x, 0) = δ(x), (10) 

summing (9) over all times finally yields the steady-state Green’s function (8). Evaluating the remaining Schwinger integral in equation (8) leads to a modified Bessel function of the second kind K0 [27, (3.471.9)]: 

G(x) = 	x	 

4πl2diff 

K0 

⎛ ⎝  

	x	 ldiff 

⎞ ⎠ . (11) 

Whereas the initial Green’s function (10) has its maximum at the origin x = 0, the steady-state Green’s function (11) is maximal at a circle, whose radius is given by 	x	 ∼ ldiff . Although we have an explicit expression (11) for the Green’s function (8), the Schwinger integral representation (9) turns out to be more advantageous for the following analytic calculation, such that we prefer to use it instead throughout the remainder of this paper. Taking this into account, equation (3) can be written as 

ΔT(x) = στB 

 ∞ 

0 dt 

 d2x G(x − x, t)|ψ(x)|2. (12) 

With this the steady-state profile of the temperature difference is given due to diffusion by the photon density. 

2.2. Photon functional Using the formal solution of the diffusion equation (2) in the form (12), the photon BEC wave function equation (1) goes over into 

μψ = 

 −�2∇2 

2m + V + gK|ψ|2 + gT 

 ∞ 

0 dt 

 d2x G(x − x, t)|ψ(x)|2 

 ψ. (13) 

Here the resulting thermo-optic interaction strength is defined as [22] 

gT = σγτB, (14) 

and is, thus, determined by various material properties of the dye solution. As a next step, we determine the energy functional corresponding to equation (13), which turns out to consist of three parts: 

E[ψ∗,ψ] = E0[ψ∗,ψ] + EK[ψ∗,ψ] + ET[ψ∗,ψ]. (15) 

4 80

The first one describes both the kinetic and the potential energy of the photon BEC and reads 

E0[ψ∗,ψ] = 

 d2x 

 �2 

2m |∇ψ|2 + V|ψ|2 

 , (16) 

whereas the second one, 

EK[ψ∗,ψ] = gK 

2 

 d2x|ψ|4, (17) 

represents the contact Kerr interaction. The last term comprises the thermo-optic effects via 

ET[ψ∗,ψ] = gT 

2 

 ∞ 

0 dt 

 d2x 

 d2x G(x − x, t)|ψ(x)|2|ψ(x)|2. (18) 

In the following we aim at minimising the energy functional (15) for a harmonic confinement along the dimensional crossover within a variational approach, similar to our preceding work [22]. 

3. Variational approach 

We express the harmonic potential in the form 

V = mΩ2 

2 (x2 + λ4y2), (19) 

where the trap aspect ratio λ = lx/ly determines the ratio of the oscillator length li =  �/(mΩi) with 

i = x, y in the respective dimensions and Ω = Ωx is the trapping frequency in x-direction. As the photon condensate wave function is a Gaussian in the non-interacting case, it is reasonable to assume that this profile remains to be valid also in the mutual presence of both Kerr and thermo-optic interaction. Therefore, the variational ansatz for the phBEC ground-state wave function reads 

ψ = 

 λN 

αxαyπl2x exp 

 − 1 

2l2x 

 x2 

α2 x 

+ λ2 y2 

α2 y 

 , (20) 

where we treat αx,αy as the corresponding variational parameters. Note that due to this choice, these parameters are dimensionless and αx = αy = 1 describes the non-interacting case. Inserting the ansatz (20) into the functional (15) yields the energy as a function of the two variational parameters and the ratio λdiff = lx/ldiff of the oscillator length lx and the diffusion length ldiff : 

E(αx,αy) = N�Ω 

 1 

4 

 1 

α2 x 

+ λ2 

α2 y 

 + 

1 

4 

 α2 

x + λ2α2 y 

 + 

g̃KλN 

4παxαy 

+ g̃TλN 

4παxαy 

 ∞ 

0 dt 

e−t 

 [1 + 2t/(λ2 

diffα 2 x)][1 + 2tλ2/(λ2 

diffα 2 y)] 

⎤ ⎦ . (21) 

Note that we have defined here the dimensionless interaction strength g̃• = mg•/�2. Thus, by performing the derivative of the function (21) either with respect to αx or with respect to αy we can calculate the corresponding equations for the variational parameters and obtain 

αx = 1 

α3 x 

+ g̃KλN 

2πα2 xαy 

+ g̃TλN 

2πα2 xαy 

 ∞ 

0 dt 

e−t 

 [1 + 2t/(λ2 

diffα 2 x)]3[1 + 2tλ2/(λ2 

diffα 2 y)] 

, (22) 

for the x direction and in the squeezed y direction we have 

λ2αy = λ2 

α3 y 

+ g̃KλN 

2παxα2 y 

+ g̃TλN 

2παxα2 y 

 ∞ 

0 dt 

e−t 

 [1 + 2t/(λ2 

diffα 2 x)][1 + 2tλ2/(λ2 

diffα 2 y)]3 

. (23) 

3.1. General solution At first, we discuss the general solution of the self-consistency equations (22) and (23) as depicted in figure 2(a). We see that, as the trap aspect ratio λ increases, the variational parameter αy approaches the value 1. This indicates that in this direction the broadening due to the interaction gets negligible, which 

5 81

Figure 2. Condensate widths for experimental parameters N = 104, g̃K = 10−8, g̃T = 10−4, and λdiff = 32 for varying trap aspect ratio λ. (a) Variational parameters αx (blue, solid) and αy (red, solid) from equations (22) and (23). The dashed lines take merely the thermo-optic (orange) and the Kerr (green) influence upon αx into account. The crosses show the results from a corresponding numerical treatment of equations (1) and (2). (b) Schematic representation of length scales of the condensate l and l/λ in different directions in comparison with the diffusion length scale ldiff for different values of the trap aspect ratio λ. 

means that the system behaves effectively one-dimensional. On the other hand, we observe a much more complex behaviour for the variational parameter αx, where we discern in total three regions. For small trap aspect ratios λ the parameter αx starts to grow, which is a characteristic sign of increasing interaction. Then, for intermediate λ ∼ λdiff , we find that the variational parameter αx saturates, which signals a saturation of the interaction. And finally, for large trap aspect ratio λ, the variational parameter αx increases again. We can understand this behaviour in more detail by separating the different interaction mechanisms numerically. The green and the red dashed line show the width by only taking the thermo-optic interaction and the Kerr interaction into account, respectively. We note, that, indeed, the thermo-optic interaction is the dominant interaction effect for small λ and saturates at λ ∼ λdiff . The Kerr interaction, on the other hand, behaves differently. Its contribution for small trap aspect ratio λ is negligible, but becomes stronger than the thermo-optic interaction at λ � λKerr = λdiff gT/gK. This threefold behaviour is schematically shown in figure 2(b) by depicting the length scales of the condensate l and l/λ in different directions in comparison with the diffusion length scale ldiff for different values of the trap aspect ratio λ. Note that the particular role of the diffusion length scale ldiff can be traced back to the steady-state Green function (11), which is maximal at the circle with radius proportional to ldiff . 

In order to support these findings, a numerical evaluation of equations (1) and (2) has been performed. Our numerics is based on an imaginary time split-step Fourier method, where the propagation with respect to the Laplacian appearing in (1) is done in the Fourier space and the remaining propagation takes place in the real space. Furthermore, the actual temperature distribution defined via the convolution integral (3) is also calculated in Fourier space using the Green’s function (4). The used space–time discretisation is chosen such that for a given trap aspect ratio λ the phBEC wavefunction can also be resolved in the squeezed direction. Thus, after a sufficiently long propagation in imaginary time we can calculate the widths qx = 

 2
x2 and qy = 

 2
y2 from the resulting steady-state photon distribution. From the variational 

ansatz (20) we see, that the variational parameter αx can directly be identified with the width qx, whereas for the y direction we have αy = λqy. As we see in figure 2 our numerical results agree well with the results obtained from the variational equations (22) and (23). However, due to the increasing numerical effort, we have only compare the results for trap aspect ratios up to λ = 5λdiff . In the following we discuss our findings in more detail from an analytical point of view. 

6 82

3.2. Isotropic case In the isotropic case we have λ = 1 and αx = αy = :α, so equations (22) and (23) reduce to the single equation 

α = 1 

α3 + 

g̃KN 

2πα3 + 

g̃TN 

2πα3 

 ∞ 

0 dt 

e−t 

(1 + 2t/λ2 diffα 

2)2 . (24) 

For the parameters of the Bonn experiment [12, 23] we estimate that λ2 diff ∼ 103  1. Furthermore, the 

exponential in the integral leads to an effective cutoff of the integral for t ∼ 1. Then the term 2t/λ2 diffα 

2 in the denominator can be neglected, since it only contributes to the integral at times t ∼ α2λ2 

diff/2  1. With this we can calculate approximately the integral and conclude that α is determined by the algebraic equation 

α ≈ 1 

α3 + 

g̃KN 

2πα3 + 

g̃TN 

2πα3 . (25) 

Here the thermo-optic interaction behaves exactly as the Kerr interaction, as the influence of the diffusion dropped out. Furthermore, we can solve equation (25) for the variational parameter and obtain 

α = 4 

 1 + 

(g̃K + g̃T)N 

2π , (26) 

which we already obtained in the former work [22]. 

3.3. Quasi 1D case Now we deal with the opposite situation, where the system is quasi-one-dimensional and determine at first for which trap aspect ratios λ this regime starts. To this end we read off from figure 2(a) that already for λ  λdiff we have αy ≈ 1, which is a sign that in the squeezed direction the influence of the interaction is negligible. In this case the sum of kinetic and potential energy Ey ≈ N�Ωλ2/2 stored in the squeezed spatial degree of freedom is proportional to the square of the trap aspect ratio, whereas the interaction energy Eint = EK + ET increases linearly with λ according to expression (21). Indeed, in this regime the contribution of the Kerr interaction can be neglected in comparison to the thermo-optic interaction according to figure 2(a). For the remaining integral we can apply the same approximation as in section 3.2, resulting finally in Eint ≈ �Ωg̃TλN/(4παx). A further inspection of figure 2 reveals that we can roughly approximate αx ≈ 1 in this regime as well. Thus, as the quasi-1D region amounts to the inequality Ey  Eint, we obtain the criterion 

λ  λ1D = g̃TN 

2π . (27) 

As current photon BEC experiments are characterized by g̃T = 10−4 and a maximal photon number N = 105, the 1D criterion (27) is basically fulfiled slightly above the 2D case λ = 1. 

We proceed now to larger values of the trap aspect ratio λ, where we can still assume αy ≈ 1, according to figure 2(a). We can now determine αx self-consistently from equation (22), yielding 

αx ≈ 1 

α3 x 

+ g̃KλN 

2πα2 x 

+ g̃TλN 

2πα2 x 

 ∞ 

0 dt 

e−t 

 (1 + 2t/λ2 

diffα 2 x)3(1 + 2tλ2/λ2 

diff) . (28) 

This integral is simplified along similar lines as in section 3.2, and it reduces to 

α4 x ≈ 1 + 

g̃1D(λ)N√ 2π 

αx, (29) 

where we have introduced the effective 1D interaction strength inspired by a comparison with equation (A.4): 

g̃1D(λ) = 1√ 2π 

 g̃Kλ + g̃Tλdiff 

 π 

2 eλ 

2 diff/(2λ2)erfc 

 λdiff√ 

2λ 

 . (30) 

We note that the contribution of the thermo-optic interaction is determined by the ratio λ/λdiff = λldiff /lx, i.e. the ratio of the diffusion length ldiff and the oscillator length in the squeezed y direction lx/λ. Figure 3 depicts the total effective 1D interaction strength g̃1D(λ) from equation (30) as a function of λ. Also here we note the aforementioned three different regions of the crossover. For small trap aspect ratio λ the thermo-optic interaction, which gives here the leading contribution, increases and then indeed, as stated above, saturates. But for λ > λKerr = λdiff g̃T/g̃K the Kerr interaction takes over and the total interaction grows again. 

7 83

Figure 3. Effective one-dimensional interaction strength g̃1D(λ) from definition (30) normalised to the isotropic 2D interaction constant g̃ = g̃K + g̃T in blue for the experimental parameters g̃T = 10−4, g̃K = 10−8, and λdiff = 32. The dashed orange line shows the thermo-optic contribution, whereas the dashed green line depicts the contribution of the Kerr interaction. 

Let us now discuss these findings in more detail. For small trap aspect ratio, i.e. λ  λdiff , we can approximate equation (30) by 

g̃1D,0(λ) ≈ 1√ 2π 

 g̃K + g̃T 

 λ, (31) 

and in this case the thermo-optic interaction behaves like the Kerr interaction showing a linear increase in λ. The reason for this is that here the diffusion length is negligible compared to the condensate width in both x and y direction. Thus, the heat produced by the condensate only diffuses within a region where the condensate wave function does not vary, such that the thermo-optic interaction behaves approximately as a local contact interaction. On the other hand, once we have entered deeply the quasi-1D regime, i.e. λ  λdiff , the effective 1D interaction strength (30) is given by 

g̃1D,∞(λ) ≈ 1√ 2π 

 g̃Kλ + g̃T,∞ 

 . (32) 

Thus, in this limit the thermo-optic part of the interaction strength no longer depends on the trap aspect ratio λ and saturates at the value 

g̃T,∞ = g̃Tλdiff, (33) 

which is fixed by the geometry of the experiment and by the used solvent. This is due to the fact that here the width of the condensate in the squeezed direction lx/λ is much smaller than the diffusion length ldiff 

and, thus, the heat being produced by the condensate diffuses through the dye medium to regions where no condensate exists, cf figure 2. This heat, therefore, cannot contribute to the interaction, such that the thermo-optic interaction saturates. For the Kerr contribution, however, the situation does not change and the total interaction strength still shows according to equation (32) a linear dependency in the trap aspect ratio λ. 

Note that it is currently reasonably to expect achieving experimentally a trap anisotropy of at most λ ∼ 102λdiff [28]. From figure 1 we read off that in this case the Kerr interaction is still negligible and that the total effective 1D interaction is due to the thermo-optic effect. Thus, the maximally achievable effective 1D interaction strength g̃exp 

1D,∞ reads, with the help of expressions (32) and (33) 

g̃exp 1D,∞ = 

λdiff√ 2π 

g̃T. (34) 

Therefore, we can, indeed, expect an increase of the effective photon–photon interaction strength via a dimensional crossover. Taking into account that λdiff ∼ 32, the expected increase of the interaction strength amounts to more than one order of magnitude. 

3.4. Energy From analysing the behaviour of the variational parameters, which are basically the widths of the phBEC wave function, at the dimensional crossover it is obvious that the effective photon–photon interaction strength can be measured quite directly. However, we emphasise that this measurement relies on evaluating real space images of the light leaking out the cavity. More precise results are expected from spectroscopic measurements of this light, which directly reveals the phBEC energy. Thus, we discuss now the resulting 

8 84

Figure 4. Interaction energy Eint,1D given by equation (37) for the experimental parameters N = 104, g̃K = 10−8, g̃T = 10−4, and λdiff = 32. The orange dashed line shows the contribution of the thermo-optic effect, whereas the green dashed line indicates the contribution of the Kerr effect. The inset shows the interaction energy relative to the non-interacting energy E0 from (36). 

energy of the condensate in more detail. In the effective 1D case by using αy ≈ 1 and the definition (30) of the effective 1D interaction strength from the energy function (21), we find for the energy 

E1D ≈ N�Ω 2 

 1 

2 

 1 

α2 x 

+ α2 x 

 + λ2 + 

g̃1D(λ)N√ 2παx 

 . (35) 

This formally coincides with (A.4) from appendix A apart from the λ2 dependency, which represents the shift of the ground state due to the energy of the squeezed direction. Introducing the non-interacting energy 

E0 = N�Ω 

2 

 1 + λ2 

 , (36) 

we can define the interaction contribution to the energy by 

Eint, 1D = E1D − E0, (37) 

which is plotted in figure 4 as a function of the trap aspect ratio λ. Again, we find the same threefold behaviour we have already observed for the widths and the interaction 

strength, which stems from a saturation of the thermo-optic interaction for intermediate λ. Moreover, we see from the inset in figure 4 that the interaction energy Eint,1D is quite small compared to the unperturbed energy (36), so that our variational approach is a good approximation of the true ground state. 

Finally, we remark that our findings can be measured by utilising the fact that the thermo-optic interaction builds up steadily during the experimental run. At the beginning of the experiment the dye-filled solution in the cavity does not have any temperature difference with respect to the environment, so the thermo-optic interaction does not yet occur, whereas the instantaneous Kerr interaction is already fully present. As a single experiment lasts only about 500 ns, the temperature difference saturates only after several pump pulses, such that then the thermo-optic interaction is in its steady state and yields its full contribution. Consequently, the resulting strength of the thermo-optic interaction can be measured by determining the energy of the condensate at the beginning of the experiment and by comparing it with the energy at the end. In principle this would involve subtracting the Kerr contribution from the interaction energy (37), 

Eth, 1D = Eint, 1D − �Ωg̃KλN2 

2 √ 

2παx . (38) 

However, as already mentioned above, in the experiment only the thermo-optic saturation region is expected to be accessible. According to figure 4 the energy contribution due to the Kerr effect is negligible in the whole experimental regime. According to equation (38) the total interaction energy (37) coincides with the thermo-optic energy contribution. Therefore, one can directly use expression (37) to determine the strength of the effective photon–photon interaction. We remark that for sufficiently small particle number N one can enter the regime where it is valid to determine the variational parameters perturbatively in first order with respect to the smallness parameter g̃1D(λ)N/ 

√ 2π. In this case the interaction energy (37) is 

directly given by 

Eint, 1D ≈ �Ωg̃1D(λ)N2 

2 √ 

2π . (39) 

allowing to directly determine the effective interaction strength from the measured value of Eint,1D. 

9 85

4. Dimensional crossover with constant particle density 

So far we have studied the crossover for a constant particle number only. However, increasing the trap aspect ratio implies a corresponding increase of the photon density, so it is unavoidable from an experimental point of view for intrinsic mirror losses to lead the condensate turning multimode [29]. Therefore, we study now a complementary approach to the dimensional crossover, where we fix the geometric mean Ω̄ = λΩx, which yields the potential in the form 

V = mΩ̄2 

2 

 x2 

λ2 + λ2y2 

 . (40) 

Thus, increasing the trap-aspect ratio λ tightens the trap in the y-direction while loosening the trapping potential in the x-direction. Due to this, the photon density in the trap centre stays the same throughout the whole crossover. However, note that the exact 1D limit, i.e. λ→∞ corresponds to a free particle in x-direction. In this situation a suitable ansatz function for a minimisation procedure is given by 

ψ = 

 N 

ᾱxᾱyπl̄ 2 exp 

 − 1 

2l̄ 

 x2 

λᾱ2 x 

+ λy2 

ᾱ2 y 

 , (41) 

where l̄ = lx/ √ λ denotes the geometric mean of the oscillator lengths and ᾱx, ᾱy are the new variational 

constants. Inserting ansatz (41) into the energy functional (15) with the potential (40) yields for the energy the expression 

Ē = N�Ω̄ 

4 

 1 

λᾱ2 x 

+ ᾱ2 

x 

λ + 

λ 

ᾱ2 y 

+ λᾱ2 y + 

g̃KN 

πᾱxᾱy + 

g̃TN 

πᾱxᾱy I 

 , (42) 

where I abbreviates the integral 

I = 

 ∞ 

0 dt 

e−t 

 1 + 2t/(ᾱ2 

yλ 2 diff) 

  1 + 2t/(ᾱ2 

xλ 2 diffλ 

2)  . (43) 

Here we can approximate I ≈ 1 since both factors in the root can be treated as explained below equation (24). This implies, that in this situation the Kerr interaction and the thermo-optic interaction behave identically and only the total interaction strength g̃ = g̃K + g̃T appears. On the other hand this also implies, that a saturation effect of the thermo-optic interaction, as found in the proceeding section, does not exist here and, therefore, a larger effective photon–photon interaction is achievable. We derive from the energy (42) the following equations for the variational parameters 

ᾱx = 1 

ᾱ3 x 

+ g̃λN 

2πᾱ2 xᾱy 

, (44) 

in the x-direction and for the y-direction we have 

ᾱy = 1 

ᾱ3 y 

+ g̃N 

2πλᾱxᾱ2 y 

. (45) 

Figure 5(a) shows a numerical solution of the coupled equations (44) and (45) for the experimentally relevant parameters N = 104, g̃K = 10−8 and g̃T = 10−4. We see also here, that for increasing trap-aspect ratio the variational parameter ᾱy in the squeezed direction attends the value 1, implying the interaction in this direction to be less relevant. Secondly, we note the monotonous increase of the variational parameter in the x direction in contrast to the previous results indicating the absence of a saturation effect. Therefore, larger condensate widths and, thus, larger effective photon–photon interactions are reachable. Moreover, also here we perform a numerical evaluation of the original equations (1) and (2) as above, which perfectly agrees with the evaluation of the variational equations (44) and (45). 

For increasing trap-aspect ratio λ we note in (45) that the interaction term vanishes. Taking approximately ᾱx ≈ 1 and ᾱy ≈ 1 again reveals the 1D criterion (27). For evaluating the effective 1D behaviour we stay as above with the approximation ᾱy ≈ 1 and insert this into equation (44). We end up with 

ᾱ4 x ≈ 1 + 

g̃λN 

2π ᾱx. (46) 

10 86

Figure 5. (a) Variational parameters from the coupled equations (44) and (45) for experimentally relevant parameters N = 104, g̃K = 10−8 and g̃T = 10−4. The green (red) line shows the variational parameter ᾱx (ᾱy), whereas the crosses indicate the corresponding numerical evaluation of equations (1) and (2). The dashed line depicts the variational parameter αx using the potential (19). (b) Effective 1D interaction strength (47) for the potential (40) (orange) compared to the effective 1D interaction strength (30) for the potential (19) (blue). 

Thus, comparing (A.6) with (46) yields for the effective 1D interaction strength in the current crossover setting governed by the potential (40) a linear increase with the trap-aspect ratio 

¯̃g1D(λ) = g̃λ√ 2π 

. (47) 

As already mentioned in the beginning of this section, indeed, no saturation regime for the thermo-optic interaction is observed in this setting and, consequently, even larger effective interaction constants can be achieved. A comparison of the interaction strength (47) with the previously derived interaction strength (30) is shown in figure 5(b). Whereas the interaction strength (30) saturates for larger anisotropies the new interaction strength (47) grows linearly for all values of the trap-aspect ratio. 

5. Summary 

In this paper we have shown how the ground state of a phBEC changes during the dimensional crossover from 2D to 1D. Our main focus in this investigation was the behaviour the effective photon–photon interaction strength in the crossover in order to make effects like superfluidity accessible in experiments. We have found that the effective photon–photon interaction strength increases through the crossover. However, we have shown that the thermo-optic interaction can only be increased up to a factor λdiff/ 

√ 2π, cf 

section 3.3. The deeper physical reason behind this finding is that for large enough trap aspect ratio a large amount of energy is carried away by the heat diffusion from the region occupied by the condensate and cannot contribute to the interaction anymore. Contrarily to that, the Kerr interaction increases linearly with the trap aspect ratio such that for a large trap anisotropy, which is presumably not achievable in current experiments, the Kerr interaction gives the leading interaction effect. Therefore, we have shown that the effective photon–photon interaction may be increased by more than an order of magnitude compared to the currently available experiments in 2D. We also work out a complementary dimensional crossover scenario, where an additional loosing of the confinement of the second dimension results in a linear growth of the effective 1D interaction constant by more than an order of magnitude. In conclusion, we show that the behaviour of the condensate in the effective 1D limit depends on the details of how the dimensional crossover is performed concretely. 

Acknowledgments 

We thank Antun Balaž, Georg von Freymann, Milan Radonjíc, Julian Schulz, Kirankumar Karkihalli Umesh and Frank Vewinger for insightful discussions. ES and AP acknowledge financial support by the Deutsche Forschungsgemeinschaft (DFG, German Research Foundation) via the Collaborative Research Center SFB/TR185 (Project No. 277625399). 

11 87

Data availability statement 

All data that support the findings of this study are included within the article (and any supplementary files). 

Appendix A. 1D Gross–Pitaevskii equation 

In order to compare the results from the dimensional crossover to the exact 1D scenario, we review in this section the steady state of a one-dimensional Gross–Pitaevskii equation with harmonic trapping potential. Thus, we have to solve 

μψ = 

 −�2∇2 

2m + 

mΩ2 

2 x2 + g1D|ψ|2 

 ψ, (A.1) 

with the corresponding functional 

E1D[ψ,ψ∗] = �2 

2m 

 dx |∂xψ|2 + 

mΩ2 

2 

 dx x2|ψ|2 + 

g1D 

2 

 dx|ψ|4. (A.2) 

In order to obtain an approximate solution, we use a Gaussian ansatz function 

ψ = 

 N√ πlα 

e−x2/(2l2α2), (A.3) 

where l =  �/(mΩ) stands for the oscillator length and α represents the dimensionless variational 

parameter. Inserting ansatz (A.3) in the energy functional (A.2) yields for the energy 

E1D = �Ω 2 

 1 

2α2 + 

α2 

2 + 

g̃1DN√ 2πα 

 , (A.4) 

where we define the dimensionless 1D interaction strength [30, section 15.3.2] 

g̃1D = g1Dml 

�2 . (A.5) 

Extremising (A.4) with respect to the dimensionless width α, we obtain the algebraic equation 

α4 = 1 + Ng̃1D√ 

2π α. (A.6) 

ORCID iDs 

Enrico Stein https://orcid.org/0000-0003-4820-7126 Axel Pelster https://orcid.org/0000-0002-5215-0348 

References 

[1] Bloch I, Dalibard J and Zwerger W 2008 Many-body physics with ultracold gases Rev. Mod. Phys. 80 885 [2] Giamarchi T 2003 Quantum Physics in One Dimension (Oxford: Oxford University Press) [3] Hadzibabic Z, Krüger P, Cheneau M, Battelier B and Dalibard J 2006 Berezinskii–Kosterlitz–Thouless crossover in a trapped 

atomic gas Nature 441 1118 [4] Fletcher R J, Robert-de-Saint-Vincent M, Man J, Navon N, Smith R P, Viebahn K G H and Hadzibabic Z 2015 Connecting 

Berezinskii–Kosterlitz–Thouless and BEC phase transitions by tuning interactions in a trapped gas Phys. Rev. Lett. 114 255302 [5] Christodoulou P, Gałka M, Dogra N, Lopes R, Schmitt J and Hadzibabic Z 2021 Observation of first and second sound in a BKT 

superfluid Nature 594 191 [6] Dettmer S et al 2001 Observation of phase fluctuations in elongated Bose–Einstein condensates Phys. Rev. Lett. 87 160406 [7] Cazalilla M A, Ho A F and Giamarchi T 2006 Interacting Bose gases in quasi-one-dimensional optical lattices New J. Phys. 8 158 [8] Delfino F and Vicari E 2017 Dimensional crossover of Bose–Einstein-condensation phenomena in quantum gases confined 

within slab geometries Phys. Rev. A 96 043623 [9] Vogler A, Labouvie R, Barontini G, Eggert S, Guarrera V and Ott H 2014 Dimensional phase transition from an array of 1D 

Luttinger liquids to a 3D Bose–Einstein condensate Phys. Rev. Lett. 113 215301 [10] Irsigler B and Pelster A 2017 Dimensionally induced one-dimensional to three-dimensional phase transition of the weakly 

interacting ultracold Bose gas Phys. Rev. A 95 043610 [11] Görlitz A et al 2001 Realization of Bose–Einstein condensates in lower dimensions Phys. Rev. Lett. 87 130402 [12] Klaers J, Schmitt J, Vewinger F and Weitz M 2010 Bose–Einstein condensation of photons in an optical microcavity Nature 468 

545 [13] Maruo S, Nakamura O and Kawata S 1997 Three-dimensional microfabrication with two-photon-absorbed photopolymerization 

Opt. Lett. 22 132 

12 88

[14] Deubel M, von Freymann G, Wegener M, Pereira S, Busch K and Soukoulis C M 2004 Direct laser writing of three-dimensional photonic-crystal templates for telecommunications Nat. Mater. 3 444 

[15] Hohmann J K, Renner M, Waller E H and von Freymann G 2015 Three-dimensional μ-printing: an enabling technology Adv. Opt. Mater. 3 1488 

[16] Stein E and Pelster A 2021 Thermodynamics of trapped photon gases at dimensional crossover from 2D to 1D (arXiv:2011.06339) [17] Bagnato V and Kleppner D 1991 Bose–Einstein condensation in low-dimensional traps Phys. Rev. A 44 7439 [18] Ketterle W and van Druten N J 1996 Bose–Einstein condensation of a finite number of particles trapped in one or three 

dimensions Phys. Rev. A 54 656 [19] Yukalov V I 2005 Modified semiclassical approximation for trapped Bose gases Phys. Rev. A 72 033608 [20] Petrov D S, Shlyapnikov G V and Walraven J T M 2000 Regimes of quantum degeneracy in trapped 1D gases Phys. Rev. Lett. 85 

3745 [21] Klaers J, Vewinger F and Weitz M 2010 Thermalization of a two-dimensional photonic gas in a ‘white wall’ photon box Nat. Phys. 

6 512 [22] Stein E, Vewinger F and Pelster A 2019 Collective modes of a photon Bose–Einstein condensate with thermo-optic interaction 

New J. Phys. 21 103044 [23] Klaers J, Schmitt J, Damm T, Vewinger F and Weitz M 2011 Bose–Einstein condensation of paraxial light Appl. Phys. B 105 17 [24] Damm T, Schmitt J, Liang Q, Dung D, Vewinger F, Weitz M and Klaers J 2016 Calorimetry of a Bose–Einstein-condensed photon 

gas Nat. Commun. 7 11340 [25] Salasnich L, Parola A and Reatto L 2002 Effective wave equations for the dynamics of cigar-shaped and disk-shaped Bose 

condensates Phys. Rev. A 65 043614 [26] Kleinert H and Schulte-Frohlinde V 2001 Critical Properties of Φ4 Theories (Singapore: World Scientific) [27] Gradshteyn I S and Ryzhik I M 2007 Table of Integrals, Series, and Products 7th edn (Amsterdam: Elsevier) [28] Vewinger F and von Freymann G 2021 Private communication [29] Hesten H J, Nyman R A and Mintert F 2018 Decondensation in nonequilibrium photonic condensates: when less is more Phys. 

Rev. Lett. 120 040601 [30] Pethick C J and Smith H 2008 Bose–Einstein Condensation in Dilute Gases 2nd edn (Cambridge: Cambridge University Press) 

13 89

## 5. Quantum Mechanical Description of Thermo-Optic Interaction 

What’s in a name? That which we call a rose, By any other name would smell as sweet. 

W. Shakespeare, Romeo and Juliet, Scene 2-2 

The main objective of this study is to develop a Hartree-Fock analogue description of the thermo-optic interaction in order to calculate the shift of the eigenenergies due to this interaction. The experiments determine these shifts by spectroscopic measurements, which allow quantifying the thermo-optic photon-photon interaction strength with a lar-ger accuracy than the current measurements based on observing the width of the photon BEC [70]. Chapter 3 only covers the dimensional crossover for an ideal gas, whereas chapter 4 deals with the photon-photon interaction at the dimensional crossover. The current chapter combines the ideas from these two studies to a description of the photon gas subject to the thermo-optic interaction during a single experimental cycle, as discussed in subsection 1.3.1 and appendix B. As the temperature-diffusion time is several or-ders of magnitude smaller than the photon-condensate lifetime, the diffusion itself does not contribute to the dynamics. Instead, the temperature distribution retains the same shape as that of the entire photon gas at the beginning of the experiment. Thus, the thermo-optic interaction can be seen as an effective potential, the strength of which in-creases linearly in time. The latter increase is also slow compared to the thermalisation dynamics of the photons, c.f., figure 1.13 a), such that it can be treated adiabatically by coarse graining the photon dynamics. As a last approximation, this study also neg-lects the photon thermalisation at the beginning and the photon decay at the end of the experimental cycle. Hence, this theory only covers the thermalised photon gas to-gether with the influence of the thermo-optic interaction and can, therefore, be seen as a Hartree-Fock analogue of thermo-optic interaction. This theory bears two advantages. The first one is its fundamental simplicity. With all the approximations, the problem effectively shrinks to a single-particle Hamiltonian, which depends adiabatically on time, such that it can be diagonalised at every time step. Due to its generic formulation, the versatility of the ansatz is the second advantage. In the cavity photon BEC setup, this means that the theory can easily be adapted to dif-ferent photon potentials, the necessity of which subsection 1.3.5 demonstrates. In the broader view, this theory can in principle be applied to all systems which bear a con-siderable thermo-optic non-linearity. The second part of the paper demonstrates these two advantages. Here, the shifts of the eigenenergies due to the thermo-optic interaction are calculated by using a first-order perturbation theory for both a harmonic and a box potential. 

91

5. Quantum Mechanical Description of Thermo-Optic Interaction 

For this publication, I developed the complete theory and worked out the first-order perturbation theory in the second part of the paper. Moreover, I prepared the manuscript for submission. Currently, the manuscript is under review at New Journal of Physics. 

92

### Quantum Mechanical Description 

### of Thermo-Optic Interaction 

Enrico Stein 

E-mail: estein@rhrk.uni-kl.de 

Department of Physics and Research Center OPTIMAS, Technische Universität 

Kaiserslautern, Erwin-Schrödinger Straße 46, 67663 Kaiserslautern, Germany 

Axel Pelster 

E-mail: axel.pelster@physik.uni-kl.de 

Department of Physics and Research Center OPTIMAS, Technische Universität 

Kaiserslautern, Erwin-Schrödinger Straße 46, 67663 Kaiserslautern, Germany 

26th April 2022 

Abstract. Thermo-optic interaction significantly differs from the usual particle-

particle interactions in physics, as it is retarded in time. A prominent platform 

for realising this kind of interaction are photon Bose-Einstein condensates, which are 

created in dye-filled microcavities. The dye solution continually absorbs and re-emits 

these photons, causing the photon gas to thermalise and to form a Bose-Einstein 

condensate. Because of a non-ideal quantum efficiency, these cycles heat the dye 

solution, creating a medium that provides an effective thermo-optic photon-photon 

interaction. So far, only a mean-field description of this process exists. 

This paper goes beyond by working out a quantum mechanical description of the 

effective thermo-optic photon-photon interaction. To this end, the self-consistent 

modelling of the temperature diffusion builds the backbone of the modelling. 

Furthermore, the manyfold experimental timescales allow for deriving an approximate 

Hamiltonian. The resulting quantum theory is applied in the perturbative regime 

to both a harmonic and a box potential for investigating its prospect for precise 

measurements of the effective photon-photon interaction strength. 

Keywords: Photon Bose–Einstein Condensate, Thermo-Optic Interaction, Dimensional Crossover Submitted to: New J. Phys. 

93

QM Thermo-Optics 2 

1. Introduction 

Ultracold quantum gases usually deal with a contact particle interaction, since in these 

systems only s-wave scattering takes place due to the very low involved energy scales 

[1, 2]. Thus, two particles have to be at the same time at the same place for a scattering 

event to happen. Experiments with dipolar quantum gases loosen the latter restriction. 

Here, also particles at different places can interact with each other via the dipole-dipole 

interaction, which is both anisotropic and slowly decreasing in space [3]. The scope 

of this work, however, lies on thermo-optic interactions, that are both non-local in 

space and retarded in time. Therefore, two particles can interact with each other even 

though they are neither in proximity nor meet at the same time. Photon Bose-Einstein 

condensates (phBEC) provide a well controllable environment for observing this kind of 

unusual interaction. The theoretical description of thermo-optic interaction in phBECs 

is at the very focus of this work. 

Photon Bose-Einstein condensates contain many competing timescales, which are 

schematically summarised in figure 1, (a). A dye-filled microcavity is the main part of 

the experimental setup [4, 5]. The dye molecules set the fastest timescale by absorption 

and re-emission of photons (∼ 1 ps). Since the vibrations of the dye molecules thermalise 

due to surrounding solvent molecules, the photon gas itself thermalises at the molecular 

timescale (∼ 10 ps). Two more timescales determine the condensate lifetime. On the 

one hand, light leaks out of the cavity (∼ 1 ns), and, on the other hand, the duration 

of counteracting external pump pulses is limited by dye bleaching (∼ 500 ns). Finally, 

the heating of the whole experimental setup introduces the slowest timescale (∼ 0.1 

s). This heating stems from electronic excitations of the dye molecules, which are not 

remitted as photons, but are converted into vibronic excitations of the dye molecules. 

The temperature increase, which the incoherent photon absorption processes produce, 

changes the refractive index of the dye solution, ultimately leading to an effective 

thermo-optic photon-photon interaction, see figure 1, (b). Since this temperature 

diffuses through the cavity, the resulting effective photon-photon interaction is non-

local in space and retarded in time. 

Hitherto, former works have only focused on how the effective photon-photon interaction 

influences the phBEC ground state. For instance, the first publication on the 

experimental realisation of phBECs investigates, amongst other things, the effective 

photon-photon interaction by using a Gross-Pitaevskii equation for the modelling [4]. 

Introducing a coupled Schrödinger and temperature-diffusion equation improves the 

model on physical grounds [6]. Here, the Schrödinger equation describes the fast 

evolution of the phBEC ground state, whereas the diffusion equation describes the 

slow dynamics of the temperature. The above-mentioned incoherent photon absorption 

processes steadily produce the latter. This model successfully describes the photon-

photon interaction in the steady state of the temperature diffusion, which follows after 

several pump pulses, see figure 1, (c). Further, this model allows for calculating the 

lowest-lying collective mode frequencies of the condensate [7] as well as its intricate 

94

QM Thermo-Optics 3 

time 

### single experimental cycle 

### experimental sequence 

external pump: 500 ns 

photon population 

thermalisation: 10 ps 

cavity decay: 

1 ns 

temperature decay: 0.1 s 

### a) b) 

### heating 

### ch an 

### gi nge ff 

### e c ti 

### v e  i n 

### te ra 

### c ti 

### o n 

fast 

slow 

### c) 

Figure 1. Timescales and interaction in typical photon BEC experiments. a) 

Timescales in a single experimental cycle. The green line visualises the external pump 

pulse, the grey line the corresponding temporal evolution of the total photon population 

and the red line marks the behaviour of the temperature, which is produced by the 

photons. b) Emergence of the effective photon-photon interaction. Here |ψ|2 stands for 

the photon density, ∆T for the temperature produced by the photons, and ∆n denotes 

the resulting shift of the refractive index. c) Temperature steady state after several 

experimental cycles. The green bars represent single experiments, like in a), and the 

red line indicates the evolution of the temperature between two single experiments. 

behaviour at the dimensional crossover from 2D to 1D [8]. The authors of reference 

[6] succeed in describing the thermo-optic interaction emerging during a single pump 

pulse by applying a heuristic approximation, which relies on the photon timescales being 

much shorter than the temperature diffusion time. 

Current measurements of the effective photon-photon interaction bear several 

disadvantages, as they are based on determining the condensate width. First, this 

approach relies on using the spatial data only, whilst the spectral data is, in principle, 

available at the same time. Utilising instead all experimentally accessible data promises 

to enhance the measurement accuracy for the photon-photon interaction strength. 

Second, these methods only consider the ground mode, which necessitates a large 

condensate fraction. But state-of-the-art experiments are only capable of achieving 

condensate fractions of about 50 %, so the impact of the thermal cloud may not be 

neglected in a theoretical description. Third, the trapping geometry must be known 

well enough to obtain reliable information about the interaction-induced condensate 

broadening. To this end, the current experimental trend of realising more sophisticated 

trapping potentials is advantageous. Standard phBEC experiments use an isotropic 

harmonic potential [4, 5, 6, 9] or double-well potentials [10]. Reference [11] reports 

the realisation of micro-condensates with only a few photons in such setups. Recently, 

experiments have even achieved box potentials for phBECs [12]. 

95

QM Thermo-Optics 4 

The theoretical description presented in this paper paves the way to more precise 

measurements of the effective photon-photon interaction strength, which are based 

on performing a detailed spectrometric analysis of the photon gas. This demands 

to extend the previous mean-field modelling by working out the underlying second-

quantised Hamiltonian of the full photon field coupled to the temperature diffusion. 

A formal elimination of the temperature by its Green’s function leads to a compact 

expression for the resulting phBEC Hamiltonian during a single pump pulse, when 

taking the respective experimental timescales into account. Moreover, abstracting from 

single absorption/re-emission processes coarse grains the evolution during a single pump 

pulse and leads to a thermal photon gas in this description. Therefore, this procedure 

treating the thermo-optic interaction includes the thermal cloud self-consistently and 

corresponds to the usual Hartree-Fock approximation used, e.g., for atomic BECs in 

order to describe the impact of a contact interaction at finite temperature [1, 2]. 

The paper is structured as follows: In section 2 the underlying second-quantised 

Hamiltonian describing the effective thermo-optic photon-photon interaction is 

introduced and simplified according to the respective experimental timescales. Finally, 

section 3 provides a perturbative calculation of the first few eigenenergies subject to 

the thermo-optic interaction and elucidates its perspective for precisely measuring the 

effective photon-photon interaction strength. 

2. Thermo-Optic Hamiltonian 

This section starts with formulating the basis of the quantum mechanical description 

of the thermo-optic interaction. To this end, the modelling considers the dynamics of 

both the second-quantised photon field and the temperature, that is produced by the 

incoherent photon absorption processes. Subsequently, taking the common experimental 

timescales into account provides a simplification of this general formulation with an 

approximate Hamiltonian. 

2.1. Generic Formulation 

The photon field operators Ψ̂(x, t), Ψ̂†(x, t) describe the electric field inside the cavity 

and fulfil the standard bosonic equal-time commutation relations, [ Ψ̂(x, t), Ψ̂(x′, t) 

] = [ Ψ̂†(x, t), Ψ̂†(x′, t) 

] = 0 , 

[ Ψ̂(x, t), Ψ̂†(x′, t) 

] = δ(x− x′) . (1) 

The corresponding second-quantised Hamiltonian includes the energy shift due to the 

temperature ∆T , produced by the photons during the experiment, and reads 

Ĥ(t) = 

∫ d2x Ψ̂†(x, t) 

{ h(x) + γ∆T (x, t) 

} Ψ̂(x, t) . (2) 

Here, 

h(x) = −~2∇2 

2m + V (x) (3) 

96

QM Thermo-Optics 5 

denotes the first-quantised Hamiltonian containing the effective photon mass m and the 

trapping potential V (x), whereas the parameter γ quantifies the energy shift due to the 

thermo-optic effect, see figure 1 (b). 

Conversely, the temperature ∆T (x, t) obeys the diffusion equation 

∂∆T (x, t) 

∂t = 

( D∇2 − 1 

τ 

) ∆T (x, t) +Bn(x, t) . (4) 

Here, D denotes the diffusion coefficient of the solvent medium, τ the longitudinal 

relaxation time, and B the heating coefficient of the dye solution [7]. Furthermore, the 

photon density 

n(x, t) = 〈 

Ψ̂†(x, t)Ψ̂(x, t) 〉 , (5) 

with 〈•〉 denoting the quantum mechanical expectation value, represents the source of 

the temperature ∆T (x, t). 

2.2. Experimental Timescales 

For the sake of simplicity, this work only considers the first pump pulse. Hence, no 

initial temperature distribution is present. Therefore, using the Green’s function 

G(x, t) = 1 

4πDt e −x2/4Dt−t/τ (6) 

allows solving the diffusion equation (4) according to 

∆T (x, t) = τB 

∫ t/τ 

0 

dt′ ∫ d2x′ G(x− x′, t− τt′)n(x′, t′) . (7) 

Here the time integration variable is changed to τt′ with a dimensionless variable t′ 

to explicitly reveal the t/τ dependency. Experimentally, t corresponds to the phBEC 

lifetime and τ denotes the decay time of the temperature difference, cf. figure 1, (a). 

Since these timescales imply the ratio t/τ ∼ 10−6, an expansion up to the first order 

in t/τ yields an accurate approximation for the temperature (7). In particular, the 

Gaussian function in (6) goes over into a Dirac-δ distribution and (7) reduces to 

∆T (x, t) ≈ τB t 

τ n(x, 0) (8) 

As a consequence of this approximation, the details of the Green’s function (6) are 

irrelevant, and only the initial photon density n(x, 0) defined in the density (5) 

determines the spatial temperature profile. 

Inserting the result (8) into the second-quantised Hamiltonian (2) yields 

Ĥ(t) = 

∫ d2x Ψ̂†(x, t) 

{ h(x) + g(t)n(x, 0) 

} Ψ̂(x, t) , (9) 

97

QM Thermo-Optics 6 

with the effective time-dependent thermo-optic interaction strength 

g(t) = tγB . (10) 

Therefore, the thermo-optic interaction behaves like an effective potential, that increases 

linearly in time, rather than like a usual two-particle interaction, which is local in time. 

This is the immediate consequence of the interplay between the slow growth of the 

temperature during a single pump pulse and the fast thermalisation timescale. This 

result bears the main physical difference compared to the standard Hartree-Fock theory 

for a two-particle contact interaction. 

2.3. Adiabatic Treatment 

Since the temperature timescale is by far the slowest, as figure 1, (a) illustrates, treating 

the time dependence of the interaction strength (10) adiabatically is justified [13]. The 

aim is to investigate the instantaneous steady states of the second-quantised Hamiltonian 

(9). To this end, the eigenvalue problem of the first-quantised Hamiltonian (3) 

h(x)ψn(x) = En(0)ψn(x) (11) 

yields a basis of orthonormal eigenmodes ψn(x) with corresponding eigenenergies En(0). 

Here, n is a multi-index denoting all the quantum numbers of the corresponding state. 

This provides an expansion of the field operators 

Ψ̂(x, t) = ∑ 

n 

ân(t)ψn(x) , Ψ̂†(x, t) = ∑ 

n 

â†n(t)ψ∗n(x) . (12) 

Here, the annihilation and creation operators ân(t) and â†n(t) fulfil the canonical bosonic 

commutation relations: [ ân(t), ân′(t) 

] = [ â†n(t), â†n′(t) 

] = 0 , 

[ ân(t), â†n′(t) 

] = δn,n′ . (13) 

As at the beginning of the experiment no interaction is present, the annihilation, and 

creation operators ân(0) and â†n(0) belong to the plain eigenmodes ψn(x) of the first-

quantised Hamiltonian (3). Moreover, since the pump laser determines the polarisation 

of the photon field in the condensed phase [14, 15], only a single photon polarisation is 

present, thus, the annihilation and creation operators do not carry a polarisation index. 

The expansion (12) allows writing the second-quantised Hamiltonian (9) in the form 

Ĥ(t) = ∑ 

nn′ Hn,n′(t)â†n(t)ân′(t) , (14) 

with the Hamiltonian matrix 

Hn,n′(t) = En(0)δn,n′ + g(t)Fn,n′ . (15) 

98

QM Thermo-Optics 7 

The non-diagonal matrix 

Fn,n′ = 

∫ d2x ψ∗n(x)n(x, 0)ψn′(x) (16) 

contains the overlap of two modes n ,n′ with the initial density n(x, 0) and, thus, 

describes the influence of the thermo-optic interaction. Diagonalising the Hamiltonian 

matrix (15) determines the finite-time operators ân(t), â†n(t), which specify the 

instantaneous eigenmodes. 

2.4. Thermal Steady State 

In the following, this work does not include the actual thermalisation dynamics of the 

photons, but instead focuses on the long timescales during a single pump pulse, where 

the influence of the thermo-optic interaction becomes of interest, cf., figure 1, (a). Hence, 

in the following, the photon gas is assumed to be always in a thermal steady state and 

the beginning of the experiment refers to right after the thermalisation. This justifies 

to interpret the quantum mechanical expectation value Nl(t) = 〈â†l(t)âl(t)〉 as the Bose-

Einstein distribution 

Nl(t) = { eβ[El(t)−µ(t)] − 1 

}−1 . (17) 

Here, El(t) denotes the instantaneous eigenenergies of the Hamiltonian matrix (15), 

β = 1/(kBT ) is the inverse temperature, and µ(t) stands for the instantaneous chemical 

potential, which is fixed by the conserved total particle number N = ∑ lNl(t). 

Moreover, in the thermal steady state the density (5) appearing in (9) takes the form 

n(x, t) = ∑ 

l 

Nl(t)|ψl(x)|2 , (18) 

such that the interaction matrix (16) is finally given by 

Fn,n′ = ∑ 

l 

Nl(0) 

∫ d2x ψ∗n(x)|ψl(x)|2ψn′(x) . (19) 

Here only the photon occupation from the beginning of the experiment appears due to 

the temporal retardation of the interaction. 

2.5. Potentials 

The formulation of the second-quantised Hamiltonian matrix (15) is generally valid for 

any trapping potential. For the purpose of illustration the next section focuses in detail 

on two concrete trapping potentials. On the one hand, an isotropic harmonic potential 

of the form 

VHo = ~Ω 

2 

x2 + y2 

l2 (20) 

99

QM Thermo-Optics 8 

is considered, with the trapping frequency Ω and the oscillator length l = √ ~/mΩ. On 

the other hand, also the box potential 

VBox = 

{ 0, 0 ≤ x ≤ L, 0 ≤ y ≤ L 

∞, elsewhere , (21) 

is analysed, where L denotes the width of the box in both directions. 

3. First-Order Perturbation Theory 

Since the photon-photon interaction is small, calculating the first-order in Rayleigh-

Schrödinger perturbation theory offers initial insights into the physics contained in 

the Hamiltonian matrix (15). Note that first-order perturbation theory neglects the 

interaction between different energy subspaces in the interaction matrix (19). 

Although reaching a condensate fraction of more than 50 % is a hard task in 

current phBEC experiments, this section concentrates on the theoretical analysis of 

the deep condensate limit, where the ground-state occupation number N0 coincides 

approximately with the total particle number N , i.e., N0 ≈ N . Hence, the interaction 

matrix (19) reduces to 

Fα,β ≈ N0(0) 

∫ d2x ψα(x)|ψ0(x)|2ψ∗β(x) , (22) 

where, the indices α, β belong to the same energy subspace, such that Eα(0) = Eβ(0). 

Consequently, the instantaneous eigenenergies En(t) have the approximate form 

En(t) ≈ En(0) + g(t)N0E (1)n , (23) 

where E (1)n denotes the first-order correction of the nth eigenenergy. Appendix Appendix 

A summarises the respective details of calculating these corrections, and table 1 lists 

the corresponding results. 

The perturbative calculation aims at the energy differences ∆En,n′(t) = En(t)−En′(t) 

between two different modes. In the considered precision they are given by 

∆En,n′(t) ≈ En(0)− En′(0) + g(t)N0 

[ E (1)n − E (1)n′ 

] . (24) 

Figure 2, (a) shows the corresponding eigenenergies up to the second excited states. 

They are plotted versus the dimensionless interaction strength g̃(t) = mg(t)/~2 [16], 

which depends linearly on time t according to (10). With this choice of the scaling, the 

results presented here are broadly valid for different experimental settings and do not 

depend on the material specific parameters γ and B. In addition, the chosen maximum 

value of 1 for N0g̃(t) corresponds to existing measurements [4]. As a consequence of 

the repulsive thermo-optic interaction, the eigenenergies are generically shifted to larger 

values. Depending on the mode symmetry, the interaction also lifts some degeneracies, 

100

QM Thermo-Optics 9 

Table 1. First-order correction to energy eigenvalues (23) for a) the harmonic 

potential (20) and b) the box potential (21). The multi-index n takes here the form 

n = (nx ny) and the square brackets denote the mode hybridisation due to the thermo-

optic interaction. 

a) 

n l2E (1)n (00) 1/(2π) 

(10) 1/(4π) 

(01) 1/(4π) 

2+ = [(20) + (02)]/ √ 

2 1/(4π) 

(11) 1/(8π) 

2− = [(20)− (02)]/ √ 

2 1/(8π) 

b) 

n L2E (1)n (11) 9/4 

(21) 3/2 

(12) 3/2 

(22) 1 

3+ = [(31) + (13)]/ √ 

2 7/4 

3− = [(31)− (13)]/ √ 

2 5/4 

## a) b) 

Figure 2. First-order perturbative calculation of eigenenergies. a) Absolute 

eigenenergies in the form of (23) as a function of the interaction strength. b) 

Corresponding energy differences to the ground-state energies EHo (00) and EBox 

(11), 

respectively. In both pictures, the solid lines and the left y-axis refer to the harmonic 

potential (20), whereas the dashed lines and the right y-axis correspond to the box 

potential (21). The different mode indices are summarised in table 1. 

for details see table 1. Moreover, the thermo-optic interaction influences the ground 

state most, and is less relevant for higher excited states. Since the effective photon-

photon interaction causes these energy shifts, its strength can be extracted from them. 

Spectroscopic measurements offer experimental access to the energy differences between 

these modes, as depicted in figure 2, (b). 

A comparison of the results from the different potentials shows that in the case of the box 

potential the interaction effects are more dominant, which is due to the much stronger 

confinement of the photon gas. In the harmonic potential the width of the excited states 

increases since for higher excitations the confinement effectively weakens. This leads to 

smaller interaction matrix elements (22) and, hence, to a smaller effective interaction 

strength. In case of the box potential, however, this is not possible due to the Dirichlet 

boundary conditions upon the condensate wave function. 

101

QM Thermo-Optics 10 

First-order perturbation theory yields analytical formulas, that allow determining the 

effective photon-photon interaction. In the harmonic case, the corresponding energy 

difference ∆EHo (10,00) between the first excited and the ground state yields for the effective 

photon-photon interaction strength the formula 

g̃Ho(t) = 4π 

N0 

[ 1− 

∆EHo (10,00)(t) 

~Ω 

] , (25) 

while for the box potential (21) this correspondingly amounts to 

g̃Box(t) = 2π2 

3N0 

[ 3− 

∆EBox (21,11)(t) 

EBox 

] , (26) 

with the 1D ground-state energy EBox = π2~2/(2mL2). Similar formulas can be derived 

for other combinations of the energy eigenstates. 

Thus, equations (25) and (26) offer the prospect for spectroscopically determining the 

effective photon-photon interaction strength with a higher precision than in previous 

measurements, which were based on detecting the condensate width [4]. For instance, 

interfering two cavity eigenmodes results in a beating signal, the frequency of which 

corresponds to the energy difference (24) of the involved modes. 

4. Summary and Outlook 

The theory presented in this work is crucial for understanding and precisely quantifying 

the effective photon-photon interaction strength in current and future phBEC 

experiments. The second-quantised Hamiltonian (9) represents the backbone of this 

theory. It describes the impact of the thermo-optic photon-photon interaction emerging 

during a single pump pulse. The experimental timescales allow treating the thermo-

optic photon-photon interaction adiabatically, yielding a matrix formulation (15) of 

the Hamiltonian (9). With this, it is possible to predict the shifts of the photon 

eigenenergies, which allow a precise spectroscopic measurement of the emerging photon-

photon interaction. 

The Hamiltonian matrix (15) also contains information about the excited states, which 

permits calculating the impact of the thermal cloud on the measurement. However, 

this impact is only relevant in case of an increased effective photon-photon interaction, 

as it may occur at the dimensional crossover [8]. Due to the increased photon-photon 

interaction, a perturbative approach like the one used in section 3 is no longer valid. 

Therefore, in such a situation, Exact Diagonalisation turns out to be a necessary tool 

for analysing the Hamiltonian matrix (15) [17]. 

Acknowledgments 

We thank Antun Balaž, Georg von Freymann, Milan Radonjić, Julian Schulz, 

Kirankumar Karkihalli Umesh, and Frank Vewinger for insightful discussions. ES 

102

QM Thermo-Optics 11 

and AP acknowledge financial support by the Deutsche Forschungsgemeinschaft (DFG, 

German Research Foundation) via the Collaborative Research Center SFB/TR185 

(Project No. 277625399). 

Appendix A. Perturbation Theory 

This appendix deals with the calculation of perturbative results used in section 3. 

Appendix A.1. Harmonic Oscillator 

The eigenenergies of the harmonic potential (20) read 

En(0) = ~Ω (nx + ny + 1) (A.1) 

and the corresponding eigenfunctions are the Gauß-Hermite functions 

ψn(x) = 

√ 1 

2nx+nynx!ny!πl2 Hnx 

(x l 

) Hny 

(y l 

) e−(x 

2+y2)/(2l2) , (A.2) 

where Hn(x) denote the Hermite polynomials. The eigenfunctions (A.2) give rise to the 

simplified interaction matrix (22) up to the third energy subspace 

FHo = N(00) 

πl2 

  

1/2 0 0 −1/(4 √ 

2) 0 −1/(4 √ 

2) 

0 1/4 0 0 0 0 

0 0 1/4 0 0 0 

−1/(4 √ 

2) 0 0 3/16 0 1/16 

0 0 0 0 1/8 0 

−1/(4 √ 

2) 0 0 1/16 0 3/16 

  , (A.3) 

where the modes are ordered with respect to their vectorised mode indices, c.f., table 

A1, (a). Calculating the first-order corrections to the energies amounts to neglecting 

the interaction between different energy subspaces, i.e., neglecting the coupling between 

ground state and second excited state in (A.3). The resulting eigenvalues E (1)n are shown 

in table 1. 

Appendix A.2. Box Potential 

The eigenenergies of the box potential (21) are given by 

En(0) = EBox 

( n2 x + n2 

y 

) , (A.4) 

with the 1D ground-state energy EBox = π2~2/(2mL2) and the eigenfunctions read 

ψn(x) = 2 

L sin (nxπx 

L 

) sin (nyπy 

L 

) . (A.5) 

This yields for the simplified interaction matrix (22) 

103

QM Thermo-Optics 12 

Table A1. Index ordering a) for harmonic potential (20) and b) for box potential 

(21) in the corresponding Hamiltonian matrix. 

a) 

n Vectorised index 

(00) 1 

(10) 2 

(01) 3 

(20) 4 

(11) 5 

(02) 6 

b) 

n Vectorised index 

(11) 1 

(21) 2 

(12) 3 

(22) 4 

(31) 5 

(13) 6 

FBox = N(11) 

L2 

  

9/4 0 0 0 −3/4 −3/4 

0 3/2 0 0 0 0 

0 0 3/2 0 0 0 

0 0 0 1 0 0 

−3/4 0 0 0 3/2 1/4 

−3/4 0 0 0 1/4 3/2 

  , (A.6) 

which is treated as the corresponding one for the harmonic potential (A.3). 

References 

[1] C.J. Pethick and H. Smith. Bose–Einstein condensation in dilute gases. Cambridge University 

Press, 2008. 

[2] L. Pitaevskii and S. Stringari. Bose-Einstein condensation and superfluidity. Oxford University 

Press, 2016. 

[3] T. Lahaye, C. Menotti, L. Santos, M. Lewenstein, and T. Pfau. The physics of dipolar bosonic 

quantum gases. Reports on Progress in Physics, 72:126401, 2009. 

[4] J. Klaers, J. Schmitt, F. Vewinger, and M. Weitz. Bose–Einstein condensation of photons in an 

optical microcavity. Nature, 468:545, 2010. 

[5] J. Klaers, J. Schmitt, T. Damm, F. Vewinger, and M. Weitz. Bose–Einstein condensation of 

paraxial light. Appl. Phys. B, 105:17, 2011. 

[6] D. Dung, C. Kurtscheid, T. Damm, J. Schmitt, F. Vewinger, M. Weitz, and J. Klaers. Variable 

potentials for thermalized light and coupled condensates. Nat. Phot., 11:565, 2017. 

[7] E. Stein, F. Vewinger, and A. Pelster. Collective modes of a photon Bose–Einstein condensate 

with thermo-optic interaction. New J. Phys., 21:103044, 2019. 

[8] E. Stein and A. Pelster. Photon BEC with Thermo-Optic Interaction at Dimensional Crossover. 

New J. Phys., 24:023032, 2022. 

[9] S. Greveling, K. L. Perrier, and D. van Oosten. Density distribution of a Bose-Einstein condensate 

of photons in a dye-filled microcavity. Phys. Rev. A, 98:013810, 2018. 

[10] C. Kurtscheid, D. Dung, E. Busley, F. Vewinger, A. Rosch, and M. Weitz. Thermally condensing 

photons into a coherently split state of light. Science, 366:894, 2019. 

[11] B. T. Walker, L. C. Flatten, H. J. Hesten, F. Mintert, D. Hunger, A. A. P. Trichet, J. M. Smith, 

and R. A. Nyman. Driven-dissipative non-equilibrium Bose–Einstein condensation of less than 

ten photons. Nature Phys., 14:1173, 2018. 

104

QM Thermo-Optics 13 

[12] E. Busley, L. Espert Miranda, A. Redmann, C. Kurtscheid, K. Karkihalli Umesh, F. Vewinger, 

M. Weitz, and J. Schmitt. Compressibility and the Equation of State of an Optical Quantum 

Gas in a Box. Science, 375:1403, 2022. 

[13] J.J. Sakurai and J. Napolitano. Modern Quantum Mechanics. Cambridge University Press, 2021. 

[14] R. I. Moodie, P. Kirton, and J. Keeling. Polarization dynamics in a photon Bose-Einstein 

condensate. Phys. Rev. A, 96:043844, 2017. 

[15] S. Greveling, F. van der Laan, H. C. Jagers, and D. van Oosten. Polarization of a Bose-Einstein 

Condensate of Photons in a Dye-Filled Microcavity. arXiv: 1712.08426, 2017. 

[16] I. Bloch, J. Dalibard, and W. Zwerger. Many-body physics with ultracold gases. Rev. Mod. Phys., 

80:885, 2008. 

[17] E. Stein and A. Pelster. Exact Diagonalisation of Photon Bose-Einstein Condensates with Thermo-

Optic Interaction. arXiv: 2204.08818, 2022. 

105

## 6. Exact Diagonalisation of Photon Bose-Einstein Condensates with Thermo-Optic Interaction 

Gather ye rosebuds while ye may, Old Time is still a-flying; And this same flower that smiles today, Tomorrow will be dying. 

Robert Herrick To the Virgins ll. 1-4 

Equipped with the fundamental theory worked out in chapter 5, this chapter applies this theory to a harmonic trapping potential. The main focus lies on numerically determining the new photon eigenstates subject to thermo-optic interaction via exact diagonalisation. This allows to determine the shift of the photon eigenenergies due to the thermo-optic interaction in view of spectroscopically measuring its strength. The first part of the paper reproduces results which have been previously derived by us-ing different methods, like a variational ansatz, see chapters 2 and 4 as well as reference [104]. The current method supersedes and extends these methods, as it includes the thermal cloud and is, thus, capable of describing finite temperatures. However, it turns out that in the thermal phase no sign of the thermo-optic interaction can be found, as here the ground-state occupation is too small to considerably change the eigenstates. Moreover, not even the thermodynamics changes in the deeply condensed limit. A com-parison of the Bose-Einstein distribution at the beginning of the experiment, where no interaction is present, with the one at the end of the experiment, where the thermo-optic interaction has developed, reveals this finding. Therefore, this study justifies the ideal Bose gas assumption of chapter 3 and explains the results of experiment [116]. Finally, it turns out that the quantum mechanical description of the thermo-optic in-teraction gets relevant at the dimensional crossover from 2D to 1D. Chapter 4 already shows the increase of the thermo-optic interaction strength with larger trap anisotrop-ies due to an increased photon density at the trap centre. The same effect also occurs in the quantum description. For large trap anisotropies, i.e., enhanced photon-photon interaction strengths, the exact diagonalisation results in a larger condensate width than a corresponding variational ansatz predicts. Hence, experimentally measuring the photon-photon interaction strength at the dimensional crossover necessitates to consider the thermal cloud, as a theory which only studies the photon BEC ground state overes-timates the interaction strength. 

For this study, I applied the theory from chapter 5 to the special case of a harmonic confining potential and implemented the exact diagonalisation algorithm. I have also carried out and analysed the necessary simulations and wrote the manuscript. The latter is currently under review at New Journal of Physics. 

107

6. Exact Diagonalisation of Photon Bose-Einstein Condensates with Thermo-Optic Interaction 

108

### Exact Diagonalisation of Photon Bose-Einstein 

### Condensates 

### with Thermo-Optic Interaction 

Enrico Stein 

E-mail: estein@rhrk.uni-kl.de 

Department of Physics and Research Center OPTIMAS, Technische Universität 

Kaiserslautern, Erwin-Schrödinger Straße 46, 67663 Kaiserslautern, Germany 

Axel Pelster 

E-mail: axel.pelster@physik.uni-kl.de 

Department of Physics and Research Center OPTIMAS, Technische Universität 

Kaiserslautern, Erwin-Schrödinger Straße 46, 67663 Kaiserslautern, Germany 

26th April 2022 

Abstract. Although photon Bose-Einstein condensates have already been used for 

studying many interesting effects, the precise role of the photon-photon interaction is 

not fully clarified up to now. In view of this, it is advantageous that these systems allow 

measuring both the intensity of the light leaking out of the cavity and its spectrum at 

the same time. Therefore, the photon-photon interaction strength can be determined 

once via analysing the condensate broadening and once via examining the interaction-

induced modifications of the cavity modes. As the former method depends crucially 

on the concrete shape of the trapping potential and the spatial resolution of the used 

camera, interferometric methods promise more precise measurements. 

To this end, the present paper works out the impact of the photon-photon interaction 

upon the cavity modes. A quantum mechanical description of the photon-photon 

interaction, including the thermal cloud, builds the theoretical backbone of the method. 

An exact diagonalisation approach introduced here exposes how the effective photon-

photon interaction modifies both the spectrum and the width of the photon gas. 

A comparison with a variational approach based on the Gross-Pitaevskii equation 

quantifies the contribution of the thermal cloud in the respective applications. 

Keywords: Photon Bose–Einstein Condensate, Thermo-Optic Interaction, Dimensional Crossover Submitted to: New J. Phys. 

109

Exact Diagonalisation of phBECs 2 

### non-linear medium 

### virtual electron-positon 

### pairs 

### K e rr 

###  i n 

### te ra 

### c ti 

### o n 

### a) b) 

Figure 1. Possible photon-photon interaction processes. a) Interaction vertex in 

vacuum. Two incoming photons produce a virtual electron-positron pair, which 

recombines again. b) Photons in non-linear media, here represented via their 

density |ψ|2, interact with the non-linear medium. This effectively introduces a Kerr 

interaction between two photons via changes of the refractive index ∆n. 

1. Introduction 

Observing photon-photon interactions is a demanding task. Classical electrodynamics 

considers light as a linear phenomenon, such that two crossing light beams only interfere 

with each other, but do not scatter. However, the advent of quantum electrodynamics 

changed this view, since in this theory electromagnetic fields can polarise the vacuum. 

Halpern was the first to express the idea of light-by-light scattering within the Dirac 

theory of electrons and positrons [1]. Afterwards, references [2] and [3] formalised the 

idea already to the modern picture, as figure 1 (a) portrays it. Here, two photons 

interact by polarising the vacuum via the production of a virtual electron-positron 

pair. The pair then recombines back into two photons with different wave vectors. 

Subsequently, reference [4] works out the corresponding modification of the Maxwell 

equations in vacuum, which is nowadays referred to as the Euler-Heisenberg Lagrangian. 

However, the authors of reference [4] point out, that this only works with photons in the 

Röntgen- or gamma-ray regime, since the energy needs to be high enough for supporting 

the electron-positron pair creation. The later works [5, 6] support these findings by 

applying the more modern S-matrix apparatus. Since this process appears in fourth-

order perturbation theory, the cross-section for this kind of photon-photon interaction 

is proportional to the fourth power of Sommerfeld’s constant. Therefore, only particle 

accelerators allow access to this kind of processes. In 2017 the ATLAS experiment at 

the Large Hadron Collider was able to observe light-by-light scattering in vacuum for 

the first time [7]. 

Embedding photons in non-linear materials increases the photon-photon interaction 

significantly. One prominent example for such a non-linear process is the Kerr effect 

110

Exact Diagonalisation of phBECs 3 

### a) b) 

Figure 2. Photon-photon interaction in photon BEC setups. a) Mechanism of thermo-

optic interaction. The photon density |ψ|2 heats the medium to a temperature ∆T . 

This shifts the refractive index by ∆n, which effectively introduces a photon-photon 

interaction. b) Timescales of thermo-optic interaction. The timescales of the photon 

population and the external pump pulse are the fastest timescales, whereas the scale 

of the temperature diffusion is the slowest one. 

[8], see figure 1 (b). Here, the refractive index of the material changes with the photon 

density, leading to effects like the self-focusing of a light beam or the existence of optical 

solitons. Such experiments are performed in effectively two-dimensional setups. This 

is remnant from light propagation in, e.g., glass cylinders, where the coordinate along 

the optical axis, due to the paraxial approximation, acts as the time coordinate and 

the remaining two dimensions as true spatial dimensions [9, 10]. A second possibility 

relies on confining the light together with the non-linear medium inside a cavity. As the 

cavity mirrors impose Dirichlet boundary conditions upon the light field, a standing wave 

emerges along the optical axis, freezing out the motion along this direction. However, 

the used photons are usually prepared in a dissipative state, as light leaks out of the 

apparatus and has to be reinjected by an external light source for achieving a steady 

state. 

However, filling a microcavity with a dye solution offers the possibility to create light 

in a steady state, which resembles thermal equilibrium [11, 12]. In these systems, also 

a small effective photon-photon interaction emerges, which does not stem from a Kerr 

effect but from a thermal non-linearity, the mechanism of which figure 2 (a) sketches. 

This originates from a heating of the dye molecules, which do not emit back all absorbed 

photons into the photon gas, but instead convert them into vibronic excitations. As a 

consequence, the dye solution heats up, changing its refractive index. As the heat 

diffuses through the experimental setup, the resulting effective thermo-optic photon-

photon interaction is non-local in space and retarded in time, which represents the main 

difference to the photon-photon interactions sketched in figure 1. Since the temporal 

retardation is large compared to the remaining experimental timescales, see figure 2 (b), 

the thermo-optic photon-photon interaction effectively corresponds to a potential, which 

111

Exact Diagonalisation of phBECs 4 

increases linearly in time [13, 14]. As the thermo-optic interaction turns out to be weak, 

only the photon BEC (phBEC) regime allows determining its strength by measuring the 

condensate width [11]. However, due to the smallness of the effective photon-photon 

interaction, this method lacks of precision. 

Instead, spectroscopic measurements promise an increased precision by measuring the 

small energy shifts, which the thermo-optic photon-photon interaction induces during 

a single pump pulse. The basis of the theoretical description of this thermo-optic 

interaction is a detailed model for the diffusion of the temperature produced in a 

single pump pulse. As the temperature slowly builds up, an adiabatic approximation 

of the corresponding quantum mechanical modelling grants access to the instantaneous 

eigenvalues. This allows determining the effective photon-photon interaction strength 

from the energy difference between two eigenmodes. Whilst reference [14] works out the 

corresponding basic theory and applies first-order perturbation theory for deriving some 

initial results, this paper goes beyond and works out in detail both the energy shifts 

and the condensate broadening by applying exact diagonalisation (ED) [15]. 

The ED of the underlying second-quantised Hamiltonian represents a powerful method 

in case of increased effective photon-photon interactions. For instance, reference [16] 

predicts this situation at the dimensional crossover from 2D to 1D, where a significant 

trap anisotropy enhances the photon-photon interaction via an increased photon density. 

Experimentally, microstructured mirrors provide such anisotropic traps [17, 18, 19]. 

However, the thermal cloud leads to a stronger increase of the condensate width and 

to a possible overestimation of the effective photon-photon interaction, provided the 

theoretical modelling only considers the phBEC ground state. To avoid this, the 

ED method combines the investigation of the thermodynamic behaviour of the non-

interacting phBEC [20] with the influence of the thermo-optic interaction upon the 

phBEC ground state at the dimensional crossover [16]. 

The present paper is structured as follows: Section 2 starts with a short summary of 

the underlying second-quantised Hamiltonian and uses ED for working out the new 

eigenmodes of the harmonically trapped photon gas. Moreover, the corresponding 

condensate width is compared to former results and special attention lies on the 

temperature dependence of both the eigenenergies and the width of the photon 

gas. Subsequently, section 3 deals with the dimensional crossover and presents the 

corresponding results. Section 4 summarises the main findings of the paper. 

2. Exact Diagonalisation of Harmonic Potential 

This section provides a concise introduction to the model used for describing the thermo-

optic interaction, which is based on reference [13] and worked out more rigorously in 

the preceding paper [14]. Afterwards, ED serves as a method for benchmarking both 

the perturbative results on the energy spectrum derived in [14] and the variational 

approach performed in [13]. The last part of this section goes beyond these findings 

and investigates the impact of finite temperatures on both the energy spectrum and the 

112

Exact Diagonalisation of phBECs 5 

cloud width. 

2.1. Model 

As the phBEC itself varies on timescales, which are much faster than the produced 

temperature, see figure 2 (b), reference [14] breaks down the quantum mechanical 

description of the thermo-optic interaction to an effective potential, which increases 

linearly in time. Hence, the second-quantised Hamiltonian, 

Ĥ(t) = ∑ 

nn′ Hn,n′(t)â†n(t)ân′(t) , (1) 

bears an adiabatic time dependency introduced by the temporal retardation of 

the thermo-optic photon-photon interaction. The bosonic creation and annihilation 

operators â†n(t), ân′(t) belong to the instantaneous eigenmodes of the Hamiltonian (1). 

The Hamiltonian matrix in (1) has the form 

Hn,n′(t) = En(0)δn,n′ + g(t)Fn,n′ , (2) 

with the effective time-dependent thermo-optic interaction strength g(t) increasing 

linearly in time [14]. At the beginning of the experiment, i.e., at t = 0, no interaction is 

present, yielding the initial value g(0) = 0. The corresponding eigenvalue problem leads 

to the eigenenergies En(0) and the eigenfunctions ψn(x). Furthermore, the non-diagonal 

matrix 

Fn,n′ = ∑ 

l 

Nl(0) 

∫ d2x ψ∗n(x)|ψl(x)|2ψn′(x) (3) 

contains the information about the thermo-optic interaction. It uses the mode 

occupation in the form of a Bose-Einstein distribution at the beginning of the 

experiment, which stems from the temporal retardation of the thermo-optic interaction: 

Nl(0) = { eβ[El(0)−µ(0)] − 1 

}−1 . (4) 

Here β = 1/(kBT ) denotes the inverse temperature and µ(0) represents the initial 

chemical potential, which is fixed by the conserved total particle number N =∑ l〈a†l(t)al(t)〉. 

2.2. Harmonic Potential 

This paper specialises to a harmonic trapping potential of the form 

V (x) = mΩ2 

x 

2 

( x2 + λ4y2 

) , (5) 

with the effective photon mass m and the trapping frequency Ωx in x-direction. The 

trap-aspect ratio λ = √ 

Ωy/Ωx determines the trapping frequency Ωy in y-direction. 

Therefore, the eigenenergies take the form 

En(0) = ~Ωx 

[ nx + λ2ny + (1 + λ2)/2 

] . (6) 

113

Exact Diagonalisation of phBECs 6 

Furthermore, the Gauß-Hermite functions 

ψn(x) = 

√ 1 

2nx+nynx!ny!πlxly Hnx 

( x 

lx 

) Hny 

( y 

ly 

) e−x 

2/(2l2x)−y2/(2l2y) (7) 

determine the eigenfunctions of the second-quantised Hamiltonian (1) and the 

corresponding Hamiltonian matrix (2), where li = √ ~/(mΩi), i = x, y, denote the 

oscillator lengths in both directions and Hn are the Hermite polynomials. 

This paper numerically determines the new eigenmodes of the Hamiltonian matrix (2) 

with the potential (5) by applying exact diagonalisation. As this method necessitates 

using a finite number of Gauß-Hermite eigenmodes (7), the sixty lowest energy 

subspaces are included. This ensures in the Bose-Einstein condensed regime, that the 

relative occupation of higher excited states is negligible. With this finite number of 

modes, the interaction matrix (3) is constructed for a given total particle number N 

and thermodynamic temperature T . Hence, the presented method not only verifies 

previously published calculations relying on different methods, but also reveals possible 

deviations from the latter. To be specific, this section focuses on the isotropic case, i.e., 

λ = 1. 

2.3. Spectrum 

This paragraph presents the results for the adiabatic time-dependent energy eigenvalues 

En(t) of the Hamilton matrix (2) for the potential (5). Figure 3 (a) compares the 

eigenenergies obtained by the ED method with the results of first-order perturbation 

theory from the preceding paper [14]. It plots the eigenenergies as a function of 

the dimensionless interaction strength g̃(t) = mg(t)/~2, the magnitude of which is 

determined by the duration of the external pump beam. The results of both approaches 

agree well and, thus, the same observation holds for the corresponding energy differences 

shown in figure 3 (b). However, for larger interaction strengths, a slight deviation 

of up to 10−3 between the ED results and the first-order perturbation theory [14] 

becomes visible in figure 3 (c). Hence, the perturbation theory derived in [14] yields 

a good approximation in this regime of parameters. Therefore, the corresponding 

formulas, which analytically express the photon-photon interaction strength via the 

energy differences, are precise enough for being applied to spectroscopic measurements. 

2.4. Condensate Width 

The new eigenstates also show a broadening of the photon gas. The unitary matrix 

Un,m(t), which rotates into the instantaneous eigenbasis of the Hamiltonian matrix (2), 

defines creation and annihilation operators ân(t), â†n(t) at a given time t: 

ân(t) = ∑ 

l 

Un,l(t)âl(0), â†n(t) = ∑ 

l 

U †n,l(t)â † l(0). (8) 

114

Exact Diagonalisation of phBECs 7 

## a) b) 

## c) 

Figure 3. a) First few eigenenergies of the second-quantised Hamiltonian matrix 

(2). The dots stand for the results of the ED, whereas the lines represent the first-

order perturbative results from reference [14]. b) Corresponding energy differences 

∆En,n′ = En − En′ . c) Relative deviation of energy differences once calculated 

by the perturbation theory and once by the ED method. In all plots, the indices 

2± = [(20)± (02)]/ √ 

2 denote the mode hybridisation due to the interaction. 

With these at hand, the total photon density, 

n(x, t) = ∑ 

l 

Nl(t)nl(x, t), (9) 

is expressed in terms of the instantaneous eigenstate occupations, 

Nl(t) = { eβ[El(t)−µ(t)] − 1 

}−1 , (10) 

and the corresponding eigenstate density, 

nl(x, t) = ∑ 

n,m 

U †l,n(t)ψ∗n(x)ψm(x)Um,l(t) . (11) 

Therefore, the total width σx of the photon gas is defined by the FWHM 

σx(t) = √ 

2 〈x2〉 (t) . (12) 

115

Exact Diagonalisation of phBECs 8 

0.0 0.2 0.4 0.6 0.8 1.0 N0g 

1.00 

1.01 

1.02 

1.03 

1.04 x/ 

l x 

0.0 0.2 0.4 0.6 0.8 1.0 N0g 

0 

2 

4 

Re l. 

de v. 

 × 10 

4 

Figure 4. Comparison of the resulting condensate width σx from the ED of the 

Hamiltonian matrix (2) (dots) with the variational approach from appendix Appendix 

A (solid line). The inset shows the relative deviation between both results. 

Here, the second moment of the density distribution 

〈 x2 〉 

(t) = 

∫ d2x x2n(x, t)∫ d2x n(x, t) 

(13) 

with the adiabatic time-dependent photon density (9), takes the form 

〈 x2 〉 

(t) = ∑ 

l 

Nl(t) 

N 

〈 x2 〉 l (t) , (14) 

with the adiabatic time-dependent matrix elements 

〈 x2 〉 l (t) = 

∫ d2x x2nl(x, t) . (15) 

Older calculations and measurements [11, 13] consider the deep condensate limit N0(t) ≈ N . In this case, (12) reduces to the width of the ground state, i.e., σx(t) ≈ 

√ 2 〈x2〉0 (t). 

Appendix Appendix A reproduces the corresponding variational calculation of the 

photon-condensate width, which was first given in reference [13]. Figure 4 compares the 

results for the condensate width, calculated via ED and via the variational approach 

from Appendix Appendix A. As the results agree well, the ED method developed here is 

found to be able to reliably reproduce the former theoretical and experimental results. 

However, a closer look at the inset in figure 4 for larger effective interaction strengths 

reveals that the results tend to deviate for larger effective photon-photon interaction 

strengths. Since the width calculated from the ED is larger than the corresponding 

width from the variational approach, this deviation stems from an increased coupling 

to the thermal cloud. Thus, the larger the photon-photon interaction strength is, the 

ground-state-only description is less accurate. 

116

Exact Diagonalisation of phBECs 9 

Figure 5. a) Temperature dependence of the first few energy eigenvalues of the 

Hamiltonian matrix (2). b) Corresponding energy differences. The dots denote the 

results from the ED and the black lines are the corresponding a) energy eigenvalues and 

b) energy differences without the interaction, i.e., at the beginning of the experiment. 

Both plots are for total particle number N = 104 and interaction strength g̃ = 10−4. 

0 10 20 30 40 50 60 En(t)/ x 

10 4 

10 3 

10 2 

10 1 

100 

N l(t 

)/ N 

1 2 3 4 En(t)/ x 

10 2 

10 1 

N l(t 

)/ N 

Figure 6. Photon occupation Nl(t) of the different states relative to the total 

photon number N = 104 in the Bose-Einstein condensed regime characterised by the 

condensate fraction N0/N ≈ 0.9. The dots (crosses) indicate the photon occupation 

without (with) interaction at the beginning (end) of the experiment. The inset 

shows the details for the lowest-lying states. The maximal interaction strength is 

g̃(tend) = 10−4. 

2.5. Thermal Cloud 

Previous investigations of the effective photon-photon interaction only consider the zero-

temperature limit. This section, however, deals with the effects of finite temperature, 

which the Hamiltonian matrix (2) naturally includes. At the beginning of the 

experiment, the thermo-optic interaction is not present, and the phBEC behaves as an 

117

Exact Diagonalisation of phBECs 10 

10 2 10 1 100 101 

T/Tc 

1 

2 

3 

4 

5 

6 x/ 

l x 

10 2 10 1 

T/Tc 

1.0 

1.2 

1.4 

1.6 

x/ l x 

Figure 7. Total width of the photon gas at the beginning of the experiment (blue) and 

at the end of the experiment (orange), as well as the width of the ground state with 

interaction (green). The black line indicates the oscillator length, which is also the 

width of the ground state without interaction. The drawn lines are guides to the eye. 

The calculation uses the total particle number N = 104 and the maximal interaction 

strength g̃(tend) = 10−4. 

ideal Bose gas in 2D [20]. As the photon-photon interaction strength increases along the 

duration of an experiment, this section aims at describing the influence of the thermal 

cloud upon the phBEC properties. 

First, the focus lies on the temperature dependence of the energy eigenvalues, which 

figure 5 (a) shows. In the thermal regime, the energies undergo a small shift due to 

the interaction, whereas in the condensed regime, i.e., for T < Tc, a more significant 

shift builds up. This is due to the small ground-state occupation in the thermal phase. 

Since the coupling to the ground state is always the largest, significant energy shifts 

only occur in the condensed regime, as figure 5 (a) clearly indicates. Experiments can 

validate this finding by measuring the differences between the energy levels, which are 

plotted in figure 5 (b). 

The time-dependent shifts of the energy eigenstates El(t) also affect the Bose-Einstein 

distribution (10) of the photons. Figure 6 compares the photon number distribution (10) 

at the beginning (dots) and at the end of the experiment (crosses). The horizontal shift 

of the occupation numbers at the end of the experiment indicates interaction-induced 

shifts of the eigenenergies. The occupation numbers themselves, however, undergo only 

minor modifications due to the smallness of the interaction. 

Finally, the ED also allows calculating the width (12) of the total photon gas, which 

figure 7 depicts. In the zero-temperature limit, the width of the photon gas approaches 

the ground-state width. At the beginning of the experiment, where no interaction is 

118

Exact Diagonalisation of phBECs 11 

present, this width corresponds to the oscillator length, whereas during an experimental 

run the ground-state width increases and so the width of the total gas increases with 

the photon-photon interaction. In the thermal regime, however, the interaction does 

not lead to a noticeable change of the photon-gas width. This finding coincides with the 

observations above, showing only very small shifts in the energy levels in the thermal 

regime. The saturation of the width, which occurs for large temperatures, is a remnant 

from the finite number of considered eigenmodes. 

3. Dimensional Crossover 

With the development of new experimental techniques for micro-structuring the cavity 

mirrors [17, 18, 19], also large trap anisotropies for phBECs can be manufactured. 

Therefore, these techniques allow realising a dimensional crossover from 2D to 1D. 

In this case, the ED method turns out to be essential, since reference [16] predicts 

a considerable enhancement of the effective photon-photon interaction strength. 

The beginning of the section maps the 2D gas in a strong anisotropic trap onto a 1D gas, 

which determines the effective 1D interaction strength. The latter turns out to depend 

on the trap-aspect ratio λ. With this at hand, the effective 1D energy spectrum is 

calculated on the one hand numerically and on the other hand approximated analytically. 

The latter grants access to an approximation formula determining the effective photon-

photon interaction strength from the differences of the eigenenergies in the quasi-1D 

limit. Finally, the calculation of the condensate width in the quasi-1D limit shows the 

significance of the ED method, as the width turns out to deviate from the variational 

approach presented in [13], which is recovered in Appendix Appendix A. 

3.1. Effective 1D Interaction Strength 

Reference [20] demonstrates that for trap-aspect ratios larger than a critical value λ1D the squeezed direction freezes out in its ground state and that the systems behaves 

effectively quasi one-dimensional. In addition, the density in the frozen out direction 

alters the bare 2D interaction strength g̃ [16]. The resulting effective quasi one-

dimensional interaction strength g̃1D(λ) turns out to be a function of the trap-aspect 

ratio λ. 

The current paper uses the same reasoning for a single pump pulse, which reference [16] 

applies to the steady state after several pump pulses. According to definition (5) an 

increasing trap-aspect ratio squeezes the y-direction and, so, in the quasi-1D case the 

photons only populate the ground mode in this direction. This suggests the factorisation 

ψn(x) = χnx(x)ϕ0(y;λ) (16) 

119

Exact Diagonalisation of phBECs 12 

for the Gauß-Hermite eigenmodes of the potential (5). Therefore, the interaction matrix 

(3) reduces to 

Fnx,n′ x 

= w(λ) ∑ 

lx 

N(lx,0) 

∫ dx χ∗nx 

(x)|χlx(x)|2χn′ x (x) , (17) 

where the weight 

w(λ) = 

∫ dy |ϕ0(y;λ)|4 (18) 

incorporates the influence of the squeezed direction and, thus, depends on the trap-

aspect ratio λ. In the real 1D case, however, the structure of the Hamiltonian matrix 

(2) remains the same; only the multi-indices turn into single indices. Hence, the 

identification 

g̃1D(t;λ) = g̃(t)w(λ) (19) 

of an effective 1D interaction strength allows a mapping of the matrix (3) onto the real 

1D case. The explicit calculation of the weight (18) for the harmonic potential (5) leads 

to 

g̃1D(t;λ) = g̃(t)λ√ 

2π . (20) 

The effective 1D interaction (20) agrees with the corresponding result for the contact 

Kerr interaction obtained in reference [16], but not with the similar one for the thermo-

optic interaction, although the current work considers only the latter. The reason is the 

used short-time approximation in (1). Due to this, the matrix elements (3) effectively 

resemble the corresponding ones for a contact interaction. Reference [16] investigates 

the steady state after several pump pulses, such that the temperature diffusion has a 

significant impact on the behaviour. In the current work, however, this does not happen 

due to the short-time approximation. 

3.2. Energy Spectrum 

As the effective 1D interaction (20) increases along the dimensional crossover, the 

deviations observed in the previous sections become significantly large and both the 

perturbative and the variational calculation are no longer valid in the case λ  1. 

Figure 8 illustrates this finding. In figure 8 (a) the new eigenenergies are plotted 

with respect to the non-interacting ground-state energy E0 = ~Ωx(1 + λ2)/2 at the 

dimensional crossover for a fixed interaction strength g̃(t), revealing an increasing 

effective 1D interaction strength g̃1D(t;λ). Due to the enhanced effective interaction 

strength, increasing the trap anisotropy shifts the eigenenergies to larger values. Here 

too, the ground-state energy undergoes the largest change, which is clearly non-linear. 

Figure 8 (b) shows that the energy differences likewise increase with the trap-aspect ratio 

120

Exact Diagonalisation of phBECs 13 

## a) b) 

Figure 8. a) First few eigenenergies of the Hamiltonian matrix (2) relative to the 

ground state energy E0 = ~Ωx(1 + λ2)/2 at dimensional crossover. b) Corresponding 

energy differences. Here, the dashed line shows the linearisation for the lowest energy 

difference ∆E1,0. In both pictures, the dots represent the results from the ED and the 

lines are the analytical approximations (B.2). The calculation uses the total particle 

number N = 104, a condensate fraction of N0/N ≈ 0.9 and the maximal interaction 

strength g̃(tend) = 10−5. 

pointing towards the predicted increased photon-photon interaction at the dimensional 

crossover, cf., reference [16]. Thus, the ED method also allows determining the effective 

photon-photon interaction strength along the dimensional crossover in the same way 

by spectroscopic measurements as outlined above. For instance, one approach relies on 

interfering different cavity modes and observing the resulting beating signal. 

Appendix Appendix B derives an analytic approximation for the eigenvalues, which are 

numerically calculated by the ED in the deep condensate limit. This approach considers 

the first four eigenmodes and diagonalises the corresponding 1D Hamiltonian matrix. 

This reveals the non-linear character of the eigenvalues, shown in figure 8 (a) to stem 

from avoided crossings with the next-higher eigenmodes with the same symmetry. Due 

to the same reason, this method only approximates the ground and first excited state 

well, whereas the ED and the analytical approximation for the higher excited states 

agree less for larger anisotropies. This can be avoided by taking into account even higher 

excited states, which is necessary for going to larger trap anisotropies respectively larger 

interaction strength, but makes the analytical diagonalisation more difficult. However, 

if the effective photon-photon interaction strength is small enough for a linearisation, 

the analytical approximation for the ground and first-excited state represents a result 

for determining it according to 

g̃1D(λ) ≈ 2 √ 

2π 

N0 

( 1− ∆E1,0(t) 

~Ωx 

) . (21) 

121

Exact Diagonalisation of phBECs 14 

## a) b) 

Figure 9. Dimensional crossover. Both plots are for a total particle number N = 104 

and a maximal interaction strength g̃(tend) = 10−5. a) Comparison of condensate 

width (12) at the end of the experiment for different trap-aspect ratios at fixed 

interaction strength. Here, the condensate fraction amounts to N0/N ≈ 0.9. Dots: 

results from ED; lines: variational approach. b) Total width of the photon gas at the 

beginning of the experiment (blue) and at the end of the experiment (orange), as well 

as the width of the ground state with interaction (green) for trap-aspect ratio λ = 10. 

The black line indicates the oscillator length, which is also the width of the ground 

state without interaction. The drawn lines are a guide to the eye. 

3.3. Width 

Figure 9 (a) compares the widths from the ED with the results from the variational 

approach for a fixed interaction strength. Whereas in the squeezed y-direction the 

results from both methods agree quite well at the whole crossover, the results coincide 

only for small trap-aspect ratios in the un-squeezed x-direction. At larger trap-aspect 

ratios, the results deviate up to several percent, which is caused by the coupling to 

the thermal cloud. Since the effective photon-photon interaction increases along the 

dimensional crossover, the thermal cloud becomes more and more important in this 

scenario. Consequently, the ED method plays a crucial role for measuring the effective 

photon-photon interaction at the dimensional crossover. 

Also, for larger trap anisotropies the total width of the photon gas can be calculated from 

(12), which figure 9 (b) pictures. Here, the blue line depicts again the total width of the 

photon gas at the beginning of the experiment for a certain thermodynamic temperature 

T . As the experiment runs, the effective photon-photon interaction increases and, thus, 

also the photon gas width grows during the experiment. Alas, only in the condensed 

regime this growth is significant and due to the trap anisotropy enhanced in comparison 

to the situation in the isotropic trap, see figure 7. In the thermal regime, however, still 

no impact of the effective photon-photon interaction is observable. 

122

Exact Diagonalisation of phBECs 15 

4. Summary 

The findings presented in this work are crucial for precisely quantifying the effective 

photon-photon interaction strength in current and future phBEC experiments. 

The present paper analyses in detail the theory of reference [14] by using exact 

diagonalisation for a harmonically trapped photon gas. The aim consists in determining 

the impact of the thermo-optic interaction upon the cavity modes. The accurate 

prediction of the shifts of the eigenenergies allows for a precise interferometric 

measurement of the emerging photon-photon interaction. The method reproduces 

formerly derived results and extends these systematically by taking the thermal cloud 

into account. The influence of thermal cloud turns out to be crucial for understanding 

the dimensional crossover and prevents a possible overestimation of the effective 

photon-photon interaction strength. Where possible, analytic estimates provide aid 

for determining the effective photon-photon interaction strength from measurements. 

Acknowledgments 

We thank Antun Balaž, Georg von Freymann, Milan Radonjić, Julian Schulz, 

Kirankumar Karkihalli Umesh, and Frank Vewinger for insightful discussions. ES 

and AP acknowledge financial support by the Deutsche Forschungsgemeinschaft (DFG, 

German Research Foundation) via the Collaborative Research Center SFB/TR185 

(Project No. 277625399). 

Appendix A. Variational Approach 

This appendix follows reference [13] and calculates a variational solution for the 

Hamiltonian (1) at T = 0 with the potential (5). In this case, a suitable ansatz for 

the eigenfunction is given by 

ψ(x, t) = 

√ λN 

πl2αx(t)αy(t) exp 

{ − 1 

2l2 

[ x2 

αx(t)2 + 

y2 

αy(t)2 

]} , (A.1) 

where l = √ ~/(mΩx) denotes the oscillator length and αx(t), αy(t) stand for the 

dimensionless variational parameters with the adiabatic time dependency. Consequently, 

the initial density is given by n(x, 0) = |ψ(x, 0)|2, with αx(0) = 1 = αy(0). The standard 

procedure yields the variational equations 

α4 x = 1 + 

2g̃(t)λN 

π 

α4 x√ 

(1 + α2 x) 

3 (1 + α2 y 

) (A.2) 

and 

α4 y = 1 + 

2g̃(t)N 

πλ 

α4 y√ 

(1 + α2 x) ( 1 + α2 

y 

)3 . (A.3) 

123

Exact Diagonalisation of phBECs 16 

Appendix B. Analytical Approximation in the 1D Case 

The aim of this appendix is to work out an analytical approximation for the quasi-1D 

case of a harmonic potential. Since the trap-aspect ratio determines the interaction 

strength g̃1D(λ), the latter can reach comparatively large values. Therefore, the first 

four eigenstates are taken into account and the resulting 1D Hamiltonian matrix is 

diagonalised. Moreover, the deep condensate limit N0 ≈ N is assumed. With the 

harmonic-oscillator eigenfunctions, the Hamiltonian matrix reads 

H1D = ~Ωx 

  

N0g̃1D(λ)√ 2π 

0 −N0g̃1D(λ) 4 √ π 

0 

0 1 + N0g̃1D(λ) 

2 √ 2π 

0 −N0g̃1D(λ) √ 3 

8 √ π 

−N0g̃1D(λ) 4 √ π 

0 2 + 3N0g̃1D(λ) 

8 √ 2π 

0 

0 −N0g̃1D(λ) √ 3 

8 √ π 

0 3 + 5N0g̃1D(λ) 

16 √ 2π 

  , (B.1) 

where the shift due to the unperturbed ground-state energy has been dropped. The 

Hamiltonian matrix possesses the eigenvalues 

E0 = ~Ωx 

( 1 + 

11N0g̃1D(λ) 

16 √ 

2π − √ 

1− 5N0g̃1D(λ) 

8 √ 

2π + 

57(N0g̃1D(λ))2 

512π 

) , (B.2a) 

E1 = ~Ωx 

( 2 + 

13N0g̃1D(λ) 

32 √ 

2π − √ 

1− 3N0g̃1D(λ) 

16 √ 

2π + 

105(N0g̃1D(λ))2 

2048π 

) , (B.2b) 

E2 = ~Ωx 

( 1 + 

11N0g̃1D(λ) 

16 √ 

2π + 

√ 1− 5N0g̃1D(λ) 

8 √ 

2π + 

57(N0g̃1D(λ))2 

512π 

) , (B.2c) 

E3 = ~Ωx 

( 2 + 

13N0g̃1D(λ) 

32 √ 

2π + 

√ 1− 3N0g̃1D(λ) 

16 √ 

2π + 

105(N0g̃1D(λ))2 

2048π 

) . (B.2d) 

References 

[1] O. Halpern. Scattering processes produced by electrons in negative energy states. Phys. Rev., 

44:855, 1933. 

[2] H. Euler and B. Kockel. Über die Streuung von Licht an Licht nach der Diracschen Theorie. 

Naturwissenschaften, 23:246, 1935. 

[3] H. Euler. Über die Streuung von Licht an Licht nach der Diracschen Theorie. Annalen der Physik, 

418:398, 1936. 

[4] W. Heisenberg and H. Euler. Folgerungen aus der Diracschen Theorie des Positrons. Zeitschrift 

für Physik, 98:714, 1936. 

[5] R. Karplus and M. Neuman. Non-Linear Interactions between Electromagnetic Fields. Phys. 

Rev., 80:380, 1950. 

[6] R. Karplus and M. Neuman. The Scattering of Light by Light. Phys. Rev., 83:776, 1951. 

[7] ATLAS Collaboration. Evidence for light-by-light scattering in heavy-ion collisions with the 

ATLAS detector at the LHC. Nat. Phys., 13:852, 2017. 

[8] R. W. Boyd. Nonlinear Optics. Acadamic Press, 3rd edition, 2008. 

[9] M. Lax, W. H. Louisell, and W. B. McKnight. From Maxwell to Paraxial Wave Optics. Phys. 

Rev. A, 11:1365, 1975. 

124

Exact Diagonalisation of phBECs 17 

[10] A. Zangwill. Modern Electrodynamics. Cambridge University Press, 1st edition, 2012. 

[11] J. Klaers, J. Schmitt, F. Vewinger, and M. Weitz. Bose–Einstein condensation of photons in an 

optical microcavity. Nature, 468:545, 2010. 

[12] J. Klaers, J. Schmitt, T. Damm, F. Vewinger, and M. Weitz. Bose–Einstein condensation of 

paraxial light. Appl. Phys. B, 105:17, 2011. 

[13] D. Dung, C. Kurtscheid, T. Damm, J. Schmitt, F. Vewinger, M. Weitz, and J. Klaers. Variable 

potentials for thermalized light and coupled condensates. Nat. Phot., 11:565, 2017. 

[14] E. Stein and A. Pelster. Quantum Mechanical Description of Thermo-Optic Interaction. arXiv: 

2203.16955, 2022. 

[15] A. Weiße and H. Fehske. Exact Diagonalization Techniques, pages 529–544. Springer Berlin 

Heidelberg, Berlin, Heidelberg, 2008. 

[16] E. Stein and A. Pelster. Photon BEC with Thermo-Optic Interaction at Dimensional Crossover. 

New J. Phys., 24:023032, 2022. 

[17] S. Maruo, O. Nakamura, and S. Kawata. Three-dimensional microfabrication with two-photon-

absorbed photopolymerization. Opt. Lett., 22:132, 1997. 

[18] M. Deubel, G. von Freymann, M. Wegener, S. Pereira, K. Busch, and C. M. Soukoulis. Direct 

laser writing of three-dimensional photonic-crystal templates for telecommunications. Nature 

Mat., 3:444, 2004. 

[19] J. K. Hohmann, M. Renner, E. H. Waller, and G. von Freymann. Three-Dimensional µ-Printing: 

An Enabling Technology. Adv. Optical Mater., 3:1488, 2015. 

[20] E. Stein and A. Pelster. Thermodynamics of trapped photon gases at dimensional crossover from 

2D to 1D. New J. Phys., 24:023013, 2022. 

125

## 7. Conclusion 

Da steh’ ich nun, ich armer Tor Und bin so klug als wie zuvor! And here, poor fool, I stand once more, // No wiser than I was before. 

Johann W. Goethe, Faust ll. 358 

Although photon Bose-Einstein condensates were created more than ten years ago, their overall behaviour is not understood completely. For instance, the role of the thermo-optic photon-photon interaction is still lacking knowledge. Especially, the question of how to increase its strength remains open. This theoretical thesis provides results which have a clear perspective to be measured experimentally in the near future. It examines in detail two possible ways for strengthening the interaction. On the one hand, changing the cavity-mirror geometry allows for increasing the thermo-optic interaction, as chapter 2 reveals. As the strength of the thermo-optic interaction depends on the amount of heat stored in the whole dye-cavity setup, the strength of the thermo-optic interaction can be tuned by changing the size of the cavity mirrors. This result arises from the detailed consideration of the temperature diffusion in the dye-cavity structure, taking into account the different temperature diffusion constants. Moreover, for a detailed measurement of the thermo-optic interaction strength both the condensate broadening and the lowest-lying collective modes can be utilised. On the other hand, the dimensional crossover from 2D to 1D bears a second possibility for changing the effective photon-photon interaction strength. This crossover is thought to be realised by anisotropic confining potentials for the photon gas, such that the energy gap in the squeezed dimension is of the order of the thermal energy. Hence, a further increase of the trap anisotropy leads the squeezed dimension to be frozen out. In view of the new developments of creating photon potentials, which are outlined in subsection 1.3.5, the following studies are of special interest for planned experiments. These stud-ies investigate both the thermodynamics of an ideal Bose gas and the behaviour of the thermo-optic interaction at the dimensional crossover. To this end, chapter 3 answers the question of the effective dimension of the photon gas for a given temperature and trap-aspect ratio in a harmonic trapping potential. For this purpose, the chapter analytically works out the thermodynamics of an ideal Bose gas. The analysis puts emphasis on the finite-size effects which are inherently present in the experiments. Therefore, the theory is analytically solved without using an order parameter. The most interesting thermodynamic quantity for defining the effective di-mension appears to be the specific heat. The advantage of the specific heat over other thermodynamic quantities, like the condensate fraction, lies in the fact that it can be used in both regimes, the thermal and the Bose-Einstein condensed. As it obeys the Dulong-Petit law in the thermal regime, it yields directly the dimension of the thermal gas. On the other hand, the specific heat in the BEC regime depends on the dimension of the system via a power law. Combining the Dulong-Petit law and the power law yields 

127

7. Conclusion 

a definition of the effective dimension of the system at the entire dimensional crossover. Therefore, these results provide direct guidance for the experiments to figure out the relevant parameter regime for measuring the dimensional crossover. The next step in understanding the dimensional crossover of a photon BEC consists in elaborating the behaviour of the effective photon-photon interaction. For this pur-pose, chapter 4 investigates the influence of the photon-photon interaction upon the photon BEC ground state at the dimensional crossover. The chapter assumes the zero-temperature limit and relies on a variational approach based on the energy functional of the ground state. It suggests two different ways of performing the dimensional cros-sover. On the one hand, as described in chapter 3, the idea consists of squeezing only a single dimension. In this case, the thermo-optic interaction behaves differently from the contact Kerr interaction, since it saturates for certain trap-aspect ratios. This behaviour originates in a competition of the length scales of both the condensate and the temper-ature diffusion. If the condensate width in the squeezed direction is smaller than the intrinsic length scale of the temperature diffusion, the temperature, which the condens-ate induces, diffuses into regions where no condensate is present. Thus, this temperature cannot contribute to the effective photon-photon interaction and its strength saturates. On the other hand, if not only a single dimension is squeezed but at the same time the second dimension is expanded, no such saturation effect can be observed. Instead, both the thermo-optic interaction and the Kerr interaction behave in the same way, namely they increase linearly with the trap-aspect ratio. In this way, larger effective photon-photon interactions can be realised. So far, thermodynamics and interaction effects are treated separately. Hence, the goal of chapter 5 consists of combining the approaches from chapters 3 and 4 to a Hartree-Fock analogue theory for the thermo-optic photon-photon interaction. To this end, a quantum-field theoretical treatment of this interaction, where the Hamiltonian depends on the temperature diffusion, is developed. As the experimental photon BEC lifetime is much shorter than the temperature-diffusion time, the timescales of the photon BEC and the thermo-optic interaction separate. This separation turns the thermo-optic photon-photon interaction into an effective photon potential. As a consequence, the photon gas depends adiabatically on the slowly increasing photon-photon interaction strength, while the total photon density from the beginning of the experiment determines the shape of this effective potential. This setting is closer to the real experiments than the approaches from chapters 2 and 4, since these two rely on the temperature being in a steady state, which cannot be realised experimentally. As a first application, the chapter concludes with a perturbative spectrum for both the box and the harmonic potential. It turns out that the energy shifts due to interaction are stronger in the box than in the harmonic potential, which is attributed to the stronger spatial confinement in the box case. With this theory at hand, chapter 6 revisits the harmonically trapped photon gas. The final aim of this approach is to obtain the spectrum of the photon gas and how it changes during a single experiment. These data allow for an increased precision in determining the effective photon-photon interaction strength by using spectroscopic measurements. Chapter 6 produces this very data by exact diagonalisation of the Hamiltonian derived in chapter 5. Also, the dynamical broadening of the photon BEC, which can be directly observed in the experiments, and finite temperature effects are at the centre of this study. Finally, the advantage of this method, namely considering the thermal cloud, pays out at the dimensional crossover, where the effective photon-photon interaction can be tuned to larger values. Here, the coupling to the thermal cloud cannot be neglected anymore, 

128

and the spectrum cannot be treated perturbatively. Thus, the exact diagonalisation of the Hamiltonian from chapter 5 is essential. In direct comparison with the variational approach from chapter 4 the exact diagonalisation yields a larger condensate width in the unsqueezed direction than the variational approach. This hints towards an increased role of the thermal cloud, which is not present in the latter calculation. In view of an appropriate experimental investigation of the effective photon-photon interaction at the dimensional crossover, the approach developed in chapter 5 needs to be taken into ac-count together with an exact diagonalisation approach used in this chapter. In conclusion, this thesis provides results, which are relevant for understanding the ef-fective photon-photon interaction, especially at the dimensional crossover from 2D to 1D. It reveals how the interaction can be increased and how it affects the dimensional crossover. The results of the thesis are quite near to current experiments, such that these results can be used to divulge interesting experimental regimes and to directly compare between experiment and theory. 

129

## 8. Outlook 

I too am not a bit tamed, I too am untranslatable, I sound my barbaric yawp over the roofs of the world. 

W. Whitman, Song of Myself, 52, ll. 2 

The ideas presented in this thesis yield many prospects for future work. For instance, from the experimental view, the thermodynamic investigation of the dimensional cros-sover in chapter 3 can be performed for a dimple potential as well. These potentials are of special interest for the photon BEC community, as they allow for realising one-dimensional photon BECs and, thus, they provide a platform for investigating the dimen-sional crossover of nearly ideal Bose gases. To this end, section 8.1 presents preliminary results for both a harmonic and a box dimple potential. Even the effective photon-photon interaction still bears open questions. Firstly, how can the field-theoretical description of the thermo-optic interaction, as used in chapters 2 and 4, be combined with the matter degrees of freedom? Chapter 8.2 discusses one possible way, which builds upon the rate equations from subsection 1.3.2. This results in a theory, which is comparable to the projected Gross-Pitaevskii equation [142–144]. Another approach deals with the saturation effect of the matter, effectively yielding an imaginary interaction. Section 8.3 outlines the possibility to connect this non-linearity with the discussion at the end of subsection 1.3.4 about vortices. As a third way for coupling the matter to the photon field, section 8.4 takes up the P -function formalism introduced in subsection 1.1.2 and applies it to the incoherent absorption and re-emission terms of the master equation (1.64). Finally, so far neither a theoretical nor an experimental study of the dye bleaching pro-cesses in the photon BEC experiments does exist. Section 8.5 discusses several points, why this should be done in view of developing a full understanding of photon BEC experiments. 

8.1. Thermodynamics 

The thermodynamic investigation performed in chapter 3 can be extended in several ways. The microstructuring techniques developed in the von Freymann group [110–112] allow preparing photon potentials for investigating the dimensional crossover from 2D to 1D [145]. Contrarily to the investigation in chapter 3, the resulting potentials are not infinitely deep, but have the form of dimple traps. Therefore, the definition of the effective dimension from chapter 3 needs to be rethought, as the finite number of available energy states introduces a saturation of the energy. Subsection 8.1.1 elaborates this point and provides first numerical insights for a harmonic dimple potential. Another possible direction, which these techniques allow, is the investigation of box potentials. Due to the large spatial resolution, the microstructured potentials are better 

131

8. Outlook 

suited for investigating the dimensional crossover from 2D to 1D, in contrast to the delimination technique utilised in the experiment [107]. In the latter case, the spatial resolution is too small for providing box potentials over the whole crossover, so these potentials rather turn into harmonic confining potentials for large trap anisotropies. So the question arises how to define the effective dimension in such a potential. Subsection 8.1.2 presents some initial findings on this topic. 

8.1.1. Harmonic Dimple Potential 

Thus, harmonic dimple potentials printed on top of spherically shaped mirrors are of special interest to both experiment and theory. The latter superimpose a harmonic potential with much smaller trapping frequency in the order of magnitude of 40 GHz, whereas the former obtain a large trapping frequency in the terahertz regime. For the sake of simplicity, the following discussion covers first the 1D case and then generalises to the 2D potential. In 1D, the dimple potential has the form 

V = 

{ V0(x), |x| > x0 

V0(x)− U0(1− x2/x20), |x| ≤ x0 , (8.1) 

where V0(x) = mΩ2x2/2 is the mirror potential. In addition, U0 and x0 denote the depth and the width of the dimple, respectively. Experimentally realistic parameters are Ω=40 GHz, U0 ∼ kBT0 ≈ 160ℏΩ, with T0 being the room temperature, and x0 varies from 0.5 µm to 40 µm. 

Eigenmodes In the region x ≪ x0 figure 8.1 a) shows the dimple to be the dominant part of the potential (8.1). Therefore, the trap takes approximatively the form of a harmonic potential with the dimple trapping frequency ωd, which amounts from (8.1) to 

ωd = Ω 

√ 1 + 

2U0 

ℏΩ l2osc x20 

, (8.2) 

where losc = √ 

ℏ/(mΩ) stands for the oscillator length of the mirror potential. Note that the trapping frequency of the dimple ωd is in the order of terahertz, such that ωd ≫ Ω. According to 8.1 b), an imaginary time evolution using the dimple potential (8.1) reveals the eigenstates inside the dimple to be well separated from the one in the external potential, so these two regions can be discriminated experimentally. This allows for experimentally controlling the photon gas in the dimple potential only and, therefore, it suffices to take into account only the few states inside the dimple for the theoretical modelling. Figure 8.1 b) suggests that these eigenenergies can be approximated by the harmonic oscillator eigenenergies 

Ed n = ℏωd 

( n+ 

1 

2 

) − U0 , (8.3) 

whereas the outer modes can be less accurately approximated by the harmonic oscillator modes from the mirror trap by 

E0 n = ℏΩ 

( n+ 

1 

2 

) . (8.4) 

132

8.1. Thermodynamics 

10 5 0 5 10 x/losc 

150 

100 

50 

0 

50 

V / 

0 10 20 30 40 n 

150 

125 

100 

75 

50 

25 

0 

25 

50 

E n / 

Ed n 

E0 n 

a) b) 

Fig. 8.1: Numerical investigation of the dimple potential (8.1) for x0 = 18 µm ≈ 1.83 losc and U0 ≈ −160ℏΩ. a) Plot of the potential. The shaded area marks the dimple region. b) Corresponding eigenenergies. The blue dots are the nu-merical results, whereas the green (orange) dashed line indicates the dimple (mirror) eigenenergies (8.3) ((8.4)). 

Inner Energy and Specific Heat As a consequence, the whole thermodynamics of the dimple potential can be described by just taking the modes inside the dimple into account. Therefore, in the case of the 2D dimple potential at the dimensional crossover, the inner energy takes the form 

U = 

lx∑ 

n=0 

ly∑ 

m=0 

Ed n + λEd 

m 

eβ(Ed n+λEd 

m−µ) − 1 , (8.5) 

where β = 1/(kBT ) is the inverse temperature and µ denotes the chemical potential. Here, the trap-aspect ratio is denoted by λ = ωd,x/ωd,y and lx, ly represent the cutoff values of the quantum numbers in x and y-direction, respectively. The inequality 

Ed n + λEd 

m = n+mλ+ 1 + λ 

2 ≤ U0 

ℏωd (8.6) 

determines the cutoff value in the unsqueezed x-direction to 

lx = 

{⌊ U0 ℏωd 

− 1+λ 2 

⌋ , U0 ≥ ℏωdλ 

2 

0 , else . (8.7) 

Here, the second case ensures that for increasing trap-aspect ratio λ the ground state of the potential is always present. In the squeezed y-direction it is 

ly = 

{⌊ 1 λ 

( U0 ℏωd 

− 1+λ 2 

)⌋ , U0 ≥ ℏωdλ 

2 

0 , else (8.8) 

which converges to 0 for λ→ ∞ meaning that only the ground state remains. Equation (8.7) and (8.8) imply that all thermodynamic quantities highly depend on the trap-aspect ratio λ, even in the effective 1D case. Moreover, due to the few energy states available, finite-size effects are more pronounced, as figure 8.2 shows. The most prominent effect 

133

8. Outlook 

10 1 100 101 

T/Tc 

0 

10 

20 

30 

40 

U /( 

N d) 

10 1 100 101 

T/Tc 

10 2 

10 1 

100 

C N /( 

N k B 

d) 

1D 2D x2 

x 

a) b) 

Fig. 8.2: a) Inner energy and b) specific heat per particle for the harmonic dimple po-tential (8.1) with U0 = kBT0. The blue curves depict the istropic case λ = 1 and the orange curves the quasi-1D case with λ = 50. The solid lines are for N = 100 particles and the dashed lines for N = 10 particles. The solid black lines in b) are a guide to the eye for recognising the low-temperature power-law dependency and the dashed black lines depict the 2D and 1D Dulong-Petit law, respectively. 

is the cutoff yielding an upper limit for the inner energy, as the high-temperature part of figure 8.2 a) reveals. In view of the specific heat CN , this saturation of the inner energy destroys the Dulong-Petit law in the thermal phase, c.f., figure 8.2 b). In this case, the definition of the effective system dimension from chapter 3 cannot be applied. However, considering a small particle number restores the Dulong-Petit law in a certain temperature regime for the price that the phase transition from the BEC to the thermal regime is largely smeared out and turns into a smooth crossover. In the BEC regime, on the other hand, the inner energy behaves as usual and converges for T → 0 to the ground-state energy, and the specific heat for fixed particle numberN obeys the standard power law behaviour, i.e., CN ∝ T/Tc in the 1D case and CN ∝ (T/Tc) 

2 in the 2D case. Therefore, the definition of the effective system dimension from chapter 3 in the BEC case can still be used. In view of future experiments, an analytical evaluation of the thermodynamics of the harmonic dimple potential is necessary. Especially, the mapping T/Tc = (Nc/N)1/D for a given dimension D needs to be worked out analytically for the dimple potential. This turns out to be essential, as photon BEC experiments rely on tuning the particle number instead of changing the temperature [116]. 

8.1.2. Box Dimple Potential 

Another interesting case for the experiment is the finite box potential and the dimen-sional crossover in this setting. As in the case of the harmonic dimple potential, it is sufficient to take into account only the box eigenenergie. Here, the same questions as in the case of the harmonic dimple potential arise: What is the influence of the finite cutoff, and how can the effective system dimension be defined? The inner energy is defined in the same manner as for the harmonic dimple potential by 

134

8.2. Projected Gross-Pitaevskii Equation 

0 2 4 6 8 10 T/Tc 

0 

20 

40 

60 

80 

100 

120 

140 

U /( 

N d) 

10 1 100 101 

T/Tc 

10 2 

10 1 

100 

C N /( 

N k B 

d) 

a) b) 

Fig. 8.3: a) Inner energy and b) specific heat per particle for the box dimple potential. The blue curves correspond to the 2D case with λ = 1 and the orange curves belong to a trap-aspect ratio λ = 10. The solid lines are for N = 100 and the dashed lines for N = 10 particles. 

(8.5), but just replacing the harmonic oscillator eigenenergies with the box eigenergies 

Ebox n = E0n 

2 , (8.9) 

where E0 = π2ℏ2/(2mL2) denotes the ground-state energy of a 1D box with length L. In the box case, the trap-aspect ratio λ is defined via the ratio λ = L2 

x/L 2 y of the 

squares of the lengths in the x- and y-direction, respectively. This definition ensures that box and harmonic potential are comparable. Due to the quadratic scaling of the energy with the quantum number n, much fewer states exist in the box dimple potential compared to the harmonic dimple potential, provided both length scales are comparable, i.e., L ∼ 

√ ℏ/(mωd) . Consequently, finite-size effects are even more important as in the 

harmonic case. Figure 8.3 shows the inner energy and specific heat of the box dimple potential. Both quantities behave qualitatively like in the harmonic case in figure 8.2, namely, the existence of an upper bound of the energy prevents the Dulong-Petit law to exist. In both the 2D and the quasi-1D case, the transition of the specific heat is smooth, showing that in this case rather a crossover from BEC phase to thermal phase than a phase transition occurs. In the 1D case, the specific heat does nearly not change at all. Thus, the interesting question arises, how to characterise the phases in the quasi 1D case. However, for a sincere interpretation of the data in figure 8.3 an analytical theory for the infinite deep box potential needs to be worked out. With this at hand, the corresponding dependency of the specific heat upon the system dimension would be available, allowing to define the effective system dimension at the dimensional crossover analogue to chapter 3. 

8.2. Projected Gross-Pitaevskii Equation 

The mean-field model in subsection 1.3.3 defined by equations (1.60) and (1.61) bears an unstable behaviour due to the increasing width of the temperature distribution, as chapter 2 discusses. This results from not considering the absorption and re-emission of 

135

8. Outlook 

photons in this approach. Therefore, a possible way for improving the model consists in coupling the mean-field model to rate equations from subsection 1.3.2. On the simplest level, this may be done by expanding the photon-gas wave function ψ in an appropriate basis set {ψm} of some Hamiltonian Ĥ with Ĥψm = ℏωmψm. The corresponding expansion coefficients 

am = 

∫ d2x ψ∗ 

mψ (8.10) 

allow bringing together the Gross-Piatevskii equation (1.60) with the molecular popula-tion of the ground and excited states according to 

ψ̇ =− i 

ℏ 

( −ℏ2∇2 

2m + V (x) + gT∆T − iκ 

2 

) ψ 

+ 1 

2 

∑ 

m 

[B↓(ωm)N↑ −B↑(ωm)N↓] amψm , (8.11) 

with the same notations as in subsections 1.3.2 and 1.3.3. The first line in (8.11) de-scribes the evolution acting on the whole wave function, i.e., both the coherent evolution and the cavity decay. The second line considers the absorption and emission of the dye molecules, such that different absorption and emission rates B↑↓(ωm) for different modes are taken into account. The corresponding temperature diffusion equation (1.61) is not altered. The rate equations for the matter (1.52) and (1.53) have the same form, except from identifying nm = |am|2. However, one has to neglect the spontaneous emission in the matter rate equations, if the projected Gross-Pitaevskii equation is taken in the form (8.11). The spontaneous emission may be restored by appropriate stochastic terms therein. Moreover, when performing numerical simulations, the numerical procedure needs to ensure that the coherent evolution in (8.11) does not leave the considered part of the basis set. Or, to put in other words, also the coherent evolution has to respect the cutoff introduced in the wave function expansion. This consideration brings the approach described in this section close to the realm of projected Gross-Pitaevskii equa-tions [142–144]. With this method at hand, the aim consists in working out the dynamical properties of the thermo-optic interaction, the prospect of superfluidity of photon BECs and ulti-mately the vortex physics of photon gases. Therefore, this model has the potential for improving the stochastic model (1.66). 

8.3. Vortices 

The question of vortices in photon Bose-Einstein condensates is both an interesting and a challenging one, as it represents an open-dissipative system with very small or even without interaction. The works by Michiel Wouters et al., which are discussed in sub-section 1.3.4 and are based on the stochastic equation (1.66), reveal that, indeed, no interaction is needed for creating stable vortices, provided the matter introduces some non-linearity. However, the drawback is that these works are only numerical and so far neither a theoretical analysis nor a corresponding experiment has been performed. The study [78] provides a simple test model for these considerations. The correspond-ing open-dissipative Gross-Pitaevskii equation, originally developed for exciton-polariton 

136

8.3. Vortices 

4 2 0 2 4 

4 

2 

0 

2 

4 

y/ l o 

sc 

t=18.75 

0 

1 

2 

3 

4 

5 

| |2 

l2 os c 

4 2 0 2 4 

4 

2 

0 

2 

4 t=37.5 

0.0 

0.5 

1.0 

1.5 

2.0 

2.5 

3.0 

3.5 

4.0 

| |2 

l2 os c 

4 2 0 2 4 x/losc 

4 

2 

0 

2 

4 

y/ l o 

sc 

t=56.25 

0 

1 

2 

3 

4 

5 

6 

| |2 

l2 os c 

4 2 0 2 4 x/losc 

4 

2 

0 

2 

4 t=75.0 

0.0 

0.5 

1.0 

1.5 

2.0 

2.5 

3.0 

3.5 

| |2 

l2 os c 

Fig. 8.4: Rise of vortex lattice from the open-dissipative Gross-Pitaevskii equation (8.12) with g = 0. The different slides show the photon density for different times. In the numerical simulation, the emerging vortex lattice rotates. The spatial coordinates are rescaled by the oscillator length losc = 

√ ℏ/(mΩ) and the time 

coordinates by the trap frequency Ω. The pump spot has a radius of R = 3losc and a rate of p = 3Ω. The non-linear constant is given by Γ = Ω. 

BECs, reads 

iℏψ̇ = 

( −ℏ2∇2 

2m + V (x) + g|ψ|2 

) ψ + iℏ 

( p− Γ|ψ|2 

) ψ . (8.12) 

Here, the first term on the right-hand side represents the standard Gross-Pitaevskii equa-tion with the external potential V (x) and the interaction strength g. The second term stems from the open-dissipative character, with p being the pump parameter and Γ the non-linear loss channel. It turns out that for homogeneous pumping the steady state of (8.12) is unstable, and for a finite homogeneous pump spot even a rotating vortex lattice emerges. The interaction-free regime g = 0 is of special interest for the photon Bose-Einstein con-densate. The open-dissipative term is in this case reminiscent of an adiabatic elimination of the matter degrees of freedom, and the non-linearity traces back to the matter satur-ation, compare to the laser equation (1.5). A numerical evaluation of the corresponding equation (8.12) for g = 0 reveals the existence of vortex lattices even in this situation. Figure 8.4 shows the emergence of a rotating vortex lattice from equation (8.12) for van-ishing interaction strength in the case of a harmonic potential V = mΩ2x2/2. However, the interpretation of vortices in this situation is slightly different from that in closed sys-tems. According to (8.12) the loss is large, where the photon density |ψ|2 is large. Right at the vortex core, the photon density vanishes, such that there is only the pump term p 

137

8. Outlook 

present. As a result, the vortex acts like a “particle canon”. This behaviour is confirmed by observing the flux j = ℏ/mIm (ψ∗∇ψ) of the condensate near the vortex. Reference [68] studies this in detail for a similar equation for exciton-polariton condensates, see figure 1.9 in subsection 1.2.2. The authors find exactly the described behaviour, with the flux pointing to the outside of the vortex. 

8.4. P-Function Representation for Photon Bose-Einstein Condensate 

Subsection 1.1.2 introduces a P -function representation for the photon field inside a laser cavity, which adiabatically eliminates the matter degrees of freedom. The same approach allows for treating the photon BEC master equation (1.64). For the sake of simplicity, this section just discusses the P -function approach for the thermalisation part of the master equation and neglects the coherent dye-photon coupling. 

P-Function Thus, the master equation is given by 

˙̂ρ = −i ∑ 

n 

[ δnâ 

† nân, ρ̂ 

] − 1 

2 

{ κ ∑ 

n 

L [ân] + ∑ 

m 

( Γ↑L 

[ σ̂+m ] + Γ↓L 

[ σ̂−m ]) } ρ̂ 

− 1 

2 

∑ 

nm 

{ γ+nL[ânσ̂+m] + γ−nL[â†nσ̂−m] 

} ρ̂ , 

(8.13) 

where the notations are the same as in the master equation (1.64) and L[x̂]ρ̂ denotes the Lindblad superoperator. The ansatz (1.18) for the density matrix is here generalised to many photon modes and reads 

ρ̂ = 

{∏ 

n 

∫ d2αn |αn⟩ ⟨αn| 

} χ̂({αn, α 

∗ n}) , (8.14) 

with χ̂ playing the role of the P -function for the photons and being a density matrix for the matter. Moreover, |α⟩n denotes the nth coherent state, to which the stochastic variable αn is linked via the eigenvalue equation ân |αn⟩ = αn |αn⟩. Applying the correspondence rules (1.19) yields the evolution to split in three different parts. The first describes the evolution of the light field only and reads 

LFχ̂ = ∑ 

n 

{ ∂ 

∂αn αn 

( iδn + 

κ 

2 

) + c.c. 

} χ̂ . (8.15) 

The matter in this approach follows the Liouvillian 

LMχ̂ = −1 

2 

∑ 

m 

{( Γ↑ + 

∑ 

n 

|αn|2 ) L[σ̂+m] 

+ 

[ Γ↓ + 

∑ 

n 

( |αn|2 − 

∂ 

∂αn αn − ∂ 

∂α∗ n 

α∗ n 

)] L[σ̂−m] 

} χ̂ . 

(8.16) 

Although the photon numbers |αn|2 appear in (8.16), this does not represent an inter-action between light and matter, since these terms vanish when tracing out the matter 

138

8.4. P-Function Representation for Photon Bose-Einstein Condensate 

degrees of freedom. Instead, it adds to the incoherent pump and decay channels. Finally, the light-matter interaction is described by 

LMFχ̂ = −1 

2 

∑ 

nm 

{ γ−n 

[ ∂ 

∂αn αnχ̂σ̂ 

+ mσ̂ 

− m + h.c.− 2 

∂2 

∂αn∂α∗ n 

σ̂−mχ̂σ̂ + m 

] 

− γ+n 

[ ∂ 

∂αn αnσ̂ 

− mσ̂ 

+ mχ̂+ h.c. 

]} . 

(8.17) 

The total time evolution of the density matrix χ̂ is then described by 

˙̂χ = (LF + LM + LMF) χ̂ . (8.18) 

Fokker-Planck Equation As in subsection 1.1.2, the Fokker-Planck equation for the photon modes is derived under the assumption that the total density matrix χ̂ factorises into the P -function and the density matrix χ̂M of the matter, which is assumed to be in its steady state. Tracing over the matter degrees of freedom in (8.18) yields already the form of the Fokker-Planck equation as 

Ṗ = ∑ 

n 

{ ∂ 

∂αn αn 

[ iδn + 

κ 

2 − ∑ 

m 

( γ−n 2 

1 + ⟨σ̂zm⟩M 2 

− γ+n 2 

1− ⟨σ̂zm⟩M 2 

)] + c.c. 

+ ∑ 

m 

γ−n ∂2 

∂αn∂α∗ n 

1 + ⟨σ̂zm⟩M 2 

} P . 

(8.19) 

Equation (8.19) is already close to the form of a Fokker-Planck equation, just the expect-ation value of the σ̂z operators has to be calculated. With the matter Liouvillian (8.16) this is calculated from evaluating 0 = trM [σ̂zn(LM + LMF)χ̂]. As equation (8.19) already contains second-order derivates of ⟨σ̂zm⟩M, the appearing derivates in the Liouvillian (8.16) are neglected. This procedure results in 

⟨σ̂zm⟩M ≈ Γ↑ − Γ↓ + ∑ 

n 

[ γ+n |αn|2 − γ−n 

( |αn|2 + 1 

)] 

Γ↑ + Γ↓ + ∑ 

n 

[ γ+n |αn|2 + γ−n (|αn|2 + 1) 

] . (8.20) 

Due to this approximation, equation (8.19) is, indeed, a Fokker-Planck equation for the different photon modes, which can be interpreted in the following way. The first line of (8.19) describes the coherent evolution, as well as stimulated emission and absorption. The second line, on the other hand, accounts for the spontaneous emission into the re-spective cavity mode, yielding the photon gas to thermalise. The set of Itô SDEs with multiplicative noise corresponding to the Fokker-Planck equation (8.19) can be solved numerically for obtaining the steady state, which figure 8.5 depicts. Figure 8.5 a) shows for a 1D harmonic potential with trapping frequency Ω that the ground-mode occupation〈 |α0|2 

〉 gets macroscopic, if the external pump Γ↑ is larger than a certain critical pump 

γcrit = Γ↓eβℏΩ + γ+ 0 

1−e−βℏΩ , which follows from the steady state of the coherent evolution. The absorption and emission coefficients have to fulfil the Kennard-Stepanov relation (1.51) for a certain temperature β. Figure 8.5 b) verifies the resulting photon distribu-tion for a given external pump to obey the Bose-Einstein distribution (1.58). Note that these results are comparable to a corresponding treatment of the rate equations from subsection 1.3.2. The Fokker-Planck equation (8.19) allows for different studies, such as the emergence of 

139

8. Outlook 

Fig. 8.5: Steady state resulting from simulating the set of Itô SDEs corresponding to the Fokker-Planck equation (8.19) for the case of a 1D harmonic potential. The first eleven modes of the harmonic potential are included, and the absorption coefficient is simplified to be γ+n = 10κ for all modes, whereas the emission coefficient follows the Kennard-Stepanov relation (1.51) at the temperature ℏΩβ = 0.1. The non-radiant decay of the molecules is chosen to be Γ↓ = 0.5κ. a) Mode occupation ni = 

〈 |αi|2 

〉 as function of the external pump Γ↑. The 

ground state is depicted in blue, the first excited state in orange, and so on. b) Verification of Bose-Einstein distribution of photon occupation in thermal phase (orange, Γ↑ = 0.01γcrit) and in Bose-Einstein condensed phase (blue, Γ↑ = 100γcrit). 

coherence along the phase transition, the influence of the fluctuations, c.f., [87, 90], or it can be generalised to also take into account the thermo-optic photon-photon interaction. Note that the latter works here, since the thermo-optic interaction is a mean-field inter-action per definition, c.f., chapter 5. Another possible way of improving this approach consists of switching to the Wigner function and also take into account the full evolution of the matter via the truncated Wigner approximation from [43]. 

8.5. Dye Bleaching 

One point, which so far is not included in all theoretical studies and only qualitatively in the experiments, is the dye bleaching. Subsection 1.3.1 mentions the dye bleaching as a limiting factor of a single experimental cycle [71]. In fact, already in this timespan, some molecules are lost, such that after each cycle the power of the pump laser has to be increased in order to reach the desired photon number [146]. A further point of discussion is how the dye bleaching affects the photon condensate dynamically, or, more precisely, how can dye bleaching effectively mimic the behaviour of the thermo-optic interaction? This has to be considered as both processes accumulate over time. There are mainly two different processes responsible for dye bleaching. On the one hand, a dye molecule can spontaneously decay into a metastable triplet state, such that this molecule is not available for the remainder of the experiment. On the other hand, a Förster resonance energy transfer yields a total loss of a molecule [147, 148]. The idea here is that one excited dye molecule de-excites by transferring its excitation via dipole-dipole interaction to a second excited dye molecule nearby. As a result, the energy of the 

140

8.5. Dye Bleaching 

0.0 0.2 0.4 0.6 0.8 1.0 / 

1.016 

1.017 

1.018 

1.019 

1.020 

1.021 

/l o sc 

Fig. 8.6: Mean condensate width (8.22) from the 2D equation (8.21) with harmonic po-tential V = mΩ2x2/2. The mean is taken after a sufficient time, such that the condensate width oscillates around its new steady state. 

second molecule is so high that it breaks up and is completely lost to the experiment. As both of these effects are proportional to the density of excited dye molecules, they are also proportional to the photon density. Hence, in the region of high photon density the dye molecule loss is also large, such that the photon density drops in this region. As a result, this may look like an effective broadening of the photon condensate, which is usually attributed to the effective photon-photon interaction. As both the dye bleaching and the thermo-optic interaction increase slowly in time, see chapters 5 and 6 for the latter, the distinction of these two effects is not obvious. This is in particular complic-ated, as the dye bleaching sets an upper limit to the condensate lifetime of 500µs, but in contrast to the thermo-optic interaction, it is not clear, whether a timescale exists for the dye bleaching due to its non-linear origin. Therefore, a detailed modelling of the dye bleaching is indispensable for achieving a deeper understanding of this issue. A simple model for describing the effect of dye bleaching on the mean-field level consists of a Gross-Pitaevskii equation with imaginary interaction 

iℏψ̇ = 

[ −ℏ2∇2 

2m + V (x) 

] ψ − iδ|ψ|2ψ . (8.21) 

The first term on the right-hand side consists of the kinetic and potential energy, whereas the last term of the right-hand side considers effectively the dye bleaching, where the prefactor δ is assumed to be non-negative. The latter leads to a non-linear decay of the condensate. Figure 8.6 shows the results from a numerical simulation of the 2D Gross-Pitaevskii equation (8.21) with harmonic potential V = mΩ2x2/2. It seems that, indeed, the mean of the condensate width 

σ = 2 

√∫ d2x x2|ψ|2∫ d2x |ψ|2 (8.22) 

tends to increase with increasing bleaching and, thus, behaves like an effective photon-photon interaction. This underlines the importance for developing a detailed theory for the dye-bleaching dynamics. 

141

## A. Harmonic Oscillator Coupled to a Bosonic Heat Bath 

Systems coupled to large reservoirs are a common problem appearing in nearly every branch of physics with regard to, e.g., thermalisation of a subsystem to a reservoir or, as it is the case in section 1.1, when a system is externally driven. The dynamics of these systems can be described using a variety of methods [39, 40, 149]. The present appendix focuses on the master equation in Lindblad form, which is the most common type of master equation in the realm of quantum optics. This kind of master equation is also at the heart of microscopic models for photon BECs, as subsection 1.3.4 outlines. This section illustrates the derivation of the Lindblad master equation for the important example of a harmonic oscillator coupled to a thermal bath of harmonic oscillators. An example of such a system is a photon mode inside a cavity coupled to the electrical field outside the cavity, describing the decay of an optical photon mode. At first, section A.1 derives the generic form of the Born-Markov master equation. Subsection A.2 specialises this master equation to the case a harmonic oscillator coupled to a bath of harmonic oscillators and brings it to the form of a Lindblad master equation. 

A.1. Born-Markov Master Equation 

The total Hamiltonian 

Ĥ = ĤS + ĤR + ĤI (A.1) 

consists of a part ĤS describing the system of interest, the reservoir Hamiltonian ĤR 

and the system-reservoir interaction ĤI . The energy scale of the latter is assumed to be much smaller than the energy scale of the system and the reservoir. In order to ensure this, the Hamiltonian (A.1) is rewritten in the form 

Ĥ = ĤS + ĤR + ĤI , (A.2) 

where ĤS = ĤS+ 〈 ĤI 

〉 R contains the remaining system part of the interaction Hamilto-

nian with ⟨•⟩R denoting the reservoir expectation value and ĤI = ĤI − 〈 ĤI 

〉 R can be 

seen as the perturbation due to the interaction of the system with the reservoir. The dynamics of the total density matrix ρ̂ is determined by the von-Neumann equation 

˙̂ρ(t) = − i 

ℏ 

[ Ĥ, ρ̂(t) 

] . (A.3) 

The aim consists in finding an equation of motion for the system density matrix ρ̂S = trRρ̂, where trR denotes the partial trace of the reservoir degrees of freedom. The following derivation is abundant in literature [39, 40, 149, 150]. The derivation is most conveniently done in the interaction picture, which, for an operator Â, is defined by 

ˆ̃A(t) = e(i/ℏ)(ĤS+ĤR)tÂe(−i/ℏ)(ĤS+ĤR)t . (A.4) 

143

A. Harmonic Oscillator Coupled to a Bosonic Heat Bath 

Therefore, the von-Neumann equation (A.3) takes the form 

˙̂ ρ̃(t) = − i 

ℏ 

[ ˆ̃HI(t), ˆ̃ρ(t) 

] . (A.5) 

Equation (A.5) can be formally integrated to yield 

ˆ̃ρ(t) = ˆ̃ρ(0)− i 

ℏ 

∫ t 

0 dt′ 

[ ˆ̃HI(t 

′), ˆ̃ρ(t′) ] . (A.6) 

Inserting the integrated equation (A.6) into the differential equation (A.5) yields the exact equation 

˙̂ ρ̃(t) = − i 

ℏ 

[ ˆ̃HI(t), ˆ̃ρ(0) 

] − 1 

ℏ2 

∫ t 

0 dt′ 

[ ˆ̃HI(t), 

[ ˆ̃HI(t 

′), ˆ̃ρ(t′) ]] , (A.7) 

from which several approximations are made. At first, the reservoir is assumed to be sufficiently large such that the weak coupling to the system does not affect the reservoir’s state. Thus, the reservoir stays in its steady state described by the density matrix ρ̂R. Next, the initial state is chosen such that no correlations exist, i.e., ρ̂(0) = ρ̂S(0)ρ̂R. As the system-reservoir coupling is small, this holds for all times t and it is 

ˆ̃ρ(t) ≈ ˆ̃ρS(t)ρ̂R . (A.8) 

The Born approximation uses the approximation (A.8) in the integral in equation (A.7). Therefore, the resulting equation is of second order in the interaction ĤI , but still an integro-differential equation. Finally, the Markov approximation neglects the system memory, which corresponds to replacing ˆ̃ρS(t 

′) by ˆ̃ρS(t) in the integral in (A.7), and turns the integro-differential equation into a differential equation. Finally, tracing out the bath degrees of freedom results in the master equation in Born-Markov approximation 

˙̂ ρ̃S(t) = − 1 

ℏ2 

∫ t 

0 dt′ trR 

[ ˆ̃HI(t), 

[ ˆ̃HI(t 

′), ˆ̃ρS(t)ρ̂R ]] , (A.9) 

where the first term in (A.7) does not appear due to 〈 ˆ̃HI 

〉 R = 0 and ⟨•⟩R = trR(•ρ̂R) 

denotes the reservoir expectation value. As a final approximation, the time evolution in (A.9) is coarse-grained, such that the decay of the reservoir-correlation functions in (A.9) is assumed to be much faster than the times, at which (A.9) is valid [40]. Therefore, the lower integration limit in the time integral can be sent to −∞ and a change of the integration variable t′ to τ = t− t′ yields 

˙̂ ρ̃S(t) = − 1 

ℏ2 

∫ ∞ 

0 dτ trR 

[ ˆ̃HI(t), 

[ ˆ̃HI(t− τ), ˆ̃ρS(t)ρ̂R 

]] . (A.10) 

The Born-Markov master equation (A.10) contains only the second-order contribution of the system-reservoir coupling explicitly, as the first-order term is hidden in the inter-action picture (A.4). Therefore, transforming back to the Schrödinger picture yields for the full Born-Markov master equation 

˙̂ρS(t) = − i 

ℏ 

[ ĤS + 

〈 ĤI 

〉 R , ρ̂S(t) 

] − 1 

ℏ2 

∫ ∞ 

0 dτ trR 

[ ĤI , 

[ ˆ̃HI(−τ), ρ̂S(t)ρ̂R 

]] , (A.11) 

144

A.2. Master Equation of Lindblad Form 

where the term 〈 ĤI 

〉 R denotes the first-order contribution in the first commutator. The 

remaining time-dependency ˆ̃HI(−τ) is approximated by 

ˆ̃HI(−τ) ≈ e−i/ℏ(ĤS+ĤR)τ ĤIe i/ℏ(ĤS+ĤR)τ , (A.12) 

as the double commutator in (A.11) is already of second order in the system-reservoir coupling. 

A.2. Master Equation of Lindblad Form 

This section specifies the Born-Markov master equation (A.10) to the Lindblad master equation for the special case of a harmonic oscillator coupled to a thermal bath of harmonic oscillators. The system Hamiltonian reads 

ĤS = ℏωâ†â , (A.13) 

where ω is the oscillator frequency and â (â†) denotes the bosonic annihilation (cre-ation) operator of the system oscillator. With the bosonic bath annihilation (creation) 

operators b̂j (b̂†j) the bath Hamiltonian is of similar form 

ĤB = ∑ 

j 

ℏΩj b̂ † j b̂j , (A.14) 

with the bath frequencies Ωj . Finally, the system-reservoir coupling reads 

ĤI = ℏg ∑ 

j 

( â†b̂j + âb̂†j 

) . (A.15) 

Here, g denotes the interaction strength, which is assumed to be much smaller than the frequencies ω,Ωj , i.e., g ≪ ω,Ω. The thermal state at temperature T of the bath is governed by the reservoir density matrix [27] 

ρ̂R = ∏ 

j 

e−ℏωj b̂ † j b̂j/(kBT ) 

( 1− e−ℏωj/(kBT ) 

) . (A.16) 

For this system, the first order term in (A.11) vanishes, as it is proportional to 〈 b̂ 〉 R = 0. 

For the same reason, ĤI reduces to ĤI . The expression ∫∞ 0 dτ trRĤI 

ˆ̃HI(τ)ρ̂S(t)ρ̂R/ℏ2 allows for deriving the second order terms explicitly. Inserting the corresponding oper-ators yields 

1 

ℏ2 

∫ ∞ 

0 dτ trRĤI 

ˆ̃HI(−τ)ρ̂S(t)ρ̂R = 

g2 ∑ 

j 

∫ ∞ 

0 dτ [ â†â(n̄j + 1)ei(ω−Ωj)τ + ââ†n̄je−i(ω−Ωj)τ 

] ρ̂S(t) , 

(A.17) 

where n̄j = 〈 b̂†j b̂j 

〉 R 

denotes the only surviving second order expectation value of the 

reservoir. In order to further work out the time integral, the reservoir sum is turned into an integral with the corresponding density of states D(Ω) [39, 45] 

∑ 

j 

n̄je i(ω−Ωj)τ ≈ 

∫ ∞ 

−∞ dΩ n̄(Ω)D(Ω)ei(ω−Ω)τ . (A.18) 

145

A. Harmonic Oscillator Coupled to a Bosonic Heat Bath 

For large times τ , the integral (A.18) has a non-vanishing value, iff ω ≈ Ω. Thus, further approximation turns the sum into a Dirac-δ function [45] 

∑ 

j 

n̄je i(ω−Ωj)τ ≈ 2πn̄(ω)D(ω)δ(τ) . (A.19) 

Inserting (A.19) into the expression (A.17) yields 

1 

ℏ2 

∫ ∞ 

0 dτ trRĤI 

ˆ̃HI(−τ)ρ̂S(t)ρ̂R ≈ g2πD(ω) { â†â[n̄(ω) + 1] + ââ†n̄(ω) 

} ρ̂S(t) . (A.20) 

The remaining terms in the double commutator in the Born-Markov master equation (A.10) can be treated in the same way. Summarising all the terms yields the Linblad master equation for a harmonic oscillator coupled to a thermal bath of harmonic oscil-lators 

˙̂ρS(t) ≈ − i 

ℏ 

[ ℏωâ†â, ρs(t) 

] − γ 

2 

{ [n̄(ω) + 1]L[â] + n̄(ω)L[â†] 

} ρ̂S(t) , (A.21) 

where 

L[x̂]ρ̂S = x̂†x̂ρ̂S + ρ̂S x̂ †x̂− 2x̂ρ̂S x̂ 

† (A.22) 

denotes the Linblad superoperator and γ = 2πg2D(ω) the rate of the corresponding processes. The equation of motion for the expectation value of the occupation n(t) = 

〈 â†â 〉 (t) yields 

a physical interpretation of the master equation (A.21). By using ṅ(t) = tr ( â†â ˙̂ρS(t) 

) 

the equation of motion for n takes the form 

ṅ(t) = γ(−n(t) + n̄) , (A.23) 

with the solution 

n(t) = n0e −γt + n̄ 

( 1− e−γt 

) , (A.24) 

where n0 is the initial cavity occupation. The solution (A.24) reveals the bath pushing the system into the bath’s steady state with the rate γ. In the case n̄ = 0, which occurs for instance for an optical cavity at room temperature, the solution (A.24) tends to 0. In the master equation (A.21) only the first Lindblad superoperator survives, revealing its interpretation as a pure dissipator. Thus, the second Lindblad superoperator pumps particles into the system, establishing the finite steady state limt→∞ n(t) = n̄. The equation (A.21) builds the foundation for describing incoherent processes, as they occur due to incoherent pumping, like in subsection 1.1.2 for pump and dissipative processes in the laser or in subsection 1.3.4 for describing incoherent absorption and emission processes in the photon BEC setup. Hence, the reasoning outlined in this appendix can be straightforwardly generalised to more involved system-bath couplings, while the ideas and the general interpretations do not change. 

146

## B. Effective Steady State of Temperature 

The thermo-optic photon-photon interaction introduced in subsection 1.3.1 highly de-pends on the temperature diffusion inside the microcavity. In particular, the strength of the thermo-optic interaction is proportional to the temperature accumulated during a single experiment, as figure 1.13 a) depicts. This is especially important, as the maxi-mum condensate lifetime is limited by the dye bleaching, as outlined in subsection 1.3.1 and in section 8.5. Therefore, this appendix deals with the quasi steady-state of the temperature amplitude during a whole experimental sequence, as it is depicted in figure 1.13 c). As the temperature decay time τ is much larger than the condensate lifetime texp, a δ-function peak models the temperature gain ∆T during a single experiment. For the detailed timescales, consider figure 1.13 a). The temperature gain is connected to the heating rate B, the condensate lifetime texp and the photon number N in a single pump pulse via 

∆T = texpBN . (B.1) 

In this appendix, ∆T is assumed to be equal throughout an experimental cycle. Hence, the equation 

Ṫ = −1 

τ T +∆T 

M∑ 

n=1 

δ(t−∆tn) (B.2) 

describes the temperature amplitude during a whole sequence of M experiments, each separated by the time ∆t. A Dirac comb models the sequence of experiments heating the cavity. The first step for working out the solution of (B.2) is to consider a single pulse at t = ∆t. Integrating equation (B.2) from ∆t− ϵ to ∆t+ ϵ and taking the limit ϵ → 0 yields the temperature gain ∆T during this pulse. For t > ∆t, equation (B.2) reduces to a simple decay equation. Hence, for a single pulse at t = ∆t the temperature amounts to 

T = 

{ 0 , 0 ≤ t < ∆t 

∆Te−(t−∆t)/τ , t ≥ ∆t . (B.3) 

Combining now two δ-function peaks leads with the same reasoning to 

T = 

   

0 , 0 ≤ t < ∆t 

∆Te−(t−∆t)/τ ,∆t ≤ t < 2∆t 

∆T ( 1 + e−∆t/τ 

) e−(t−2∆t)/τ , t ≥ 2∆t 

. (B.4) 

Therefore, the temperature amplitude TM after M experiments, i.e., TM = T (∆tM) takes the recursive form 

TM = ∆T + TM−1e −∆t/τ , (B.5) 

147

B. Effective Steady State of Temperature 

0 2 4 6 8 10 t/ 

0.0 

0.5 

1.0 

1.5 

2.0 

2.5 

T/ T 

numerical solution TM from (B.6) Tmax 

Fig. B.1: Comparison of the solutions of the temperature equation (B.2) for ∆t = τ/2. The blue line is the direct numerical solution of (B.2), whereas the orange markers indicate the temperature amplitude right after a δ-function peak from the explicit expression (B.6). The dashed green line indicates the maximal temperature (B.7). 

with T1 = ∆T and formally defining T0 = 0. Bringing (B.5) into explicit form and solving the resulting geometric series yields for the total temperature 

TM = ∆T 1− e−M∆t/τ 

1− e−∆t/τ . (B.6) 

The maximum temperature of (B.6) corresponds to the limit M → ∞ and is given by 

Tmax = ∆T 

1− e−∆t/τ . (B.7) 

Equation (B.7) shows how the maximal temperature depends on ∆T and the ratio ∆t/τ . Figure B.1 compares the different solutions with each other. In the case of ∆t ≫ τ subsequent experiments do not influence each other, as here Tmax = ∆T , i.e., the maximally reached temperature is just the one from a single experiment. On the other hand, realistic experimental settings [71] amount to τ ∼ 1 s and ∆t ≈ 8ms, realising the opposite case τ ≫ ∆t. With (B.1) the maximal temperature (B.7) acquires the form 

Tmax = στBN , (B.8) 

where σ = texp/∆t is the so-called duty cycle of the experiment, which has in most experiments the value σ = 1/16 000 due to the condensate lifetime texp = 500 ns. Thus, the larger the duty cycle, i.e., the condensate lifetime, the larger the interaction. The result (B.8) already shows that a theory working with a CW pump, as it is assumed in chapters 2 and 4, has to average over the different pump pulses. 

148

## C. Derivation of Microscopic Model 

For a full description of photon Bose-Einstein condensation, a deeper understanding of the microscopic absorption and emission processes of photons with dye molecules is ne-cessary. Molecules are complex structures built of atomic nuclei and electrons, which all interact with each other. Therefore, not only the pure electronic transitions, but also the molecular vibrations contribute to the absorption and re-emission processes. This electron-phonon coupling is at the focus of section C.1. Starting with the fun-damental Hamiltonian of a molecule, this section derives the effective Hamiltonian for only two electronic levels coupled to phononic excitations of the molecule in the form of a Spin-Boson model. Subsequently, section C.2 couples the resulting Hamiltonian to a single photonic mode, constituting the microscopic model of a photon BEC. The section continues with deriving the photon BEC master equation (8.18). For this pur-pose, the molecule-photon Hamiltonian dynamics is enriched by the external dissipative processes. After tracing out the phononic degrees of freedom by means of a Lindblad master equation as in appendix A, this more complex model yields the photon BEC master equation (8.18). In contrast to the derivation of the Lindblad master equation in appendix A, the interaction picture used in this section has to be modified in order to include the external dissipative processes. The arising dissipative interaction picture [151, 152] allows for using the Born-Markov master equation (A.11) as a starting point. 

C.1. Molecular Hamiltonian 

The generic Hamiltonian of a molecule 

Ĥmol = T̂N + T̂e + V (r̂, R̂) (C.1) 

does not only contain the kinetic energy T̂N of the nuclei, but also the kinetic energy T̂e of the electrons and the interaction V (r̂, R̂), which depends on both, the electron position r̂ and the position of the nuclei R̂. The details of the Hamiltonian (C.1) are not of interest for the purpose of this appendix, but can be found in textbooks of molecular physics, e.g., [153, 154]. The Born-Oppenheimer approximation assumes the timescales of the nuclei and the electrons to be separated, such that the electrons adiabatically depend upon the nuclear motions. Thus, assuming only two electronic levels, |g⟩ and |e⟩ for ground and excited state, respectively, the adiabatic Hamiltonian (C.1) takes the form [155–158] 

Ĥmol = |g⟩ ⟨g| Ĥg(R̂) + |e⟩ ⟨e| Ĥe(R̂) , (C.2) 

where the Hamiltonians 

Ĥg/e(R̂) = T̂N + ℏΩg/e(R̂) (C.3) 

describe the nuclear energies in the electronic ground and excited state, respectively, which depend on the electronic energies ℏΩg/e(R̂) themselves. Expanding the energies 

149

C. Derivation of Microscopic Model 

ℏΩ•(R̂) around the potential minimum allows for writing the nuclear Hamiltonians in the form of harmonic oscillators, such that the nuclear Hamiltonian (C.3) for the electronic ground state can be written in the form 

Ĥg = ∑ 

i 

( p̂2i 2mi 

+ miω 

2 i q̂ 

2 i 

2 

) + ℏΩ0g . (C.4) 

Here, p̂i and q̂i denote the operators for the excitations of nuclear equilibrium configu-rations in the electronic ground state, mi the corresponding masses and ωi the accom-panying oscillation eigenfrequencies. Note that the index i also includes the different polarisation degrees of freedom. The displacements di accounting for a different nuclear equilibrium position slightly alter the nuclear Hamiltonian for the excited electronic state, such that 

Ĥe = ∑ 

i 

[ p̂2i 2mi 

+ miω 

2 i (q̂i + di) 

2 

2 

] + ℏΩ0e . (C.5) 

Note that the displacement di is also responsible for the Stokes shift, i.e., a relative shift between the maxima of the absorption and emission spectrum, respectively. In the following, it is more convenient to shift the nuclear coordinates to q̂i → q̂i + di/2 and the energies to the energy gap ∆ = Ω0e − Ω0g. These shifts allow for introducing the 

standard harmonic-oscillator ladder operators b̂i for the phononic degrees of freedom. Hence, the Hamiltonians (C.4) and (C.5) can be brought to the form 

Ĥg/e = ∑ 

i 

ℏωib̂ † i b̂i ∓ 

∑ 

i 

ℏωi 

√ Si 

( b̂†i + b̂i 

) ∓ ℏ∆ 

2 + ∑ 

i 

ℏωiSi , (C.6) 

where the upper signs are for the ground state and the lower signs for the excited state. Moreover, Si = mωid 

2 i /(8ℏ) denotes the Huang-Rhys factor [156, 158], which denotes 

the coupling of the corresponding phonon state to the electronic transition. Note that in standard photon BEC models [83, 84] the Huang-Rhys factor is assumed to be the same for all modes. Inserting the Hamiltonians (C.6) into the total molecular Hamiltonian (C.2) finally yields 

Ĥmol = ∑ 

i 

ℏωib̂ † i b̂i + 

[ ℏ∆ 2 

+ ∑ 

i 

ℏ √ Si 

( b̂†i + b̂i 

)] σ̂z . (C.7) 

Here, the representations Î = |g⟩ ⟨g|+ |e⟩ ⟨e| and σ̂z = |e⟩ ⟨e| − |g⟩ ⟨g| for the electronic identity and the electronic population are used. Moreover, the constant energy shift∑ 

i ℏωiSi has been neglected. Hence, the molecule is effectively modelled by a two-level system with energy spacing ∆ coupled to a bath of harmonic oscillators. 

C.2. Photon BEC Master Equation 

The remaining chapter derives the master equation for a photon BEC, as used in [33, 83, 84, 152]. In order to simplify the derivation, only a single cavity mode and a single molecule is considered. Within this simplification, the molecular Hamiltonian (C.7) 

150

C.2. Photon BEC Master Equation 

coupled to the photon mode with frequency Ω, denoted by â, in the sense of Jaynes-Cummings, as introduced in subsection 1.1.2 and in references [28, 39], builds the total Hamiltonian as 

Ĥ = ℏΩâ†â+ 

[ ℏ∆ 2 

+ ∑ 

i 

ℏ √ Si 

( b̂†i + b̂i 

)] σ̂z + g 

( â†σ̂− + âσ̂+ 

) , (C.8) 

where g denotes the light-matter coupling strength and â (â†) is the photonic annihilation (creation) operator. The polaron transformation Ĥ = ÛĤÛ †, where the transformation is defined by 

Û = exp 

{ σ̂z ∑ 

i 

√ Si ωi 

( b̂†i − b̂i 

)} , (C.9) 

allows for treating the electron-phonon coupling up to infinite order [33, 83, 84, 152]. This is essential for the thermalisation of the photon gas inside the cavity, as the trans-formation also includes multi-phonon processes. In the result, the Hamiltonian (C.8) takes the form 

Ĥ = ℏΩâ†â+ ∑ 

i 

ℏωib̂ † i b̂i + 

ℏ∆ 2 σ̂z + ℏg 

( â†σ̂−D̂− + âσ̂+D̂+ 

) , (C.10) 

with the polaron displacement operator 

D̂± = exp 

{ ± ∑ 

i 

2 √ Si ωi 

( b̂†i − b̂i 

)} . (C.11) 

The system is subject to loss and external pump processes. Therefore, the Hamiltonian (C.10) is not sufficient for the description. Instead, the following master equation with the dissipator D is considered: 

˙̂ρ = − i 

ℏ 

[ Ĥ, ρ̂ 

] −Dρ̂ , (C.12) 

where D includes the cavity loss κ, the emission into non-cavity modes Γ↓ and the external pump rate Γ↑ and has the form: 

Dρ̂ = 1 

2 

{ κL[â] + Γ↓L[σ̂−] + Γ↑L[σ̂+] 

} ρ̂ , (C.13) 

with the Lindblad superoperator L[x̂]ρ̂ as defined in (A.22). As a remark for later usage, note that the right-hand side of the intermediate master equation (C.12) can be summarised by the Liouvillian L, such that the total time evolution of the density matrix is formally given by 

ρ̂(t) = eLtρ̂(0) . (C.14) 

As the processes captured in the Lindblad part in equation (C.12) already present a bath for the whole system, it also effects the “inner” bath of the phonons. Hence, this model is also called bath-in-the-bath or nested model. In the following, the phonon bath is assumed to be in a thermal steady state and, there-fore, eliminated from the dynamics by means of a master equation approach as in ap-pendix A. This comes together with the standard assumption for the Kennard-Stepanov 

151

C. Derivation of Microscopic Model 

relation, in which the vibrational degrees of freedom of a molecule are thermalised to their surroundings before and after the photon emission [76, 77]. In order to achieve this, the “dissipative interaction picture” turns out to replace the standard interaction picture used in the derivation of the Born-Markov master equation (A.11). This kind of interaction picture was developed in [151] and used in [152]. As in appendix A, the following parts of the total Hamiltonian (C.10) are identified. The system Hamiltonian ĤS is given by 

ĤS = ℏΩâ†â+ ℏ∆ 2 σ̂z + ℏg 

( â†σ̂− 

〈 D̂− 〉 R + âσ̂+ 

〈 D̂+ 〉 R 

) , (C.15) 

where ⟨•̂⟩R = trR(•̂ρR) denotes the expectation value with respect to the thermal phonon bath and ρR the respective phonon density matrix. The reservoir Hamiltonian reads 

ĤR = ∑ 

i 

ℏωib̂ † i b̂i . (C.16) 

Using ∆D̂± = D̂± − 〈 D̂± 〉 R , the interaction Hamiltonian is given by 

ĤI = ℏg ( â†σ̂−∆D̂− + âσ̂+∆D̂+ 

) . (C.17) 

Note that most references, which derive the photon BEC master equation, do not con-sider this. So far, only [33] takes this mandatory rewriting of the Hamiltonian into account. 

Dissipative Interaction Picture In section A.1 the interaction picture was defined with respect to ĤS+ĤR. Now, this interaction picture is modified to also include the influence of the Lindbladian part of the intermediate master equation (C.12), which describes the influence of the outer bath. This is most conveniently done by the dissipative interaction picture [151], which is formally defined by 

ρ̂ = e(LS+LR+LD)t ˆ̃ρ , (C.18) 

where L• denotes the Liouvillian superoperator with respect to the evolution with ĤS , ĤR, D. The adjoint equation of motion allows adapting equation (C.18) to the operator level. In general, the adjoint equation of an operator X̂ with a Hamiltonian ĥ 

and Lindbladian L [ Ŷ ] , where Ŷ is some jump operator, has the form 

˙̂ X = 

i 

ℏ 

[ ĥ, X̂ 

] − L† 

[ Ŷ ] X̂ , (C.19) 

with the adjoint Lindbladian 

L† [ Ŷ ] X̂ = 

[ X̂, Ŷ † 

] Ŷ + Ŷ † 

[ Ŷ , X̂ 

] . (C.20) 

The first term in (C.19) represents the standard Heisenberg equation of motion for the operator X̂, whereas the second term takes into account the open-dissipative dynamics. On formal grounds the adjoint Liouvillian L† summarises the right-hand side of equation (C.19), such that, analogously to (C.14), the formal solution to the adjoint equation can be written down as 

X̂(t) = eL †tX̂(0) . (C.21) 

152

C.2. Photon BEC Master Equation 

Hence, inverting (C.21) with the adjoint Liouvillian L† = L† S + L† 

R + L† D yields the 

operator X̂(t) in the dissipative interaction picture to be [151] 

ˆ̃X(t) = e−(L† S+L† 

R+L† D)tX̂. (C.22) 

In particular, this implies for the appearing time-dependent interaction Hamiltonian ˆ̃H(−τ) in the Born-Markov master equation (A.11) [151] 

ˆ̃HI(−τ) = e(L † S+L† 

R+L† D)τ ĤI , (C.23) 

which looks like the formal solution (C.21) to the adjoint equation with the appropriate Liouvillians corresponding to (C.15), (C.16) and (C.13). Equation (C.23) generalises the interaction-picture representation of (A.12) to a dissipative-interaction picture. Note that the time in (C.23) is inverted with respect to (A.12), which is due to the derivation of (C.23) via the adjoint equation of motion. As in (A.12) the evolution due to the system Liouvillian is only with respect to ĤS , as the corresponding term in the Born-Markov equation is already of second order in the system-reservoir coupling. Conclusively, the Born-Markov master equation (A.11) for the photon BEC takes the form [151, 152] 

˙̂ρS(t) = − i 

ℏ 

[ ĤS , ρ̂S(t) 

] −Dρ̂S(t)− 

1 

ℏ2 

∫ ∞ 

0 dτ trR 

[ ĤI , 

[ e(L 

† S+L† 

R+L† D)τ ( ĤI 

) , ρ̂S(t)ρ̂R 

]] , 

(C.24) 

with the Hamiltonians for the system (C.15), the interaction (C.17) and the dissipator (C.13). Before continuing with the actual derivation of the photon BEC master equation, the dissipative interaction picture for the appearing operators is summarised. As all the operators in the interaction Hamiltonian (C.17) are defined on different Hilbert spaces, it is sufficient to take into account the corresponding part of the adjoint equation (C.19). This amounts for the photon operators to 

d 

dt â = 

( −iΩ− κ 

2 

) â , (C.25) 

such that the time evolution of the photon annihilation operator takes the form 

â(t) = e(−iΩ−κ/2)tâ . (C.26) 

In the same manner, one finds for the electron operators 

σ̂−(t) = e[−i∆−(Γ↑+Γ↓)/2]tσ̂− (C.27) 

and, finally, for the phonon displacement operators 

D̂±(t) = exp 

   ∑ 

j 

2 √ Sj 

ωj 

( b̂†je 

iωjt − b̂je −iωjt 

)    . (C.28) 

153

C. Derivation of Microscopic Model 

Master Equation The final step for deriving the photon BEC master equation consists in evaluating the reservoir trace for the double commutator in (C.24). First, the single term 

Ŝ(t) = 1 

ℏ2 

∫ ∞ 

0 dτ trR 

{ ĤIe 

(L† S+L† 

R+L† D)τ ( ĤI 

) ρ̂S(t)ρ̂R 

} (C.29) 

with the interaction Hamiltonian (C.17) is considered. With the time-dependent oper-ators (C.26)–(C.28) the only two surviving terms read 

Ŝ(t) = g2 { â†âσ̂−σ̂+K∗(δ) + ââ†σ̂+σ̂−K∗(−δ) 

} ρ̂S(t) , (C.30) 

with the dye-cavity detuning δ = Ω−∆ and the reservoir-correlation function [33] 

K(δ) = g2 ∫ ∞ 

0 dτ (〈 D̂−(τ)D̂+ 

〉 R − 〈 D̂−(τ) 

〉 R 

〈 D̂+ 〉 R 

) e(iδ−Γ/2)τ , (C.31) 

depending on the total damping Γ = κ + Γ↑ + Γ↓. Note that in addition to [33, 83, 84] the cavity decay κ also contributes to the correlation function [152]. Reference [33] provides a detailed modelling of the phonon bath and the corresponding treatment of the arising bath expectation values in the reservoir-correlation function (C.31). Treating the remaining terms in the double commutator in (C.24) in the same way yields 

Ĉ(t) = − 1 

ℏ2 

∫ ∞ 

0 dτ trR 

[ ĤI , 

[ e(L 

† S+L† 

R+L† D)τ ( ĤI 

) , ρ̂S(t)ρ̂R 

]] 

= [ â†σ̂−, âσ̂+ρ̂S(t) 

] K∗(δ) + 

[ âσ̂+, â†σ̂−ρ̂S(t) 

] K∗(−δ) 

+ [ ρ̂S(t)â 

†σ̂−, âσ̂+ ] K(δ) + 

[ ρ̂S(t)âσ̂ 

−, â†σ̂+ ] K(−δ) . 

(C.32) 

In the photon BEC field, it is standard to only consider the real part of the correlation function (C.31) and to neglect the Lamb shift [33, 83, 84], which arises from the corres-ponding imaginary part. In doing so, the double commutator (C.32) acquires the form of two Lindblad terms 

Ĉ(t) = −1 

2 

{ γ+L 

[ âσ̂+ 

] + γ−L 

[ â†σ̂− 

]} ρ̂S(t) , (C.33) 

where γ+ = 2ReK(δ) describes the incoherent absorption and γ− = 2ReK(−δ) the incoherent emission processes. These two terms are essential for the description of the photon BEC as they introduce photon thermalisation. Therefore, the Born-Markov master equation (C.24) now takes the form 

˙̂ρS(t) = − i 

ℏ 

[ ĤS , ρ̂S(t) 

] −Dρ̂S(t)− 

1 

2 

{ γ+L 

[ âσ̂+ 

] + γ−L 

[ â†σ̂− 

]} ρ̂S(t) , (C.34) 

which is of the same form as the master equation (8.18), apart from the additional phase diffusion, which does not stem from the interaction with the molecules. 

154

## Bibliography 

[1] W. Schadewaldt, Homer: Die Odyssee, 2nd ed. (Rowohlt Taschenbuch Verlag, Reinbek bei Hamburg, 2010). 

[2] L. Albert, Greek Mythology, 1st ed. (Adams Media, Stoughton, MA, 2021). 

[3] Wikimedia Commons, File:circe offering the cup to odysseus.jpg — wikimedia commons, the free media repository, (2022) https://commons.wikimedia.org/ w/index.php?title=File:Circe_Offering_the_Cup_to_Odysseus.jpg& 

oldid=685619230 (visited on 31/08/2022). 

[4] Wikimedia Commons, File:osiris-apis mgeg inv22847-9.jpg — wikimedia com-mons, the free media repository, (2020) https://commons.wikimedia.org/ 

w/index.php?title=File:Osiris- Apis_MGEg_Inv22847- 9.jpg&oldid= 

456075386 (visited on 31/08/2022). 

[5] Wikimedia Commons, File:serapis pio-clementino inv689 n2.jpg — wikimedia commons, the free media repository, (2020) https://commons.wikimedia.org/ w/index.php?title=File:Serapis_Pio-Clementino_Inv689_n2.jpg&oldid= 

470276013 (visited on 31/08/2022). 

[6] D. Graeber and D. Wengrow, The Dawn of Everything, 1st ed. (Farrar, Straus and Giroux, New York, 2021). 

[7] M. Niehaus and M. Wink, Wie man Männer in Schweine verwandelt und sich vor solch üblen Tricks schützt, 1st ed. (Hirzel Verlag, Stuttgart, 2020). 

[8] H. Kloft, Mysterienkulte der Antike, 4th ed. (C. H. Beck, München, 2019). 

[9] H. Heinen, Geschichte des Hellenismus, 2nd ed. (C. H. Beck, München, 2007). 

[10] M. Beard, S.P.Q.R, 1st ed. (Profile Books Ltd, London, 2016). 

[11] C. Nixey, The Darkening Age, 1st ed. (Pan Books, London, 2018). 

[12] W. Schadewaldt,Die Anfänge der Philosophie bei den Griechen, 10th ed. (Suhrkamp Verlag, Frankfurt am Main, 2017). 

[13] J. Anglin, ‘Quantum Optics: Particles of Light’, Nature 468, 517 (2010). 

[14] S. I. Newton, Opticks: Or, A Treatise of the Reflections, Refractions, Inflections and Colours of Light, 4th ed. (1730). 

[15] C. Huygens, Abhandlung über das Licht: worin die Ursachen der Vorgänge bei seiner Zurückwerfung und Brechung und besonders bei der eigentümlichen Brechung des isländischen Spates dargelegt sind; (1678), 4. Aufl., Reprint [der Ausg.] Leipzig, Engelmann, Ostwalds Klassiker der exakten Wissenschaften 20 (Verlag Harri Deutsch, Thun [u.a.] Deutsch, 1996). 

[16] J. C. Maxwell, A treatise on electricity and magnetism, 2nd ed., Vol. I (Oxford, 1881). 

[17] A. Einstein, ‘Zur Elektrodynamik bewegter Körper’, Annalen der Physik und Chemie Jg. 17, 891 (1905). 

155

Bibliography 

[18] M. Planck, ‘Über eine Verbesserung der Wienschen Spektralgleichung (1)’, Ver-handlungen der Deutschen Physikalischen Gesellschaft 2, 202 (1900). 

[19] M. Planck, ‘Zur Theorie des Gesetzes der Energieverteilung im Normalspektrum’, Verhandlungen der Deutschen Physikalischen Gesellschaft 2, 237 (1900). 

[20] M. Planck, ‘Über das Gesetz der Energieverteilung im Normalspektrum’, Drudes Annalen, 553 (1901). 

[21] A. Einstein, ‘Über einen die Erzeugung und Verwandlung des Lichtes betreffenden heuristischen Gesichtspunkt’, Drudes Annalen, 132 (1905). 

[22] M. Born, ‘Zur Quantenmechanik der Stoßvorgänge’, Z. Physik 26, 863 (1926). 

[23] L. D. Landau and E. M. Lifschitz, Lehrbuch der theoretischen Physik, 9th ed., Vol. III, Quantenmechanik (Wissenschaftlicher Verlag Harri Deutsch GmbH, Frank-furt am Main, 2012). 

[24] C. J. Pethick and H. Smith, Bose–Einstein Condensation in Dilute Gases, 2nd ed. (Cambridge University Press, Cambridge, 2008). 

[25] Pitaevskii, L. and Stringari, S., Bose-Einstein Condensation and Superfluidity, 1st ed. (Oxford University Press, Oxford, 2016). 

[26] H. T. C. Stoof, K. B. Gubbels and D. B. M. Dickerscheid, Ultracold Quantum Fields, 1st ed. (Springer Dordrecht, 2009). 

[27] L. D. Landau and E. M. Lifschitz, Lehrbuch der theoretischen Physik, 8th ed., Vol. V, Statistische Physik, Teil 1 (Wissenschaftlicher Verlag Harri Deutsch GmbH, Frankfurt am Main, 2008). 

[28] H. Haken, Laser Theory, 1st ed. (Springer Berlin, Heidelberg, 1984). 

[29] H. Haken, Licht und Materie II, 1st ed. (Bibliographisches Institut, Zürich, 1981). 

[30] A. Einstein, ‘Strahlungs-Emission und -Absorption nach der Quantentheorie’, Verhandlungen der Deutschen Physikalischen Gesellschaft 18, 318 (1916). 

[31] E. Jaynes and F. Cummings, ‘Comparison of quantum and semiclassical radiation theories with application to the beam maser’, Proceedings of the IEEE 51, 89 (1963). 

[32] W. Kopylov, M. Radonjić, T. Brandes, A. Balaž and A. Pelster, ‘Dissipative two-mode Tavis-Cummings model with time-delayed feedback control’, Phys. Rev. A 92, 063832 (2015). 

[33] M. Radonjić, W. Kopylov, A. Balaž and A. Pelster, ‘Interplay of coherent and dissipative dynamics in condensates of light’, New J. Phys. 20, 055014 (2018). 

[34] J. Dalibard, Y. Castin and K. Mølmer, ‘Wave-function approach to dissipative processes in quantum optics’, Phys. Rev. Lett. 68, 580 (1992). 

[35] R. Dum, P. Zoller and H. Ritsch, ‘Monte Carlo simulation of the atomic master equation for spontaneous emission’, Phys. Rev. A 45, 4879 (1992). 

[36] S. Krämer, D. Plankensteiner, L. Ostermann and H. Ritsch, ‘Quantumoptics. jl: a julia framework for simulating open quantum systems’, Computer Physics Communications 227, 109 (2018). 

[37] R. J. Glauber, ‘Coherent and Incoherent States of the Radiation Field’, Phys. Rev. 131, 2766 (1963). 

156

Bibliography 

[38] E. C. G. Sudarshan, ‘Equivalence of Semiclassical and Quantum Mechanical De-scriptions of Statistical Light Beams’, Phys. Rev. Lett. 10, 277 (1963). 

[39] H. J. Carmichael, Statistical Methods in Quantum Optics 1, 1st ed. (Springer Berlin, Heidelberg, 1999). 

[40] C. Gardiner and P. Zoller, Quantum Noise, 2nd ed. (Springer-Verlag Berlin, Heidelberg, 2000). 

[41] D. W. Barry and P. D. Drummond, ‘Qubit phase space: SU(n) coherent-state P representations’, Phys. Rev. A 78, 052108 (2008). 

[42] S. Mandt, D. Sadri, A. A. Houck and H. E. Türeci, ‘Stochastic differential equa-tions for quantum dynamics of spin-boson networks’, New J. of Phys. 17, 053018 (2015). 

[43] C. D. Mink, D. Petrosyan and M. Fleischhauer, ‘Hybrid discrete-continuous trun-catedWigner approximation for driven, dissipative spin systems’, arXiv: 2203.17120 (2022). 

[44] H. Risken, The Fokker-Planck Equation, 2nd ed. (Springer Berlin, Heidelberg, 1996). 

[45] H. Haken, Synergetics - an introduction, 1st ed. (Springer-Verlag Berlin, Heidel-berg, 1977). 

[46] I. Carusotto and C. Ciuti, ‘Quantum fluids of light’, Rev. Mod. Phys. 85, 299 (2013). 

[47] M. Wimmer, M. Monika, I. Carusotto, U. Peschel and H. M. Price, ‘Superfluidity of Light and Its Breakdown in Optical Mesh Lattices’, Phys. Rev. Lett. 127, 163901 (2021). 

[48] R. Boyd, Nonlinear Optics, 4th ed. (Academic Press, London, 2020). 

[49] F. T. Arecchi, G. Giacomelli, P. L. Ramazza and S. Residori, ‘Vortices and defect statistics in two-dimensional optical chaos’, Phys. Rev. Lett. 67, 3749 (1991). 

[50] G. A. Swartzlander and C. T. Law, ‘Optical vortex solitons observed in Kerr nonlinear media’, Phys. Rev. Lett. 69, 2503 (1992). 

[51] T. Frisch, Y. Pomeau and S. Rica, ‘Transition to dissipation in a model of super-flow’, Phys. Rev. Lett. 69, 1644 (1992). 

[52] K. Staliunas, ‘Laser Ginzburg-Landau equation and laser hydrodynamics’, Phys. Rev. A 48, 1573 (1993). 

[53] H. Deng, H. Haug and Y. Yamamoto, ‘Exciton-polariton Bose-Einstein condens-ation’, Rev. Mod. Phys. 82, 1489 (2010). 

[54] J. Bloch, I. Carusotto and M. Wouters, ‘Non-equilibrium Bose–Einstein condens-ation in photonic systems’, Nat. Rev. Phys. 4, 470 (2022). 

[55] C. Weisbuch, M. Nishioka, A. Ishikawa and Y. Arakawa, ‘Observation of the coupled exciton-photon mode splitting in a semiconductor quantum microcavity’, Phys. Rev. Lett. 69, 3314 (1992). 

[56] R. Houdré, C. Weisbuch, R. P. Stanley, U. Oesterle, P. Pellandini and M. Ilegems, ‘Measurement of Cavity-Polariton Dispersion Curve from Angle-Resolved Photo-luminescence Experiments’, Phys. Rev. Lett. 73, 2043 (1994). 

157

Bibliography 

[57] L. S. Dang, D. Heger, R. André, F. Bœuf and R. Romestain, ‘Stimulation of Polariton Photoluminescence in Semiconductor Microcavity’, Phys. Rev. Lett. 81, 3920 (1998). 

[58] H. Deng, G. Weihs, C. Santori, J. Bloch and Y. Yamamoto, ‘Condensation of Semiconductor Microcavity Exciton Polaritons’, Science 298, 199 (2002). 

[59] J. Kasprzak, M. Richard, S. Kundermann, A. Baas, P. Jeambrun, J. M. J. Keeling, F. M. Marchetti, M. H. Szymańska, R. André, J. L. Staehli, V. Savona, P. B. Littlewood, B. Deveaud and L. S. Dang, ‘Bose–Einstein condensation of exciton polaritons’, Nature 443, 409 (2006). 

[60] Y. Sun, P. Wen, Y. Yoon, G. Liu, M. Steger, L. N. Pfeiffer, K. West, D. W. Snoke and K. A. Nelson, ‘Bose-Einstein Condensation of Long-Lifetime Polaritons in Thermal Equilibrium’, Phys. Rev. Lett. 118, 016602 (2017). 

[61] R. M. Stevenson, V. N. Astratov, M. S. Skolnick, D. M. Whittaker, M. Emam-Ismail, A. I. Tartakovskii, P. G. Savvidis, J. J. Baumberg and J. S. Roberts, ‘Continuous Wave Observation of Massive Polariton Redistribution by Stimulated Scattering in Semiconductor Microcavities’, Phys. Rev. Lett. 85, 3680 (2000). 

[62] D. N. Krizhanovskii, D. Sanvitto, A. P. D. Love, M. S. Skolnick, D. M. Whittaker and J. S. Roberts, ‘Dominant Effect of Polariton-Polariton Interactions on the Coherence of the Microcavity Optical Parametric Oscillator’, Phys. Rev. Lett. 97, 097402 (2006). 

[63] E. del Valle, D. Sanvitto, A. Amo, F. P. Laussy, R. André, C. Tejedor and L. Viña, ‘Dynamics of the Formation and Decay of Coherence in a Polariton Condensate’, Phys. Rev. Lett. 103, 096404 (2009). 

[64] K. G. Lagoudakis, M. Wouters, M. Richard, A. Baas, I. Carusotto, R. André, L. S. Dang and B. Deveaud-Plédran, ‘Quantized vortices in an exciton–polariton condensate’, Nature Physics 4, 706 (2008). 

[65] A. Amo, J. Lefrère, S. Pigeon, C. Adrados, C. Ciuti, I. Carusotto, R. Houdré, E. Giacobino and A. Bramati, ‘Superfluidity of polaritons in semiconductor mi-crocavities’, Nature Physics 5, 805 (2009). 

[66] M. Wouters and V. Savona, ‘Stochastic classical field model for polariton con-densates’, Phys. Rev. B 79, 165302 (2009). 

[67] M. Wouters and I. Carusotto, ‘Excitations in a Nonequilibrium Bose-Einstein Condensate of Exciton Polaritons’, Phys. Rev. Lett. 99, 140402 (2007). 

[68] V. N. Gladilin and M. Wouters, ‘Interaction and motion of vortices in nonequi-librium quantum fluids’, New J. Phys. 19, 105005 (2017). 

[69] V. N. Gladilin and M. Wouters, ‘Normal and superfluid fractions of inhomogen-eous nonequilibrium quantum fluids’, Phys. Rev. B 93, 134511 (2016). 

[70] J. Klaers, J. Schmitt, F. Vewinger and M. Weitz, ‘Bose–Einstein condensation of photons in an optical microcavity’, Nature 468, 545 (2010). 

[71] J. Klaers, J. Schmitt, T. Damm, F. Vewinger and M. Weitz, ‘Bose–Einstein con-densation of paraxial light’, Appl. Phys. B 105, 17 (2011). 

[72] J. Schmitt, ‘Dynamics and correlations of a Bose–Einstein condensate of photons’, J. Phys. B: At. Mol. Opt. Phys. 51, 173001 (2018). 

158

Bibliography 

[73] J. Klaers, F. Vewinger and M. Weitz, ‘Thermalization of a two-dimensional photo-nic gas in a ‘white wall’ photon box’, Nat. Phys. 6, 512 (2010). 

[74] N. D. Mermin and H. Wagner, ‘Absence of Ferromagnetism or Antiferromagnet-ism in One- or Two-Dimensional Isotropic Heisenberg Models’, Phys. Rev. Lett. 17, 1133 (1966). 

[75] P. C. Hohenberg, ‘Existence of Long-Range Order in One and Two Dimensions’, Phys. Rev. 158, 383 (1967). 

[76] E. H. Kennard, ‘On The Thermodynamics of Fluorescence’, Phys. Rev. 11, 29 (1918). 

[77] B. I. Stepanov, ‘Universal Relation Between the Absorption Spectra and Lumi-nescence Spectra of Complex Molecules’, Dokl. Akad. Nauk 112, 839 (1957). 

[78] J. Keeling and N. G. Berloff, ‘Spontaneous Rotating Vortex Lattices in a Pumped Decaying Condensate’, Phys. Rev. Lett. 100, 250401 (2008). 

[79] E. Stein, ‘Open-Dissipative Mean-Field Theory for Photon Bose-Einstein Con-densates’, Diploma Thesis (Technische Universität Kaiserslautern, 2018). 

[80] H. Alaeian, M. Schedensack, C. Bartels, D. Peterseim and M. Weitz, ‘Thermo-optical interactions in a dye-microcavity photon Bose–Einstein condensate’, New J. Phys. 19, 115009 (2017). 

[81] N. Mann, M. R. Bakhtiari, F. Massel, A. Pelster and M. Thorwart, ‘Driven Bose-Hubbard model with a parametrically modulated harmonic trap’, Phys. Rev. A 95, 043604 (2017). 

[82] A. L. Fetter and D. Rokhsar, ‘Excited states of a dilute Bose-Einstein condensate in a harmonic trap’, Phys. Rev. A 57, 1191 (1998). 

[83] P. Kirton and J. Keeling, ‘Nonequilibrium Model of Photon Condensation’, Phys. Rev. Lett. 111, 100404 (2013). 

[84] P. Kirton and J. Keeling, ‘Thermalization and breakdown of thermalization in photon condensates’, Phys. Rev. A 91, 033826 (2015). 

[85] J. Keeling and P. Kirton, ‘Spatial dynamics, thermalization, and gain clamping in a photon condensate’, Phys. Rev. A 93, 013829 (2016). 

[86] R. I. Moodie, P. Kirton and J. Keeling, ‘Polarization dynamics in a photon Bose-Einstein condensate’, Phys. Rev. A 96, 043844 (2017). 

[87] F. E. Öztürk, T. Lappe, G. Hellmann, J. Schmitt, J. Klaers, F. Vewinger, J. Kroha and M. Weitz, ‘Fluctuation dynamics of an open photon Bose-Einstein condensate’, Phys. Rev. A 100, 043803 (2019). 

[88] M. Vlaho, H. A. M. Leymann, D. Vorberg and A. Eckardt, ‘Controlled two-mode emission from the interplay of driving and thermalization in a dye-filled photonic cavity’, Phys. Rev. Research 1, 033191 (2019). 

[89] M. Vlaho and A. Eckardt, ‘Nonequilibrium mode competition in a pumped dye-filled cavity’, Phys. Rev. A 104, 063709 (2021). 

[90] F. E. Öztürk, T. Lappe, G. Hellmann, J. Schmitt, J. Klaers, F. Vewinger, J. Kroha and M. Weitz, ‘Observation of a non-Hermitian phase transition in an optical quantum gas’, Science 372, 88 (2021). 

159

Bibliography 

[91] O. L. Berman, R. Y. Kezerashvili and Y. E. Lozovik, ‘On Bose-Einstein condens-ation and superfluidity of trapped photons with coordinate-dependent mass and interactions’, J. Opt. Soc. Am. B 34, 1649 (2017). 

[92] N. S. Voronova and Y. E. Lozovik, ‘On the Position-Dependent Effective Mass in Bose Condensates of Photons and Polaritons in an Optical Microcavity Trap’, JETP Letters 108, 791 (2018). 

[93] V. N. Gladilin and M. Wouters, ‘Classical field model for arrays of photon con-densates’, Phys. Rev. A 101, 043814 (2020). 

[94] V. N. Gladilin and M. Wouters, ‘Vortices in Nonequilibrium Photon Condensates’, Phys. Rev. Lett. 125, 215301 (2020). 

[95] V. N. Gladilin and M. Wouters, ‘Vortex unbinding transition in nonequilibrium photon condensates’, Phys. Rev. A 104, 043516 (2021). 

[96] V. N. Gladilin and M. Wouters, ‘Vortex-pair annihilation in arrays of photon cavities’, Phys. Rev. A 105, 013527 (2022). 

[97] V. L. Berezinskii, ‘Destruction of long-range order in one-dimensional and two-dimensional systems possessing a continuous symmetry group. II. Quantum sys-tems’, Sov. Phys. JETP 34, 610 (1972). 

[98] J. M. Kosterlitz and D. J. Thouless, ‘Ordering, metastability and phase transitions in two-dimensional systems’, J. Phys. C: Solid State Phys. 6, 1181 (1973). 

[99] Z. Hadzibabic, P. Krüger, M. Cheneau, B. Battelier and J. Dalibard, ‘Berezin-skii–Kosterlitz–Thouless crossover in a trapped atomic gas’, Nature 441, 1118 (2006). 

[100] Z. Hadzibabic, P. Krüger, M. Cheneau, S. P. Rath and J. Dalibard, ‘The trapped two-dimensional Bose gas: from Bose–Einstein condensation to Berezinskii–Koster-litz–Thouless physics’, New J. Phys. 10, 045006 (2008). 

[101] J. Schmitt, T. Damm, . Vewinger, M. Weitz and J. Klaers, ‘Thermalization of a two-dimensional photon gas in a polymeric host matrix’, New J. Phys. 14, 075019 (2012). 

[102] R. Weill, A. Bekker, B. Levit and B. Fischer, ‘Bose-Einstein condensation of photons in an erbium-ytterbium co-doped fiber cavity’, Nat. Commun. 10, 747 (2019). 

[103] R. Weill, A. Bekker, B. Levit and B. Fischer, ‘Bose-Einstein condensation of photons in a long fiber cavity’, Opt. Express 29, 27807 (2021). 

[104] D. Dung, C. Kurtscheid, T. Damm, J. Schmitt, F. Vewinger, M. Weitz and J. Klaers, ‘Variable potentials for thermalized light and coupled condensates’, Nat. Photonics 11, 565 (2017). 

[105] C. Kurtscheid, D. Dung, A. Redmann, E. Busley, J. Klaers, F. Vewinger, J. Schmitt and M. Weitz, ‘Realizing arbitrary trapping potentials for light via direct laser writing of mirror surface profiles’, EPL (Europhysics Letters) 130, 54001 (2020). 

[106] C. Kurtscheid, D. Dung, E. Busley, F. Vewinger, A. Rosch and M.Weitz, ‘Thermal-ly condensing photons into a coherently split state of light’, Science 366, 894 (2019). 

160

Bibliography 

[107] E. Busley, L. E. Miranda, A. Redmann, C. Kurtscheid, K. K. Umesh, F. Vewinger, M. Weitz and J. Schmitt, ‘Compressibility and the equation of state of an optical quantum gas in a box’, Science 375, 1403 (2022). 

[108] B. T. Walker, B. Ash, A. A. P. Trichet, J. M. Smith and R. A. Nyman, ‘Bespoke mirror fabrication for quantum simulation with light in open-access microcavities’, Opt. Express 29, 10800 (2021). 

[109] S. Maruo, O. Nakamura and S. Kawata, ‘Three-dimensional microfabrication with two-photon-absorbed photopolymerization’, Opt. Lett. 22, 132 (1997). 

[110] M. Deubel, G. von Freymann, M. Wegener, S. Pereira, K. Busch and C. M. Soukoulis, ‘Direct laser writing of three-dimensional photonic-crystal templates for telecommunications’, Nature Mat. 3, 444 (2004). 

[111] S. Wong, M. Deubel, F. Pérez-Willard, S. John, G. A. Ozin, M. Wegener and G. von Freymann, ‘Direct laser writing of three-dimensional photonic crystals with a complete photonic bandgap in chalcogenide glasses’, Adv. Mater. 18, 265 (2006). 

[112] J. K. Hohmann, M. Renner, E. H. Waller and G. von Freymann, ‘Three-dimensional µ-printing: an enabling technology’, Adv. Optical Mater. 3, 1488 (2015). 

[113] M. Vretenar and B. Kassenberg and S. Bissesar and C. Toebes and J. Klaers, ‘Controllable Josephson junction for photon Bose-Einstein condensates’, Phys. Rev. Research 3, 023167 (2021). 

[114] M. Vretenar, C. Toebes and J. Klaers, ‘Modified Bose-Einstein condensation in an optical quantum gas’, Nat. Commun. 12, 5749 (2021). 

[115] J. Schmitt, T. Damm, D. Dung, C. Wahl, F. Vewinger, J. Klaers and M. Weitz, ‘Spontaneous Symmetry Breaking and Phase Coherence of a Photon Bose-Einstein Condensate Coupled to a Reservoir’, Phys. Rev. Lett. 116, 033604 (2016). 

[116] T. Damm, D. Dung, F. Vewinger, M. Weitz and J. Schmitt, ‘First-order spa-tial coherence measurements in a thermalized two-dimensional photonic quantum gas’, Nat. Commun. 8, 158 (2017). 

[117] T. Damm, J. Schmitt, Q. Liang, D. Dung, F. Vewinger, M. Weitz and J. Klaers, ‘Calorimetry of a Bose-Einstein-Condensed Photon Gas’, Nat. Commun. 7, 11340 (2016). 

[118] J. Klaers, J. Schmitt, T. Damm, F. Vewinger and M. Weitz, ‘Statistical Physics of Bose-Einstein-Condensed Light in a Dye Microcavity’, Phys. Rev. Lett. 108, 160403 (2012). 

[119] F. E. Öztürk, F. Vewinger, M. Weitz and J. Schmitt, ‘Fluctuation-dissipation relation for a Bose-Einstein condensate of photons’, arXiv:2203.13255 (2022). 

[120] V. V. Kocharovsky, V. V. Kocharovsky, M. Holthaus, C. H. Raymond Ooi, A. Svidzinsky, W. Ketterle and M. O. Scully, ‘Fluctuations in Ideal and Interact-ing Bose– Einstein Condensates: From the Laser Phase Transition Analogy to Squeezed States and Bogoliubov Quasiparticles’, in Advances in atomic, molecu-lar, and optical physics, Vol. 53, edited by G. Rempe and M. Scully (Academic Press, 2006), p. 291. 

[121] J. Schmitt, T. Damm, D. Dung, F. Vewinger, J. Klaers and M.Weitz, ‘Observation of Grand-Canonical Number Statistics in a Photon Bose-Einstein Condensate’, Phys. Rev. Lett. 112, 030401 (2014). 

161

Bibliography 

[122] R. A. Nyman and B. T. Walker, ‘Bose-Einstein condensation of photons from the thermodynamic limit to small photon numbers’, J. Mod. Opt. 65, 754 (2017). 

[123] B. T. Walker, L. C. Flatten, H. J. Hesten, F. Mintert, D. Hunger, A. A. P. Trichet, J. M. Smith and R. A. Nyman, ‘Driven-dissipative non-equilibrium Bose–Einstein condensation of less than ten photons’, Nat. Phys. 14, 1173 (2018). 

[124] J. D. Rodrigues, H. S. Dhar, B. T. Walker, J. M. Smith, R. F. Oulton, F. Mintert and R. A. Nyman, ‘Learning the Fuzzy Phases of Small Photonic Condensates’, Phys. Rev. Lett. 126, 150602 (2021). 

[125] J. Schmitt, T. Damm, D. Dung, F. Vewinger, J. Klaers and M. Weitz, ‘Thermal-ization kinetics of light: From laser dynamics to equilibrium condensation of photons’, Phys. Rev. A 92, 011602 (2015). 

[126] B. T. Walker, J. D. Rodrigues, H. S. Dhar, R. F. Oulton, F. Mintert and R. A. Nyman, ‘Non-stationary statistics and formation jitter in transient photon con-densation’, Nat. Commun. 11, 1390 (2020). 

[127] J. Marelic and R. A. Nyman, ‘Experimental evidence for inhomogeneous pumping and energy-dependent effects in photon Bose-Einstein condensation’, Phys. Rev. A 91, 033813 (2015). 

[128] J. Marelic, L. F. Zajiczek, H. J. Hesten, K. H. Leung, E. Y. X. Ong, F. Mintert and R. A. Nyman, ‘Spatiotemporal coherence of non-equilibrium multimode photon condensates’, New J. Phys. 18, 103012 (2016). 

[129] S. Greveling, K. L. Perrier and D. van Oosten, ‘Density distribution of a Bose-Einstein condensate of photons in a dye-filled microcavity’, Phys. Rev. A 98, 013810 (2018). 

[130] S. Greveling, F. van der Laan, K. L. Perrier and D. van Oosten, ‘The Effective Interaction Strength in a Bose-Einstein Condensate of Photons in a Dye-Filled Microcavity’, arXiv: 1712.07922 (2017). 

[131] S. Greveling, F. van der Laan, H. C. Jagers and D. van Oosten, ‘Polarization of a Bose-Einstein Condensate of Photons in a Dye-Filled Microcavity’, arXiv: 1712.08426 (2017). 

[132] C. Toebes, M. Vretenar and J. Klaers, ‘Dispersive and dissipative coupling of photon Bose-Einstein condensates’, Commun. phys. 5, 59 (2022). 

[133] P. Muruganandam and S. Adhikari, ‘Fortran Programs for the Time-Dependent Gross–Pitaevskii Equation in a Fully Anisotropic Trap’, Comput. Phys. Commun. 180, 1888 (2009). 

[134] D. Vudragović, I. Vidanović, A. Balaž, P. Muruganandam and S. K. Adhikari, ‘C Programs for Solving the Time-Dependent Gross–Pitaevskii Equation in a Fully Anisotropic Trap’, Comput. Phys. Commun. 183, 2021 (2012). 

[135] L. E. Young-S., D. Vudragović, P. Muruganandam, S. K. Adhikari and A. Balaž, ‘OpenMP Fortran and C Programs for Solving the Time-Dependent Gross–Pitaevs-kii Equation in an Anisotropic Trap’, Comput. Phys. Commun. 204, 209 (2016). 

[136] A. Görlitz, J. M. Vogels, A. E. Leanhardt, C. Raman, T. L. Gustavson, J. R. Abo-Shaeer, A. P. Chikkatur, S. Gupta, S. Inouye, T. Rosenband and W. Ketterle, ‘Realization of Bose-Einstein Condensates in Lower Dimensions’, Phys. Rev. Lett. 87, 130402 (2001). 

162

Bibliography 

[137] T. Lausch, A. Widera and M. Fleischhauer, ‘Role of thermal two-phonon scatter-ing for impurity dynamics in a low-dimensional Bose-Einstein condensate’, Phys. Rev. A 97, 033620 (2018). 

[138] B. Klünder and A. Pelster, ‘Systematic semiclassical expansion for harmonically trapped ideal Bose gases’, Eur. Phys. J. B 68, 457 (2009). 

[139] V. Bagnato and D. Kleppner, ‘Bose-Einstein condensation in low-dimensional traps’, Phys. Rev. A 44, 7439 (1991). 

[140] V. I. Yukalov, ‘Modified semiclassical approximation for trapped Bose gases’, Phys. Rev. A 72, 033608 (2005). 

[141] W. Ketterle and N. J. van Druten, ‘Bose-Einstein condensation of a finite number of particles trapped in one or three dimensions’, Phys. Rev. A 54, 656 (1996). 

[142] P. B. Blakie and M. J. Davis, ‘Projected Gross-Pitaevskii equation for harmonic-ally confined Bose gases at finite temperature’, Phys. Rev. A 72, 063608 (2005). 

[143] P. B. Blakie, A. Bradley, M. Davis, R. J. Ballagh and C. Gardiner, ‘Dynamics and statistical mechanics of ultra-cold Bose gases using c-field techniques’, Adv. Phys. 57, 363 (2008). 

[144] S. J. Rooney, P. B. Blakie and A. S. Bradley, ‘Stochastic projected Gross-Pitaevskii equation’, Phys. Rev. A 86, 053634 (2012). 

[145] K. K. Umesh, ‘Investigation of 3D-printed potentials for photon gases’, Master Thesis (Rheinische Friedrich-Wilhelms-Universität Bonn, 2021). 

[146] Private Communication with F. Vewinger. 

[147] T. Förster, ‘Zwischenmolekulare Energiewanderung und Fluoreszenz’, Annalen der Physik 437, 55 (1948). 

[148] J. R. Lakowicz, Principles of Fluorescence Spectroscopy, 3rd ed. (Springer New York, NY, 2006). 

[149] H.-P. Breuer and F. Petruccione, The theory of open quantum systems, 1st ed. (Oxford University Press, Oxford, 2002). 

[150] C. Cohen-Tannoudji, J. Dupont-Roc and G. Grynberg, Atom-Photon Interactions - Basic Processes and Applications, 1st ed. (Wiley-VCH Verlag GmbH & Co. KGaA, Weinheim, 2004). 

[151] A. Mari and J. Eisert, ‘Cooling by Heating: Very Hot Thermal Light Can Signi-ficantly Cool Quantum Systems’, Phys. Rev. Lett. 108, 120602 (2012). 

[152] A. Erglis and S. Y. Buhmann, ‘Nested Open Quantum Systems Approach to Photonic Bose−Einstein Condensation’, arXiv: 2203.11039 (2022). 

[153] H. Haken and H. C. Wolf, Molekülphysik und Quantenchemie, 5th ed. (Springer Berlin, Heidelberg, 2006). 

[154] W. Demtröder, Experimentalphysik 3, 5th ed. (Springer Spektrum Berlin, Heidel-berg, 2016). 

[155] M. Born and K. Huang, Dynamical theory of crystal lattices, 1st ed. (Oxford University Press, London, 1954). 

[156] K. Huang and A. Rhys, ‘Theory of light absorption and non-radiative transitions in F -centres’, Proceedings of the Royal Society of London. Series A. Mathematical and Physical Sciences 204, 406 (1950). 

163

Bibliography 

[157] J. J. Markham, ‘Interaction of Normal Modes with Electron Traps’, Rev. Mod. Phys. 31, 956 (1959). 

[158] S. Mukamel, Principles of nonlinear optical spectroscropy, 1st ed. (Oxford Uni-versity Press, New York, 1995). 

164

## Acknowledgement 

Es gebeuten mich nun die Zeit mit der Dissertation zum Ende zu kommen und die Höflichkeit ins Deutsche zu wechseln, damit ich vielen Leuten, die mich beim Entstehen dieser Arbeit untersützt haben, meinen Dank zu überbringen vermag. Zuvörderst geht mein größter Dank an meine Familie; meinen Eltern Claudia und Wer-ner, meiner Tante Andrea, meinen Großeltern Ella und Helmut sowie Inge und Bernd, die nun leider das Ende meiner Arbeit nicht mehr mitfeiern können. Eure Unterstützung, die mich während meines ganzen Lebens vom Kindergarten, über Schule bis hin zum Stu-dium und nun zur Promotion, begleitet hat, ist durch nichts aufzuwiegen. Als letztem in dieser Reihe danke ich meinem Freund Maxwell, der mir die letzten Monate meines Doktorantenlebens zu ertragen und aufzulockern half. Die zweite Runde des Dankes geht an die wissenschaftlichen Kollegen. Hier gilt mein größter Dank meinem Betreuer Axel Pelster, der mit viel Humor und Engangement, mir immer mit Rat und Tat zur Seite stand und auch die Teilnahme an vielen Konferenzen ermöglichte. In diesem Atemzug muß ich auch Michael Fleischhauer danken, der mich in seine Arbeitsgruppe aufnahm und zu Beginn auch unter seine Fittiche packte. Mein Dank gilt auch individuell den studentischen Mitgliedern der Gruppe, Max, Chris, Julius, Maddin, Brady, Simon, Carsten und Dennis, die doch dabei halfen, den Arbeitsalltag und die Entstehung dieser Dissertation zu überleben. Dies ermöglichten auch längere Weggefährten wie Christoph Dauer, der mich bereits seit dem ersten Semester aushält und immer noch mit mir redet, André Becker, der die Ehre hatte ein Büro mit mir zu teilen und meinen Humor am eigenen Leibe zu erfahren. Für Ablenkung vom alltäglichen Frust gilt mein Dank dem Nachbrenner-Team sowie meinem Trinkgefährten Robert Meyer, der einige Donnerstagabende (und manche Frei-tagmorgen) für ein gepflegtes Bier opferte. Etwas ernstere Ablenkung ermöglichte mir die jDPG – sowohl die Regionalgruppe als auch der Bundesverband – mit vielen interes-santen Veranstaltungen, an denen ich teilnehmen konnte, und vor allem auch mit vielen Möglichkeiten, bei denen ich mich einbringen und auch austoben konnte. Last, but not least danke ich allen, die ein Teil meiner Doktorarbeit Korrektur gelesen hatten – ich erhielt durchweg gute und konstruktive Kritik! In dem Sinne bleibt mir zum Abschlusse dieser Arbeit nur noch zu sagen: 

Ich danke euch! 

165

Lebenslauf 

Persönliche Daten 

Name Enrico Stein Addresse Konrad-Adenauer-Straße 63, 67663 Kaiserslautern Telefon +49 160/9696 7231 E-Mail estein@rhrk.uni-kl.de 

Geburtsdatum 21. Februar 1994 in Ruthweiler Nationalität Deutsch 

Ausbildung 

September 2018-aktuell Promotion Thema „Dimensional Crossover in Photon Bose-Einstein Condensates“ Gruppe „Theoretische Quantenoptik“, Prof. Dr. Michael Fleischhauer, 

Technische Universität Kaiserslautern Betreuer PD Dr. Axel Pelster 

Geplantes Ende Herbst 2022 

Mai 2013-Juli 2018 Studium der Physik Universität Technische Universität Kaiserslautern Juli 2018 Diplom (Note: 1.1) 

2004 – 2013 Gymnasium Schule Staatliches Gymnasium Kusel 

Ehrenamtliche Tätigkeiten 

November 2017-November 2019 

Mitglied im Bundesvorstand für berufsvorbereitendes Programm der jungen Deutschen Physikalischen Gesellschaft (jDPG) der Deutschen Physikalischen Gesellschaft e.V. (DPG) Organisation bundesweiter Berufsvorbereitungsseminare 

März 2017-März 2018 

Studentischer Vertreter im Organisationskomitee der 82. Jahrestagung der DPG und Frühjahrstagung der SAMOP 

Januar 2015-November 2017 

Vorsitzender der Regionalgruppe Kaiserslautern der jDPG 

Dezember 2013-aktuell 

Aktives Engagement in der jDPG 

1/2

Konferenz- und Seminarorganisation ausgewählte Konferenzen: 

März 2019 Konferenzvorsitz des Arbeitskreises jDPG 83. Jahrestagung der DPG und DPG Frühjahrstagung der Sektion Atome, Moleküle, Plasmaphysik und Quantenoptik (SAMOP), Rostock 

ausgewählte Konferenzbeiträge 06. März 2018 Podiumsdiskussion: „The Future of our Publication System“, mit Uwe Kahlert 

und Esther Tobschall 82. Jahrestagung der DPG und DPG Frühjahrstagung der SAMOP, Erlangen 

06. März 2017 Symposium „Driven-Dissipative Quantum Systems“ DPG Frühjahrstagung der SAMOP, Mainz 

ausgewählte bundesweite Veranstaltungen der jDPG: 25.-27. Oktober 2019 Wochenendseminar „Wirtschaft & Wissenschaft - Optik in Jena“, Jena 

28.-30. Juni 2019 Berufsvorbereitung: Lehramt Physik, Freiburg 10.-12. Oktober 2017 Bundesexkursion, München 

21.-23. Juli 2017 Berufsvorbereitungsseminar, Kaiserslautern 29.-30. April 2017 (G)Astro (Seminar über Astronomie und Gastronomie), Bad Kreuznach 

Publikationen E. Stein, F. Vewinger, and A. Pelster, NJP 21, 103044 (2019) Collective Modes of a Photon Bose-Einstein Condensate with Thermo-Optic Interac-tion 

E. Stein, and A. Pelster, NJP 24, 023013 (2022) Thermodynamics of Trapped Photon Gases at Dimensional Crossover from 2D to 1D 

E. Stein, and A. Pelster, NJP 24, 023032 (2022) Photon BEC with Thermo-Optic Interaction at Dimensional Crossover 

Sprachen Deutsch Muttersprache Englisch fließend in Wort und Schrift 

Interessen Literatur, Kunst, (Indoeuropäische) Sprachen, klassische Philologie Altertumskunde, Musik 

2/2