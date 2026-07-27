# Ginzburg-Landau patterns in circular and spherical geometries: vortices, attractors and spirals - arXiv.org

# Ginzburg–Landau patterns 

# in circular and spherical geometries: 

# vortices, spirals and attractors 

### Jia-Yuan Dai* and Phillipo Lappicy** 

∗ National Center of Theoretical Sciences, National Taiwan University No. 1, Sec. 4, Roosevelt Rd., Astronomy-Mathematics Building, 106, Taipei, Taiwan 

∗ ∗ ICMC, Universidade de São Paulo Av. trabalhador são-carlense 400, 13566-590, São Carlos, SP, Brazil ∗ ∗ Instituto Superior Técnico, Universidade de Lisboa Av. Rovisco Pais, 1049-001 Lisboa, Portugal

Abstract 

This paper consists of three results on pattern formation of Ginzburg–Landau m-armed vortex solutions and spiral waves in circular and spherical geometries. First, we completely describe the global bifurcation diagram of vortex equilibria. Second, we prove persistence of all bifurcation curves under perturbations of parameters, which yields the existence of spiral waves for the complex Ginzburg–Landau equa-tion. Third, we explicitly construct the global attractor ofm-armed vortex solutions. Our main tool is a new shooting method that allows us to prove hyperbolicity of vortex equilibria in the invariant subspace of vortex solutions. 

Keywords: Ginzburg–Landau equation, m-armed vortex solutions, spiral waves, global attractors, shooting method, hyperbolicity. 

AMS Subject Classification: 35Q56, 37G35, 37G40. 

1 Introduction 

We consider the Ginzburg–Landau equation 

(1.1) Ψt = ∆MΨ+ λ (1− |Ψ|2) Ψ, 

where ∆M is the Laplace–Beltrami operator on a compact surface of revolutionM to be defined shortly. Here λ > 0 is a bifurcation parameter and the unknown function Ψ is complex valued. 

We are interested in understanding pattern formation on the surfaceM from the dynamics of (1.1). For this purpose we prove three main results: the global bifurcation diagram of vortex equilibria, the existence of spiral waves, and the global attractor of vortex solutions that contains vortex transition waves. 

Vortex solutions and spiral waves of (1.1) are special solutions, each of which consists of at least a vortex and isophase curves emitted from the vortex; see [16]. They play a key role in the dynamics of nonlinear fields in condensed matter physics; see [34]. In different contexts vortices are also called phase singularities, topological defects, and wave dislocations; see [2, 35] for interpretations and applications in physics. From a mathematical point of view, the Ginzburg–Landau equation serves as the normal form for PDEs near the Hopf instability; see [31, 42]. Moreover, vortex solutions and spiral waves can be triggered by symmetry breaking; see [7, 8, 33, 46, 47]. For surveys and numerical evidences on Ginzburg–Landau vortex solutions and spiral waves, see [2, 13, 45]. 

Concerning mathematical analysis, it has been proved that vortex solutions and spiral waves exist on the extended plane R2; see [17, 19, 23]. However, in experiments and numerical simulations the underlying domain is bounded, and moreover, the domain size and presence of boundary may affect the existence and the pattern of vortex solutions; see [4, 16]. To analyze the role of these elements, we consider surfaces of revolution, among which disks and spheres are the simplest domains that differ topologically from each other, and then investigate how the topological structure of the domain influences the pattern. In [45], it was proved that spiral waves exist for disks with Neumann boundary conditions. In [10], one of the authors generalized the existence result for circular geometries with Robin boundary conditions and spherical geometries. In particular, spherical geometries support 

patterns with two vortices (so-called 2-tip spirals), whose global shape is topologically different from the vortex solutions on R2 and disks documented in the literature. We also mention that spiral waves on spheres governed by many other reaction-diffusion models are gaining increasing interest; see [15, 29, 30, 39, 44, 48]. 

In our mathematical setting the compact surface of revolution is defined as 

(1.2) M := {(a(s) cos(ϕ), a(s) sin(ϕ), ã(s)) : s ∈ [0, s∗], ϕ ∈ S 1}. 

Our main examples are the unit disk when a(s) = s and ã(s) = 0 for s ∈ [0, 1], or the unit 2-sphere when a(s) = sin(s) and ã(s) = cos(s) for s ∈ [0, π]. 

In general, we consider the smoothness class ofM to be C2,ν with a fixed Hölder exponent ν ∈ (0, 1), and thus a(s) and ã(s) are C2,ν functions. Without loss of generality, let s be the arc length parameter and thus (a′(s))2 + (ã′(s))2 = 1 for s ∈ [0, s∗]. We assume 

(1.3) a(0) = 0 and a(s) > 0 for all s ∈ (0, s∗). 

The smoothness ofM prevents formation of a cusp at s = 0 and thus implies ã′(0) = 0, or equivalently, a′(0) = 1 due to the arc length parametrization. 

We consider such a surface of revolution M because its S1-symmetry in the ϕ-variable allows us to seek vortex solutions explained shortly. Moreover, the unit 2-sphere differs from the unit disk topologically. Hence we distinguish two cases, either ∂M is empty or nonempty, in order to study how topological structure affects the dynamics of vortex solutions. Note that the boundary ∂M is empty if and only if a(s∗) = 0, and furthermore, the smoothness ofM implies a′(s∗) = −1. In case that ∂M is empty, we further assume the following reflectional symmetry, which is a technical assumption for the main result: 

(1.4) a(s) = a(s∗ − s) for all s ∈ [0, s∗]. 

We adopt the functional setting ∆M : D(∆M)→ L2(M,C). Here the domain D(∆M) is chosen to be H2(M,C), and if ∂M is nonempty, also equipped with the following Robin boundary conditions: 

(1.5) α1Ψ+ α2∇Ψ · n = 0, 

where α1, α2 ∈ R are not both zero and α1α2 ≥ 0. Here n is the unit outer normal vector field on ∂M. We require α1α2 ≥ 0 so that the real and imaginary parts of solutions do not grow at ∂M. Note that Robin boundary conditions for the Ginzburg–Landau equation result from minimizing a free energy in the theory of superconductivity; see [11, 37]. 

The Ginzburg–Landau equation (1.1) possesses the global gauge symmetry : 

(1.6) Ψ is a solution of (1.1) if and only if eiωΨ is a solution for each ω ∈ S1. 

This gauge together with the S1-symmetry in the ϕ-variable of M allows us to seek solutions of the following form for each fixed m ∈ N: 

(1.7) Ψ(t, s, ϕ) := u(t, s)eimϕ. 

Indeed, we define the following subspace, which is invariant under the dynamics of (1.1): 

(1.8) L2 m(R) := {ψ ∈ L 

2(M,C) : ψ(s, ϕ) = u(s)eimϕ, u(s) ∈ R}. 

The first step to analyze the dynamics of the Ginzburg–Landau equation (1.1) restricted to L2 

m(R) is to study time-independent solutions given by Ψ(t, s, ϕ) = ψ(s, ϕ), which we call m-armed vortex equilibria. They satisfy the elliptic equation 

(1.9) 0 = ∆Mψ + λ (1− |ψ|2)ψ. 

For each vortex equilibrium of (1.9), we exhibit its pattern as isophase lines, and here we consider the level set of when its imaginary part on M is equal to zero. Hence the pattern is given by the relation mϕ = 0 (mod π) due to (1.7). The 2π-periodicity of angle ϕ yields the relation ϕ = ϕℓ = ℓπ/m (mod 2π) for ℓ = 0, 1, ..., 2m− 1, which allows us to plot the pattern onM via the coordinates (1.2). Continuity of ψ implies that u(0) = 0, and also u(s∗) = 0 if ∂M is empty. Since vortices are phase singularities, that is, zeros of ψ at which the phase field of ψ undergoes a jump discontinuity, the vortices reside at s = 0, and also at s = s∗ if ∂M is empty. For more details on pattern formation see [13, 16]. Therefore, spherical geometries support patterns with two vortices, and thus the topology of the domain impacts on the global shape of patterns. Nevertheless, due to the special form (1.7) of solutions, the pattern of vortex equilibria always hits boundary points in normal direction, and thus its local shape near the boundary looks the same; see [10, Lemma 2.3] and Figure 1. 

Figure 1: On the left, a 2-armed vortex pattern on the disk with the origin as the vortex. On the right, a 1-armed vortex pattern on the sphere with the north and south poles as the vortices. 

The existence of nontrivial vortex equilibria ψ ∈ C2,ν(M,C) has been proved in [10] by bifurcation analysis as the parameter λ > 0 changes. As a consequence, u(s) is a nontrivial smooth solution of the following ODE for s ∈ (0, s∗): 

(1.10) 0 = u′′ + a′ 

a u′ − 

m2 

a2 u+ λ (1− u2) u, 

( u′ := 

du 

ds 

) , 

and Robin boundary conditions (1.5) are equivalent to 

(1.11) α1 u(s∗) + α2 u ′(s∗) = 0. 

It has been proved in [10] that nontrivial m-armed vortex equilibria form countably many supercritical pitchfork bifurcation curves as the parameter λ crosses the eigenvalues λk of −∆M restricted to L2 

m(R) that can be ordered as follows: 

(1.12) 0 < λ0 < λ1 < ... < λk < ..., lim k→∞ 

λk =∞. 

Nevertheless, only the principal curve was proved to be global, in the sense that it exists for all λ > λ0. We are able to extend all other bifurcation curves globally, i.e., bifurcation curves exist for all λ strictly larger than the bifurcation value. 

Theorem 1.1. Global Bifurcation of Vortex Equilibria. All bifurcation curves of (1.9) are global. More precisely, for each k ∈ N0 and λ ∈ (λk, λk+1) there are 2k + 2 nontrivial m-armed vortex equilibria denoted by ψ± 

j (s, ϕ) = u±j (s)e imϕ with j = 0, 1, ..., k; 

