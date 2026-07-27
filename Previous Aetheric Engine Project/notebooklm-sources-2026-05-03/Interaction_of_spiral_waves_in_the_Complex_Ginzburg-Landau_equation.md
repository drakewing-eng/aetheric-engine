# Interaction of spiral waves in the Complex Ginzburg-Landau equation

Interaction of spiral waves in the Complex Ginzburg-Landau equation 

M. Aguareles,1 S.J. Chapman,2 and T. Witelski2 1Departament de Matemàtica Aplicada I, Universitat Politècnica de Catalunya, Diagonal 647, 08028 Barcelona (Spain) 

2OCIAM, Mathematical Institute, 24-29 St Giles’s, Oxford OX1 3LB (UK) (Dated: September 25, 2008) 

Solutions of the general cubic complex Ginzburg-Landau equation comprising multiple spiral waves are considered, and laws of motion for the centres are derived. The direction of the motion changes from along the line of centres to perpendicular to the line of centres as the separation increases, with the strength of the interaction algebraic at small separations and exponentially small at large separations. The corresponding asymptotic wavenumber and frequency are also determined, which evolve slowly as the spirals move. 

The complex Ginzburg-Landau equation is one of the most-studied nonlinear models in physics. It describes on a qualitative level, and in many important cases on a quantitative level, a great number of phenomena, from nonlinear waves to second-order phase transitions, in-cluding superconductivity, superfluidity, Bose-Einstein condensation, liquid crystals, and string theory [1]. 

The equation arises as the amplitude equation in the vicinity of a Hopf bifurcation in spatially extended sys-tems, and is therefore generic for active media displaying wave patterns. The simplest examples of such media are chemical oscillations such as the Belousov-Zhabotinsky reaction. More complex examples include thermal con-vection of binary fluids [2] and transverse patterns of high intensity light [3]. The general cubic complex Ginzburg-Landau equation is given by 

∂Ψ ∂t 

= Ψ− (1 + ia) |Ψ|2Ψ + (1 + ib)∇2Ψ, (1) 

where a and b are real parameters and the complex field Ψ represents the amplitude and phase of the modulations of the oscillatory pattern. 

Of particular interest are “defect” solutions in which Ψ has a single zero, around which the phase of Ψ varies by a non-zero integer multiple of 2π. When a = b these solutions are known as vortices, and the constant phase lines are rays emanating from the zero. When a 6= b the defect solutions are known as spirals, with the constant phase lines behaving as rotating Archimedean spirals. 

It is often convenient to factor out the rotation of the spiral, by writing Ψ = e−iωt((1 + ωb)/(1 + ab))1/2ψ, t = (1 + ωb)−1t′, x = ((1 + b2)/(1 + bω))1/2x′, to give, on dropping the primes, 

(1−i b)∂ψ ∂t 

= ∇2ψ+(1−|ψ|2)ψ+iqψ(1−k2−|ψ|2), (2) 

where 

q = a− b 

1 + ba , q(1− k2) = 

ω − b 

1 + bω . 

If k is chosen correctly rotating single spiral waves are now stationary solutions of (2); k is known as the asymp-totic wavenumber, since at infinity arg(ψ) ∼ nφ± kr. 

If q = 0 then k = 0, and a great amount is known about the solutions to (2). In particular, Neu [4] anal-ysed a system of N vortices in the limit in which their separation is much greater than the core radius using the theory of matched asymptotic expansions. By approx-imating the solution using near-field or “inner” expan-sions in the vicinity of each vortex core and matching these to a far-field or “outer” expansion away from vor-tex cores, Neu derived a law of motion for each vortex in terms of the positions of the others, thus reducing (2) to the solution of 2N ordinary differential equations (for the x- and y-coordinates of each vortex). The interaction between defects in this case is long-range, essentially de-caying like r−1 for large r. Neu’s analysis has become the template for the analysis of the motion of a system of defects in many equations [5–7]. 

