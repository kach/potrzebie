new dimension dimensionless measured in 1

(* COMMON NUMBERS *)

exactly = 1.0
of = 1

hundred = 10^2
thousand = 10^3
myriad = 10^4
lakh, lac = hundred thousand
million = 10^6
crore = hundred lakh
billion = 10^9
pi = 3.14159265359
e  = 2.718281828459
trillion = 10^12
quadrillion = 10^15

(* METRIC PREFIXES *)

hella = 10^27
yotta = 10^24
zetta = 10^21
exa   = 10^18
peta  = 10^15
tera  = 10^12
giga  = 10^09
mega  = 10^06
kilo  = 10^03
hecto = 10^02
deca  = 10^01
deci  = 10^-01
centi = 10^-02
milli = 10^-03
micro = 10^-06
nano  = 10^-09
pico  = 10^-12
femto = 10^-15
atto  = 10^-18
zepto = 10^-21
yocto = 10^-24

new prefix hella    = hella
new prefix yotta, Y = yotta
new prefix zetta, Z = zetta
new prefix exa,   E = exa
new prefix tera,  T = tera
new prefix giga,  G = giga
new prefix mega,  M = mega
new prefix kilo,  k = kilo
new prefix hecto, h = hecto
new prefix deca, da = deca
new prefix deka = deca
new prefix deci,  d = deci
new prefix centi, c = centi
new prefix milli, m = milli
new prefix micro, u = micro
new prefix nano,  n = nano
new prefix pico,  p = pico
new prefix femto, f = femto
new prefix atto,  a = atto
new prefix zepto, z = zepto
new prefix yocto, y = yocto
new prefix unit_    = 1 (* in case you accidentally shadow a unit *)

(* SI BASE UNITS *)

new unit   m, s, kg, A, K, mol, cd, bit
autoprefix m, s,     A, K, mol, cd

meter, meters, metre, metres ^= m
second, seconds, sec, secs ^= s
g, gram, grams, gramme, grammes ^= (1/1000) kg
ampere, amperes, amp, amps ^= A
kelvin, kelvins ^= K
mole, moles, mols ^= mol
candela, candelas ^= cd
bits = bit

new dimension length measured in m
new dimension time measured in s
new dimension mass measured in kg
new dimension current measured in A
new dimension amount_of_substance measured in mol
new dimension luminous_intensity measured in cd
new dimension information measured in bit

rad, radian, radians = m / m
new dimension angle measured in rad

degree, degrees = pi / 180
angle_minute, angle_minutes = degree / 60
angle_second, angle_seconds = angle_minute / 60
circle = 2 pi rad

sr, steradian, steradians = m^2 / m^2
new dimension solid_angle measured in sr

Hz, hertz ^= 1/s
new dimension frequency measured in Hz
new dimension angular_velocity measured in rad/s
new dimension angular_acceleration measured in rad/s^2
new dimension frequency_drift measured in Hz/s^2

new dimension area measured in m^2

L, liter, liters, litre, litres ^= (1/1000) m^3
new dimension volume measured in L
new dimension density measured in kg / L
new dimension volumetric_flow measured in m^3/s

new dimension velocity measured in m/s
new dimension acceleration measured in m/s^2
(* the rate of increase of inflation is decreasing -- Nixon in 1972 *)
new dimension jerk measured in m/s^3
new dimension snap measured in m/s^4
new dimension crackle measured in m/s^5
new dimension pop measured in m/s^6

t, tonne, tonnes ^= 10^3 kg

N, newton, newtons ^= kg m / s^2
new dimension force measured in N
new dimension torque measured in N m

Pa, pascal, pascals ^= N / m^2
new dimension pressure measured in Pa

J, joule, joules ^= N m
new dimension energy measured in J

W, watt, watts ^= J/s
new dimension power measured in W

C, coulomb, coulombs ^= A s
new dimension charge measured in C

V, volt, volts ^= W/A
new dimension electric_potential measured in V

F, farad, farads ^= C/V
new dimension capacitance measured in F

ohm, ohms ^= V/A
new dimension resistance measured in ohm
new dimension impedance measured in ohm
new dimension reactance measured in ohm

S, siemens ^= 1/ohm
new dimension conductance measured in S

Wb, weber, webers ^= V s
new dimension magnetic_flux measured in Wb

T, tesla, teslas ^= Wb/m^2
new dimension magnetic_flux_density measured in T

H, henry, henries, henrys ^= Wb/A
new dimension inductance measured in H

degC, celsius = K

lm, lumen, lumens ^= cd sr
new dimension luminous_flux measured in lm

lx, lux ^= lm / m^2
new dimension illuminance measured in lx

Bq, becquerel, becquerels ^= 1/s
new dimension radioactivity measured in Bq