see Figure 2. 

λ ∈ R 

L2 m(R) 

0 λ0 λ1 λ2 

ψ+ 

0 ψ+ 

1 ψ+ 

2 

ψ− 

0 ψ− 

1 ψ− 

2 

Figure 2: The supercritical pitchfork bifurcation of the trivial equilibrium possesses global branches, yielding all m-armed vortex equilibria. The pitchfork shape represents the Z2-symmetry: (λ, ψ) is a solution of (1.9) if and only if (λ,−ψ) is a solution. All bifurcation curves are indexed by the number of zeros of the amplitude uk. 

We next pursue two different directions to obtain time-dependent patterns originated from vortex equilibria. Towards the first direction, we prove the existence of spiral waves for the complex Ginzburg–Landau equation by means of perturbating vortex solutions. As for the second direction, we construct vortex transition waves of the Ginzburg–Landau equation (1.1), which are eternal solutions that exist for all t ∈ R and converge to different vortex equilibria when t→ −∞ and t→∞. 

On the one hand, we prove the existence of spiral waves governed by the complex Ginzburg– Landau equation 

(1.13) Ψt = (1 + i η)∆MΨ+ λ (1− |Ψ|2 − i β |Ψ|2) Ψ 

with the complex diffusion parameter η ∈ R and the kinetic parameter β ∈ R. We seek m-armed spiral wave solutions of the following form: 

(1.14) Ψ(t, s, ϕ) := e−Ωt u(s) eimϕ, 

where u(s) is now a complex-valued function whose argument is not piecewise constant, and thus the pattern exhibited by Ψ is a twisted spiral; see Figure 3. Here the rotation frequency Ω ∈ R is an unknown quantity to be determined. Note that (1.1) corresponds to η = β = 0, and moreover, the case η = β 6= 0 is reduced to the special case η = β = 0 as we choose Ω = λη in (1.14). 

Figure 3: On the left, a 2-armed spiral pattern on the disk with the origin as the vortex. On the right, a 1-armed spiral pattern on the sphere with the north and south poles as the vortices. Both spiral patterns may rotate with respect to the axis of rotation of the surfaceM with the rotation frequency Ω. 

We can prove the existence of spiral waves with a perturbation argument in the extended invariant subspace 

(1.15) L2 m(C) := {ψ ∈ L 

2(M,C) : ψ(s, ϕ) = u(s)eimϕ, u(s) ∈ C}. 

The following result generalizes [10, Theorem 1.5]. 

Theorem 1.2. Existence of Spiral Waves. For each k ∈ N0 and λ ∈ (λk, λk+1) there exists an ǫ > 0 such that the complex Ginzburg–Landau equation (1.13) possesses k + 1 distinct (up to a gauge symmetry defined in (1.6)) nontrivial spiral wave solutions for each η, β ∈ (−ǫ, ǫ) and η 6= β. Moreover, we classify the types of patterns as shown in Figure 4. 

η 

β 

ǫ 

Figure 4: The complex Ginzburg–Landau equation (1.13) possesses different types of patterns in the (η, β)-parameter space, according to [10, Lemma 5.5]. Vortex patterns as shown in Figure 1 appear for each parameter on the bold diagonal line. Each parameter that is not on the bold line yields a spiral pattern as shown in Figure 3. Such spiral patterns are rotating, i.e., Ω 6= 0, if and only if parameters do not lie on the dashed line. 

Spiral waves proved in Theorem 1.2 are rigidly rotating from the nature of the solution form (1.7). It is worth noting that they serve as ideal reference solutions for secondary bifurcations to more intricate patterns; see [2, 12, 13, 40] for spirals with meandering and even drifting vortices. It is also interesting to study the dynamics of vortices and decide whether two different vortices annihilate; see [6, 26]. 

On the other hand, we describe the global asymptotic dynamical behaviour of m-armed vortex solutions. In particular, we construct vortex transition waves, which are hetero-clinic orbits that converge to different vortex equilibria as t→ −∞ and t→∞. Indeed, the Ginzburg–Landau equation (1.1) restricted to L2 

m(R) is equivalent to the PDE, 

(1.16) ut = uss + as a us − 

m2 

a2 u+ λ (1− u2) u for s ∈ (0, s∗). 

To illustrate dynamical properties of solutions of the PDE (1.16), recall that (1.16) is the restriction of the Ginzburg–Landau equation (1.1) to the invariant subspace L2 

m(R), and thus (1.16) inherits the following aspects of (1.1). First, (1.1) generates a compact semiflow on the interpolation space H2γ(M,C) for any exponent γ > 1/2, according to [21, Theorem 3.3.3] and the Schauder elliptic regularity theory. Second, the semiflow is dissipative, in the sense that all solutions of (1.1) eventually stay in a fixed ball in H2γ(M,C); see [5]. By generating a compact dissipative semiflow, (1.1) possesses a global attractor A ⊂ H2γ(M,C), which is defined as the maximal compact invariant set; see [5]. Alternatively, the global attractor can be characterized as the minimal set that attracts all bounded sets, or the set of all global bounded solutions of (1.1); see [3, Chapter 2]. 

The global attractor A has gradient structure and thereby consists of vortex equilibria and vortex transition waves (as heteroclinic orbits), since it is associated with the following strict Lyapunov function (also see [2]): 

(1.17) E [Ψ] := 

∫ 

M 

|∇Ψ|2 − λ 

( |Ψ|2 − 

|Ψ|4 

2 

) dV + 

α1 

α2 

∫ 

∂M 

|Ψ|2 dS. 

Here dV and dS stand for the volume and area elements onM, respectively. Note that the boundary integral is absent if ∂M is empty, or in case of either Neumann (α1 = 0) or Dirichlet (α2 = 0) boundary conditions. In the invariant subspace L2 

m(R), we obtain the restricted semiflow generated by (1.16) with the attractor of m-armed vortex solutions, denoted by Am ⊆ H2γ(M,C) ∩ L2 

m(R). 

We seek to construct Am by stating sufficient and necessary conditions to describe which m-armed vortex equilibria in Theorem 1.1 are connected by a vortex transition wave, as in [14]. When m = 0 and M is the unit 2-sphere, (1.16) describes certain self-similar Schwarzschild solutions of the Einstein constraint equations, whose global attractor was constructed in [24, 25]. For m ∈ N, in the upcoming theorem we explicitly construct the global attractor Am. 

We provide a few nomenclatures before the next result. Let u∗ = u∗(s) be an equilibrium of the equation (1.16). First, we denote the Morse index by i(u∗), which is equal to the unstable dimension of u∗, i.e., the number of positive eigenvalues of the associated linearized operator at u∗. Second, we denote by the zero number z(u∗) the number of strict sign changes of u∗(s). Lastly, we specify the concept of adjacency depending on whether ∂M is empty. If ∂M is nonempty, then two equilibria u− and u+ of (1.16) are called adjacent if there is no other equilibrium u∗ between u− and u+ at the boundary point s = s∗ along the shooting curveM 

u s∗ defined in (3.36), i.e., either u−(s∗) ≺ u∗(s∗) ≺ u+(s∗) 

or u−(s∗) ≻ u∗(s∗) ≻ u+(s∗), where ≺ is the order following the parametrization of Mu s∗ , 

such that z(u− − u∗) = z(u− − u+) = z(u+ − u∗). If ∂M is empty, we define adjacency as mentioned above, except for replacing s∗ by the midpoint s∗/2. 

Theorem 1.3. Global Attractor of Vortex Solutions. For each λ ∈ (λk, λk+1) let u+j and u−j be the amplitude of the vortex equilibria of the equation (1.16) from Theorem 1.1 with j = 0, 1, ..., k. Then 

(1.18) i(u+j ) = i(u−j ) = j. 

Moreover, there exists a vortex transition wave solution u(t, s) of the equation (1.16) which is a heteroclinic orbit that converges to distinct vortex equilibria uιj(s) and uι 

′ 

ℓ (s) with ι, ι′ ∈ {+,−} as t→ ±∞, i.e., 

(1.19) uιj(s) t→−∞ ←−−−− u(t, s) 

t→+∞ −−−−→ uι 

′ 

ℓ (s) in H2γ(M,C) ∩ L2 m(R), 

if and only if uιj(s) and uι ′ 

ℓ (s) are adjacent and j > ℓ. In particular, the global attractor Am is described in Figure 5. 

u−0 u+0 u ≡ 0 

−Φ∞ 

1 

+Φ∞ 

1 

(a): λ ∈ (λ0, λ1). 

u−1 

u+1 

u−0 u+0 

(b): λ ∈ (λ1, λ2). 

u−1 

u+1 

u−0 u+0 

u+2 

u−2 

(c): λ ∈ (λ2, λ3). 

Figure 5: The Ginzburg–Landau global attractor Am of m-armed vortex solutions, where dots corre-spond to vortex equilibria and arrows to vortex transition waves as heteroclinic orbits. Note Am coincides with the well-known Chafee–Infante attractor; see [20, 21]. 

Note that the vortices of transition waves are always pinned, in the sense that the solution amplitude u satisfies u(t, 0) = 0, and also u(t, s∗) = 0 if ∂M is empty, for all t ≥ 0. Indeed, since the attractor is contained in the space L2 

m(R) defined by (1.8), continuity of u at s = 0 implies u(t, 0) = 0 for all t ∈ R. Also, recall that every solution of (1.1) converges to some equilibrium as t→∞, due to the gradient structure (1.17); see also [27, Theorem 2.1] for coupling with electromagnetic fields. By Theorem 1.3 we can specify which vortex equilibrium is the forward time limit of certain solutions of (1.16). 

As regards to stability information of vortex equilibria, Theorem 1.3 gives the Morse index of each vortex equilibrium constrained to L2 

m(R), which also yields a lower bound of the Morse index in the full space L2(M,C). We remark that estimates on the Morse index have attracted recent attention; see [9]. Moreover, by (1.18) every m-armed vortex equi-librium on the principal bifurcation branch is L2 

