# The Complex Ginzburg-Landau equation for beginners W. van Saarloos Instituut Lorentz, University of Leiden P. O. Box 9506, 2300

**The Complex Ginzburg-Landau equation for beginners **

W. van Saarloos 

Instituut Lorentz, University of Leiden P. O. Box 9506, 2300 RA Leiden 

The Netherlands 

This article appeared in Spatio-temporal Patterns in Nonequilibrium Complex Systems, eds. P. E. Cladis and P. Palffy-Muhoray, Santa Fe Institute, Studies in the Sciences of Complexity, proceedings XXI (Addison-Wesley, Reading, 1994) 

Scope of this chapter 

Several systems discussed at this workshop on Spatio-Temporal Patterns in Non-equilibrium Complex Systems have been related to or analyzed in the context of the so-called Complex Ginzburg-Landau equation (CGL). What is the difference between the physics underlying the usual amplitude description for stationary patterns and the one underlying the CGL? Why are there many more stable coherent structures [pulses, sources (holes), sinks] possible in systems described by the CGL than in systems exhibiting a stationary bifurcation, and what is their relation, if any, to the chaotic behavior that is characteristic of the CGL in some parameter regimes? The organizers of this workshop have asked me to try to provide some answers to these questions for the non-expert, someone with an interest in pattern formation but who has not had an introduction to the CGL before or who has not followed the recent developments in this field. Since there are several very recent review papers on this subject[3],[8],[9],[12] where a more thorough and detailed discussion can be found1, I will confine myself here to a brief low-level introduction, in which I try to paint some of the main ideas with broad strokes. I stress that I do not pretend to give a balanced review — this chapter is extremely sketchy and coloured by my own interests, and I urge the reader interested in learning more about this line of research to consult the papers cited above and the references therein. 

The CGL as an Amplitude equation 

Amplitude equations describe the slow modulation in space and time near the threshold for an instability. Imagine we consider a system which initially is in a basic state which is homogeneous (e.g. the purely conductive state of a Rayleigh-Bénard cell), and which exhibits a finite wave length instability when one of the parameters is varied. We can always define an appropriately rescaled control pa-rameter ε, so that this instability occurs when ε becomes positive. The existence of a finite wave length instability means that when we consider the evolution of a Fourier mode exp[−iΩt + ikx], the growth rate ImΩ of each mode k behaves as sketched in Figure 1. For ε < 0, all modes are decaying (ImΩ < 0), so the basic 

1Note that Ref.[12] was not written as an introductory review on the complex CGL approach, but as a research paper on the CGL equation; its main emphasis is on systematizing many (new) results for coherent structures in the one-dimensional equation. 

1

Figure 1: Behavior of the growth rate as a function of wave number k. 

Figure 2: Slow modulation of the critical modes for ε  1. The envelope is indicated with the dashed line. 

state is stable. If kc denotes the wave number of the mode whose growth rate is zero at ε = 0, then we see that there is a narrow band of width around kc where the growth rate is slightly positive (of order ε) for ε > 0. Let us assume that the transition to patterns corresponds to a supercritical bifurcation, meaning that the nonlinearities are saturating so that patterns slightly above threshold have a small amplitude. We then also expect that the patterns slightly above threshold2, i.e. for 0 < ε  1, will have a wave length close to 2π/kc. However, due to the fact 

that the width of the band of unstable modes is nonzero and of order ε 1 2 , there 

can be slow modulations of the patterns on length scales of order 1/ε 1 2 .3 Close 

to threshold, a typical physical field (the temperature field in a Rayleigh-Bénard cell, say) will therefore look like sketched in Figure 2. 

If ReΩ = 0, the amplitude of modes near kc is growing in time for ε > 0, but each mode is stationary in space. This situation arises near a bifurcation to stationary patterns. If ReΩ 6= 0, each mode corresponds to a traveling wave, so we will generally have ReΩ 6= 0 at a transition to traveling wave patterns. Let us first consider the case of a stationary bifurcation (ReΩ = 0). The separation of the dynamics of the patterns close to threshold in terms of a fast component (with the length scale set by the critical wave number) and an envelope that varies slowly in space and time, can then be formulated by writing the relevant field(s) close to threshold as follows: 

physical fields ∝ A(x, t)eikcx + A∗(x, t)e−ikcx + higher harmonics , (1) 