When q > 0 the situation is much more complicated, even for a single defect. Hagan [8] studied single spiral wave solutions for 0 < q ¿ 1 and demonstrated that the far-field exhibits a transition at distances exponen-tially large in q (at what we shall call the outer core radius) where the level phase lines switch from radial to azimuthal; k(q) is correspondingly exponentially small in q. This outer core radius plays a key role in the motion of spirals; when the separation lies between the inner and outer core radii the interaction is algebraic, but when the separation is large compared to the outer core radius the interaction of spirals decays exponentially. 

The fact that the outer equation for the phase of ψ is nonlinear when q > 0, so that the contributions from multiple defects may not simply be added, along with the exponential scaling of the outer variable, explains the difficulty in applying Neu’s techniques to the general case of non-zero q. Thus, despite much work and some partial results [9, 10], the interaction of spirals is still not well understood. Here we solve this interaction problem and derive a law of motion for a system of spirals. 

We start by considering the distinguished limit in which the spirals are separated by distances of the same order as the outer core radius as q → 0. Since this outer core radius varies exponentially with winding number [8], we assume that all winding numbers are ±1. We also set

 b = 0 for simplicity. Assuming that the spirals are separated by distances 

of order ε−1, with ε ¿ 1, we rescale time and space by setting X = εx, T = qε2t, to give 

ε2q ∂ψ 

∂T = ε2∇2ψ + (1 + iq)(1− |ψ|2)ψ − iε2α2 

q ψ, (3) 

where α = kq/ε; the outer core radius is the value of ε which makes α of order one. Writing ψ = feiχ and expanding in powers of ε leads to 

q ∂χ0 

∂T = ∇2χ0 + q|∇χ0|2 − α2 

q . (4) 

It is tempting to linearise (4) via the Cole-Hopf transfor-mation χ0 = (1/q) log h, to give 

qhT = ∇2h− α2h. (5) 

Then, since the equation is linear, we can sum up the contributions from each spiral to give 

h ∼ N∑ 

j=1 

βj(T )eqnjφjKiqn(αRj), (6) 

where K is the modified Bessel function, Rj and φj are the polar variables centred on the j th spiral and the weights βj depend on the slow time variable T . This function has the right type of singularities to match with the spiral core when we expand it locally. Unfortunately, as observed in [11] and [9], such a solution corresponds to a multivalued ψ. Nevertheless, this transformation can be used to advantage without causing ψ to become multivalued, providing care is taken. The key is the ob-servation that for a single spiral the dependence of χ on φ occurs at O(1), not O(1/q) [8], so that at leading order the Cole-Hopf transformation can be used without diffi-culty. Then, at first order, the single-valueness of ψ can be maintained by introducing exactly the right multival-ueness in h. 

Expanding χ0 in powers of q as χ0 ∼ χ00/q+χ01 + · · · gives, to leading order, 

0 = ∇2χ00 + |∇χ00|2 − α2. (7) 

Linearising (7) through the Cole-Hopf transformation χ00 = log h0 leads to 

h0 = N∑ 

j=1 

βj(T )K0(αRj). (8) 

Crucially, because the leading-order solution does not de-pend on φ, there is no problem with multivalueness of ψ. The weights βj will be determined by matching with an inner expansion in the vicinity of each spiral. 

We rescale near the ` th spiral by setting X = X` + εx to give 

εq 