m-stable, and it is natural to conjecture its full L2-stability. Heuristically, 1-armed vortex equilibria are believed to be L2-stable since their local shape is robust under general L2-perturbations; see [19]. This L2-stability of 1-armed vortex equilibria on disks has been proved by the variational method; see [28, 32]. An alternative to the variational method for stability analysis is based on the decomposi-tion L2 = 

⊕∞ ℓ=0 L 

2 ℓ , and the L2-stability information can be extracted by analyzing mode 

interactions induced by perturbations from all other spaces L2 ℓ with ℓ 6= m; see [8, 16]. 

The study on mode interactions answers whether vortex equilibria undergo secondary bi-furcations, and also suggests how the global attractors Am1 

and Am2 of vortex solutions 

change and influence each other. 

Our main tool in the proof of all theorems is the usage of a different shooting method in comparison with the shooting argument extensively used in the literature to study Ginzburg–Landau vortex solutions; see [17, 19, 23, 45]. Indeed, such a different shooting method has been widely used in constructing global attractors for scalar reaction-diffusion equations on bounded intervals; see [14, 25]. 

We illustrate the main feature and limitations of the shooting argument used in the literature. Indeed, this shooting argument tracks the first critical point of the solution amplitude. With such information the amplitude of vortex solutions is monotone and its derivative is zero either at the infinity of R2 or at the boundary of disks. This feature carries two drawbacks. First, this shooting argument is not able to treat Robin boundary conditions. Second, vortex solutions with sign-changing amplitude are missing in the 

literature. These bottlenecks were overcome by establishing a global bifurcation approach in [10], but however, not all bifurcation branches of vortex equilibria are proved to be global. 

In order to globally extend all bifurcation branches, we recall that the stationary Ginzburg– Landau equation restricted to the space of vortex solutions L2 

m(R) can be viewed as a Sturm–Liouville type ODE given by (1.10) with unbounded coefficients at vortices. The usage of a different shooting method treats the dynamics near vortices in a more sophis-ticated manner. In particular, our shooting method provides four advantages: 

(1) It generalizes the shooting argument used in the literature, which occurs as a special case for seeking solutions with monotone amplitude. 

(2) It justifies the shooting parameter in the shooting argument, which is the leading coefficient of a formal asymptotic expansion of solutions near vortices. Such a formal expansion is justified via the invariant manifold theory; see Subsection 3.1. 

(3) It provides not only the existence of vortex equilibria, but also hyperbolicity, that is, the associated linearization in the invariant subspace L2 

m(R) possesses only nonzero eigenvalues. Furthermore, it describes the unstable dimension of each vortex equi-librium as in (1.18). For a review on stability analysis of vortex solutions see [41]. 

(4) Most importantly, it characterizes the global attractor of vortex solutions that con-tains vortex transition waves. 

The remaining of this paper is organized as follows. In Section 2 we prove the three main theorems by assuming that hyperbolicity of vortex equilibria holds true. We devote three subsections in Section 3 to proving hyperbolicity. In Subsection 3.1 we define the shooting curves and present the general scheme of proof. In Subsection 3.2, we construct a piece of the shooting curve by showing that its angle and radius are monotone. As a conclusion, in Subsection 3.3 we use the symmetries of the ODE (1.10) to construct the full shooting curves and prove hyperbolicity. 

2 Proof of Theorems 

In this section, we prove the main results: Theorems 1.1, Theorem 1.2, and Theorem 1.3. Our proof essentially relies on the following crucial lemma proved in Section 3. 

Lemma 2.1. Hyperbolicity. All nontrivial m-armed vortex equilibria of the Ginzburg– Landau equation (1.1) are hyperbolic in L2 

m(R), that is, its associated linearization in L2 m(R) possesses only nonzero eigenvalues. 

2.1 Global bifurcation of vortex equilibria 

In this subsection we prove Theorem 1.1. For the sake of completeness, we briefly recall the framework of bifurcation analysis adopted in [10]. Indeed, we seek vortex equilibria of the Ginzburg–Landau equation that bifurcate from the trivial solution ψ ≡ 0 of the 

elliptic equation (1.9) restricted to L2 m(R). Hence we study the linearized operator around 

the trivial equilibrium, 

(2.1) L(λ,0)[U ] := ∆MU + λU, 

where U ∈ H2 m(R) := H2(M,C) ∩ L2 

m(R). 

Observe that −∆M restricted to L2 m(R) is a singular Sturm-Liouville operator because 

a(0) = 0 (and also a(s∗) = 0 if ∂M is empty). However, it is singular merely due to polar coordinates of M. Thus it was proved in [10, Lemma 4.2] that the spectrum of −∆M 

restricted to L2 m(R) consists of simple eigenvalues, which can be listed as 

(2.2) 0 < λ0 < λ1 < ... < λk < ..., lim k→∞ 

λk =∞. 

Therefore, based on the well-known local bifurcation from simple eigenvalues, nontrivial solutions of (1.9) near each bifurcation point (λk, 0) ∈ R+ ×H 

2 m(R), indexed by k ∈ N0, 

form a unique local bifurcation curve Ck in R+×H 2 m(R); see [10, Lemma 3.5]. Furthermore, 

the cubic nonlinearity in (1.9) determines the local shape of Ck as a supercritical pitchfork. By the Z2-symmetry, that is, (λ, ψ) is a solution of (1.9) if and only if (λ,−ψ) is a solution, and thus the curve Ck is reflectional symmetric with respect to the λ-axis; see Figure 6. Therefore, we decompose Ck = Ck,+∪Ck,−∪{(λk, 0)}, where (λ, ψ) ∈ Ck,+ (resp., (λ, ψ) ∈ Ck,−) if the amplitude u(s) of ψ is positive (resp., negative) near the vortex s = 0, and thereby both Ck,ι for ι ∈ {+,−} can be locally parametrized by λ in a monotone way; see [10, Lemma 3.6]. 

The main task is to globally extend such a monotone parametrization to the right infinity, and moreover, each Ck undergoes no secondary bifurcations in R+ × H 

2 m(R). The idea 

of proof is based on an analytic induction, which follows from an open-closed argument: Show that the set of bifurcation parameter values that parametrize the curve Ck,ι is both open and closed in the parameter space (λk,∞), and consequently this set is equal to (λk,∞); see Figure 6. 

λ ∈ R 

L2 m(R) 

0 λk 

Ck 

λ ∈ R 

L2 m(R) 

0 λk 

Ck 

Figure 6: On the left, the local bifurcation curve Ck extends along the dashed line by the implicit function theorem; this is openness. Then it extends to the endpoint of the dashed line by a compactness argument; this is closedness. On the right, as a result, Ck is global as it extends to the right infinity. 

Lemma 2.2. Openness. Suppose that the bifurcation curve Ck,ι admits a monotone parametrization in λ ∈ (λk, λk + δ] for some δ > 0. Then there exists a δ̃ > δ such that the monotone parametrization extends to λ ∈ (λk, λk + δ̃). 

Proof. We extend the monotone parametrization by the implicit function theorem. Thus we show that the linearized operator around any given vortex equilibrium (λ, ψ) ∈ Ck, 

(2.3) L(λ,ψ)[U ] := ∆MU + λ (1− 3 |ψ|2)U, 

is a linear homeomorphism. Since L(λ|ψ) is self-adjoint on L 2 m(R), and moreover, Fredholm 

of index zero (see [1, Theorem 2.4.1]), it suffices to show that the kernel of L(λ|ψ) is trivial, which follows from hyperbolicity of vortex equilibria in Lemma 2.1. 

Remark. In [10] one of the authors proved openness for the principal bifurcation curve C0. The reason is that the amplitude u(s) of solutions on C0 does not change sign (see [10, Lemma 3.3]), and thus comparison of principal eigenvalues yields openness. Such a comparison is fruitless for other bifurcation curves, since in this case the amplitude must change sign. 

The following C0-bound for solutions, which is essentially a consequence of the maximum principle, is crucial for the global character of Ck: 

(2.4) |ψ|C0 = sup s∈[0,s∗] 

|u(s)| ≤ 1; 

see [10, Lemma 3.7]. With the C0-bound (2.4) and the fact that ∆M has compact resol-vent, it follows from a compactness argument that the monotone parametrization extends to the endpoint and thus yields closedness of all bifurcation curves. 

Lemma 2.3. Closedness. [see [10, Lemma 3.10]] Suppose that Ck,ι admits a monotone parametrization in λ ∈ (λk, λk + δ̃) for some δ̃ > 0. Then the monotone parametrization extends to λ = λk + δ̃. 

2.2 Existence of spiral waves 

In this subsection we prove Theorem 1.2. To seek spiral waves solutions in the form 

(2.5) Ψ(t, s, ϕ) := e−Ωt u(s) eimϕ, 

where Ω ∈ R is the rotation frequency to be determined, we shall consider the complex Ginzburg–Landau equation 

(2.6) Ψt = (1 + i η)∆MΨ+ λ (1− |Ψ|2 − i β |Ψ|2) Ψ, 

with prescribed parameters η, β ∈ R such that (η, β) 6= (0, 0). Indeed, when (η, β) = (0, 0), (2.6) possesses the strict Lyapunov function (1.17), which implies Ω = 0, and up to the global gauge symmetry (1.6) that the radial part u(s) must be real valued; see [10, Lemma 2.4]. 

We follow the perturbation argument in [10] and prove persistence of the global bifurcation diagram in Figure 2 under small perturbations 0 < |η|, |β| ≪ 1. As a result of such persistence, the pattern of vortex equilibria is slightly twisted and thus exhibits a spiral shape, since the radial part becomes genuinely complex valued. 

More precisely, we introduce the extended invariant subspace 