where A(x, t) is the complex amplitude or envelope, and where ‘higher harmonics’ stands for terms proportional to exp(2ikcx). For simplicity, we will consider here 

2Of course, if we start with special initial conditions, the wave number can be different during initial transients. 

3Just like in radio transmission a low frequency signal is transmitted by modulating a high frequency signal within a narrow band. 

2

only one dimension. To lowest order in ε, A then obeys an equation of the form 

τ0 ∂A 

∂t = ξ2 

0 

∂2A 

∂x2 + εA − g|A|2A , (g > 0) . (2) 

For a given problem, the constants τ0, ξ0 and g can in principle be calculated from the starting equations. As they only set the scales of time, length and of the size of the amplitude, we will rescale these here and write the equation in the rescaled form 

∂A 

∂t = 

∂2A 

∂x2 + εA − |A|2A . (3) 

A few remarks concerning this result are in order: (i) With an additional rescaling x → ε− 

1 2 x, t → ε−1t, A → ε 

1 2 A, ε can be 

scaled out of Eq. (3). This confirms that patterns evolve on long time scales ε−1 

and large length scales ε− 1 2 , and that the amplitude of the patterns grows as ε 

1 2 

as we had anticipated. Nevertheless, we prefer to keep ε explicit in (3), so as to avoid a control parameter dependent rescaling. Moreover, this will make it easier to consider what happens when ε changes through zero. 

(ii) Although the equation and the coefficients τ0 etc. can be calculated from the full equations describing the physical problem under study, this equa-tion arises naturally near any stationary supercritical bifurcation if the system is translation invariant and reflection symmetric (x → −x). The latter symme-try dictates that the second order term ∂2/∂x2 arises as the lowest order spatial derivative, while the form of the cubic term is prescribed by the requirement that the equation is invariant upon multiplying A by an arbitrary phase factor exp(iφ): according to (1) this corresponds to translating the pattern by a distance φ/kc, so translation invariance implies that the equation for A has to be invariant under A → Aeiφ.4 

(iii) Note that for ε > 0 Eq. (3) has stationary solutions of the form A = a0e iqx, 

with q2 = ε − a2 0. According to (1), these so-called phase winding solutions 

describe steady state periodic patterns with total wave number slightly bigger (q > 0) or slightly smaller (q < 0) than kc. We will come back to the stability of these solutions below. 

(iv) It is easy to check that Eq. (3) can be written in the form 

∂A 

∂t = − δF 

δA∗ , with F = ∫ 

dx 

  ∣∣∣∣∣ ∂A 

∂x 

∣∣∣∣∣ 2 

− ε|A|2 + 1 2 |A|4 

  , (4) 

from which it follows that dF/dt < 0. Thus, F plays the role of a ‘free energy’ or Lyapunov functional, and many aspects of the dynamics of patterns can simply be understood in terms of the tendency of patterns to evolve towards the ‘lowest free-energy’ state. In this sense, the dynamics of (3) is very thermodynamic-like. 

(v) Eq. (3) has the form of the Ginzburg-Landau equation for superconduc-tivity in the absence of a magnetic field. To distinguish it from the amplitude equation for traveling waves given below, we will refer to it as the real Ginzburg-Landau equation, since the coefficients in this equation are real. 

4The invariance under a change of the phase implies that the phase is a slow variable, whose dynamics is governed by a diffusion type equation. 

3

In the case in which a traveling wave mode of the form exp(−iΩct+ikcx) becomes unstable for ε = 0, the separation of the pattern into the critical mode and a slowly varying amplitude can then be done in essentially the same way as before; we now write5 

physical fields ∝ A(x, t)e−iΩct+ikcx+A∗(x, t)eiΩct−ikcx + higher harmonics . (5) 

In this case, the equation obeyed by A reads, after properly rescaling space, time and amplitude6, 

∂A 

∂t = (1 + ic1) 

∂2A 

∂x2 + εA − (1 − ic3)|A|2A . (6) 

This equation will be referred to as the Complex Ginzburg-Landau (CGL) equa-tion. How can we understand that the amplitude equation for traveling waves has complex coefficients in front of the second derivative and cubic term? To see this, note that for Eq. (3) we found a band of stationary phase winding solutions A = a0e 

ikcx; these correspond to a band of stationary patterns of the physical system that are periodic in space. For traveling waves, there is also a band of traveling wave solutions A = a0e 

