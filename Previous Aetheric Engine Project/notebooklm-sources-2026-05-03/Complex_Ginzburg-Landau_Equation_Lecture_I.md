# Complex Ginzburg-Landau Equation Lecture I

Complex Ginzburg-Landau Equation Lecture I 

Igor  Aranson & Lorenz Kramer, Reviews of Modern Physics, The World of the Complex Ginzburg-Landau Equation, v 74, p 99 (2002)

Tentative plan 

 Lecture 1. General Introduction. Real GLE 

 Lectures 2 & 3. Complex GLE

Complex Ginzburg-Landau Equation 

 A(x,y,z,t)  –complex amplitude  

                            Laplace operator  

 b – linear dispersion 

 c – nonlinear dispersion

Preamble 

 The  complex Ginzburg-Landau equation  (CGLE) is one of the most-studied nonlinear equations in the physics community. 

  It describes  phenomena from nonlinear waves to second-order phase transitions,  superconductivity, superfluidity and Bose-Einstein condensation etc. 

 Our goal is to give an overview of phenomena  in 1D, 2D and 3D.

Some Historic Comments 

 Vitalii Ginzburg received Nobel Prize in Physics 2003 for writing the GL equation 

 Alex Abrikosov received Nobel Prize in Physics 2003 for a particular (and incorrect) stationary solution to the GL equation 

 What would Landau have said about CGLE? Pathological Science? 

Why do we need to study the CGLE?

Definitions 

 CGLE describes isotropic extended systems near the threshold of long-wavelength supercritical oscillatory instability (Hopf Bifurcation). 

 Near the threshold  the equation assumes universal from. 

 Equation is written in terms of complex amplitude of the most unstable oscillatory mode.  

Examples 

 B-Z type  chemical reactions (2D, 3D) 

 Wide-aperture lasers (2D) 

 Electro-convection in liquid crystals (1D) 

 Hydrodynamic flows (1D) 

 Flames (1D, 2D) 

 Micro-organisms colonies (2D) 

 System near the threshold of orientation transition 

   (2D)  

Cardiac activity

Self-Assembling Microtubules and Molecular Motors 

T. Surray, F. Nedelec, S. Leibler & E. Karsenti,  Physical Properties Determining Self-Organization of Motors & Microtubules, Science, 292 (2001)

Superconductivity and Superfluidity 

NOBEL PRIZE WINNER — Argonne physicist Alexei A. Abrikosov has won the 2003 Nobel Prize for Physics, along with Anthony Leggett of the University of Illinois, Urbana-Champaign, and Vitaly Ginzburg of the P.N. Lebedev Physical Institute in Moscow.

Observed Patterns in the CGLE

Connections to Condensed Matter 

#  (real) Ginzburg-Landau Equation (b,c=0) Superconductivity, superfluidity near Tc 

#  Nonlinear Schrödinger Equations   Superconductivity, superfluidity for T=0 , nonlinear optics 

(fully integrable system in 1D)  

History: Hopf Bifurcation (0D) 

### Poincare considered the problem too trivial to write down…. 

### Andronov & Leontovich did it on the plane ( ~1938). 

Hopf generalized it to many degrees of freedom (1942). 

### |A|=r/g - radius of the cycle, r ~ m arg A  - angle, w – frequency  

# Landau or normal form equation (amplitude equation) 

### u0,v0-steady state solution At  m=0  real part of 2 complex roots cross zero Periodic motion emerges (limit  cycle)

Stability of fixed point 

### Linear stability analysis  

# u 

# v 

# u 

# v 

### m< 0 

### m> 0 limit cycle 

# u 0 

# v 0 

Re l 

Im lw-w 

. .

Example: Limit cycle in the van der Pol Equation 

### Asymptotic method: perturbative solution  

### Substituting in the first  order we obtain linear equation for the correction term  

### From the condition that no resonance we obtain the Landau equation    

Solving the Landau Equation  

### Polar coordinates   A= R ei j     

### R=1 – stable point, R=0 unstable point. Stable solution is a circle of radius R=1 

### General case (the complex Landau equation)

Home work: derive the Landau equation from  

Generalization to arbitrary order system of eqns    

### U – vector of dimension N, L – NxN matrix, F – nonlinearity, w – eigenfrequency, U0 – eigenvector  

### Expansion (transition into a rotating frame)  

Solvability conditions (Fredholm alternative)    

### Zero eigenvector of conjugated system 

### From linear algebra

Spatially Extended Systems 

### Phenomenologically: Newell and Whitehead 1970/1971 Derived for destabilization of plane Couette flow Stewartson & Stuart, DiPrima, Ekhaus and Siegel, 1971 

### Amplitude equation should reproduce linear dispersion relation in the long-wavelength limit 

### Local evolution near the threshold should reproduce Landau equation or normal form (because u(t),v(t) are solutions of full system)  