(2.7) L2 m(C) := {ψ ∈ L 

2(M,C) : ψ(s, ϕ) = u(s) eimϕ, u(s) ∈ C} 

and obtain the following elliptic equation by substituting (2.5) into the complex Ginzburg– Landau equation (2.6): 

(2.8) 0 = (1 + i η)∆Mψ + i λΩψ + λ (1− |ψ|2 − i β |ψ|2)ψ. 

Then we consider the linearized operator around a given vortex equilibrium (λ∗, ψ∗) ∈ Ck,ι when (Ω, η, β) = (0, 0, 0), 

(2.9) L[U ] := ∆MU + λ∗ (1− |ψ∗| 2)U − 2 λ∗ |ψ∗| 

2UR e imϕ. 

Here U ∈ H2 m(C) is given by U(s, ϕ) = (UR(s) + i UI(s)) e 

imϕ and UR(s) and UI(s) are real-valued functions. Note that we identify C as a real vector space, and hence L is a linear operator over R. It follows that L is self-adjoint on L2 

m(C), and moreover, Fredholm of index zero (see [1, Theorem 2.4.1]). 

Notice that the standard implicit function theorem is not applicable for perturbation arguments here, since the global gauge symmetry (1.6) already implies that the kernel of L∗ contains spanR〈i ψ∗〉. However, this situation is amendable to an equivariant version of implicit function theorem, as we restrict the elliptic equation (2.8) to the quotient space by the one-dimensional group orbit of the global gauge symmetry. To relieve the burden of notations, we rewrite the statement of [36, Theorem 3.1] according to our setting. 

Proposition 2.4. Equivariant Implicit Function Theorem. Let H(ψ,Ω, η, β) denote the nonlinear elliptic operator defined by the right-hand side of (2.8). Assume 

(2.10) dim kerL = 1, 

and the real one-dimensional cokernel of L is spanned by D(Ω,η,β)H(ψ∗, 0, 0, 0), that is, the following decomposition holds: 

(2.11) L2 m(C) = LH 

2 m(C)⊕D(Ω,η,β)H(ψ∗, 0, 0, 0)R. 

Then there exist an open neighborhood W of (η, β) = (0, 0) and unique smooth func-

tions ψ̃ : W → H2 m(C), Ω̃ : W → R such that ψ̃(0, 0) = ψ∗, Ω̃(0, 0) = 0, and 

H(ψ̃(η, β), Ω̃(η, β), η, β) = 0 for all (η, β) ∈ W . 

Lemma 2.5. Perturbation Argument. For any given (λ∗, ψ∗) ∈ Ck,ι, there exists an 

ǫ > 0 that admits a smooth parametrization of nontrivial solutions (ψ,Ω) = (ψ̃(η, β), Ω̃(η, β)) 

of (2.8) for all 0 ≤ |η|, |β| < ǫ. Moreover, ψ̃(0, 0) = ψ∗ and Ω̃(0, 0) = 0. 

Proof. In order to apply Proposition 2.4, we must verify the conditions (2.10) and (2.11). 

For the condition (2.10), since spanR〈i ψ∗〉 ⊂ kerL, we need to show spanR〈i ψ∗〉 = kerL. By (2.9), the linear equation L[U ] = 0 for U ∈ H2 

m(C), U(s, ϕ) = (UR(s) + i UI(s)) e imϕ, 

is equivalent to the following decoupled system: 

0 = ( ∆M + λ∗ (1− 3 |ψ∗| 

2) ) UR e 

imϕ,(2.12) 

0 = ( ∆M + λ∗ (1− |ψ∗| 

2) ) UI e 

imϕ.(2.13) 

As we assume Lemma 2.1, hyperbolicity of the vortex equilibrium (λ∗, ψ∗) is equivalent to the fact that the kernel of L(λ∗,ψ∗) := ∆M + λ∗ (1 − 3 |ψ∗| 

2) in (2.12) is trivial; see also (2.3). Hence UR(s) e 

imϕ is identically zero. To show UI(s) e imϕ = c ψ∗(s, ϕ) for some 

c ∈ R\{0}, note that (2.13) is equivalent to the linear second-order ODE with unbounded coefficients as sց 0: 

(2.14) 0 = U ′′ 

I + a′ 

a U ′ I − 

m2 

a2 UI + λ∗ (1− |ψ∗| 

2)UI , 

which possesses only one nontrivial bounded solution (up to nonzero real multiples); see the proof of [10, Lemma 3.2]. Then notice that as a vortex equilibrium (λ∗, ψ∗) already satisfies (2.13). 

To verify the condition (2.11), since L is self-adjoint on L2 m(C) and 

(2.15) D(Ω,η,β)H(ψ∗, 0, 0, 0) = i λ∗ ψ∗, 

it suffices to show LH2 m(C) ∩D(Ω,η,β)H(ψ∗, 0, 0, 0)R = {0}, or equivalently, the only real 

multiple of i λ∗ ψ∗ that belongs to the range of L must be zero. Hence we suppose L[V ] = c i λ∗ ψ∗ for some V = (VR + i VI) e 

imϕ ∈ H2 m(C) and c ∈ R. Then the equation 

for VI e imϕ reads 

(2.16) (∆M + λ∗ (1− |ψ∗| 2)) VI e 

imϕ = c λ∗ ψ∗. 

We multiply (2.16) by the complex conjugate ψ∗, integrate over M, and then obtain c λ∗ |ψ∗|L2 = 0 by self-adjointness. Since ψ∗ is nontrivial, c = 0 and so (2.11) is verified. 

2.3 Global attractor of transitions between vortices 

In this section we prove Theorem 1.3. Note that the PDE (1.16) generates a bounded dissipative semiflow and possesses a strict Lyapunov function given by (1.17) restricted to L2 m(R). Therefore, the global attractor exists and its internal dynamics is decomposed into 

a union of equilibria and their heteroclinic orbits. These attractors for reaction-diffusion equations on a bounded interval are known as Sturm attractors, and have been extensively studied in the literature; see [14, 20, 21, 25] and references therein. The most challenging task is to characterize which pair of equilibria admits a heteroclinic orbit between them; see [14] for PDEs with bounded coefficients and [25] for PDEs with unbounded coefficients. 

The proof of Theorem 1.3 is a consequence of the following three lemmata. 

Lemma 2.6. Cascading. Let u− and u+ be a pair of amplitudes of vortex equilibria of the Ginzburg–Landau equation (1.16) such that n := i(u−)−i(u+) > 0. Then the following statements are equivalent: 

(i) There exists a heteroclinic orbit from u− to u+ in forward time, as in (1.19). 

(ii) There exists a sequence (cascade) of vortex equilibria {uj} n j=0 with u0 := u− and 

un := u+ such that the following holds for all j = 0, ..., n− 1: 

1. i(uj+1) = i(uj) + 1; 

2. there exists a heteroclinic orbit from uj+1 to uj in forward time. 

The proof of Lemma 2.6 relies on nodal properties of solutions, and we refer to [14, Lemma 1.5]. Due to the cascading principle it suffices to construct all heteroclinic orbits between equilibria such that their Morse indices differ by one. Note that the implication of (ii)→ (i) is a special case of a transitivity principle that holds for certain Morse–Smale systems including (1.16). 

The second lemma provides a condition that prevents heteroclinic orbits between vortex equilibria with Morse indices differing by one. Before we present its content, we say that two hyperbolic vortex equilibria uj+1 and uj of (1.16) with i(uj+1) = i(uj)+ 1 are blocked if one of the following conditions holds: 

1. Morse blocking: z(uj+1 − uj) 6= i(uj); 

2. Zero number blocking: there exists an equilibria u∗ between uj+1 and uj along the shooting curve Mu 

s given by (3.36) for some s ∈ [0, s∗] such that 

(2.17) z(uj+1 − u∗) = z(uj+1 − uj) = z(uj − u∗). 

Lemma 2.7. Blocking. Let uj+1 and uj be vortex equilibria of the equation (1.16) such that i(uj+1) = i(uj) + 1. Suppose that uj+1 and uj are blocked. Then there does not exist heteroclinic orbits from uj+1 to uj in forward time. 

The proof of Lemma 2.7 follows from nodal properties of solutions of (1.16); see the subsequent discussion of Definition 1.6 in [14]. 

The third and final lemma is an act of liberalism: If a heteroclinic connection among two equilibria is not forbidden by the blocking law, then a connection between them does exist. Such a liberalism follows from an application of the Conley index theory; see [14, Lemma 1.7]. 

Lemma 2.8. Liberalism. Let uj+1 and uj be hyperbolic vortex equilibria of the equation (1.16) such that i(uj+1) = i(uj)+1. Suppose that uj+1 and uj are not blocked. Then there exists a heteroclinic orbit from uj+1 to uj in forward time. 

Therefore, the blocking and liberalism principles assert that the information of the Morse indices and zero numbers are sufficient to construct the global attractor explicitly. Indeed, these two quantities are determined by the shooting curves (3.36) that we construct in Subsection 3.1. In particular, Theorem 1.3 follows from Section 3, as we show that (1.16) possesses the same shooting curve as the axisymmetric Chafee–Infante equation studied in [25], and thus the global attractor Am of Ginzburg–Landau m-armed vortex solutions coincides with the Chafee–Infante attractor as shown in Figure 5. 

3 Hyperbolicity of Vortex Equilibria 

In this section we present the framework of proof for hyperbolicity of vortex equilibria in Lemma 2.1. First, we study the asymptotic behavior of bounded solutions of the ODE (1.10) near vortices, and then extract the shooting parameter. Next, we define the shooting manifolds as the unstable manifold of the vortex at s = 0, and if ∂M is empty, also the stable manifold of the other vortex at s = s∗. When ∂M is nonempty, the shooting curve is the section of the shooting manifold on the boundary. When ∂M is empty, the section at s = s∗/2 of the shooting manifolds yields two shooting curves. Note that hyperbolicity of vortex equilibria in L2 