−iωt+iqx with Imω = 0 to exist. Just like q mea-sures the difference between the wave number of the pattern and the critical wave number, so does ω measure the difference between the frequency of the pattern and the frequency of the critical mode, Ωc — after all there is in general no reason why the frequency should not depend on the wave number or on the amplitude of the pattern. Indeed, if we substitute the Ansatz A = a0e 

−iωt+iqx with Imω = 0 into Eq. (6), we obtain 

ω = c1q 2 − c3a 

2 0 , q2 = ε − a2 

0 . (7) 

The expression for ω illustrates that c1 is the coefficient that measures the strength of the linear dispersion, i.e. the dependence of the frequency of the waves on the wave number, while c3 is a measure of the nonlinear dispersion. We will see below that these terms can dramatically affect the stability of the phase winding solutions. 

Let us also make a number of brief comments on the CGL: (i) For traveling waves, the group velocity vgr ≡ ∂ω/∂k is generally nonzero. 

As it stands, Eq. (6) is written in the frame moving with the group velocity. In the laboratory frame, there is an additional term vgr∂A/∂x on the left hand side of the equation. This distinction is particularly important for determining whether the instability is convective or absolute. 

(ii) We have written only one CGL equation for a single amplitude. When the underlying system is symmetric under reflection7 (x → −x), both left- and right-moving traveling waves can exist. For such systems, one actually obtains two coupled CGL equations, one for the amplitude of the left-moving waves and one for the amplitude of the right-moving waves. Depending on the nonlinear 

5Note that ImΩ = 0 for k = kc. 6There are many different conventions for the imaginary parts of the coefficients in (5); here 

I follow the convention of Ref. [12]. 7This happens e.g. for traveling waves in binary mixtures, but not in the rotating Rayleigh-

Bénard cells discussed by Ecke and coworkers at this workshop. 

4

Figure 3: Illustration of the stability of phase winding solutions. (a) The stability diagram for c1 = c3 = 0 and for c1c3 > 1. (b) Sketch of three roll patterns in a Rayleigh-Bénard cell for q close to the left edge of the band of allowed solutions, q ≈ 0, and for a q close to the right edge of the band. 

interaction terms, one can either have a situation in which standing waves are favoured, or one in which one wave completely suppresses the other. In the latter case, one can effectively use a single CGL equation like (6). 

(iii) For c1, c3 6= 0, the CGL can not be derived from a Lyapunov functional or ‘free energy’. As a result, it displays a much richer type of dynamical behavior than the real Ginzburg-Landau equation (3). In fact, in the limit c1, c3 → ∞ the equation reduces to the Nonlinear Schrödinger equation, which is not only Hamiltonian but also integrable (it has the well-known soliton solutions). The fact that the CGL reduces to a relaxational equation in one limit and to a Hamiltonian equation in another limit makes the equation very interesting from a theoretical point of view. In addition, these two limits can be exploited as starting points for perturbation theories. 

Stability of phase winding solutions 

We saw above that both the real and the complex Ginzburg-Landau equation admit phase winding solutions with wave-vector −ε 

1 2 < q < ε 

1 2 . For the real 

equation these are stationary solutions that correspond to stationary periodic patterns in the band [kc − ε 

1 2 , kc + ε 

1 2 ], in the complex case these correspond 

to spacially periodic traveling wave solutions. What is the stability of these solutions? The linear stability analysis of these solutions is quite straightforward, and can be found in the various reviews cited. Here we just want to give the reader some intuitive understanding of the fact that in the region c1c3 > 1 all periodic solutions are linearly unstable (so-called Benjamin-Feir unstable). 

For the real case (c1, c3 = 0), the qualitative answer is well-known; consider the left part of Figure 3(a). For a given ε > 0, the values of q for which steady state solutions exist fall within the solid line. However, only the solutions within the dashed lines are stable — solutions corresponding to values of q in the hatched region, close to the edge of the band, are linearly unstable (sometimes called Eckhaus or Benjamin-Feir unstable). Intuitively, one may understand this as follows. A wave number q close to the left edge of the band corresponds to a 

5

Figure 4: Illustration of the dynamical process by which phase winding solutions with too large |q| go unstable. In (a) the complex envelope A is plotted as a function of x for three different times. Note that the plane perpendicular to the x-axis is a complex plane. In (b) the dynamics of |A| is sketched; at time t2 the phase slip center occurs. 