( εψT − dX` 

dT · ∇ψ 

) = ∇2ψ+(1+iq)(1−|ψ|2)ψ−i ε 

2α2 

q ψ 

Expanding ψ ∼ ψ0 + εψ1 + · · · , gives 

0 = ∇2ψ0 + (1 + iq)ψ0(1− |ψ0|2), (9) 

−q dX` 

dT · ∇ψ0 = ∇2ψ1 + (1 + iq)(ψ1(1− |ψ0|2) 

− ψ0(ψ0ψ ∗ 1 + ψ∗0ψ1)). (10) 

The solution of (9) is that of a single stationary spiral, ψ0 = f0(r)ein`φ+iϕ0(r), where 

f ′′0 + 1 r f ′0 − f0 

( 1 r2 

+ (ϕ′0) 2 

) + (1− f2 

0 )f0 = 0, (11) 

f0 

( ϕ′′0 + 

ϕ′0 r 

) + 2f ′0ϕ 

′ 0 + q(1− f2 

0 )f0 = 0, (12) 

Expanding in powers of q we find that as r →∞ [8], 

f0 ∼ 1− 1 r2 

N∑ 

j=0 

aj{q(log(r) + c1)}2j + · · · , (13) 

ϕ′0 ∼ −1 r 

N∑ 

j=0 

bj{q(log(r) + c1)}2j+1 + · · · , (14) 

where aj > 0 and bj > 0 are constants independent of q and n`, and c1 ≈ −0.098. 

The normal procedure is now to match (14) with (8) to determine βj . However, we will see that for α to be of order one, q must be logarithmic in ε. In this case all orders of q must be included when matching leading-order terms in ε: when q is of order 1/ log(1/ε) and r of order 1/ε, all the terms in (14) are the same order. 

To circumvent this problem we resum the series (14) by writing down the equations satisfied by the outer limit of the inner expansion. Rewriting (9) in terms of the outer variable R = εr gives 

0 = ε2(∇2f0 − f0|∇χ0|2) + (1− f2 0 )f0, (15) 

0 = ε2∇ · (f2 0∇χ0) + q(1− f2 

0 )f2 0 , (16) 

where ψ0 = f0e iχ0 . Expanding as χ0 ∼ χ̂00(q) + 

ε2χ̂01(q) + · · · , f0 ∼ f̂00(q) + ε2f̂01(q) + · · · , gives 

0 = ∇2χ̂00 + q|∇χ̂00|2. (17) 

Equation (17) can be linearised with the usual change of variable χ̂00 = (1/q) log ĥ0 to give Laplace’s equation, with solution ĥ0 = eqn`φH0(R) where 

H0 = A`(q, T )ε−iqn`Riqn` +B`(q, T )εiqn`R−iqn` , (18) 

where the constants A` and B` may depend on q and T , and may be different at each spiral; the factors ε±iqn`

 have been included to facilitate comparison with the so-lution in the inner variable. Expanding A` ∼ A`0/q + A`1 + · · · , B` ∼ B`0/q +B`1 + · · · , writing χ̂00 in terms of r, expanding in powers of q, and comparing with (14) gives 

A`0 −B`0 = 0, (A`1 −B`1) A`0 +B`0 

i = −n`cn` . (19) 

The remaining equations determining A` and B` will be fixed when matching with the outer region. Equa-tion (18) gives the outer limit of the leading-order inner expansion, including all the resummed terms in q. To match this to the inner limit of the leading-order outer solution we rewrite (8) in terms of the inner variable by setting X = X` + εx and expand in powers of ε to give 

h0 ∼ −β` log αεr 

2 −β`γ+G(X`)+εx·∇G(X`)+· · · , (20) 

where 

G(X) = N∑ 

j=1,j 6=` 

βj(T )K0(α|X−Xj |). (21) 

Expanding (18) for small q and comparing with (20) we find that matching is only possible if 

q log(1/ε) = π 

2 + νq, (22) 

where ν is O(1). This is the relationship between q and ε required for α to be of order one, and is equivalent to as-suming that the typical spiral separation 1/ε = O(eπ/2q). 

Assuming (22) holds, 

ĥ0 ∼ −(A`0 +B`0) logR− (A`0 +B`0)ν + i n`(A`1 −B`1) + · · · . (23) 

Comparing with (20) gives 

A`0 +B`0 = β`, 

i n`(A`1 −B`1) = β`(ν − logα+ log 2− γ) +G(X`). 

Eliminating A` and B` using (19) and (21) gives 

−(c1 + ν)β` = −β`(log α 

2 + γ) + 

N∑ 

j 6=` 

βjK0(α|X` −Xj |). 

(24) Since (24) holds for each spiral this is a system of N ho-mogeneous linear equations for the unknown weights βj . A non-zero solution exists only if the determinant is zero: this is the condition which determines the parameter α (and therefore the frequency ω). Note that βj and α (and therefore k) depend on the position of the spiral centres, and will therefore evolve on the slow timescale T . For a single pair of spirals β1 = β2 and (24) gives 

k = 2 q e−π/2q−γ+c1+K0(α|X1−X2|), 

in agreement with [9]. The law of motion arises as a solvability condition 

on equation (10). To determine the matching condition imposed by the outer solution, we need to sum the q-expansion of the outer limit of the first-order inner solu-tion. Writing (10) in terms of the outer variable and ex-panding in powers of ε as χ1 ∼ χ̂10/ε+· · · , f1 ∼ f̂10+· · · , we find χ̂10 = ĥ1e 

−qbχ00/q, where 

ĥ1 = − qA`ε −iqn`(V1` − iV2`) 

4 Riqn`+1 e(qn`+i)φ 

− qB`ε iqn`(V1` + iV2`) 

4 R−iqn`+1 e(qn`−i)φ 

+ γ1R 1−iqn` e(qn`+i)φ + γ2R 

1+iqn` e(qn`−i)φ, (25) 

where we have written dX`/dT = (V`1, V`2). Note that eibχ10 is single-valued as required. Expanding for small q 

ĥ1 ∼ ( γ1 − A`0e 

in`π/2(V1` − iV2`) 4 

) Reiφ 

+ ( γ2 − B0`e 

−in`π/2(V1` + iV2`) 4 

) Re−iφ. 

In order to match with (20) we require this to be equal to X · ∇G(X`) so that 

γ1 = A`0e 

in`π/2(V1`0 − iV2`0) 4 

+ GX(X`)− iGY (X`) 

2 , 

γ2 = B0`e 

−in`π/2(V1`0 + iV2`0) 4 

+ GX(X`) + iGY (X`) 

2 . 

Now, writing (25) in terms of the inner variable r and expanding in powers of q we find that, as r →∞, 

χ10 ∼ −r 2 

(V1 cosφ+ V2 sinφ) + n`r 

β` ∇G(X`) · eφ. (26) 

We now turn to the solvability condition for (10). Using the Fredholm alternative we find that a solution will exist only if 

− ∫ 

D 

< { q dX` 

dT · ∇ψ0v 

∗ } dS = 

∫ 

∂D 

< { 

(1− iq) ( v∗ ∂ψ1 

∂n − ∂v∗ 

∂n ψ1 

)} ds, 

where v is any solution of the adjoint problem, and D ar-bitrary. The non-trivial solutions of the adjoint equation are directional derivatives ∇ψ0 ·d of ψ0, with q replaced by −q, where d is any vector in R2. Choosing D to be a ball of large radius, at leading order in q the solvability condition becomes 

lim r→∞ 

( ∂χ10 

∂r + χ10 

r 

) = 0. (27) 

Using (26) this gives the law of motion as 

dX` 

dT = −2n` 

β` ∇G⊥(X`), (28)

 where ⊥ represents rotation by π/2. For a pair of spirals (28) describes motion perpendicular to the line of cen-tres, and generalises the translational velocity for a sin-gle pair of opposite spirals derived in [9] to an arbitrary system. We see that the velocity is algebraic at small dis-tances but decays exponentially at large distances; thus the outer core radius marks the effective limit on the in-teraction of spirals. 

However, as q → 0 this law of motion does not agree with that derived by Neu [4] for the case q = 0, for which the interaction is along the line of centres. To interpolate between these two laws, we need to consider the case in which the separation is smaller than the canonical sep-aration, so that α ¿ 1. In this case a similar analysis leads to the law of motion 

dX` 

dT = 2 cot(qn` log ε)∇Ḡ⊥(X`) (29) 

where 

Ḡ(X) = N∑ 

j 6=` 

nj (φj + tan(qnj log ε) log |X−Xj |) . (30) 

The direction of motion varies from along the line of cen-tres to perpendicular to the line of centres as q| log ε| varies from 0 to π/2. The laws (28) and (29) can be combined to form the composite expansion 

dX` 

dT ∼ −2n`α 

β` × 

N∑ 

j 6=` 

βjK ′ 0(α|X` −Xj |) 

( nj cot(q| log ε|) erj + eφj 

) . (31) 

In Figures 1 and 2 we show the velocities of rotation and separation of a pair of n` = 1 spirals when they are separated by a distance of 60. The numerical simulations were done with second-order accurate finite differences in a square domain of length 800. We see that the composite expansion captures the qualitative behaviour very well, and provides a reasonable quantitative prediction. 

In conclusion, we have calculated the law of motion for spirals in the complex Ginzburg-Landau equation (1) for small q. We find that for small separations the in-teraction is along the line of centres, in agreement with the corresponding analysis for vortices when q = 0 [4]; like spirals repel, opposites attract. As the separation in-creases the direction of the interaction gradually changes, until it is perpendicular to the line of centres at large distances. The direction of rotation of one spiral about another depends only on its own winding number: pos-itive spirals rotate in an anti-clockwise direction about any other spiral, negative spirals in a clockwise direction. Thus like positive spirals rotate in an anti-clockwise di-rection while separating, like negative spirals rotate in a clockwise direction while separating, and unlike spirals 

0.1 0.2 0.3 0.4 0.5 0.6 q 

0.005 

0.010 

0.015 

Rotation velocity 

FIG. 1: Rotation velocity of a pair of spirals 60 units apart as a function of q, using (28) [solid], (29) [dashed] and the composite (31) [dotted]. The points correspond to a numerical simulation of (2). 

0.1 0.2 0.3 0.4 0.5 q 

0.002 

0.004 

0.006 

0.008 

0.010 

Separation velocity 

FIG. 2: Separation velocity of a pair of spirals 60 units apart using (29) [dashed] and the composite (31) [dotted]. 

translate while approaching. Since the motion is perpen-dicular to the line of centres at large distances, the ques-tion of bound states emerges. To answer this question the first-order correction to the radial velocity is needed; our calculations indicate the radial velocity remains of one sign, so that bound states are not possible for small q, in agreement with [10], who found bound states were possible only for q > 0.845. 

M. Aguareles was supported in part by the MEC of Spain, grant MT2005-07660-C02-01. 

[1] I. S. Aranson and L. Kramer, Rev. Mod. Phys. 74, 99–143 (2002). 

[2] R. W. Walden, P. Kolodner, A. Passner, and C. M. Surko, Phys. 

Rev. Lett. 55, 496–499 (1985). 

[3] J. V. Moloney and A. C. Newell, Phys. D 44, 1–37 (1990). 

[4] J. C. Neu, Phys. D 43, 385–406 (1990). 

[5] L. Peres and J. Rubinstein, Phys. D 64, 299–309 (1993). 

[6] S. J. Chapman and G. Richardson, SIAM J. Appl. Math. 55, 

1275–1296 (1995). 

[7] S. J. Chapman and G. Richardson, Phys. D 108, 397–407 (1997). 

[8] P. S. Hagan, SIAM J. Math. Anal. 13, 717–738 (1982). 

[9] L. M. Pismen and A. A. Nepomnyashchy, Phys. D 54, 183–193 

(1992). 

[10] I. S. Aranson, L. Kramer, and A. Weber, Phys. Rev. E 47, 3231– 

3241 (1993). 

[11] L. M. Pismen, Phys. D 184, 141–152 (2003).