m(R) that satisfy the ODE (1.10) with unbounded coefficients is equivalent to transverse intersections between the shooting curve of such ODEs and the line associated with prescribed linear separate boundary conditions; see [25, Lemma 2.4]. Hence our idea of proof is to study the shooting curves defined by the ODE (1.10). 

3.1 Shooting Curves 

The ODE (1.10) possesses unbounded coefficients as s ց 0, and as sր s∗ if in addition ∂M is empty. Thus we apply the Euler multiplier 

(3.1) 

( ds 

dτ := 

) ṡ = a(s), 

to transform (1.10) into 

(3.2) ü−m2u+ λ a2(s(τ)) (1− u2) u = 0 

for τ ∈ (−∞, τ∗) so that all coefficients are bounded. 

Note that we can recover the original variable s ∈ [0, s∗] via the mapping τ = τ(s) such that τ ′(s) = 1/a(s) and limsց0 τ(s) = −∞. Moreover, τ∗ := limsրs∗ τ(s) = ∞ if ∂M is empty, and τ∗ := τ(s∗) <∞ if ∂M is nonempty. 

We recast (3.2) into the following autonomous ODE system: 

u̇ = v, 

v̇ = m2u− λ a2(s)(1− u2) u,(3.3) 

ṡ = a(s). 

Clearly, (3.3) possesses the homogeneous equilibrium (u, v, s) = (0, 0, 0), and another homogeneous equilibrium (u, v, s) = (0, 0, s∗) if in addition ∂M is empty. Our first lemma guarantees that all solutions converge to these two equilibria as |τ | → ∞. 

Lemma 3.1. Let ψ(s, ϕ) = u(s)eimϕ be a smooth solution of (1.9). Then after applying the Euler multiplier (3.1), we have 

(3.4) lim τ→−∞ 

u(τ) = 0, lim τ→−∞ 

u̇(τ) = 0. 

If in addition ∂M is empty, then 

(3.5) lim τ→∞ 

u(τ) = 0, lim τ→∞ 

u̇(τ) = 0. 

Proof. Since τ = −∞ corresponds to s = 0 by the Euler multiplier (3.1), continuity of ψ(s, ϕ) at s = 0 implies limsց0 ψ(s, ϕ) = limsց0 ψ(s, ϕ + π). Thus limsց0 u(s) = 0, and so limτ→−∞ u(τ) = 0. 

By the chain rule u̇(τ) = u′(s) a(s), where s = s(τ) is solved by (3.1), it is equivalent to show limsց0 u 

′(s) a(s) = 0. Since ψ solves (1.9), we have ψ ∈ C2,ν(M,C) by elliptic regularity. In particular 

(3.6) |∇ψ|C0 = sup s∈[0,s∗] 

( |u′(s)|2 + 

m2 

a2(s) |u(s)|2 

) <∞ 

and thus u′(0) exists. Hence limsց0 u ′(s) a(s) = 0 because a(0) = 0. 

The proof for the case ∂M being empty is analogous because a(s∗) = 0. 

Note that the trivial equilibrium (u, v, s) = (0, 0, 0) of (3.3) is hyperbolic with three eigen-values 1 and ±m corresponding to the eigendirections given by (0, 0, 1) and (1,±m, 0), respectively. Therefore, Lemma 3.1 implies that solutions of (3.3) are in the unstable manifold of the trivial equilibrium. Moreover, linear analysis shows that every nontrivial bounded solution satisfies the following asymptotic expansion as τ → −∞: 

(3.7) u(τ) = d emτ + g(τ) 

for some d 6= 0 and smooth function g(τ) that satisfies 

(3.8) lim τ→−∞ 

g(τ) 

emτ = 0. 

Here we notice that the shooting argument used in the literature [17, 19, 23, 45] assumes that g exists, and thus the corresponding asymptotic expansion is formal. Here, however, our shooting method proves the existence of g via the Euler multiplier and the unstable manifold of the trivial equilibrium. 

The only bounded solution that does not satisfy the asymptotic expansion (3.7) is the trivial equilibrium, which occurs when d = 0, and it corresponds to a one-dimensional submanifold of the two-dimensional unstable manifold; see Figure 7. 

(0, 0, 1) 

(1,m, 0) 

s 

v 

u 

(1,m, 0) 

(0, 0, 1) 

Figure 7: Consider the case m > 1. On the left, the linear flow corresponds to the tangent space of the two-dimensional unstable manifold of the trivial equilibrium (0, 0, 0). On the right, the unstable manifold contains a one-dimensional curve (in bold) parametrized by d ∈ R. Note that the unstable manifold inherits the symmetry (u, v) 7→ (−u,−v) of the equation (3.3). 

We define 

(3.9) w(τ) := u(τ) 

emτ . 

Thus by (3.7) we have 

(3.10) w(τ) = d+ g(τ) 

emτ . 

Substituting u(τ) = w(τ)emτ into (3.2) yields 

(3.11) ẅ + 2mẇ + λ a2(s(τ)) (1− e2mτw2)w = 0. 

The following lemma forces us to solve (3.11) by imposing the Neumann boundary con-dition at τ = −∞. 

Lemma 3.2. If w(τ) is a smooth bounded solution of (3.11), then 

(3.12) lim τ→−∞ 

ẇ(τ) = 0. 

Proof. By (3.10), we know 

(3.13) lim τ→−∞ 

ẇ(τ) = lim τ→−∞ 

ġ(τ)−mg(τ) 

emτ . 

Due to (3.8), it suffices to show 

(3.14) lim τ→−∞ 

ġ(τ) 

emτ = 0. 

Substituting w(τ) in (3.10) into (3.11) and using limτ→−∞ a(s(τ)) = a(0) = 0, we see 

(3.15) lim τ→−∞ 

g̈(τ) 

emτ = 0. 

Hence given any ǫ > 0, there exists some τ̃ ∈ (−∞, τ∗) such that 

(3.16) |g(τ)|, |g̈(τ)| ≤ ǫ emτ for all τ ∈ (−∞, τ̃). 

We consider τ ∈ (−∞, τ̃ − 1). We apply the mean value theorem twice and obtain 

g(τ + 1)− g(τ)− ġ(τ) = ġ(ξ1)− ġ(τ)(3.17) 

= g̈(ξ2)(ξ1 − τ) 

for some ξ1 ∈ (τ, τ+1) and ξ2 ∈ (τ, ξ1). Since τ +1 ∈ (−∞, τ̃ ), ξ1−τ ≤ 1, and ξ2−τ ≤ 1, the bounds in (3.16) applied to (3.17) imply that 

|ġ(τ)| ≤ |g(τ + 1)|+ |g(τ)|+ |g̈(ξ2)|(3.18) 

≤ ǫ (em + 1 + em) emτ 

for all τ ∈ (−∞, τ̃ − 1). The proof is complete. 

If in addition ∂M is empty, then the equilibrium (u, v, s) = (0, 0, s∗) is hyperbolic with two negative eigenvalues −1 and −m < 0 corresponding to the eigendirections given by (0, 0, 1) and (1,−m, 0), respectively. Hence the following asymptotic expansion as τ →∞ holds: 

(3.19) u(τ) = d̃ e−mτ + h(τ), 

where limτ→∞ h(τ)/e−mτ = 0. 

We define 

(3.20) z(τ) := u(τ) 

e−mτ , 

substitute u(τ) = z(τ)e−mτ into (3.2), and then obtain 

(3.21) z̈ − 2m ż + λ a2(s(τ)) (1− e−2mτz2) z = 0. 

Similarly, we have to impose the Neumann boundary condition at τ =∞ to solve (3.21). The proof is the same as the one in Lemma 3.2. 

Lemma 3.3. If ∂M is empty and z(τ) is a smooth bounded solution of (3.21), then 

(3.22) lim τ→∞ 

ż(τ) = 0. 

Next, we define the shooting curves using the variables w, and also z if in addition ∂M is empty. Indeed, recast (3.11) as the following autonomous ODE system: 

ẇ = p, 

ṗ = −λ a2(s)(1− e2mτ(s)w2)w − 2mp,(3.23) 

ṡ = a(s) 

for τ ∈ (−∞, τ∗). According to Lemma 3.2 we solve (3.23) with the Neumann data (w, p, s) = (d, 0, 0), where d ∈ R is the shooting parameter; see Figure 8. 

s 

ẇ 

w 

Figure 8: The bold line is parametrized by d ∈ R and describes the Neumann data given by (3.12) for the shooting flow (3.23) in (w, ẇ, s)-coordinates. 

Similarly, if ∂M is empty, we recast (3.21) as the following autonomous ODE system: 

ż = q, 

q̇ = −λ a2(s)(1− e−2mτ(s)z2) z + 2mq,(3.24) 

ṡ = a(s). 

for τ ∈ (−∞,∞) and solve it with the Neumann data (z, q, s) = (d̃, 0, 0), where d̃ ∈ R is another shooting parameter, according to Lemma 3.3. 

The Neumann line at s = 0 is given by 

(3.25) L0 := {(w, p, s) ∈ R 3 | (w, p, s) = (d, 0, 0)}, 

and each point in L0 is a homogeneous equilibrium of (3.23). Hence, L0 is invariant under the dynamics of (3.23). Therefore, we cannot evolve L0 under the flow of (3.23) to define the shooting manifold. Instead, we define the shooting manifold as the unstable manifold of L0 as follows. The linearization of (3.23) at each equilibrium (d, 0, 0) ∈ L0 possesses eigenvalues 1, −2m, and 0 with associated eigenvectors (0, 0, 1), (1,−2m, 0), (1, 0, 0), respectively. Hence, there is only one unstable direction (0, 0, 1) parallel to the s-axis and thus a one-dimensional unstable manifold denoted by W u(d, 0, 0), which is locally a graph {(wu(s, d), pu(s, d), s) ∈ R3}; see [18]. 