smaller total wave number of the pattern, and hence a larger wave length. When the wave length is too small, as illustrated for a roll pattern in a Rayleigh-Bénard cell on the left of Figure 3(b), the pattern is unstable because a roll is so wide that it will split into three. Likewise, a q near the right edge amounts to a pattern that is unstable because three narrow rolls like those in the right part of Figure 3(b) merge into one. Only patterns with wave length close to the critical one (those in the center of Figure 3(b) with q ≈ 0) are stable. Now, in the Rayleigh-Bénard example of Figure 3(b), the phase difference of Aeikcx between two points divided by 2π is equal to the number of pairs of rolls between these two points. Thus when three rolls merge into one or when one roll splits into three, the number of phase windings of A over a certain distance changes by one. But since the phase of A is well-defined and continuous whenever |A| is nonzero, the only way the number of phase windings can change discontinuously in a localized region is if at some point in time and space |A| = 0. At that point the phase is undefined, and so can ”slip” by 2π. These points are called phase slip centers. Figure 4 illustrates the rapid variation of the phase and the decrease in modulus |A| that lead to such behavior. 

We note that the analogous process is well known for the superconductivity of one-dimensionsal wires (thin enough that the magnetic field generated may be neglected). In Ginzburg-Landau theory, the supercurrent is proportional to the gradient of the phase, so phase winding solutions are current-carrying solutions. The wave number corresponding to a value on the dashed line of Figure 3(a) and beyond which the pattern is unstable, corresponds to the critical current: beyond the critical current, these current carrying solutions are unstable and lead to the generation of phase slips. In superconducting wires, there is also a small dissipation for currents slightly smaller than the critical current due to phase slips that are generated by thermal fluctuations — see [6] for details. 

When the parameters c1 and c3 in the CGL are nonzero but small, the stability of phase winding solutions is qualitatively the same as for the case c1 = c3 = 0 discussed above, with the band of stable solutions narrowing when c1 and c3 are of the same sign and increasing. However, when the product c1c3 equals one, the width of the band of stable solutions is zero, so that for c1c3 > 1 none of the phase winding solutions is stable, as illustrated on the right hand side of Figure 3(b). 

6

Figure 5: Four possible coherent structures in the one-dimensional CGL 

To get some feeling for why this happens8 note that we can combine the two Eqs. (6) to 

ω = εc3 + (c1 + c3)q 2 . (8) 

This equation shows that if we imagine a distortion of a phase winding solution in the case c1, c3 6= 0 so that the local wave number9 q (or, because of (7), the local modulus) varies with x, we see that regions with a different local wave number will rotate with a different frequency, and the phase gradients tend to increase, as if the spring-like pattern of Figure 4(a) is wound up more tightly. We can imagine that when c1 and c3 are large enough the difference in local frequencies tends to drive every perturbation unstable [and possibly towards the generation of a phase slip event illustrated in Figure (4)]. This is indeed what happens for c1c3 > 1. The fact that all phase winding solutions are unstable in this regime of the CGL leads to various types of chaotic behavior, and is one of the examples of the richness of behavior encountered in this equation — see e.g. the contribution by Chaté to this workshop. 

Coherent structures 

Another aspect of the CGL is that there is a larger variety of ‘coherent struc-tures’. These are solutions that are either themselves localized or that consist of domains of regular patterns connected by localized defects or interfaces. In two dimensions, a well known example is a spiral10, but we will confine ourselves here to summarizing the most important features of the one dimensional structures illustrated in Figure 5. 

Sources and Sinks Let us first consider solutions that connect one phase winding solution on the left 

8The following argument only partially ‘explains’ why this happens. In particular, it would suggest that only the combination c1 + c3 is important, whereas in reality the product c1c3 

determines the transition to the regime where all phase winding solutions are unstable: both linear and nonlinear dispersion need to be present. Another caveat: the argument below is not meant to suggest that phase slips always occur if all phase winding solutions are unstable. In the ‘phase chaos’ regime discussed by Chaté (see also [11]), one is indeed in the Benjamin-Feir unstable regime, but no phase slips are dynamically generated. 

9This is allowed since the Benjamin-Feir instability we are considering is essentially a long wave length instability. 

10See the contribution by Huber at this workshop. 

7

