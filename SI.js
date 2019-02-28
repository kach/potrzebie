var SI = `
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
(* trillion = 10^12 *)
(* quadrillion = 10^15 *)

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
hydrogen = 1.008 g/mol
helium = 4.0026 g/mol
lithium = 6.94 g/mol
beryllium = 9.0122 g/mol
boron = 10.81 g/mol
carbon = 12.011 g/mol
nitrogen = 14.007 g/mol
oxygen = 15.999 g/mol
fluorine = 18.998 g/mol
neon = 20.180 g/mol
sodium = 22.990 g/mol
magnesium = 24.305 g/mol
aluminium = 26.982 g/mol
silicon = 28.085 g/mol
phosphorus = 30.974 g/mol
sulfur = 32.06 g/mol
chlorine = 35.45 g/mol
argon = 39.948 g/mol
potassium = 39.098 g/mol
calcium = 40.078 g/mol
scandium = 44.956 g/mol
titanium = 47.867 g/mol
vanadium = 50.942 g/mol
chromium = 51.996 g/mol
manganese = 54.938 g/mol
iron = 55.845 g/mol
cobalt = 58.933 g/mol
nickel = 58.693 g/mol
copper = 63.546 g/mol
zinc = 65.38 g/mol
gallium = 69.723 g/mol
germanium = 72.630 g/mol
arsenic = 74.922 g/mol
selenium = 78.971 g/mol
bromine = 79.904 g/mol
krypton = 83.798 g/mol
rubidium = 85.468 g/mol
strontium = 87.62 g/mol
(* TODO finish these *)


(* https://en.wikipedia.org/wiki/United_States_customary_units *)
(* https://en.wikipedia.org/wiki/List_of_unusual_units_of_measurement *)
(* https://en.wikipedia.org/wiki/List_of_humorous_units_of_measurement *)
(* https://en.wikipedia.org/wiki/SI_derived_unit *)
(* https://en.wikipedia.org/wiki/Non-SI_units_mentioned_in_the_SI *)

(* 5 M * 2mL * (hydrogen + chlorine) *)
(* 2 uF * 30 kiloohm *)
(* https://xkcd.com/687/ *)
`.split('\n');