The union of all unstable manifolds defines the unstable shooting manifold : 

(3.26) Mu := ⋃ 

d∈R 

W u(d, 0, 0). 

Similarly, if ∂M is empty, then by Lemma 3.3 we consider the Neumann line at s = s∗ 

(3.27) Ls∗ := {(z, q, s) ∈ R 3 | (z, q, s) = (d̃, 0, s∗)}. 

Note that Ls∗ consists of homogeneous equilibria and is invariant under the dynamics of (3.24). Each homogeneous equilibrium (d̃, 0, s∗) ∈ Ls∗ possesses a one-dimensional stable manifold W s(d̃, 0, s∗), locally given by the graph {(zs(s, d̃), qs(s, d̃), s) ∈ R3} and is tangent to the eigenvector (0, 0,−1). The stable shooting manifold is defined by 

(3.28) Ms := ⋃ 

d̃∈R 

W s(d̃, 0, s∗). 

On the other hand, if ∂M is nonempty, then due to Robin boundary conditions (1.11), we consider the Robin line 

(3.29) Lα1,α2 

s∗ = { ( w, p, s) ∈ R 

3 | (α1 a(s∗) + α2m ) w + α2 p = 0, s = s∗}. 

There is no need to define the stable shooting manifold, since there are no unbounded coefficients of the ODE (1.10) at s = s∗, due to a(s∗) 6= 0. 

Lemma 3.4. For any shooting parameter d ∈ R, the solution of the ODE system (3.23) exists globally. If in addition ∂M is empty, then for any shooting parameter d̃ ∈ R, the solution of the ODE system (3.24) exists globally 

Proof. The local existence of solutions near τ = −∞ is ensured by the unstable man-ifold of the equilibrium (d, 0, 0). Towards a contradiction, suppose that there is a so-lution (w(τ), p(τ), s(τ)) that blows up in finite time T ∈ R. Thus there exists an in-creasing sequence {τj}j∈N with limj→∞ τj = T such that either limj→∞ |w(τj)| = ∞ or limj→∞ |p(τj)| =∞. We rewrite the second equation in (3.23) as follows: 

(3.30) ṗ = h1(τ, w, p) := −2mp− λ a2(s(τ))w + λ a2(s(τ)) e2mτ w3. 

The proof consists of two steps. In the first step we prove that w(τ) is monotone near the blow up time T . In the second step we derive a contradiction by applying a suitable comparison principle. 

Case 1 : limj→∞w(τj) = ∞. We claim p(τ) > 0 for all τ with sufficiently small positive T − τ , which in particular implies 

(3.31) lim τրT 

w(τ) =∞. 

Indeed, towards a contradiction to this claim, suppose that p(τ) is not positive for all τ with sufficiently small positive T − τ . Since limj→∞w(τj) =∞, there exists an increasing sequence {ξj}j∈N with limj→∞ ξj = T such that w(ξj) > 0, limj→∞w(ξj) =∞, p(ξj) = 0, and ṗ(ξj) ≤ 0. However, by (3.30) we know 

(3.32) ṗ(ξj) = −λ a 2(s(ξj))w(ξj) + λ a2(s(ξj)) e 

2mξj w3(ξj) > 0 

for sufficiently large j ∈ N, which is a contradiction to ṗ(ξj) ≤ 0. 

Case 2 : limj→∞ p(τj) =∞. There are two further cases. First, if ṗ(τ) > 0 for all τ with sufficiently small positive T − τ , then limτրT p(τ) =∞ due to limj→∞ p(τj) =∞, which 

together with (3.30) implies (3.31). Second, if ṗ(τ) is not positive for all τ with sufficiently small positive T − τ , then there exists an increasing sequence {ζj}j∈N with limj→∞ ζj = T such that p(ζj) > 0, limj→∞ p(ζj) = ∞, and ṗ(ζj) = 0. Hence substituting ζj into (3.30) implies limj→∞w(ξj) =∞, which is reduced to Case 1. 

Case 3 : Either limj→∞w(τj) = −∞ or limj→∞ p(τj) = −∞. Since (w(τ), p(τ), s(τ)) is a solution of (3.23) if and only if (−w(τ),−p(τ), s(τ)) is a solution, we can slightly modify the proof in Case 1 and 2 to obtain the monotonicity of w(τ) and in particular 

(3.33) lim τրT 

w(τ) = −∞. 

Next, we derive a contradiction for Case 1 and 2. We compare (3.30) with the following autonomous damped second-order ODE: 

(3.34) ˙̃w = p̃, 

˙̃p = h2(w̃, p̃) := −2m p̃− w̃ + λ a2M e2mT w̃3, 

where aM := maxs∈[0,s∗] a(s). Notice that solutions of (3.34) exist globally by phase portrait analysis. Observe that 

(3.35) h1(τ, w, p) < h2(w, p) 

for all τ ∈ (−∞, T ), sufficiently large w > 0, and p ∈ R. Due to (3.31), there is a τ0 with sufficiently small positive T − τ0 such that (3.35) holds as we substitute the solution of (3.23) for τ ∈ (τ0, T ) into h1 and h2. We can always choose an initial condition (w̃(τ0), p̃(τ0)) for the ODE (3.34) such that w(τ0) ≤ w̃(τ0) and p(τ0) ≤ p̃(τ0). Then the comparison principle in [22, Theorem 1] ensures w(τ) ≤ w̃(τ) for τ ∈ (τ0, T ), which contradicts to the assumption of finite time blow up, since w̃(τ) exists globally. 

For a contradiction to Case 3, due to (3.33) we still compare (3.30) with (3.34), but we reverse the sign of (3.35) and the inequality between initial conditions at τ = τ0. 

If in addition ∂M is empty, then the ODE systems (3.23) and (3.24) are symmetric with respect to the time reversal symmetry τ 7→ −τ . With such a symmetry, the previous proof is valid and the global existence of solutions also holds for (3.24) 

Because of the global existence in Lemma 3.4, we are able to define the unstable shooting curve as the section of the unstable manifold Mu for any fixed ŝ ∈ [0, s∗], namely 

(3.36) Mu ŝ :=Mu ∩ {(w, p, ŝ) ∈ R 

3}. 

This is a smooth simple curve parametrized by d ∈ R. If ∂M is empty, then similarly we define the stable shooting curve Ms 

ŝ parametrized by d̃ ∈ R. 

The shooting manifolds characterize equilibria, their Morse indices, and zero numbers; see [25, Lemma 2.4]. For the case ∂M being empty, the set of solutions of (1.10) is in one-to-one correspondence with Mu 

s∗/2 ∩ Ms 

s∗/2 . Moreover, a solution corresponding to 

fixed d ∈ R and d̃ ∈ R is hyperbolic if and only if W u(d, 0, 0) intersects W s(d̃, 0, s∗) transversely. Similarly, when ∂M is nonempty, the set of solutions of (1.10) is in one-to-one correspondence with Mu 

s∗ ∩ L α1,α2 

s∗ . Moreover, a solution corresponding to a fixed d ∈ R is hyperbolic if and only if W u(d, 0, 0) intersects Lα1,α2 

s∗ transversely. 

3.2 Monotonicity 

To construct the unstable shooting manifold Mu of the ODE system (3.23), due to the symmetry that (w, p, s) is a solution of (3.23) if and only if (−w,−p, s) is also a solution, it suffices to consider d > 0. Similarly, if ∂M is empty, it suffices to consider d̃ > 0 for obtaining the stable shooting manifold Ms of the ODE system (3.24). 

Furthermore, since we only focus on hyperbolicity of vortex equilibria, it suffices to con-sider d ∈ (0, dλ) for any fixed λ > λ0. Here dλ > 0 is the shooting parameter that yields the intersection point between two shooting curves (if ∂M is empty) or between the un-stable shooting curve and the Robin line (if ∂M is nonempty), which corresponds to the vortex equilibrium with positive amplitude. Note that the existence of such a vortex equilibrium has already been proved in [10, Lemma 3.8]. We will study how the unstable shooting manifold Mu winds around the line of trivial equilibria {(0, 0, s) ∈ R3}. 

More precisely, in polar coordinates with clockwise angle 

(3.37) (w, p) = (ρ cos(µ),−ρ sin(µ)), 

the ODE system (3.23) reads 

ρ̇ = ρ sin(µ) cos(µ) ( λ a2(s)(1− e2mτ(s)ρ2 cos2(µ))− 1 

) − 2mρ sin2(µ), 

µ̇ = sin2(µ) + λ a2(s) cos2(µ) ( 1− e2mτ(s)ρ2 cos2(µ) 

) − 2m sin(µ) cos(µ),(3.38) 

ṡ = a(s). 

The Neumann data (w, p) = (d, 0) at τ = −∞ reads 

(3.39) lim τ→−∞ 

µ(λ, τ) = 0 

for each fixed λ > 0. We adapt the idea in [20, 25, 38] to prove that the radius function ρ and the angle function µ are monotone with respect to the shooting parameter d ∈ (0, dλ). 

Lemma 3.5. For each fix λ > 0, let (ρ, µ) and (ρ̃, µ̃) be solutions of (3.38) with different Neumann data 

(3.40) lim τ→−∞ 

(ρ(τ), µ(τ)) = (d, 0), lim τ→−∞ 

(ρ̃(τ), µ̃(τ)) = (d̃, 0), 

where 0 < d < d̃ < dλ. Then 

(3.41) µ(τ) > µ̃(τ) 

and 

(3.42) ρ(τ) < ρ̃(τ) 

for all τ ∈ (−∞, τ∗). 

Proof. Define F : R3 → R3, F = F (ρ, µ, s), whose j-th coordinate function Fj corre-sponds to the j-th line of the right-hand side in (3.38). Clearly, F is Lipschitz continuous. 

We first prove the nonstrict inequality: 

(3.43) µ(τ) ≥ µ̃(τ) for all τ ∈ (−∞, τ∗). 