to another phase winding solution on the right. These are domain wall or shock type solutions. Since a traveling wave has a nonzero group velocity vgr, there are several possibilities depending on whether the group velocity of each phase winding solution points away from or towards the localized structure connecting the two asymptotic states. It is useful to use the group velocity ṽgr relative to the velocity v of this localized structure: ṽgr ≡ vgr − v. Thus ṽgr is the velocity with which a small perturbation to a phase winding solution travels in the frame moving with the domain wall between the two states we consider. If the relative group velocity points away from it on both sides, the localized structure has the properties of a source, while if ṽgr points inwards on both sides, we will call the domain wall a sink[4],[12]. In principle, solutions with the relative group velocity pointing in the same direction on both sides of the wall are also possible, but one can show [12] that such solutions do not exist in the cubic CGL (6). They should, however, exist in higher order extensions, like the quintic extension of the CGL mentioned below. In the real Ginzburg-Landau equation, most of the dynamics of domain walls can be understood in terms of the tendency of walls to move in the direction of the lowest ‘free energy’ state [see the discussion after (4)]. The behavior of sinks and sources in the CGL is more complicated. 

Sinks are in a sense relatively dull objects, since the very fact that the relative group velocities point inwards means that the waves it connects must come from some other regions in space. One then tends to focus on the dynamics in these regions. Nevertheless, the velocity of sinks is important during transients by determining which region shrinks and which one expands. For example, in two dimensions the arms of competing spirals form a sink type solution when they meet. In this case, it is known that the sink moves in the direction of the spiral with the smallest frequency. In this sense, the sink does play a role in determining which spiral survives. In the one dimensional CGL, there is typically a two-parameter family of sinks for not too large velocities [12]. This means that if we select two arbitrary asymptotic phase winding solutions on the left and right with group velocities pointing inwards, there is always a sink solution that connects these two states. I would intuitively expect such solutions to be stable, but their stability has, to my knowledge, not been studied in detail. 

Sources send out waves, and so may determine the large time asymptotic dynam-ics. On the basis of simple counting arguments [12], one generically expects the existence of a v = 0 source, as well as a discrete set of v 6= 0 solutions11. Surpris-ingly, however, Bekki and Nozaki[2] found a family of exact source solutions of (6); Hohenberg and I have taken this as a hint that there might be some hidden symmetry or some accidental nongenericity in the cubic CGL. Support for this point of view comes from recent work by Aranson et al.[1], who discovered that if a small perturbation is added to the CGL (6), the stability of these solutions depend sensitively on the sign and strength of this perturbation12. For certain ranges of the parameters c1 and c3, these source solutions play an important role in the chaotic dynamics of the CGL — see Chaté’s contribution or [1] for details. 

11In other words, one expects that in addition to the v = 0 solutions there are only solutions with particular values of the velocity and asymptotic wave numbers. 

12The stability of the Bekki-Nozaki solutions was recently studied by Sasa and Iwamoto, and by Manneville and Chaté. See [1] for references. 

8

Pulses The work on pulse type solutions of the type sketched in Figure 5 was moti-vated largely by observations of localized convective regions in experiments on binary mixtures by Niemela, Ahlers and Cannell, and by Kolodner13. Since the instability to traveling waves in this system actually corresponds to a subcritical bifurcation, this motivated a number of groups to study the following quintic extension of the CGL 

∂A 

∂t = (1 + ic1) 

∂2A 

∂x2 + εA + (1 − ic3)|A|2A − (1 − ic5)|A|4A . (9) 

Both perturbation expansions about the relaxational limit (ci → 0) and about the Hamiltonian limit14 (ci → ∞) have shown that there exist stable pulse solutions with zero velocity in large subcritical (ε < 0) ranges of the ε, c1, c3, c5 parameter space. Pulse solutions can go unstable by splitting into two fronts that move apart. Since they move apart, the long time properties of each front is given by that of a single front like that shown in Figure 5(a), so one can get information on the range of existence of pulses by analyzing the dynamics of a single front. Pulse solutions of (9) are stationary in the frame moving with the group velocity of the traveling waves; in principle, if one considers an amplitude expansion near a weakly first order subcritical bifurcation, in the same order as the quintic term |A|4A other nonlinear terms arise that give pulses a drift velocity slightly different from the group velocity. Experimentally, however, pulses are found to have a drift velocity much smaller than the group velocity [5]. Although this can be accounted for on an ad hoc basis by taking some of the parameters in the extension of (9) large, a more fundamental analysis [10] attributes the small drift velocity of pulses to the coupling with the concentration field. 