Gy, gray, grays ^= m^2 / s^2
new dimension absorbed_dose measured in Gy

Sv, sievert, sieverts ^= m^2 / s^2
new dimension equivalent_dose measured in Sv

kat, katal, katals ^= mol/s
new dimension catalytic_activity measured in kat

M, molar ^= mol / L
new dimension molarity measured in M

avogadro = 6.022140857e+23 mol^-1
amu, amus, u, Da, dalton, daltons ^= 1 g / (avogadro mol)




(* Big library of everything *)

(* LENGTH *)
ft, foot, feet    ^= (3048 / 10000) m
yd, yard, yards   ^= 3 feet
mi, mile, miles   ^= 1760 yd
ins, inch, inches ^= ft / 12
P, pica           ^= inch / 6
p, point          ^= pica / 12

li, link ^= (33/50) ft
survey_foot ^= 30.480 cm
rd, rod ^= 25 li
ch, chain ^= 4 rd
fur, furlong ^= 10 ch
survey_mile, statue_mile ^= 8 fur
lea, league ^= 3 survey_mile

ftm, fathom ^= 2 yd
cb, cable ^= 120 ftm
NM, nmi, nautical_mile ^= 3429/15625 km

au, AU, astronomical_unit ^= 1.495978707 * 10^11 m

(* AREA *)

sqft, sqft ^= ft^2
sqch, sqch ^= ch^2
acre ^= 10 sqch
section ^= survey_mile^2
twp, survey_township ^= 36 section

cuin ^= inch^3
cuft ^= ft^3
cuyd ^= yd^3

(* VOLUME *)

min, minim ^= 61.611519921875 uL
fldr, fluid_dram ^= 60 min
tsp, teaspoon ^= 80 min
Tbsp, tbsp, tablespoon ^= 3 tsp
floz, fluid_ounce ^= 2 Tbsp
jig, shot ^= 3 tbsp
gi, gill ^= 4 floz
cp, cup ^= 2 gi
pint = 2 cp
qt, quart = 2 pint
gal, gallon = 4 qt
bbl, barrel = (31 + 1/2) gal
oil_barrel = 42 gal
hogshead = 63 gal

(* TIME *)
min, mins, minute, minutes ^= 60 sec
hr, hrs, hour, hours ^= 60 min
day, days ^= 24 hours
week, weeks ^= 7 days
fortnight ^= 2 weeks
yr, yrs, year, years ^= (365 + 1/4) days
mon, month, months ^= year / 12

(* PERIODIC TABLE *)