Suppose towards a contradiction that 

(3.44) µ(τ1) < µ̃(τ1) for some τ1 ∈ (−∞, τ∗). 

Let w = w(τ, d) be the solution of (3.23) with the shooting parameter d > 0. The variational equation for y := wd is given by 

(3.45) ÿ + 2m ẏ + λ a2(s)(1− 3 e2mτw2) y = 0. 

In polar coordinates, the associated angle function ϑ of y satisfies 

ϑ̇ = sin2(ϑ) + λ a2(s) cos2(ϑ)(1− 3 e2mτ(s)w2)− 2m sin(ϑ) cos(ϑ)(3.46) 

=: f(ϑ, s, w). 

Clearly, 

(3.47) f(ϑ, s, d) > f(ϑ, s, d̃) 

holds in some neighborhood of (ϑ, s) = (0, 0) for 0 < d < d̃. 

Note that the equation (3.46) describes the angle of the tangent vector of the shooting curve for the shooting parameter d > 0. Therefore, due to (3.47), comparison of two solutions of (3.46) with different initial data d < d̃ implies ϑ(τ, d) > ϑ(τ, d̃). In other words, as the parametrization of the shooting curve given by d > 0 increases, the an-gle of its tangent vector decreases. Around the nonhyperbolic homogeneous equilibrium (w, p, s) = (d, 0, 0), the semiflow generated by (3.23) is locally topologically conjugate to the one generated by its associated linearization (see [43]), and moreover, by continuous dependence of the semiflow generated by (3.23) with respect to d > 0, (3.46) and (3.47) imply 

(3.48) µ(τ) > µ̃(τ) for all τ near −∞. 

Due to (3.44), (3.48), and continuity of µ, µ̃ in τ , there is some τ2 ∈ (−∞, τ1) so that 

(3.49) µ(τ2) = µ̃(τ2), µ(τ) < µ̃(τ) for all τ ∈ (τ2, τ1). 

Integrating the µ-equation in (3.38) on (τ2, τ) with τ2 < τ ≤ τ1 gives 

(3.50) µ(τ)− µ(τ2) = 

∫ τ 

τ2 

F2(ρ(σ), µ(σ), s(σ)) dσ, 

and similarly for µ̃, 

(3.51) µ̃(τ)− µ̃(τ2) = 

∫ τ 

τ2 

F2(ρ̃(σ), µ̃(σ), s(σ)) dσ. 

We consider the difference of (3.50) and (3.51), noticing (3.49) and Lipschitz continuity of F2. Hence there exists a constant c1 = c1(τ2, τ) > 0 such that the difference µ̃ − µ satisfies 

(3.52) 0 < µ̃(τ)− µ(τ) ≤ c1 

∫ τ 

τ2 

√ |ρ̃(σ)− ρ(σ)|2 + |µ̃(σ)− µ(σ)|2 dσ. 

We define c2 = c2(τ2, τ) > 0 such that |ρ̃(σ) − ρ(σ)| < c2 for all σ ∈ (τ2, τ). Since the square root of a sum is less than the sum of the square roots, we have 

(3.53) µ̃(τ)− µ(τ) ≤ c1 c2 (τ − τ2) + c1 

∫ τ 

τ2 

µ̃(σ)− µ(σ) dσ. 

The mean value theorem yields some τ3 ∈ (τ2, τ) such that 

(3.54) τ − τ2 = 

∫ τ τ2 µ̃(σ)− µ(σ) dσ 

µ̃(τ3)− µ(τ3) . 

Note that the denominator is nonzero due to (3.49). For sufficiently small ǫ > 0, let 

(3.55) mǫ := min s∈[τ2+ǫ,τ1] 

( µ̃(s)− µ(s) 

) . 

Then mǫ ∈ (0,∞) by continuity of µ̃ and µ, and also (3.49). Substituting (3.54) and (3.55) into (3.53) yields 

(3.56) µ̃(τ)− µ(τ) ≤ 

( c1c2 mǫ 

+ c1 

)∫ τ 

τ2 

(µ̃(σ)− µ(σ)) dσ 

for all τ ∈ [τ2 + ǫ, τ1]. 

The integral Grönwall inequality implies µ̃(τ)−µ(τ) ≤ 0 for all τ ∈ [τ2+ǫ, τ1], in particular for τ = τ1, which contradicts to the definition of τ1 in (3.44) and proves the nonstrict inequality (3.43). 

Next we prove the strict inequality (3.41). Suppose on the contrary that there exists a τ4 ∈ R such that µ(τ4) = µ̃(τ4). 

By (3.48) we can take τ5 ∈ (−∞, τ4) such that µ(τ5) > µ̃(τ5). Note that the nonstrict inequality (3.43) holds for all τ ∈ (τ5, τ4). Integrating the µ-equation of (3.23) backwards from τ4 to τ5 through the transformation τ̃ := τ4 + τ5 − τ yields 

(3.57) µ(τ5)− µ(τ4) = 

∫ τ5 

τ4 

F2(ρ(σ), µ(σ), s(σ)) dσ, 

with similar equality for µ̃. 

Hence, the same method from (3.52) to (3.56) above can be applied for the difference µ(τ)− µ̃(τ), yielding the inequality µ(τ5)− µ̃(τ5) ≤ 0. This contradicts to the definition of τ5 and proves the strict inequality (3.41). 

Analogously, we can apply the above argument to prove the monotonicity (3.42) of the radius function, with only two mild adaptations. First, we do not have to study the asymptotic behavior as τ → −∞, since the shooting parameters are already ordered by 0 < d < d̃. Second, we take an upper bound of |µ̃−µ| in (3.52), and then apply the mean value theorem on |ρ̃− ρ| in the analogous version of (3.53). The proof is complete. 

3.3 Hyperbolicity: All intersections are transverse 

When ∂M is nonempty, hyperbolicity is equivalent to transverse intersections between the shooting curve Mu 

s∗ from (3.36) and the Robin line Lα1,α2 

s∗ from (3.29) that describes Robin boundary conditions. 

In case that the boundary conditions are not of the Dirichlet type, that is, α2 6= 0, in order to describe whether the shooting curve is tangent to the line Lα1,α2 

s∗ easily, we rotate the horizontal w-axis to Lα1,α2 

s∗ by the constant angle 

(3.58) θ := arctan 

( − α1 a(s∗) + α2m 

α2 

) . 

In other words, we rotate the original polar coordinates (w, p) = (ρ cos(µ),−ρ sin(µ)), as in (3.37), by defining the new polar coordinates 

(3.59) (w̃, p̃) := (ρ cos(µ̃),−ρ sin(µ̃)), 

where 

(3.60) µ̃ := µ− θ. 

It suffices to prove that the shooting curve in the new coordinates (w̃, p̃, s∗) intersects the w̃-axis transversely. 

In case of Dirichlet boundary conditions, that is, α2 = 0, there is no need for introducing the rotation and thus we simply let θ = 0. 

The tangent vector of the shooting curve is given by (w̃d(τ∗), p̃d(τ∗)). Suppose that there exists a tangent vector parallel to the w̃-axis, that is, p̃d(τ∗) = 0 for some d ∈ (0, dλ). Then (3.59) implies 

(3.61) 0 = −ρd(τ∗) sin(µ̃(τ∗))− ρ(τ∗) cos(µ̃(τ∗))µ̃d(τ∗). 

Monotonicity in Lemma 3.5 and the uniqueness theorem of ODE initial value problems yield 

(3.62) ρd(τ∗) > 0, µ̃d(τ∗) < 0 

for all d ∈ (0, dλ). 