Fronts The dynamics of fronts in the cubic CGL (6) for ε > 0 is relatively well understood in terms of marginal stability selection criteria (see [12] and references therein). Because of their importance for the stability of pulse solutions, the dynamics of fronts both for ε < 0 and for ε > 0 has recently been studied in great detail[12]. It turns out that an exact nonlinear front solution can be found whose dynamics plays an important role in the selection of patterns. Together with a set of rules and conjectures, a fairly complete picture of the stability of pulses and of the dynamics of fronts emerges. Some of the surprising findings are: 

(i) In some ranges of the parameters, pulses can remain stable in the limit ε ↑ 0. In these regions of parameter space, fronts only advance into the state A = 0 for ε > 0, and dynamically the distinction between the supercritical and subcritical case seems to have blurred. 

(ii) For fronts to propagate into the state A = 0 the nonlinear dispersion has to be relatively small. 

(iii) It is possible to have fronts that propagate with the linear marginal stability speed but that are not uniformly translating. 

13See references in [10]. 14In the relaxational limit no stable pulse solutions exists; one then perturbs about the point 

where a front like that in Figure 5(a) has zero velocity. In the Hamiltonian limit, a two-parameter family of moving pulse solutions can be used as a starting point for a perturbation expansion. 

9

(iv) There are subcritical regions of parameter space where chaotic ‘slugs’ spread. 

(v) There are regions of parameter space in the limit ci → ∞ where there are dynamically important front solutions that can not be obtained perturbatively. 

Concluding remark 

In this brief and extremely elementary contribution, I have tried to introduce the CGL in relatively non-technical terms. Although the coherent structures dis-cussed do illustrate that the CGL exhibits much richer and complicated behavior than the real equation, this overview does not do justice to its full richness, nor does it do justice to the many other interesting results obtained by a number of groups. A full discussion of coherent structures should include the work by Coullet and co-workers[4] on transitions in domain wall motion and on defects. Moreover, most of the current work is focussed on patterns in two dimensions and on the chaotic behavior in one and two dimensions; though shocks and Bekki-Nozaki holes do appear to play a role in some of the chaotic regimes, the extent to which they drive the chaotic dynamics is far from understood. 

### **References **

[1] Aranson, I., L. Kramer, S. Popp, O. Stiller and A. Weber, Localized Hole Solutions and Spatio-Temporal Chaos in the 1d Complex Ginzburg-Landau Equation, submitted to Phys. Rev. Lett. 

[2] Bekki, N. and K. Nozaki, Phys. Lett. **A110, **133 (1985). 

[3] Cross, M. C., and P. C. Hohenberg, Pattern Formation Outside of Equilib-rium, to appear in Rev. Mod. Phys., July 1993. 

[4] See e.g. P. Coullet, T. Frisch and F. Plaza, Sources and sinks of wave pat-terns, Physica **62D, **75 and references therein. 

[5] Kolodner, P., Drifting Pulses of Traveling-Wave Convection, Phys. Rev. Lett. **66, **1165 (1991). 

[6] Langer, J. S. and V. Ambegaokar, Intrinsic resistive transition in narrow superconducting channels, Phys. Rev. **164, **498 (1967). 

[7] Newell, A. C., Envelope Equations, In: Lectures in Applied Mathematics, Nonlinear Wave Motion, **15, **157 (1974). 

[8] Newell, A. C., T. Passot and J. Lega, Order parameter equations for patterns, Ann. Rev. Fluid Mech. **25 **399 (1993). 

[9] Passot, T., and A. C. Newell, Towards a Universal Theory for Natural Pat-terns, preprint. See also the chapter in these proceedings. 

[10] Riecke, H., Self-trapping of traveling wave pulses in binary fluid mixture convection, Phys. Rev. Lett. **68, **301 (1992). 

10

[11] Shraiman, B. I., A. Pumir, W. van Saarloos, P. C. Hohenberg, H. Chaté and M. Holen, Spatiotemporal chaos in the one-dimensional complex Ginzburg-Landau equation, Physica **D57, **241 (1992). 

[12] van Saarloos, W., and P. C. Hohenberg, Fronts, pulses, sources and sinks in generalized complex Ginzburg-Landau equations, Physica **D56, **303 (1992). 

11