new dimension molar_mass measured in g/mol
(* 0 *) neutron = 1.00866491597 g/mol
(* 1 *) hydrogen = 1.00794 g/mol
(* 2 *) helium = 4.002602 g/mol
(* 3 *) lithium = 6.941 g/mol
(* 4 *) beryllium = 9.012182 g/mol
(* 5 *) boron = 10.811 g/mol
(* 6 *) carbon = 12.0107 g/mol
(* 7 *) nitrogen = 14.0067 g/mol
(* 8 *) oxygen = 15.9994 g/mol
(* 9 *) fluorine = 18.9984032 g/mol
(* 10 *) neon = 20.1797 g/mol
(* 11 *) sodium = 22.98977 g/mol
(* 12 *) magnesium = 24.305 g/mol
(* 13 *) aluminum = 26.981538 g/mol
(* 14 *) silicon = 28.0855 g/mol
(* 15 *) phosphorus = 30.973761 g/mol
(* 16 *) sulfur = 32.065 g/mol
(* 17 *) chlorine = 35.453 g/mol
(* 18 *) argon = 39.948 g/mol
(* 19 *) potassium = 39.0983 g/mol
(* 20 *) calcium = 40.078 g/mol
(* 21 *) scandium = 44.95591 g/mol
(* 22 *) titanium = 47.867 g/mol
(* 23 *) vanadium = 50.9415 g/mol
(* 24 *) chromium = 51.9961 g/mol
(* 25 *) manganese = 54.938049 g/mol
(* 26 *) iron = 55.845 g/mol
(* 27 *) cobalt = 58.9332 g/mol
(* 28 *) nickel = 58.6934 g/mol
(* 29 *) copper = 63.546 g/mol
(* 30 *) zinc = 65.409 g/mol
(* 31 *) gallium = 69.723 g/mol
(* 32 *) germanium = 72.64 g/mol
(* 33 *) arsenic = 74.9216 g/mol
(* 34 *) selenium = 78.96 g/mol
(* 35 *) bromine = 79.904 g/mol
(* 36 *) krypton = 83.798 g/mol
(* 37 *) rubidium = 85.4678 g/mol
(* 38 *) strontium = 87.62 g/mol
(* 39 *) yttrium = 88.90585 g/mol
(* 40 *) zirconium = 91.224 g/mol
(* 41 *) niobium = 92.90638 g/mol
(* 42 *) molybdenum = 95.94 g/mol
(* 43 *) technetium = 98 g/mol
(* 44 *) ruthenium = 101.07 g/mol
(* 45 *) rhodium = 102.9055 g/mol
(* 46 *) palladium = 106.42 g/mol
(* 47 *) silver = 107.8682 g/mol
(* 48 *) cadmium = 112.411 g/mol
(* 49 *) indium = 114.818 g/mol
(* 50 *) tin = 118.71 g/mol
(* 51 *) antimony = 121.76 g/mol
(* 52 *) tellurium = 127.6 g/mol
(* 53 *) iodine = 126.90447 g/mol
(* 54 *) xenon = 131.293 g/mol
(* 55 *) cesium = 132.90545 g/mol
(* 56 *) barium = 137.327 g/mol
(* 57 *) lanthanum = 138.9055 g/mol
(* 58 *) cerium = 140.116 g/mol
(* 59 *) praseodymium = 140.90765 g/mol
(* 60 *) neodymium = 144.24 g/mol
(* 61 *) promethium = 145 g/mol
(* 62 *) samarium = 150.36 g/mol
(* 63 *) europium = 151.964 g/mol
(* 64 *) gadolinium = 157.25 g/mol
(* 65 *) terbium = 158.92534 g/mol
(* 66 *) dysprosium = 162.5 g/mol
(* 67 *) holmium = 164.93032 g/mol
(* 68 *) erbium = 167.259 g/mol
(* 69 *) thulium = 168.93421 g/mol
(* 70 *) ytterbium = 173.04 g/mol
(* 71 *) lutetium = 174.967 g/mol
(* 72 *) hafnium = 178.49 g/mol
(* 73 *) tantalum = 180.9479 g/mol
(* 74 *) tungsten = 183.84 g/mol
(* 75 *) rhenium = 186.207 g/mol
(* 76 *) osmium = 190.23 g/mol
(* 77 *) iridium = 192.217 g/mol
(* 78 *) platinum = 195.078 g/mol
(* 79 *) gold = 196.96655 g/mol
(* 80 *) mercury = 200.59 g/mol
(* 81 *) thallium = 204.3833 g/mol
(* 82 *) lead = 207.2 g/mol
(* 83 *) bismuth = 208.98038 g/mol
(* 84 *) polonium = 209 g/mol
(* 85 *) astatine = 210 g/mol
(* 86 *) radon = 222 g/mol
(* 87 *) francium = 223 g/mol
(* 88 *) radium = 226 g/mol
(* 89 *) actinium = 227 g/mol
(* 90 *) thorium = 232.0381 g/mol
(* 91 *) protactinium = 231.03588 g/mol
(* 92 *) uranium = 238.02891 g/mol
(* 93 *) neptunium = 237 g/mol
(* 94 *) plutonium = 244 g/mol
(* 95 *) americium = 243 g/mol
(* 96 *) curium = 247 g/mol
(* 97 *) berkelium = 247 g/mol
(* 98 *) californium = 251 g/mol
(* 99 *) einsteinium = 252 g/mol
(* 100 *) fermium = 257 g/mol
(* 101 *) mendelevium = 258 g/mol
(* 102 *) nobelium = 259 g/mol
(* 103 *) lawrencium = 262 g/mol
(* 104 *) rutherfordium = 261 g/mol
(* 105 *) dubnium = 262 g/mol
(* 106 *) seaborgium = 266 g/mol
(* 107 *) bohrium = 264 g/mol
(* 108 *) hassium = 277 g/mol
(* 109 *) meitnerium = 268 g/mol
(* 110 *) darmstadtium = 281 g/mol
(* 111 *) roentgenium = 272 g/mol
(* 112 *) copernicium = 285 g/mol
(* 113 *) nihonium = 286 g/mol
(* 114 *) flerovium = 289 g/mol
(* 115 *) moscovium = 289 g/mol
(* 116 *) livermorium = 293 g/mol
(* 117 *) tennessine = 294 g/mol
(* 118 *) oganesson = 294 g/mol

(* https://en.wikipedia.org/wiki/United_States_customary_units *)
(* https://en.wikipedia.org/wiki/List_of_unusual_units_of_measurement *)
(* https://en.wikipedia.org/wiki/List_of_humorous_units_of_measurement *)
(* https://en.wikipedia.org/wiki/SI_derived_unit *)
(* https://en.wikipedia.org/wiki/Non-SI_units_mentioned_in_the_SI *)

(* 5 M * 2mL * (hydrogen + chlorine) *)
(* 2 uF * 30 kiloohm *)
(* by how much does a windmill slow the wind? *)
(* https://xkcd.com/687/ *)