Since ρ(τ∗) > 0, we see that both sin(µ̃(τ∗) and cos(µ̃(τ∗)) are nonzero. We divide (3.61) by cos(µ̃(τ∗)) and obtain 

(3.63) µ̃(τ∗) = arctan 

( − ρ(τ∗)µ̃d(τ∗) 

ρd(τ∗) 

) . 

Since µ̃d(τ∗) and ρd(τ∗) have different signs, as in (3.62), the angle of the shooting curve satisfies µ̃(τ∗) ∈ (0, π/2). This means that if the tangent vector of a point on the shooting curve is parallel to the w̃-axis, then such a point lies outside the w̃-axis and the p̃-axis. Hence, the shooting curve intersects the w̃-axis and the p̃-axis transversely. 

When ∂M is empty, note thatMu andMs have different coordinates given by (w, p, s) and (z, q, s), respectively. We unify those coordinates into a single nomenclature, namely, we denote the horizontal axis to be either the w-axis for Mu or the z-axis for Ms. Similarly, we denote the vertical axis to be either the p-axis for Mu or the q-axis for Ms. The reflectional symmetry (1.4) admits the time reversal symmetry τ 7→ −τ , which implies that (w(τ), p(τ), s(τ)) is a solution of (3.23) if and only if (w(−τ),−w(−τ), s∗−s(−τ)) is a solution of (3.24). Hence the stable shooting manifoldMs of (3.24) is simply a reflection of the unstable shooting manifold Mu of (3.23) with respect to the vertical axis. 

Due to the time reversal symmetry, the intersection points between Mu and Ms, which yield vortex equilibria, are on either the horizontal axis or the vertical axis; also see [10, Lemma 3.5 (iii)]. Hence for hyperbolicity it suffices to prove that both shooting curves Mu 

s∗/2 and Ms 

s∗/2 are not tangent to the horizontal axis and the vertical axis. Indeed, the 

time reversal symmetry implies that at each intersection point, Mu s∗/2 

is tangent to the axis if and only if Ms 

s∗/2 also does. 

Consequently, we have reduced the proof to showing that the shooting curve Mu s∗/2 

is not tangent to the horizontal axis and the vertical axis. Such a proof follows directly by the one above, for the case ∂M being nonempty. See Figure 9 for a schematic shape of shooting curves. 

w 

p 

Mu s∗/2 

Ms s∗/2 

w 

p 

Mu s∗/2 

Ms s∗/2 

w 

p 

Mu s∗/2 

Ms s∗/2 

Figure 9: From left to right, when ∂M is empty, the shooting curves Mu s∗/2 

(solid curve) and M s s∗/2 

(dashed curve) generated by (3.23) and (3.24) for λ ∈ (λ0, λ1), λ ∈ (λ1, λ2), and λ ∈ (λ2, λ3), respectively. The schematic shape of these curves is rigorously obtained by the monotonicity of both the radius and angle of each curve in polar coordinates (see Lemma 3.5) and the time reversal symmetry τ 7→ −τ . 

Therefore, all nontrivial vortex equilibria are hyperbolic. The trivial equilibirum, that is, when d = 0 and thus ρ ≡ 0, is a tangent intersection point only at the bifurcation point λ = λk, where λk denotes the k-th eigenvalue of −∆M restricted to L2 

m(R). 

Acknowledgment. This collaboration arose from the pleasant office sharing while the authors did their PhD in Berlin. For that we are grateful for Bernold Fiedler. Jia-Yuan Dai was supported by NCTS grant number 107-2119-M-002-016 and sunshine in São Carlos. PL was supported by FAPESP, 2017/07882-0, 18/18703-1, and a free lunch after winning a bet regarding a proof in this paper. 

References 

[1] M. S. Agranovich, Y. Egorov, and M. A. Shubin. Partial Differential Equations IX: Elliptic Boundary Value Problems. Vol. 79 of Encyclopaedia of Mathematical Sci-ences, Springer-Verlag Berlin Heidelberg, (1997). 

[2] I. S. Aranson and L. Kramer. The world of complex Ginzburg–Landau equation. Rev. Modern Phys. 74, 99–143, (2002). 

[3] A.V. Babin and M.I. Vishik. Attractors of Evolution Equations. Elsevier Science, (1992). 

[4] M. Bär, A. K. Bangia, and I. G. Kevrekidi. Bifurcation and stability analysis of rotating chemical spirals in circular domains: Boundary-induced meandering and stabilization. Phys. Rev. E 67, p56126, (2003). 

[5] A. N. Carvalho and J. G. Ruas-Filho. Global Attractors for Parabolic Problems in Fractional Power Spaces. SIAM Journal on Mathematical Analysis,Vol. 26, 415–427, (1995). 

[6] K.-S. Chen. Instability of Ginzburg–Landau vortices on manifolds. Proceedings of the Royal Society of Edinburgh Section A: Mathematics, 143, 337–350, (2013). 

[7] P. Chossat, R. Lauterbach and I. Melbourne. Steady-State Bifurcation with O(3)-Symmetry. Arch. Rational Mech. Anal. 113, 313–376, (1990). 

[8] P. Chossat and R. Lauterbach (2000). Methods in Equivariant Bifurcations and Dy-namical Systems. World Scientific Publishing Co. Pte. Ltd, (2000). 

[9] D. R. Cheng. Instability of solutions to the Ginzburg–Landau equation on Sn and CP 

n. Journal of Functional Analysis, Vol. 279, 108669, (2020). 

[10] J.-Y. Dai. Ginzburg–Landau Spiral Waves in Circular and Spherical Geometries. SIAM Journal on Mathematical Analysis, Vol. 53, 1004–1028, (2020). 

[11] Q. Du, M. G. Max. and J. S. Peterson. Analysis and Approximation of the Ginzburg–Landau Model of Superconductivity. SIAM Review 34, 54–81, (1992). 

[12] B. Fiedler, M. Georgi, and N. Jangle. Spiral wave dynamics: reaction and diffusion versus kinematics. Analysis and Control of Complex Nonlinear Processes in Physics, Chemistry and Biology. Lecture Notes in Complex Systems 5, World Scientific, Sin-gapore, 69–114, (2007). 

[13] B. Fiedler and A. Scheel. Spatio-Temporal Dynamics of Reaction-Diffusion Patterns. Trends in Nonlinear Analysis, Springer-Verlag Berlin Heidelberg, 23–152, (2003). 

[14] B. Fiedler and C. Rocha. Heteroclinic orbits of semilinear parabolic equations. J. Diff. Eq. 125, 239–281, (1996). 

[15] J. Gomatam and F. Amdjadi. Reaction-diffusion equations on a sphere: Meandering of spiral waves. Phys. Rev. E, 56, 3913–3919, (1997). 

[16] M. Golubitsky and I. Stewart. The Symmetry Perspective. Birkhäuser-Verlag, (2003). 

[17] J. M. Greenberg. Spiral waves for λ− ω systems. SIAM Journal on Applied Mathe-matics, 39, 301–309, (1980). 

[18] J. Guckenheimer and P. Holmes. Nonlinear Oscillations, Dynamical Systems, and Bifurcations of Vector Fields. Springer-Verlag New York, (1983). 

[19] P. S. Hagen. Spiral Waves in Reaction-Diffusion Equations. SIAM Journal on Applied Mathematics, 42, 762–786, (1982). 

[20] J. Hale. Dynamics of a scalar parabolic equation. Canadian App. Math. Quarterly 12, 239–314, (1989). 

[21] D. Henry. Geometric theory of semilinear parabolic equations. Springer-Verlag Berlin Heidelberg (1981). 

[22] L. Jackson and K. Schrader. On Second Order Differential Inequalities. Proc. Am. Math. Soc., 17, 1023–1027, (1966). 

[23] N. Kopell and L. N. Howard. Target pattern and spiral solutions to reaction-diffusion equations with more than one space dimension. Adv. App. Math. 2, 417–449, (1981). 

[24] P. Lappicy. Space of initial data for self-similar Schwarzschild solutions of the Einstein equations. Phys. Rev. D 99, 043509, (2019). 

[25] P. Lappicy. Sturm attractors for quasilinear parabolic equations with singular coef-ficients. J. Dyn. Diff. Eq. 32, 359–390, (2020). 

[26] F.-H. Lin. Some dynamical properties of Ginzburg–Landau vortices. Comm. Pure App. Math. 49, 323–359, (1996). 

[27] F.-H. Lin and D. Qiang. Ginzburg–Landau Vortices: Dynamics, Pinning, and Hys-teresis. SIAM Journal on Mathematical Analysis 28, 1265–1293, (1997). 

[28] T.-C. Lin. The stability of the radial solution to the Ginzburg–Landau equation. Communications in Partial Differential Equations 22, 619–632, (1997). 

[29] J. Maselko. Symmetrical double rotor spiral waves on spherical surfaces. J. Chem. Soc., Faraday Trans. 94, 2343–2345, (1998). 

[30] J. Maselko and K. Showalter. Single and double rotor spiral waves on spherical sur-faces. Reaction Kinetics and Catalysis Letters 42, 263–274, (1990). 

[31] A. Mielke. The Ginzburg–Landau equation in its role as a modulation equation. Handbook of dynamical systems, Vol. 2, North-Holland, Amsterdam, 759–834, (2002). 

[32] P. Mironescu. On the Stability of Radial Solutions of the Ginzburg–Landau Equation. Journal of Functional Analysis, Vol. 130, 334–344, (1995). 

[33] J. D. Murray. Mathematical Biology II: Spatial Models and Biomedical Applications. Springer-Verlag New York, (2003). 

[34] L. M. Pismen. Vortices in Nonlinear Fields: From Liquid Crystals to Superfluids, from Non-equilibrium Patterns to Cosmic Strings. Clarendon Press, (1999). 

[35] L. M. Pismen. Patterns and Interfaces in Dissipative Dynamics. Springer-Verlag Berlin Heidelberg, (2006). 

[36] L. Recke and D. Peterhof. Abstract forced symmetry breaking and forced frequency locking of modulated waves. Journal of Differential Equations, Vol. 144, 233–262, (1998). 

[37] G. Richardson and J. Rubinstein. The mixed boundary condition for the Ginzburg Landau model in thin films. Applied Mathematics Letters 13, 97-99, (2000). 

[38] C. Rocha. Generic Properties of Equilibria of Reaction-Diffusion Equations. Proc. of the Roy. Soc. Edinburgh, 45–55, (1985). 

[39] K. Rohlf, L. Glass and R. Kapral. Spiral wave dynamics in excitable media with spherical geometries. Chaos 16, 037115, (2006). 

[40] B. Sandstede and A. Scheel. Superspiral Structures of Meandering and Drifting Spiral Waves. Phyical Review Letters, 86, 171–174 (2001). 

[41] B. Sandstede and A. Scheel. Spiral waves: Linear and nonlinear theory. To appear in Memoirs Amer. Math. Soc., arXiv:2002.10352, (2020). 

[42] A. Scheel. Bifurcation to spiral waves in reaction-diffusion systems. SIAM Journal on Mathematical Analysis, Vol. 29, 1399–1418, (1998). 

[43] A. N. Shoshitaishvili. Bifurcations of topological type at singular points of parametrized vector fields. Funct. Anal. and its App. 6, 169–170, (1971). 

[44] R. Sigrist and P. Matthews. Symmetric Spiral Patterns on Spheres. SIAM Journal on Applied Dynamical Systems, 10, 1177–1211, (2011). 

[45] J.-C. Tsai. Rotating spiral waves in λ− ω systems on circular domains. Physica D: Nonlin. Phenomena 239, 1007–1025, (2010). 

[46] A. M. Turing. The chemical basis of morphogenesis. Philosophical Transactions of the Royal Society of London B: Biological Sciences, Vol. 237, 37–72, (1952). 

[47] A. Vanderbauwhede. Local Bifurcation and Symmetry. Research Notes in Mathemat-ics, (1982). 

[48] H. Yagisita, M. Mimura and M. Yamada. Spiral wave behaviors in an excitable reaction-diffusion system on a sphere. Physica D: Nonlinear Phenomena 124, 126– 136, (1998). 