Linear Stability Analysis

Linearized System

Linear Behavior 

#  for q=0 (Hopf bifurcation)      

#  for small q – long-wavelength oscillatory instability       max growth-rate for homogeneous oscillations  

### Re(l) 

### q 

### Re(l) 

### q x 

### q y

Weakly Non-Linear  Analysis

CGLE-result of solvability conditions 

#  Substitute anzatz into original system 

#  Collect terms at O(e3/2) 

#  Orthogonalization with respect to eigenvector (U1,V1) 

#  D,g can be scaled out  

 from  

Classification of Bifurcation Scenario 

#  General form of linear growth-rate in generic anisotropic systems (expanded near critical wavenumber qc and frequency wc) 

#  vg-linear group velocity, t and x characteristic time and length 

Real Ginzburg-Landau Equation 

 (i) wc=b=0, qc = 0 – real GLE (e.g. 1D) 

#    Examples: stationary bifurcation in Rayleigh-Benard 

# convection, superconductivity & superfluidity (but for totally different reason), system near orientation transition in 2D

Complex Ginzburg-Landau Equation 

 (ii) wc≠ 0, qc = 0 – classic CGLE    

#    Examples: oscillatory chemical reactions, certain class of 

# wide-aperture lasers, biological systems

Coupled Complex Ginzburg-Landau Equations 

 (iii) wc≠ 0, qc ≠ 0 – 2 CGLE for counter-

propagating waves A,B    

# Examples: many 1D hydrodynamic and optical systems

Short Wave Instability: Swift-Hohenberg Equation 

#  Linear growth-rate is max at |q|=qc   General form of linear 

# growth-rate in isotropic systems   

        Complex Swift-Hohenberg Equation    

### qx 

### qy 

### Rel(q) 

### Wensink et al, Mesoscale turbulence in living fluids,  PNAS, 2012

Generic Properties of CGLE 

 Translation Invariance:  r→r+const 

 Isotropic: angle q→q+const 

 Gauge Invariant: A→Aeij, j=const 

 Inversion in param space: (b,c,A)→(-b,-c,A*) 

 Hidden symmetries  (inherited from the NSE)

Select Solutions of the CGLE 

 Plane Waves Solutions: 1D 

 Vortices and Spirals: 2D 

 Vortex Filaments or Lines: 3D 

Plane-wave solutions 

# For b=c=0 (real GLE) Vg=w=0

Plane-wave solutions

Plane-wave solutions 

# For b=c=0 (real GLE) Vg=w=0

Difference with linear waves 

### Linear waves Nonlinear Waves in the CGLE 

### Frequency does not depend on amplitude 

### Frequency is function of amplitude W= - b q2 – c A2 

### Amplitude does not depend on wavenumber q 

### Amplitude depends on the wavenumber A2=1- q2  

### Waves decay  due to dissipation Waves do not decay, system is active, consumes energy 

### Waves do not interact, linear superposition 

### Waves interact, nonlinear collisions and shocks 

### No frequency selection Topological defects and boundaries select unique frequency 

Linear wave equation

Spiral Solution 

### F(r) 

### y(r) 

### For real GLE y=w=0

3D vortex filaments

Few facts about real GLE 

##  1D Stationary GLE is fully integrable. We write it for amplitude-phase 

## variable A=I eij        

##  “Integral of Motion” from the second equations   

##  Home work: find the solution to stationary 1D GLE

Vortices in 2D case

Asymptotic Behaviors 

### for m=±1 

### F 

### r

Slowly Drifting Vortex Solution

Derivation of the  Drift Velocity

Zero modes of adjoint operator  

### Consider Nonlinear PDE   L(U)=0.  Let U0(r) is the solution, L(U0(r))=0 and dL(U0(r))w=0 is corresponding linearized equation. If L(U) does not depend explicitly on r, then                         satisfies the linearized equation  

Adjoint Eigenfunctions

Equations of motion

A Big Trouble with the  Mobility 

The mobility diverges for Rè∞??? 

The vortex does not move???

Saving the Theory 

 Regularization of the Mobility (by Lorenz Kramer et al, and later by Len Pismen) 

 Main issue: moving defects do not perturb the phase far away from the cores 

 One needs more accurate approximation for    r→∞  

Simple Way: 

 Introduce cut-off radius Rc ~1/V   

 From balance of main terms

Equation for the phase of A

Regularization of the Mobility 

### To read more: Len Pismen, Vortices in Nonlinear Fields, Oxford, 1999  

Regularized Equation of Motion 

### Mobility is velocity-dependent 

### The dependence is non-analytic 

Equations of motion are highly nonlinear

Application to Vortex Interaction 

### y 

### x 

### First vortex:       x=0,y=0,m=1 Second vortex: x=x0,y=0,m=-1 

### v v 

### oppositely charged –attraction likely charged – repulsion  