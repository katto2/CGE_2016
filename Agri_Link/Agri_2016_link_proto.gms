$TITLE Hybrid model top down module year 3
$ONTEXT
- June. 2016
This model is modified from incomp_2016.gms in  work_2015/0000_Hybrid_2nd/Paper_incompatibility/analysis/incomp_2016.gms
Data : 2010 IO table. Basic price data. 2010 Energy Balance. 2010 National Inventory Report



$OFFTEXT
OPTION SYSOUT=ON;
OPTION limrow=50;
OPTION limcol=50;

parameter
operation;
operation=0;
*operation=1;
SET
*$include "..\SAM\set_agri_recursive_nonlink_2016.txt"
$include "..\SAM\Agri\set_agri_static_nonlink_2016_alt_cons.txt"

*$include "..\SAM\set_agri_recursive_link_2016.txt"
set
io /1*391/
*input/ELEC,GASHeat,OIL,COAL,ENIT,NEINT,Rice,Barley,Bean,Potato,Vegi,Fruit,Flower,MissCrop,Dairy,Meat,Pork,Poultry,MissLstock,Labor,Capital,NRES,Ptaxin,Ptaxetc/
input /ELEC,GAS,HEAT,Gasoline,Jetoil,Diesel,Kerosene,Fueloil,LPG,Oilpro,CoalPro,Coal,Oil,LNG,Mining,IS,Cement,Chemistry,WoodPaper,FiberLeather,Mineral,nonISmetal,Machine,Electronics,Semidis,Auto,Ship,Food,MissManu,Const,Rail,Road,Air,Marine,MissTrans,Housing,Commercial,Public,Rice,Barley,Bean,Potato,Vegi,Fruit,Flower,MissCrop,Dairy,Meat,Pork,Poultry,MissLstock,FF,Waste,Labor,Capital,NRES,Ptaxin,Ptaxetc/
inputc /ELEC-c,GAS-c,HEAT-c,Gasoline-c,Jetoil-c,Diesel-c,Kerosene-c,Fueloil-c,LPG-c,Oilpro-c,CoalPro-c,Coal-c,Oil-c,LNG-c,Mining-c,IS-c,Cement-c,Chemistry-c,WoodPaper-c,FiberLeather-c,Mineral-c,nonISmetal-c,Machine-c,Electronics-c,Semidis-c,Auto-c,Ship-c,Food-c,MissManu-c,Const-c,Rail-c,Road-c,Air-c,Marine-c,MissTrans-c,Housing-c,Commercial-c,Public-c,Rice-c,Barley-c,Bean-c,Potato-c,Vegi-c,Fruit-c,Flower-c,MissCrop-c,Dairy-c,Meat-c,Pork-c,Poultry-c,MissLstock-c,FF-c,Waste-c,Labor,Capital /

*inputc/ELEC-c,GASHeat-c,OIL-c,COAL-c,ENIT-c,NEINT-c,Rice-c,Barley-c,Bean-c,Potato-c,Vegi-c,Fruit-c,Flower-c,MissCrop-c,Dairy-c,Meat-c,Pork-c,Poultry-c,MissLstock-c,Labor,Capital/

*inputa/ELEC-a,GASHeat-a,OIL-a,COAL-a,ENIT-a,NEINT-a,Rice-a,Barley-a,Bean-a,Potato-a,Vegi-a,Fruit-a,Flower-a,MissCrop-a,Dairy-a,Meat-a,Pork-a,Poultry-a,MissLstock-a,Labor,Capital/
inputa/ELEC-a,GAS-a,HEAT-a,Gasoline-a,Jetoil-a,Diesel-a,Kerosene-a,Fueloil-a,LPG-a,Oilpro-a,CoalPro-a,Coal-a,Oil-a,LNG-a,Mining-a,IS-a,Cement-a,Chemistry-a,WoodPaper-a,FiberLeather-a,Mineral-a,nonISmetal-a,Machine-a,Electronics-a,Semidis-a,Auto-a,Ship-a,Food-a,MissManu-a,Const-a,Rail-a,Road-a,Air-a,Marine-a,MissTrans-a,Housing-a,Commercial-a,Public-a,Rice-a,Barley-a,Bean-a,Potato-a,Vegi-a,Fruit-a,Flower-a,MissCrop-a,Dairy-a,Meat-a,Pork-a,Poultry-a,MissLstock-a,FF-a,Waste-a,Labor,Capital /


*c /ELEC-c,GASHeat-c,OIL-c,COAL-c,ENIT-c,NEINT-c,Rice-c,Barley-c,Bean-c,Potato-c,Vegi-c,Fruit-c,Flower-c,MissCrop-c,Dairy-c,Meat-c,Pork-c,Poultry-c,MissLstock-c/
*C /ELEC-c,GAS-c,HEAT-c,Gasoline-c,Jetoil-c,Diesel-c,Kerosene-c,Fueloil-c,LPG-c,Oilpro-c,CoalPro-c,Coal-c,Oil-c,LNG-c,Mining-c,IS-c,Cement-c,Chemistry-c,WoodPaper-c,FiberLeather-c,Mineral-c,nonISmetal-c,Machine-c,Electronics-c,Semidis-c,Auto-c,Ship-c,Food-c,MissManu-c,Const-c,Rail-c,Road-c,Air-c,Marine-c,MissTrans-c,Housing-c,Commercial-c,Public-c,Rice-c,Barley-c,Bean-c,Potato-c,Vegi-c,Fruit-c,Flower-c,MissCrop-c,Dairy-c,Meat-c,Pork-c,Poultry-c,MissLstock-c,FF-c,Waste-c /

*ENC(C) /GASHeat-c,OIL-c,COAL-c/
*ENC(C) /GAS-c,Gasoline-c,Jetoil-c,Diesel-c,Kerosene-c,Fueloil-c,LPG-c,Oilpro-c,CoalPro-c,Coal-c,Oil-c,LNG-c /

*a /ELEC-a,GASHeat-a,OIL-a,COAL-a,ENIT-a,NEINT-a,Rice-a,Barley-a,Bean-a,Potato-a,Vegi-a,Fruit-a,Flower-a,MissCrop-a,Dairy-a,Meat-a,Pork-a,Poultry-a,MissLstock-a/
*A /ELEC-a,GAS-a,HEAT-a,Gasoline-a,Jetoil-a,Diesel-a,Kerosene-a,Fueloil-a,LPG-a,Oilpro-a,CoalPro-a,Coal-a,Oil-a,LNG-a,Mining-a,IS-a,Cement-a,Chemistry-a,WoodPaper-a,FiberLeather-a,Mineral-a,nonISmetal-a,Machine-a,Electronics-a,Semidis-a,Auto-a,Ship-a,Food-a,MissManu-a,Const-a,Rail-a,Road-a,Air-a,Marine-a,MissTrans-a,Housing-a,Commercial-a,Public-a,Rice-a,Barley-a,Bean-a,Potato-a,Vegi-a,Fruit-a,Flower-a,MissCrop-a,Dairy-a,Meat-a,Pork-a,Poultry-a,MissLstock-a,FF-a,Waste-a /

*INS/Household,GoV,NRES,Ptaxin,Ptaxetc,Tarrif,YTAX,S-I,ROW /
*INS/Household,GoV,NRES,Ptaxin,Ptaxetc,Tarrif,YTAX,S-I,ROW /


*f(input)/Labor,Capital/
fc(inputc)/Labor,Capital/

*L(f) /Labor/
*K(f) /Capital/
J production (13)
/Rice,Barley,Bean,Potato,Vegi,Fruit,Flower,MissCrop,Dairy,Meat,Pork,Poultry,
MissLstock/

TC cost components: M won
/ SEED, FERT, PEST, FEED, CUB, MED, ENERGY, WATER, SMACH, LMACH, FACIL,
OINPUT, OSERV, KCOST, LCOST, SUR, TW/

map_jc(j,c)
/Rice.Rice-c,
Barley.Barley-c,
Bean.Bean-c,
Potato.Potato-c,
Vegi.Vegi-c,
Fruit.Fruit-c,
Flower.Flower-c,
MissCrop.MissCrop-c,
Dairy.Dairy-c,
Meat.Meat-c,
Pork.Pork-c,
Poultry.Poultry-c,
MissLstock.MissLstock-c/
map_ja(j,a)
/Rice.Rice-a,
Barley.Barley-a,
Bean.Bean-a,
Potato.Potato-a,
Vegi.Vegi-a,
Fruit.Fruit-a,
Flower.Flower-a,
MissCrop.MissCrop-a,
Dairy.Dairy-a,
Meat.Meat-a,
Pork.Pork-a,
Poultry.Poultry-a,
MissLstock.MissLstock-a/


map_ioc(io,c)
/
1.Rice-c
2.Barley-c
3.Bean-c
4.Potato-c
5.Vegi-c
6.Fruit-c
7.MissCrop-c
8.MissCrop-c
9.MissCrop-c
10.Flower-c
11.MissCrop-c
12.MissCrop-c
13.MissCrop-c
14.Dairy-c
15.Meat-c
16.Pork-c
17.Poultry-c
18.MissLstock-c
19.FF-c
20.FF-c
21.FF-c
22.FF-c
23.FF-c
24.FF-c
25.Commercial-c
26.Coal-c
27.Coal-c
28.Oil-c
29.LNG-c
30.Mining-c
31.Mining-c
32.Mining-c
33.Mining-c
34.Mining-c
35.Food-c
36.Food-c
37.Food-c
38.Food-c
39.Food-c
40.Food-c
41.Food-c
42.Rice-c
43.Food-c
44.Food-c
45.Food-c
46.Food-c
47.Food-c
48.Food-c
49.Food-c
50.Food-c
51.Food-c
52.Food-c
53.Food-c
54.Food-c
55.Food-c
56.Food-c
57.Food-c
58.Food-c
59.Food-c
60.Food-c
61.Food-c
62.FiberLeather-c
63.FiberLeather-c
64.FiberLeather-c
65.FiberLeather-c
66.FiberLeather-c
67.FiberLeather-c
68.FiberLeather-c
69.FiberLeather-c
70.FiberLeather-c
71.FiberLeather-c
72.FiberLeather-c
73.FiberLeather-c
74.FiberLeather-c
75.FiberLeather-c
76.FiberLeather-c
77.FiberLeather-c
78.FiberLeather-c
79.FiberLeather-c
80.FiberLeather-c
81.FiberLeather-c
82.FiberLeather-c
83.WoodPaper-c
84.WoodPaper-c
85.WoodPaper-c
86.WoodPaper-c
87.WoodPaper-c
88.WoodPaper-c
89.WoodPaper-c
90.WoodPaper-c
91.WoodPaper-c
92.WoodPaper-c
93.WoodPaper-c
94.WoodPaper-c
95.WoodPaper-c
96.WoodPaper-c
97.WoodPaper-c
98.WoodPaper-c
99.CoalPro-c
100.CoalPro-c
101.Oilpro-c
102.Gasoline-c
103.Jetoil-c
104.Kerosene-c
105.Diesel-c
106.Fueloil-c
107.LPG-c
108.Oilpro-c
109.Oilpro-c
110.Oilpro-c
111.Chemistry-c
112.Chemistry-c
113.Chemistry-c
114.Chemistry-c
115.Chemistry-c
116.Chemistry-c
117.Chemistry-c
118.Chemistry-c
119.Chemistry-c
120.Chemistry-c
121.FiberLeather-c
122.Chemistry-c
123.Chemistry-c
124.Chemistry-c
125.Chemistry-c
126.Chemistry-c
127.Chemistry-c
128.Chemistry-c
129.Chemistry-c
130.Chemistry-c
131.Chemistry-c
132.Chemistry-c
133.Chemistry-c
134.Chemistry-c
135.Chemistry-c
136.Chemistry-c
137.Chemistry-c
138.Chemistry-c
139.Chemistry-c
140.Mineral-c
141.Mineral-c
142.Mineral-c
143.Mineral-c
144.Mineral-c
145.Mineral-c
146.Mineral-c
147.Mineral-c
148.Cement-c
149.Cement-c
150.Cement-c
151.Cement-c
152.Cement-c
153.Cement-c
154.Cement-c
155.Cement-c
156.Cement-c
157.IS-c
158.IS-c
159.IS-c
160.IS-c
161.IS-c
162.IS-c
163.IS-c
164.IS-c
165.IS-c
166.IS-c
167.IS-c
168.IS-c
169.nonISmetal-c
170.nonISmetal-c
171.nonISmetal-c
172.nonISmetal-c
173.nonISmetal-c
174.nonISmetal-c
175.nonISmetal-c
176.nonISmetal-c
177.nonISmetal-c
178.Machine-c
179.Machine-c
180.Machine-c
181.Machine-c
182.Machine-c
183.Machine-c
184.Machine-c
185.Machine-c
186.Machine-c
187.Machine-c
188.Machine-c
189.Machine-c
190.Machine-c
191.Machine-c
192.Machine-c
193.Machine-c
194.Machine-c
195.Machine-c
196.Machine-c
197.Machine-c
198.Machine-c
199.Machine-c
200.Machine-c
201.Machine-c
202.Machine-c
203.Machine-c
204.Machine-c
205.Machine-c
206.Machine-c
207.Machine-c
208.Machine-c
209.Machine-c
210.Machine-c
211.Machine-c
212.Machine-c
213.Machine-c
214.Electronics-c
215.Electronics-c
216.Electronics-c
217.Electronics-c
218.Electronics-c
219.Electronics-c
220.Electronics-c
221.Electronics-c
222.Electronics-c
223.Electronics-c
224.Semidis-c
225.Semidis-c
226.Semidis-c
227.Semidis-c
228.Semidis-c
229.Semidis-c
230.Semidis-c
231.Semidis-c
232.Semidis-c
233.Semidis-c
234.Semidis-c
235.Semidis-c
236.Semidis-c
237.Semidis-c
238.Semidis-c
239.Semidis-c
240.Electronics-c
241.Electronics-c
242.Electronics-c
243.Electronics-c
244.Electronics-c
245.Electronics-c
246.Electronics-c
247.Electronics-c
248.Electronics-c
249.Auto-c
250.Auto-c
251.Auto-c
252.Auto-c
253.Auto-c
254.Auto-c
255.Auto-c
256.Ship-c
257.Ship-c
258.Ship-c
259.Ship-c
260.Ship-c
261.Ship-c
262.Ship-c
263.MissManu-c
264.MissManu-c
265.MissManu-c
266.MissManu-c
267.MissManu-c
268.MissManu-c
269.MissManu-c
270.MissManu-c
271.MissManu-c
272.MissManu-c
273.MissManu-c
274.ELEC-c
275.ELEC-c
276.ELEC-c
277.ELEC-c
278.ELEC-c
279.GAS-c
280.HEAT-c
281.Public-c
282.Waste-c
283.Waste-c
284.Waste-c
285.Waste-c
286.Waste-c
287.Const-c
288.Const-c
289.Const-c
290.Const-c
291.Const-c
292.Const-c
293.Const-c
294.Const-c
295.Const-c
296.Const-c
297.Const-c
298.Const-c
299.Const-c
300.Const-c
301.Const-c
302.Commercial-c
303.Commercial-c
304.Rail-c
305.Rail-c
306.Road-c
307.Road-c
308.MissTrans-c
309.Marine-c
310.Marine-c
311.Air-c
312.MissTrans-c
313.MissTrans-c
314.MissTrans-c
315.MissTrans-c
316.MissTrans-c
317.MissTrans-c
318.Commercial-c
319.Commercial-c
320.Commercial-c
321.Commercial-c
322.Commercial-c
323.Commercial-c
324.Commercial-c
325.Commercial-c
326.Commercial-c
327.Commercial-c
328.Commercial-c
329.Commercial-c
330.Commercial-c
331.Commercial-c
332.Commercial-c
333.Commercial-c
334.Commercial-c
335.Commercial-c
336.Commercial-c
337.Commercial-c
338.Commercial-c
339.Commercial-c
340.Commercial-c
341.Housing-c
342.Commercial-c
343.Commercial-c
344.Commercial-c
345.Commercial-c
346.Public-c
347.Commercial-c
348.Commercial-c
349.Commercial-c
350.Commercial-c
351.Commercial-c
352.Commercial-c
353.Commercial-c
354.Commercial-c
355.Commercial-c
356.Commercial-c
357.Commercial-c
358.Commercial-c
359.Commercial-c
360.Public-c
361.Public-c
362.Public-c
363.Commercial-c
364.Commercial-c
365.Public-c
366.Commercial-c
367.Commercial-c
368.Public-c
369.Public-c
370.Commercial-c
371.Public-c
372.Commercial-c
373.Commercial-c
374.Commercial-c
375.Commercial-c
376.Commercial-c
377.Commercial-c
378.Commercial-c
379.Commercial-c
380.Commercial-c
381.Commercial-c
382.Commercial-c
383.Commercial-c
384.Commercial-c
/
map_iof(io,f)
/
387.Labor
388.Capital
389.Capital
/
map_ioins(io,ins)
/385.Ptaxin
386.Nres
390.Ptaxetc
/

TABLE  iotc_r(tc,io,J) Data
$ondelim
$include "..\SAM\Agri\consistency\iocost_r_Agri_2016.csv"
$offdelim;

Table Agricost(tc,j)
$ondelim
$include "..\SAM\Agri\consistency\cost_Agri_2016.csv"
$offdelim;

parameter
theta_aj(a,j)
theta_cj(c,j);

theta_aj(a,j)=0;
theta_cj(c,j)=0;
theta_aj(a,j)$map_ja(j,a)=1;
theta_cj(c,j)$map_jc(j,c)=1;

Agricost(tc,j)=Agricost(tc,j)/1000;


parameter
theta_ioc(io,c)
theta_iof(io,f)
theta_ioins(io,ins);
theta_ioc(io,c)=0;
theta_iof(io,f)=0;
theta_ioins(io,ins)=0;
theta_ioc(io,c)$map_ioc(io,c)=1;
theta_iof(io,f)$map_iof(io,f)=1;
theta_ioins(io,ins)$map_ioins(io,ins)=1;

parameter
theta_tc_j (tc,j)
;



PARAMETERS
alpha_nres(A) net residue to output ratio
ta_in(A)        net producer's tax rate in production a (PTAXin)
ta_ex(A)        etc producer's tax rate in production a (PTAXex)
ica(C,A)      Material(C) intermediate demand coefficient in production A:  XAP(C_A) over XC(A)
ifa(F,A)      Factor demand coefficient in production A (Link Activity only) :LD(L_A) over XC(A) and KD(K_A) over XC(A)
iea(C,A)      Electricity(ELECC) intermediate demand coefficient in production A (Link Activity only):XAP(C_A) over XC(A)
ifuela(C,A)   Fuel(ENC) intermediate demand coefficient in production A (Link Activity only):QCE(C_A) over XC(A)
iza(A)        Agriculture common Resource Z demand coefficient in production A (Link Activity only):ZD(A) over XC(A)

thetaP(GC,A)  GHG emission per unit of Activity a output

alphaq(C)       Armington CES function shifting parameter
deltaq(C)       Armington CES function share parameter
rhoq(C)                Armington CES function exponent
sigmaq(C)       1 over (1+rhoq(CM))

alphat(C)       CET function shifting parameter
deltat(C)       CET function share parameter
rhot(C)                CET function exponent
sigmat(C)       1 over (1-rhot(CE))

alphaaVAE(A)    VAE CES function shifting parameter
alphaaAG(A)     AG Cobb douglas function shifting parameter

deltaf(F,A)     VAE CES function share parameter for factor
deltac(C,A)     VAE CES function share parameter for intermediate input (ENC and ENCN) Cobb-Douglas share parameter for AG input
rhoaVAE(A)      VAE CES function exponent
sigmaaVAE(A)    1 over (1+rhoaVAE(A))
rhoaHKTE(A)     HTKE CES function exponent
sigmaaHKTE(A)   1 over (1+rhoaHTKE(A))
rhoaXEP(A)       XEP CES function exponent
sigmaaXEP(A)    1 over (1+rhoaXEP(A))
rhoaXFL(A)      XFL CES function exponent (fuel)
sigmaaXFL(A)    1 over (1+rhoaXLF(A))
rhoaXLFL(A)     XLFL CES function exponent (liquid fuel)
sigmaaXLFL(A)   1 over (1+rhoaXLFL(A))

thetaE(GC,C,A)   GHG emmision per unit of Energy good C input in A: valid if C in ENC

tm(C)           Import tax rate
tm_in           Net producers' tax levied on import
te(C)           Export tax rate

pwm(C)          CIF price of good C in foreign currency
pwe(C)          FOB price of good C in foreign currency
fsav0           base year current account balance
FSAD            Foreign saving adjustment factor exogenous


tr0_per(H)           base year transfer payment to Oldpopulation ratio of Household H
shr(F,H)         Household H share of endownment F
shrpro(A,H)      Household H share of profit from Activity A production
thetaRES_c       share of net residue payment to consumption
* ResinC (Residue payment to household) =thetaRES_c*(sum(A, alphaNRES(A)*XC(A)))

mu(C,H)           marginal propensity to consume Commodity C
mus(H)             marginal propensity to save
epsilon_L(L)     uncompensated elasticity of labor to real wage
Lw0(L)           Labor supply adjusting constant Ls=Lw0*(realwage)^epsilon_L(L)
tc_in            Net Producers' tax in Household consumption to Total Household consumption


*Government
qg0(C)           Base year government consumption of Commodity c
qgr0(C)          ratio of Base year gov consumption of commodity c to Absortion
sg0              Base year government savings.
tg_in            Net Producers' tax revenue in government consumption to Gov consumption
*tax policy paremeters
TINS0            Base year income tax rate
YD0(H)          Base Year Household Disposable Income

*carbon tax policy paremeters
gtax(GC)        carbon tax rate
gtax_policy(GC,t) carbon tax rate evolution
*dgtax(t)      Optional GHG tax rate evolution when all tax increse would same
CrevH         Revenue Recycling share of Household transfer
CrevH_share(H)   Household share of Revenue Recycling share of Household transfer
CrevC         Revenue Recycling share of Government Consumption
CrevI         Revenue Recycling share of Total Industry subsidy
CrevIw(A)     Revenue Recycling industry share of Industry subsidy
Crevtax       Revenue Recycling share of income tax cut

*initialization parameter replicating bau. Set as zero
gtaxrate_o
crevI_o

cwrt(C)         Price index weight
theta(A,C)      Yield of commodity C form one unit of Activity A
qinv_o(C)        Initial investment level
tiv_in          Net Producers' tax revenue in government consumption to Investment demand
thetaRes_iv     share of net residue payment to investment

cpi_o             Consumer price index
lambdat         overall labor productivity
lambda(A)       Activity specific labor productivity
AEEI(C,A)       Automatic energy efficiency imporvment index.
lambdak         overal capital productivity
lambdaka(A)     Activity specific capital productivity
Oldpop          Population age 65 and older at base year
Oldpopg(t)      Population age 65 and older growth rate
TBg(t)          Foreing saving growth rate
Scenario        Policy scenarios BAU TR GE GS LCUT NCUT
delta           Depreciation rate
XC_bottom(A)    Bottom up Domestic Production
LD_bottom(L,A)    Bottom up Labor input in Agriculture
KD_bottom(K,A)    Bottom up Capital input in Agriculture
ZD_bottom(A)      Bottom up Resoucre input in Agriculture
XAP_bottom(C,A)   Bottom up non energy_electricity intermediate input in Agriculture
QNEG_bottom(C,A)  Bottom up fuel intermediate input in Agriculture
XC_bottom_1(A)    Bottom up Domestic Production
LD_bottom_1(L,A)    Bottom up Labor input in Agriculture
KD_bottom_1(K,A)    Bottom up Capital input in Agriculture
*ZD_bottom(A)      Bottom up Resoucre input in Agriculture
XAP_bottom_1(C,A)   Bottom up non energy_electricity intermediate input in Agriculture
QNEG_bottom_1(C,A)  Bottom up fuel intermediate input in Agriculture
*VARIABLES========================================================================
positive variables
PC(A)           Activity price
XMT(C)           Import composite of good C
PMT(C)           Import composite price of good C
XD(C)           Domestic supply of domestic production C
PD(C)           Price of domestic supply of domestic production C

XA(C)           Supply of C
PA(C)           Market price of C
ES(C)           Export of good C
PET(C)           Export price of C
XP(C)           Export domestic supply composite of domestic production
PP(C)           Price of export domestic supply composite of domestic production
QNEG(C,A)  Demand of commodity c GHG composite for non electricity composite
PNEG(C,A)       Price of commodity c GHG composite


Variables
XC(A)           Activity supply
PVAE(A)                Value added energy composite price
QVAE(A)                Demand for Value added energy composite
PAG(A)                 Agricluture composite price
XAG(A)                 Demand for Agriculture composite
PHKTE(A)               Capital Energy composite price
HKTE(A)                Capital Energy composite demand
PEP (A)                Energy composite price
XEP (A)                Energy Composite demand
PFL (A)                Fuel composite price
XFL (A)                Fuel composite demand
PLFL (A)               Liquid Fuel composite price
XLFL (A)               Liquid Fuel composite demand

XAP(C,A)       Intermediate demand of commodity C
QINTG(GC,A)   Intermediate demand of GHG G
Rent           rent on Agriculture Resource

R(K)           rental price of Capital
W(L)           wage
LD(L,A)            labor demand for production A
KD(K,A)            capial demand for production A
ZD(A)              Agriculture Resource demand for production A (Agriculture only)

Ks(K)           Capital supply
Ls(L)           Labor supply
Zs              Agriculture Resource supply

QCE(C,A)      Demand of commodity c for Electricity composite in A production
QGE(GC,C,A)      Demand of GHG g for commodity c-GHG composite in A production

EXR             The ratio of domestic currency to foeign currency
YG              Government revenue

TR(H)           Transfer payment to Household H
XAF(FD,C)       Final Demand of good C government and Investment
SG              Government savings



MPS(H)          Household Marginal Propensity to save
LY(H)           Household labor income
KY(H)           Household capital income
EY(H)           Household equity income
YH(H)           Household income
YD(H)            Household disposable income
XAC(C,H)                Consumption C of household H
SH(H)            Household Savings

TINSR            income tax rate


FSAV            Net import or Foreign Saving
IVAD            Investment adjustment factor
Warlas          S-I eq dummy


CREV(A)       Carbon tax revenue collected from Activity A
TCREV         Total Carbon tax revenue
ResinC        Residue income from consumption
ResinI        Residue income from investment
CPI           consumer price index
*** Loading Data

table sam(ACT,ACTP) data in CSV format
$Ondelim
$include "..\SAM\Agri\b_sam_agri_model_g_pos_cons.csv"
$Offdelim

table samng(ACT,ACTP) data in CSV format
$Ondelim
$include "..\SAM\Agri\b_sam_agri_model_ng_pos_cons.csv"
$Offdelim

table ghg(ACT,ACTP) data in CSV format
$Ondelim
$include "..\SAM\Agri\GHG_agri_model_process_cons.csv"
*$include "..\SAM\Agri\GHG_agri_model_p_20160621.csv"
$Offdelim


Equations

*Price Block
ImPr(C) Import Price
ExPr(C) Export price
AspPr(C) Absorption Price PA f of PD and PMT
AspPrni(C) Absorption price PA without import PA=PD
AspPrnd(C) Absorption price PA without domestic production PA=PMT
ProdPr(C) Supply Price PP f of PET and PD
ProdPrne(C) Supply Price PP without export PP=PD
ProdPrnd(C) Supply Price PP without domestic supply PP=PET

ComPr(C) Activity Price and Commodity Price
ActR(A) Activity revenue and costs with C02 not in process with positive agriculture input
ActRp(A) Activity Revenue and costs with C02 in process with positive agriculture input
ActRna(A) Activity revenue and costs with C02 not in process without agriculture input
ActRpna(A) Activity Revenue and costs with C02 in process without positive agriculture input
ActR_Link(A) Activity revenue and costs with C02 not in process with positive agriculture input (Linked)
ActRp_Link(A) Activity Revenue and costs with C02 in process with positive agriculture input (Linked)
ActRna_Link(A) Activity revenue and costs with C02 not in process without agriculture input  (Linked)
ActRpna_Link(A) Activity Revenue and costs with C02 in process without positive agriculture input (Linked)



VAEPr0(A) KLEM composite price without Labor
VAEPr1(A) KLEM composite price with Labor and HKTE
VAEPr2(A) KLEM composite price without HKTE (multiple labor)
VAEPr3(A) KLEM composite price with sinlge labor

VAGPr (A) Agriculture composite price

HKTEPr0 (A) KEM composite price without Capital
HKTEPr1 (A) KEM composite price with Capital and XEP
HKTEPr2 (A) KEM composite price without XEP (multiple capital)
HKTEPr3 (A) KEM composite price with single capital
XEPr0 (A) Energy composite price without Electricity
XEPr1 (A) Energy composite price with Electricity and Fuel
XEPr2 (A) Energy composite price without Fuel (multiple Electricity)
XEPr3 (A) Energy composite price with single electricity
XFLPr0(A) Fuel composite price without solid fuel
XFLPr1(A) Fuel composite price with solid fuel and Liquid fuel
XFLPr2(A) Fuel composite price without Liquad fuel (multiple solid fuel)
XFLPr3(A) Fuel composite price with single solid fuel
*XFLPr_SO(A) Fuel composite price with only solid fuel
XLFLPr2 (A) Liquid Fuel composite price (multiple Liquid fuel)
XLFLPr3 (A) Liquid Fuel composite price (single Liquid fuel)
NEGPr(C,A) Non Electricity price without CO2 PNEG =PA
NEGPrco(C,A) Non Electricity GHG composite price with CO2 PNEG f of PA of fuel and PG
NEGPr_Link(C,A) Non Electricity price without CO2 PNEG =PA (Linked only)
NEGPrco_Link(C,A) Non Electricity GHG composite price with CO2 PNEG f of PA of fuel and PG (Link only)

Norm Consummer Price Index definition
CPIfix    Fixing CPI
Labsup(L) Labor supply

*Production and Trade block
QVAED(A) value added - Energy composite demand QVAE f of XC
XAGD(A) Agriculture composite demand XAG. f of XC
HKTED0(A) KEM composite demand HKTE without labor demand
HKTED1(A) KEM composite demand HKTE function of QVAE
XEPD0(A) Energy composite demand XEP without capital demand
XEPD1(A)  Energy composite demand XEP function of HKTE
XFLD0(A) Fuel composite demand XFL without electricity demand
XFLD1(A)  Fuel composite demand XFL function of XEP
XLFLD0(A) liquid fuel composite demand XFLD function of XFL(Single Liquid fuel)
XLFLD1(A) liquid fuel composite demand XFLD function of XFL(multiple Liqudi fuel)

INTDM(C,A) Material intermeidate demand for XC(A): Leontief of XC
INTDAG0(C,A) Agriculture intermediate demand for XC(A) :Cobb Douglas of XAG Ag singleton
INTDAG1(C,A) Agriculture intermediate demand for XC(A) :Cobb Douglas of XAG Ag more than one
INTDE1(C,A) Electricity intermediate demand for XC(A): CES of VAE
INTDE2(C,A) Electricity intermediate demand for XC(A). Multi Electricity only in (XEP nest)
INTDE3(C,A) Electricity intermediate demand for XC(A). Single Electricity only in (XEP nest)
INTGD(GC,A) intermediate demand of CO2 CO2 emission in process

INTDM_Link(C,A) Material intermeidate demand for XC(A): Leontief of XC  (Link only)
INTDAG0_Link(C,A) Agriculture intermediate demand for XC(A): Cobb Douglas of XAG Ag singleton (Link only)
INTDAG1_Link(C,A) Agriculture intermediate demand for XC(A): Cobb Douglas of XAG Ag more than one(Link only)
INTDE1_Link(C,A) Electricity intermediate demand for XC(A): CES of VAE (Link only)
INTDE2_Link(C,A) Electricity intermediate demand for XC(A). Multi Electricity only in (XEP nest) (Link only)
INTDE3_Link(C,A) Electricity intermediate demand for XC(A). Single Electricity only in (XEP nest) (Link only)
INTGD_Link(GC,A) intermediate demand of CO2 CO2 emission in process  (Link only)


LDA1(L,A) labor demand LD f of QVAE
LDA2(L,A) labor demand with only labor (multiple labor)
LDA3(L,A) labor demand with only labor (labor singleton)

KDA1(K,A) Capital demand  KD f of HKTE
KDA2(K,A) Capital demnad with only Capital (multi capital) (in HKTE nest)
KDA3(K,A) Capital demnad with only Capital (singleton) (in HKTE nest)

LDA1_Link(L,A) labor demand LD f of QVAE (Link only)
LDA2_Link(L,A) labor demand with only labor (multiple labor) (Link only)
LDA3_Link(L,A) labor demand with only labor (labor singleton) (Link only)

KDA1_Link(K,A) Capital demand  KD f of HKTE (Link only)
KDA2_Link(K,A) Capital demnad with only Capital (multi capital) (in HKTE nest) (Link only)
KDA3_Link(K,A) Capital demnad with only Capital (singleton) (in HKTE nest) (Link only)
ZD_Link(A) Link resource demand ZD f of XC (Link only)

NEGDL2(C,A) Fuel-CO2 composite Demand: Liquid. Multi input . f of XLFL
NEGDL3(C,A) Fuel-CO2 composite Demand: Liquid Singleton. f of XLFL

NEGDL2_Link(C,A) Fuel-CO2 composite Demand: Liquid. Multi input . f of XLFL (Link only)
NEGDL3_Link(C,A) Fuel-CO2 composite Demand: Liquid Singleton. f of XLFL (Link only)


NEGDS1(C,A) Fuel-CO2 composite Demand: Solid Multi input with XLFL. f of XFL
NEGDS2(C,A) Fuel-CO2 composite Demand: Solid Multi input without XLFL. f of XFL
NEGDS3(C,A) Fuel-CO2 composite Demand: Solid Singleton only in (XFL nest)
*NEGDL2(C,A) Fuel-CO2 composite Demand for liquid fuel (XFL and XLFL: multi liqud with solid)

NEGDS1_Link(C,A) Fuel-CO2 composite Demand: Solid Multi input with XLFL. f of XFL (Link_only)
NEGDS2_Link(C,A) Fuel-CO2 composite Demand: Solid Multi input without XLFL. f of XFL (Link_only)
NEGDS3_Link(C,A) Fuel-CO2 composite Demand: Solid Singleton only in (XFL nest) (Link_only)


NELQCED(C,A) fuel demand QCE f of QNEG
NELQCED_Link(C,A) fuel demand QCE f of QNEG (Link only)

GD(GC,C,A) CO2 Demand(emission) in fuel use QGE f of QCE
GD_Link(GC,C,A) CO2 Demand(emission) in fuel use QGE f of QCE (Link only)



ActDC(A) Activity demand by commodity

XDD(C) Domestic Product Demand f of XA
XDDni(C) Domestic Product Demand without import
XMTD(C) Import Demand  f of XA
XMTDnd(C) Import Demand without domestic product

XDS(C) Domestic Produciton Supply
XDSne(C) Domestic Production Supply without export
ESS(C) Export Supply
ESSnd(C) Export without Domestic Production.

*Institution
InvD(C) Investment Demand
HouseLY(H) Household labor Income
HouseKY(H) Household capital income
HouseEY(H) Household Equity income
HouseY(H) Household Income
HouseYD(H) Household Disposable Income

HouseD(C,H) Household Demand
Hsave(H) Household Savings
Saver(H) Marginal propensity to save


GovE(C) Government Spending
Tras(H) transfer payment
Ytax Income tax rate

ForS Foreign Saving
GovI Government Income

*Market clearing
LabM(L) Labor market clearing
CapM(K) Capital market clearing
ResM    Agriculture Resource market clearing


ComMENCN(C) Market clearing: non fuel non link
ComMENCN_Link(C) Market clearing: Link
ComMENC(C)  Market clearing (ENC)


CREVE(A)  carbon tax revenue without process emission (A)
CREVP(A)  carbon tax revenue with process emission(A)
TCREVsum   Total carbon tax revenue

InvM Savings and Investment clearing
CAB Current Accoutn Balance
GovB Governmetn Balance

*Residue income for household and investment
ResC Residue income due to consumption
ResI Residuw income due to investment;

*Price Block
ImPr(C)$(SAM('ROW',C) ne 0)..pwm(C)*(1+tm(C))*EXR=g=PMT(C);
ImPr.m(C)=1;
ExPr(C)$(SAM(C,'ROW') ne 0)..PET(C)=g=pwe(C)*(1-te(C))*EXR;
ExPr.m(C)=1;

AspPr(C)$((SAM('ROW',C) ne 0) and (sum(A,SAM(A,C))>0))..(1/alphaq(C))*(((deltaq(C))**(sigmaq(C))*(PD(C))**(1-sigmaq(c))+ (1-deltaq(C))**sigmaq(C)*(PMT(C))**(1-sigmaq(c)))**(1/(1-sigmaq(C))))=g=PA(C);
AspPr.m(C)=1;
AspPrni(C)$(SAM('ROW',C)=0 and (sum(A,SAM(A,C))>0))..PA(C)=e=PD(C);
AspPrni.m(C)=1;
AspPrnd(C)$(sum(A,SAM(C,A))+sum(H,SAM(C,H))+sum(FD,SAM(C,FD))-SAM('ROW',C)=0)..PA(C)=e=PMT(C);
AspPrnd.m(C)=1;

ProdPr(C)$((SAM(C,'ROW') ne 0) and (sum(A,SAM(A,C))>0))..PP(C)=g=(1/alphat(C))*(((deltat(C))**(sigmat(C))*(PET(C))**(1-sigmat(c))+ (1-deltat(C))**(sigmat(C))*(PD(C))**(1-sigmat(c)))**(1/(1-sigmat(C))));
ProdPr.m(C)=1;
ProdPrne(C)$(SAM(C,'ROW')=0 and (sum(A,SAM(A,C))>0))..PP(C)=e=PD(C);
ProdPrne.m(C)=1;
ProdPrnd(C)$(sum(A,SAM(A,C))-SAM(C,'ROW')=0)..PP(C)=e=PET(C);
ProdPrnd.m(C)=1;

ComPr(C)$(sum(A,SAM(A,C))>0)..sum(A$XPXC(C,A),theta(A,C)*PC(A))=g=PP(C);
ComPr.m(C)=1;

ActR(A)$(sum(C,SAM(A,C))>0 and not ghg('process',A) and sum(AgriC,SAM(AgriC,A))>0 and not LinkA(A))..PC(A)*alpha_nres(A)*XC(A)+sum(C$(M(C) and not AgriC(C)),PA(C)*ica(C,A)*XC(A))+PVAE(A)*QVAE(A)+PAG(A)*XAG(A)=g=PC(A)*(1-ta_in(A)-ta_ex(A))*XC(A)+crevI*crevIw(A)*CREV(A);
ActR.m(A)=1;
ActRp(A)$(ghg('process',A) ne 0 and sum(AgriC,SAM(AgriC,A))>0 and not LinkA(A))..PC(A)*alpha_nres(A)*XC(A)+sum(C$(M(C) and not AgriC(C)),PA(C)*ica(C,A)*XC(A))+sum(GC,thetaP(GC,A)*XC(A)*gtax(GC)*cpi)+PVAE(A)*QVAE(A)+PAG(A)*XAG(A)=g=PC(A)*(1-ta_in(A)-ta_ex(A))*XC(A)+crevI*crevIw(A)*CREV(A);
ActRP.m(A)=1;

ActRna(A)$(sum(C,SAM(A,C))>0 and not ghg('process',A) and sum(AgriC,SAM(AgriC,A))=0 and not LinkA(A))..PC(A)*alpha_nres(A)*XC(A)+sum(C$(M(C) and not AgriC(C)),PA(C)*ica(C,A)*XC(A))+PVAE(A)*QVAE(A)=g=PC(A)*(1-ta_in(A)-ta_ex(A))*XC(A)+crevI*crevIw(A)*CREV(A);
ActRna.m(A)=1;
ActRpna(A)$(ghg('process',A) ne 0 and sum(AgriC,SAM(AgriC,A))=0 and not LinkA(A))..PC(A)*alpha_nres(A)*XC(A)+sum(C$(M(C) and not AgriC(C)),PA(C)*ica(C,A)*XC(A))+sum(GC,thetaP(GC,A)*XC(A)*gtax(GC)*cpi)+PVAE(A)*QVAE(A)=g=PC(A)*(1-ta_in(A)-ta_ex(A))*XC(A)+crevI*crevIw(A)*CREV(A);
ActRPna.m(A)=1;


ActR_Link(A)$(sum(C,SAM(A,C))>0 and not ghg('process',A) and sum(AgriC,SAM(AgriC,A))>0 and LinkA(A))..XC(A)=e=XC_bottom(A);
ActR_Link.m(A)=1;
ActRp_Link(A)$(ghg('process',A) ne 0 and sum(AgriC,SAM(AgriC,A))>0 and LinkA(A))..XC(A)=e=XC_bottom(A);
ActRP_Link.m(A)=1;

ActRna_Link(A)$(sum(C,SAM(A,C))>0 and not ghg('process',A) and sum(AgriC,SAM(AgriC,A))=0 and LinkA(A))..XC(A)=e=XC_bottom(A);
ActRna_Link.m(A)=1;
ActRpna_Link(A)$(ghg('process',A) ne 0 and sum(AgriC,SAM(AgriC,A))=0 and LinkA(A))..XC(A)=e=XC_bottom(A);
ActRPna_Link.m(A)=1;


VAEPr0(A)$(sum(ELECC,SAM(ELECC,A))+sum(ENC,SAM(ENC,A))+sum(K,SAM(K,A))>0 and sum(L,SAM(L,A))=0 and not LinkA(A))..PVAE(A)=e=(1/alphaaVAE(A))*PHKTE(A);
VAEPr0.m(A)=1;
VAEPr1(A)$(sum(ELECC,SAM(ELECC,A))+sum(ENC,SAM(ENC,A))+sum(K,SAM(K,A))>0 and sum(L,SAM(L,A))>0 and not LinkA(A))..PVAE(A)=e=(1/alphaaVAE(A))*(sum(L,(deltaf(L,A)**sigmaaVAE(A))*(W(L)/(lambdat*lambda(A)))**(1-sigmaaVAE(A))) + (1-sum(L,deltaf(L,A)))**sigmaaVAE(A)*(PHKTE(A))**(1-sigmaaVAE(A)))**(1/(1-sigmaaVAE(A)));
VAEPr1.m(A)=1;
VAEPr2(A)$(sum(ELECC,SAM(ELECC,A))+sum(ENC,SAM(ENC,A))+sum(K,SAM(K,A))=0 and (L_single(A) eq 1) and not LinkA(A))..PVAE(A)=e=(1/alphaaVAE(A))*(sum(L,(deltaf(L,A)**sigmaaVAE(A))*(W(L)/(lambdat*lambda(A)))**(1-sigmaaVAE(A))))**(1/(1-sigmaaVAE(A)));
VAEPr2.m(A)=1;
VAEPr3(A)$(sum(ELECC,SAM(ELECC,A))+sum(ENC,SAM(ENC,A))+sum(K,SAM(K,A))=0 and (L_single(A) eq 0) and not LinkA(A))..PVAE(A)=e=(1/alphaaVAE(A))*sum(L,W(L)/(lambdat*lambda(A)));
VAEPr3.m(A)=1;

VAGPr(A)$(sum(C$AgriC(C),SAM(C,A))>0 and not LinkA(A))..PAG(A)=e=(1/alphaaAG(A))*prod(C$(XAPA(C,A) and AgriC(C)),(PA(C)/deltaC(C,A))**deltaC(C,A));
VAGPr.m(A)=1;


HKTEPr0(A)$(sum(ELECC,SAM(ELECC,A))+sum(ENC,SAM(ENC,A))>0 and sum(K,SAM(K,A))=0 and not LinkA(A))..PHKTE(A)=e=PEP(A);
HKTEPr0.m(A)=1;
HKTEPr1(A)$(sum(ELECC,SAM(ELECC,A))+sum(ENC,SAM(ENC,A))>0 and sum(K,SAM(K,A))>0 and not LinkA(A))..PHKTE(A)=e=
(
     sum(K,(deltaf(K,A))**(sigmaaHKTE(A))*(R(K)/lambdak*lambdaka(A))**(1-sigmaaHKTE(A)))
+ (1-sum(K,deltaf(K,A)))**sigmaaHKTE(A)*(PEP(A))**(1-sigmaaHKTE(A))
)**(1/(1-sigmaaHKTE(A)));
HKTEPr1.m(A)=1;

HKTEPr2(A)$(sum(ELECC,SAM(ELECC,A))+sum(ENC,SAM(ENC,A))=0 and (K_single(A) eq 1) and not LinkA(A))..PHKTE(A)=e=
(     sum(K,(deltaf(K,A))**(sigmaaHKTE(A))*(R(K)/lambdak*lambdaka(A))**(1-sigmaaHKTE(A)))
)**(1/(1-sigmaaHKTE(A)));
HKTEPr2.m(A)=1;

HKTEPr3(A)$(sum(ELECC,SAM(ELECC,A))+sum(ENC,SAM(ENC,A))=0 and (K_single(A) eq 0) and not LinkA(A))..PHKTE(A)=e=sum(K,R(K)/lambdak*lambdaka(A));
HKTEPr3.m(A)=1;


XEPr0(A)$(sum(ENC,SAM(ENC,A))>0 and sum(ELECC,SAM(ELECC,A))=0 and not LinkA(A))..PEP(A)=e=PFL(A);
XEPr0.m(A)=1;
XEPr1(A)$(sum(ENC,SAM(ENC,A))>0 and sum(ELECC,SAM(ELECC,A))>0 and not LinkA(A))..PEP(A)=e=
(
  sum(C$ELECC(C),  (deltac(C,A))**(sigmaaXEP(A))*(PA(C))**(1-sigmaaXEP(A)))
+ (1-sum(C$ELECC(C),deltaC(C,A)))**sigmaaxEP(A)*(PFL(A))**(1-sigmaaXEP(A))
)**(1/(1-sigmaaXEP(A)));
XEPr1.m(A)=1;

XEPr2(A)$(sum(ENC,SAM(ENC,A))= 0 and ELECC_single(A) eq 1 and not LinkA(A))..PEP(A)=e=
( sum(C$ELECC(C),  (deltac(C,A))**(sigmaaXEP(A))*(PA(C))**(1-sigmaaXEP(A)))
)**(1/(1-sigmaaXEP(A)));
XEPr2.m(A)=1;

XEPr3(A)$(sum(ENC,SAM(ENC,A))= 0 and ELECC_single(A) eq 0 and not LinkA(A))..PEP(A)=e=sum(C$(ELECC(C) and EleccA(A,C)),  PA(C));
XEPr3.m(A)=1;


XFLPr0(A)$(sum(C$Lfuel(C),SAM(C,A))>0 and sum(C$sfuel(C),SAM(C,A))=0 and not LinkA(A))..PFL(A)=e=PLFL(A);
XFLPr0.m(A)=1;

XFLPr1(A)$(sum(C$Lfuel(C),SAM(C,A))>0 and sum(C$sfuel(C),SAM(C,A))>0 and not LinkA(A))..PFL(A)=e=
(
sum(C$SfuelA(A,C),deltac(C,A)**sigmaaXFL(A)*(PNEG(C,A)/AEEI(C,A))**(1-sigmaaXFL(A)))
+
(1-sum(C$SfuelA(A,C),deltac(C,A)))**(sigmaaXFL(A))*PLFL(A)**(1-sigmaaXFL(A))
)**(1/(1-sigmaaXFL(A)));
XFLPr1.m(A)=1;

XFLPr2(A)$(sum(C$Lfuel(C),SAM(C,A))=0 and Sfuel_single(A) eq 1 and not LinkA(A))..PFL(A)=e=
(sum(C$SfuelA(A,C),deltac(C,A)**sigmaaXFL(A)*(PNEG(C,A)/AEEI(C,A))**(1-sigmaaXFL(A)))
)**(1/(1-sigmaaXFL(A)));
XFLPr2.m(A)=1;

XFLPr3(A)$(sum(C$Lfuel(C),SAM(C,A))=0 and Sfuel_single(A) eq 0 and not LinkA(A))..PFL(A)=e=sum(C$(Sfuel(C) and SfuelA(A,C)),PNEG(C,A))/sum(C$(Sfuel(C) and SfuelA(A,C)),AEEI(C,A));
XFLPr3.m(A)=1;

XLFLPr2(A)$(sum(C$Lfuel(C),SAM(C,A))>0 and Lfuel_single(A) eq 1 and not LinkA(A))..PLFL(A)=e=
(
sum(C$LfuelA(A,C),(deltac(C,A))**(sigmaaXLFL(A))*(PNEG(C,A)/AEEI(C,A))**(1-sigmaaXLFL(A)))
)**(1/(1-sigmaaXLFL(A)));
XLFLPr2.m(A)=1;

XLFLPr3(A)$(sum(C$Lfuel(C),SAM(C,A))>0 and Lfuel_single(A) eq 0 and not LinkA(A))..PLFL(A)=e=sum(C$(ENC(C) and LfuelA(A,C)),PNEG(C,A))/sum(C$(ENC(C) and LfuelA(A,C)),AEEI(C,A));
XLFLPr3.m(A)=1;


NEGPr(C,A)$(FuelA(A,C) and ghg(C,A)=0 and not LinkA(A))..PA(C)=e=PNEG(C,A);
NEGPr.m(C,A)=1;


NEGPrco(C,A)$(FuelA(A,C) and ghg(C,A)>0 and not LinkA(A))..PA(C)+sum(GC,thetaE(GC,C,A)*cpi*gtax(GC))=e=PNEG(C,A);
NEGPrco.m(C,A)=1;

NEGPr_Link(C,A)$(FuelA(A,C) and ghg(C,A)=0 and LinkA(A))..PA(C)=e=PNEG(C,A);
NEGPr.m(C,A)=1;


NEGPrco_Link(C,A)$(FuelA(A,C) and ghg(C,A)>0 and LinkA(A))..PA(C)+sum(GC,thetaE(GC,C,A)*cpi*gtax(GC))=e=PNEG(C,A);
NEGPrco.m(C,A)=1;


*Numeria
Norm..cpi=e=sum(C,PA(C)*cwrt(C));
Norm.m=1;
CPIfix..cpi=e=cpi_o;
CPIfix.m=1;

*Production and Trade block
QVAED(A)$(sum(C,SAM(A,C))>0 and not LinkA(A))..QVAE(A)=e=XC(A);
QVAED.m(A)=1;

XAGD(A)$(sum(AgriC,SAM(AgriC,A))>0 and not LinkA(A))..XAG(A)=e=XC(A);
XAGD.m(A)=1;


HKTED0(A)$(sum(ELECC,SAM(ELECC,A))+sum(ENC,SAM(ENC,A))+sum(K,SAM(K,A))>0 and sum(L,SAM(L,A))=0 and not LinkA(A))..HKTE(A)=e=(1/alphaaVAE(A))*QVAE(A);
HKTED0.m(A)=1;
HKTED1(A)$(sum(ELECC,SAM(ELECC,A))+sum(ENC,SAM(ENC,A))+sum(K,SAM(K,A))>0 and sum(L,SAM(L,A))>0 and not LinkA(A))
..HKTE(A)=e=((1-sum(L,deltaf(L,A)))**sigmaaVAE(A))*((PVAE(A)/PHKTE(A))**sigmaaVAE(A))*( alphaaVAE(A)**(sigmaaVAE(A)-1))*QVAE(A);
HKTED1.m(A)=1;

LDA1(L,A)$(sum(ELECC,SAM(ELECC,A))+sum(ENC,SAM(ENC,A))+sum(K,SAM(K,A))>0 and sum(LP,SAM(LP,A))>0 and not LinkA(A))..LD(L,A)=e=(           deltaf(L,A)**sigmaaVAE(A))*((PVAE(A)/W(L)    )**sigmaaVAE(A))*((alphaaVAE(A)*lambdat*lambda(A))**(sigmaaVAE(A)-1))*QVAE(A);
LDA1.m(L,A)=1;

LDA2(L,A)$(sum(ELECC,SAM(ELECC,A))+sum(ENC,SAM(ENC,A))+sum(K,SAM(K,A))=0 and L_single(A) eq 1 and not LinkA(A))..LD(L,A)=e=(           deltaf(L,A)**sigmaaVAE(A))*((PVAE(A)/W(L)    )**sigmaaVAE(A))*((alphaaVAE(A)*lambdat*lambda(A))**(sigmaaVAE(A)-1))*QVAE(A);
LDA2.m(L,A)=1;

LDA3(L,A)$(sum(ELECC,SAM(ELECC,A))+sum(ENC,SAM(ENC,A))+sum(K,SAM(K,A))=0 and L_single(A) eq 0 and not LinkA(A))..LD(L,A)=e=(1/(alphaaVAE(A)*lambdat*lambda(A)))*QVAE(A);
LDA3.m(L,A)=1;

LDA1_Link(L,A)$(sum(ELECC,SAM(ELECC,A))+sum(ENC,SAM(ENC,A))+sum(K,SAM(K,A))>0 and sum(LP,SAM(LP,A))>0 and LinkA(A))..LD(L,A)=e=LD_bottom(L,A);
LDA1_Link.m(L,A)=1;

LDA2_Link(L,A)$(sum(ELECC,SAM(ELECC,A))+sum(ENC,SAM(ENC,A))+sum(K,SAM(K,A))=0 and L_single(A) eq 1 and LinkA(A))..LD(L,A)=e=LD_bottom(L,A);
LDA2_Link.m(L,A)=1;

LDA3_Link(L,A)$(sum(ELECC,SAM(ELECC,A))+sum(ENC,SAM(ENC,A))+sum(K,SAM(K,A))=0 and L_single(A) eq 0 and LinkA(A))..LD(L,A)=e=LD_bottom(L,A);
LDA3_Link.m(L,A)=1;

ZD_Link(A)$(LinkA(A))..ZD(A)=e=ZD_bottom(A);
ZD_Link.m(A)=1;

XEPD0(A)$(sum(ELECC,SAM(ELECC,A))+sum(ENC,SAM(ENC,A))>0 and sum(K,SAM(K,A))=0 and not LinkA(A))..XEP(A)=e=HKTE(A);
XEPD0.m(A)=1;
XEPD1(A)$(sum(ELECC,SAM(ELECC,A))+sum(ENC,SAM(ENC,A))>0 and sum(K,SAM(K,A))>0 and not LinkA(A))..XEP(A)=e=  ((1-sum(K,deltaf(K,A)))**sigmaaHKTE(A))*((PHKTE(A)/PEP(A))**sigmaaHKTE(A))*HKTE(A);
XEPD1.m(A)=1;

KDA1(K,A)$(sum(ELECC,SAM(ELECC,A))+sum(ENC,SAM(ENC,A))>0 and sum(KP,SAM(KP,A))>0 and not LinkA(A))..KD(K,A)=e=(           deltaf(K,A)**sigmaaHKTE(A))*((PHKTE(A)/R(K))**sigmaaHKTE(A))*((lambdak*lambdaka(A))**(sigmaaHKTE(A)-1))*HKTE(A);
KDA1.m(K,A)=1;
KDA2(K,A)$(sum(ELECC,SAM(ELECC,A))+sum(ENC,SAM(ENC,A))=0 and K_single(A) eq 1 and not LinkA(A))..KD(K,A)=e=(           deltaf(K,A)**sigmaaHKTE(A))*((PHKTE(A)/R(K))**sigmaaHKTE(A))*((lambdak*lambdaka(A))**(sigmaaHKTE(A)-1))*HKTE(A);
KDA2.m(K,A)=1;
KDA3(K,A)$(sum(ELECC,SAM(ELECC,A))+sum(ENC,SAM(ENC,A))=0 and K_single(A) eq 0 and not LinkA(A))..KD(K,A)=e=(1/(lambdak*lambdaka(A)))*HKTE(A);
KDA3.m(K,A)=1;

KDA1_Link(K,A)$(sum(ELECC,SAM(ELECC,A))+sum(ENC,SAM(ENC,A))>0 and sum(KP,SAM(KP,A))>0 and LinkA(A))..KD(K,A)=e=KD_bottom(K,A);
KDA1_Link.m(K,A)=1;
KDA2_Link(K,A)$(sum(ELECC,SAM(ELECC,A))+sum(ENC,SAM(ENC,A))=0 and K_single(A) eq 1 and LinkA(A))..KD(K,A)=e=KD_bottom(K,A);
KDA2_Link.m(K,A)=1;
KDA3_Link(K,A)$(sum(ELECC,SAM(ELECC,A))+sum(ENC,SAM(ENC,A))=0 and K_single(A) eq 0 and LinkA(A))..KD(K,A)=e=KD_bottom(K,A);
KDA3_Link.m(K,A)=1;


XFLD0(A)$(sum(ENC,SAM(ENC,A))>0 and sum(ELECC,SAM(ELECC,A))=0 and not LinkA(A))..XFL(A)=e=XEP(A);
XFLD0.m(A)=1;
XFLD1(A)$(sum(ENC,SAM(ENC,A))>0 and sum(ELECC,SAM(ELECC,A))>0 and not LinkA(A))..XFL(A)=e=((1-sum(C$ELECC(C),deltaC(C,A)))**sigmaaXEP(A))*((PEP(A)/PFL(A))**sigmaaXEP(A))*XEP(A);
XFLD1.m(A)=1;

INTDE1(C,A)$(ELECC(C) and SAM(C,A)$ELECC(C)>0 and sum(ENC,SAM(ENC,A))>0 and not LinkA(A))..XAP(C,A)=e=(  deltac(C,A)**sigmaaXEP(A))*((PEP(A)/PA(C))**sigmaaXEP(A))*XEP(A);
INTDE1.m(C,A)=1;
INTDE2(C,A)$(ELECC(C) and (ELECC_single(A) eq 1) and sum(ENC,SAM(ENC,A))=0 and not LinkA(A))..XAP(C,A)=e=(  deltac(C,A)**sigmaaXEP(A))*((PEP(A)/PA(C))**sigmaaXEP(A))*XEP(A);
INTDE2.m(C,A)=1;
INTDE3(C,A)$(ELECC(C) and (ELECC_single(A) eq 0) and sum(ENC,SAM(ENC,A))=0 and not LinkA(A))..XAP(C,A)=e=XEP(A);
INTDE3.m(C,A)=1;

INTDE1_Link(C,A)$(ELECC(C) and SAM(C,A)$ELECC(C)>0 and sum(ENC,SAM(ENC,A))>0 and LinkA(A))..XAP(C,A)=e=XAP_bottom(C,A);
INTDE1_Link.m(C,A)=1;
INTDE2_Link(C,A)$(ELECC(C) and (ELECC_single(A) eq 1) and sum(ENC,SAM(ENC,A))=0 and LinkA(A))..XAP(C,A)=e=XAP_bottom(C,A);
INTDE2_Link.m(C,A)=1;
INTDE3_Link(C,A)$(ELECC(C) and (ELECC_single(A) eq 0) and sum(ENC,SAM(ENC,A))=0 and LinkA(A))..XAP(C,A)=e=XAP_bottom(C,A);
INTDE3_Link.m(C,A)=1;



XLFLD0(A)$(sum(C$Lfuel(C),SAM(C,A))>0 and sum(C$sfuel(C),SAM(C,A))=0 and not LinkA(A))..XLFL(A)=e=XFL(A);
XLFLD0.m(A)=1;

NEGDS1(C,A)$(SfuelA(A,C) and sum(CP$Lfuel(CP),SAM(CP,A))>0 and not LinkA(A) )..QNEG(C,A)=e= (deltac(C,A)**sigmaaXFL(A))*((PFL(A)/PNEG(C,A))**sigmaaXFL(A))*((AEEI(C,A))**(sigmaaXFL(A)-1))*XFL(A);
NEGDS1.m(C,A)=1;

NEGDS2(C,A)$(SfuelA(A,C) and (Sfuel_single(A) eq 1) and sum(CP$Lfuel(CP),SAM(CP,A))=0 and not LinkA(A) )..QNEG(C,A)=e= (deltac(C,A)**sigmaaXFL(A))*((PFL(A)/PNEG(C,A))**sigmaaXFL(A))*((AEEI(C,A))**(sigmaaXFL(A)-1))*XFL(A);
NEGDS2.m(C,A)=1;

NEGDS3(C,A)$(SfuelA(A,C) and (Sfuel_single(A) eq 0) and sum(CP$Lfuel(CP),SAM(CP,A))=0 and not LinkA(A) )..QNEG(C,A)=e= (1/AEEI(C,A))*XFL(A);
NEGDS3.m(C,A)=1;

NEGDS1_Link(C,A)$(SfuelA(A,C) and sum(CP$Lfuel(CP),SAM(CP,A))>0 and LinkA(A) )..QNEG(C,A)=e=QNEG_bottom(C,A);
NEGDS1_Link.m(C,A)=1;

NEGDS2_Link(C,A)$(SfuelA(A,C) and (Sfuel_single(A) eq 1) and sum(CP$Lfuel(CP),SAM(CP,A))=0 and LinkA(A) )..QNEG(C,A)=e= QNEG_bottom(C,A);
NEGDS2_Link.m(C,A)=1;

NEGDS3_Link(C,A)$(SfuelA(A,C) and (Sfuel_single(A) eq 0) and sum(CP$Lfuel(CP),SAM(CP,A))=0 and LinkA(A) )..QNEG(C,A)=e= QNEG_bottom(C,A);
NEGDS3_Link.m(C,A)=1;



XLFLD1(A)$(sum(C$Lfuel(C),SAM(C,A))>0 and sum(C$sfuel(C),SAM(C,A) >0) and not LinkA(A))..XLFL(A)=e=(1-sum(C$sfuel(C),deltaC(C,A)))**sigmaaXFL(A)*(PFL(A)/PLFL(A))**(sigmaaXFL(A))*XFL(A);
XLFLD1.m(A)=1;


NEGDL2(C,A)$(LfuelA(A,C) and Lfuel_single(A) eq 1 and not LinkA(A))..QNEG(C,A)=e=                (deltac(C,A)**sigmaaXLFL(A))*((PLFL(A)/PNEG(C,A))**sigmaaXLFL(A))*((AEEI(C,A))**(sigmaaXLFL(A)-1))*XLFL(A);
NEGDL2.m(C,A)=1;

NEGDL3(C,A)$(LfuelA(A,C) and Lfuel_single(A) eq 0 and not LinkA(A))..QNEG(C,A)=e=(1/AEEI(C,A))*XLFL(A);
NEGDL3.m(C,A)=1;

NEGDL2_Link(C,A)$(LfuelA(A,C) and Lfuel_single(A) eq 1 and LinkA(A))..QNEG(C,A)=e=QNEG_bottom(C,A);
NEGDL2_Link.m(C,A)=1;

NEGDL3_Link(C,A)$(LfuelA(A,C) and Lfuel_single(A) eq 0 and LinkA(A))..QNEG(C,A)=e=QNEG_bottom(C,A);
NEGDL3_Link.m(C,A)=1;





INTDM(C,A)$((M(C) and not AgriC(C)) and SAM(C,A)$(M(C) and not AgriC(C))>0 and not LinkA(A))..XAP(C,A)=e=ica(C,A)*XC(A);
INTDM.m(C,A)=1;
INTDAG0(C,A)$(AgriC(C) and SAM(C,A)$AgriC(C)>0 and Agri_single(A) eq 0 and not LinkA(A))..XAP(C,A)=e=(1/alphaaAG(A))*XAG(A);
INTDAG0.m(C,A)=1;
INTDAG1(C,A)$(AgriC(C) and SAM(C,A)$AgriC(C)>0 and Agri_single(A) eq 1 and not LinkA(A))..XAP(C,A)=e=deltaC(C,A)*(PAG(A)/PA(C))*XAG(A);
INTDAG1.m(C,A)=1;

INTGD(GC,A)$(ghg('process',A)>0 and not LinkA(A))..QINTG(GC,A)=e=thetaP(GC,A)*XC(A);
INTGD.m(GC,A)=1;

INTDM_Link(C,A)$((M(C) and not AgriC(C)) and SAM(C,A)$(M(C) and not AgriC(C))>0 and LinkA(A))..XAP(C,A)=e=XAP_bottom(C,A);
INTDM_Link.m(C,A)=1;
INTDAG0_Link(C,A)$(AgriC(C) and SAM(C,A)$AgriC(C)>0 and Agri_single(A) eq 0 and LinkA(A))..XAP(C,A)=e=XAP_bottom(C,A);
INTDAG0_Link.m(C,A)=1;
INTDAG1_Link(C,A)$(AgriC(C) and SAM(C,A)$AgriC(C)>0 and Agri_single(A) eq 1 and LinkA(A))..XAP(C,A)=e=XAP_bottom(C,A);
INTDAG1_Link.m(C,A)=1;

INTGD_Link(GC,A)$(ghg('process',A)>0 and LinkA(A))..QINTG(GC,A)=e=thetaP(GC,A)*XC(A);
INTGD_Link.m(GC,A)=1;





NELQCED(C,A)$(ENC(C) and SAM(C,A)$ENC(C)>0 and not LinkA(A))..QCE(C,A)=e=QNEG(C,A);
NELQCED.m(C,A)=1;

NELQCED_Link(C,A)$(ENC(C) and SAM(C,A)$ENC(C)>0 and LinkA(A))..QCE(C,A)=e=QNEG(C,A);
NELQCED_Link.m(C,A)=1;


GD(GC,C,A)$(GfuelA(A,C) and not LinkA(A))..QGE(GC,C,A)=e=thetaE(GC,C,A)*QNEG(C,A);
GD.m(GC,C,A)=1;

GD_Link(GC,C,A)$(GfuelA(A,C)and LinkA(A))..QGE(GC,C,A)=e=thetaE(GC,C,A)*QNEG(C,A);
GD_Link.m(GC,C,A)=1;


ActDC(A)$(sum(C,SAM(A,C))>0)..XC(A)=g=sum(C$XPXC(C,A),theta(A,C)*XP(C));
ActDC.m(A)=1;

XDD(C)$((SAM('ROW',C) ne 0) and (sum(A,SAM(A,C))>0))..XD(C)=g=(deltaq(C)**sigmaq(C))*((PA(C)/(PD(C)))**sigmaq(C))*(alphaq(C)**(sigmaq(C)-1))*XA(C);
XDD.m(C)=1;
XDDni(C)$(SAM('ROW',C)=0 and (sum(A,SAM(A,C))>0)).. XD(C)=e=XA(C);
XDDni.m(C)=1;
XMTDnd(C)$(sum(A,SAM(C,A))+sum(H,SAM(C,H))+sum(FD,SAM(C,FD))-SAM('ROW',C)=0)..XMT(C)=e=XA(C);
XMTDnd.m(C)=1;

XMTD(C)$((SAM('ROW',C) ne 0) and (sum(A,SAM(A,C))>0))..XMT(C)=g=((1-deltaq(C))**sigmaq(C))*((PA(C)/(PMT(C)))**sigmaq(C))*(alphaq(C)**(sigmaq(C)-1))*XA(C);
XMTD.m(C)=1;

ESS(C)$(SAM(C,'ROW') ne 0 and (sum(A,SAM(A,C))>0))..(deltat(C)**sigmat(C))*((PP(C)/PET(C))**sigmat(C))*(alphat(C)**(sigmat(C)-1))*XP(C)=g=ES(C);
ESS.m(C)=1;
ESSnd(C)$(sum(A,SAM(A,C))-SAM(C,'ROW')=0)..ES(C)=e=XP(C);
Essnd.m(C)=1;

XDS(C)$(SAM(C,'ROW') ne 0 and (sum(A,SAM(A,C))>0))..((1-deltat(C))**sigmat(C))*((PP(C)/PD(C))**sigmat(C))*(alphat(C)**(sigmat(C)-1))*XP(C)=g=XD(C);
XDS.m(C)=1;
XDSne(C)$(SAM(C,'ROW')=0 and (sum(A,SAM(A,C))>0)).. XD(C)=e=XP(C);
XDSne.m(C)=1;

Labsup(L)..Ls(L)=e=Lw0(L)*(((1-TINSR)*(W(L)/cpi))**epsilon_L(L));
Labsup.m(L)=1;
*Institution
InvD(C)$(SAM(C,'S-I') ne 0)..XAF('S-I',C)=e=qinv_o(C)*IVAD;
InvD.m(C)=1;
HouseLY(H)..LY(H)=e=sum(L,shr(L,H)*Ls(L)*W(L));
HouseLY.m(H)=1;
HouseKY(H)..KY(H)=e=sum(K,shr(K,H)*Ks(K)*R(K));
HouseKY.m(H)=1;
HouseEY(H)..EY(H)=e=sum(A$LinkA(A),
shrpro(A,H)*(
PC(A)*(1-ta_in(A)-ta_ex(A))*XC(A)
-PC(A)*alpha_nres(A)*XC(A)
-sum(C$(XAPA(C,A) and not (ELECCA(A,C) or FuelA(A,C))) ,PA(C)*XAP(C,A))
-sum(C$ELECCA(A,C),PA(C)*XAP(C,A))
-sum(C$FuelA(A,C),PNEG(C,A)*QNEG(C,A))
-sum(K,R(K)*KD(K,A))
-sum(L,W(L)*LD(L,A))
)
)
-sum(A$(LinkA(A) and ghg('process',A)>0), shrpro(A,H)*sum(GC,QINTG(GC,A)*gtax(GC)*cpi))
;
HouseEY.m(H)=1;

HouseYD(H)..YD(H)=e=(1-TINSR)*(LY(H)+KY(H)+TR(H)+EY(H)+ResinC-delta*sum(K,shr(K,H)*Ks(K)));
HouseYD.m(H)=1;
HouseY(H)..YH(H)=e=LY(H)+KY(H)+TR(H)+EY(H)+ResinC;
HouseY.m(H)=1;
Saver(H)..MPS(H)=e=mus(H);
Saver.m(H)=1;
HouseD(C,H)$(SAM(C,'Household') ne 0)..XAC(C,H)=e=mu(C,H)*(YD(H)/(PA(C)*(1+tc_in)));
HouseD.m(C,H)=1;
Hsave(H)..SH(H)=e=MPS(H)*YD(H)+delta*sum(K,shr(K,H)*Ks(K));
Hsave.m(H)=1;

GovE(C)$(SAM(C,'Gov') ne 0)..XAF('Gov',C)=e=qgr0(C)*sum(CP,PA(CP)*XA(CP))*(1/(PA(C)*(1+tg_in)))+(qg0(C)/sum(CP,qg0(C)))*crevc*TCREV/(PA(C)*(1+tg_in));
GovE.m(C)=1;
Tras(H)..Tr(H)=e=tr0_per(H)*cpi*Oldpop+crevh*crevh_share(H)*TCREV;
Tras.m(H)=1;

Ytax..TINSR=e=(sum(H,(YH(H)-delta*sum(K,shr(K,H)*Ks(K))))*TINS0-crevtax*TCREV)/sum(H,(YH(H)-delta*sum(K,shr(K,H)*Ks(K))));
Ytax.m=1;

ForS..FSAV=e=fsav0*FSAD;
ForS.m=1;
GovI..YG=e=
sum(A$(sum(C,SAM(A,C))>0),(ta_in(A)+ta_ex(A))*PC(A)*XC(A))
+sum(C$(SAM('ROW',C) ne 0),tm(C)*pwm(C)*XMT(C)*EXR)
+sum(C$(SAM(C,'ROW') ne 0),te(C)*pwe(C)*ES(C)*EXR)
+(TINSR)*sum(H,(YH(H)-delta*sum(K,shr(K,H)*Ks(K))))
+sum((GC,A)$(ghg('process',A)>0),gtax(GC)*cpi*QINTG(GC,A))
+sum((GC,C,A)$(GfuelA(A,C)),gtax(GC)*cpi*QGE(GC,C,A))
+(tc_in)*sum((C,H)$(SAM(C,'Household') ne 0),PA(C)*XAC(C,H))
+tg_in*sum(C$(SAM(C,'Gov') ne 0),PA(C)*XAF('Gov',C))
+tiv_in*sum(C$(SAM(C,'S-I') ne 0),PA(C)*XAF('S-I',C))
+tm_in*sum(C$(SAM('ROW',C) ne 0),PMT(C)*XMT(C));
GovI.m=1;
******Market clearing
LabM(L)..Ls(L)=g=sum(A$(SAM(L,A)>0),LD(L,A));
LabM.m(L)=1;
CapM(K)..Ks(K)=g=sum(A$(SAM(K,A)>0),KD(K,A));
CapM.m(K)=1;

ResM..rent=e=sum(H,EY(H))/Zs;
ResM.m=1;


ComMENCN(C)$(ENCN(C) and not LinkC(C))..XA(C)=g=sum(A$XAPA(C,A),XAP(C,A))      +sum(H$XACH(H,C),XAC(C,H))+sum(FD$FD_C(C,FD),XAF(FD,C));
ComMENCN.m(C)=1;
ComMENCN_Link(C)$(ENCN(C) and LinkC(C))..XA(C)=g=sum(A$XAPA(C,A),XAP(C,A))      +sum(H$XACH(H,C),XAC(C,H))+sum(FD$FD_C(C,FD),XAF(FD,C));
ComMENCN_Link.m(C)=1;
ComMENC(C)$(ENC(C))..XA(C)=g=sum(A$XEPA(C,A) ,QCE(C,A ))+sum(H$XACH(H,C),XAC(C,H))+sum(FD$FD_C(C,FD),XAF(FD,C));
ComMENC.m(C)=1;




**Too many QGES' Non CO2 generating fossil fuels are included***
CREVE(A)$(ghg('process',A) eq 0)..CREV(A)=e=sum(GC,gtax(GC)*cpi*sum(C$GfuelA(A,C),QGE(GC,C,A)));
CREVE.m(A)=1;
CREVP(A)$(ghg('process',A) ne 0)..CREV(A)=e=sum(GC,gtax(GC)*cpi*sum(C$GfuelA(A,C),QGE(GC,C,A)))+sum(GC,gtax(GC)*cpi*QINTG(GC,A));
CREVP.m(A)=1;
TCREVsum..TCREV=e=sum(A,CREV(A));
TCREVsum.m=1;

InvM..sum(C$(SAM(C,'S-I') ne 0),PA(C)*(1+tiv_in)*XAF('S-I',C))=e=Warlas+sum(H,SH(H))+SG+FSAV*EXR+ResinI;
InvM.m=1;
CAB..sum(C$(SAM('ROW',C) ne 0),pwm(C)*XMT(C))=e=sum(C$(SAM(C,'ROW') ne 0),pwe(C)*ES(C))+FSAV+(tm_in)*(sum(C$(SAM('ROW',C) ne 0),PMT(C)*XMT(C))/EXR);
CAB.m=1;
GovB..SG=e=YG-sum(C$(SAM(C,'Gov') ne 0),PA(C)*(1+tg_in)*XAF('Gov',C))-sum(H,TR(H))-crevI*TCREV;
GovB.m=1;

ResC..ResinC=e=thetaRes_c*sum(A$(sum(C,SAM(A,C))>0),PC(A)*alpha_nres(A)*XC(A));
ResC.m=1;
ResI..ResinI=e=thetaRes_iv*sum(A$(sum(C,SAM(A,C))>0),PC(A)*alpha_nres(A)*XC(A));
ResI.m=1;

**** Initialization and calibration

**** Declare initial values
Parameters
PC0(A)
XC0(A)
XMT0(C)
PMT0(C)
XD0(C)
PD0(C)

XA0(C)
PA0(C)
ES0(C)
PET0(C)
XP0(C)
PP0(C)
QNEG0(C,A)
PNEG0(C,A)

PVAE0(A)
QVAE0(A)
PAG0(A)
XAG0(A)
HKTE0(A)
PHKTE0(A)
XEP0(A)
PEP0(A)
XFL0(A)
PFL0(A)
XLFL0(A)
PLFL0(A)
XAP0(C,A)
QINTG0(GC,A)

R0(K)
W0(L)
rent0
LD0(L,A)
KD0(K,A)
ZD0(A)
Ks0(K)
Ls0(L)
Zs0
QCE0(C,A)
QGE0(GC,C,A)

EXR0
YG0

TR0(H)
XAF0(FD,C)
SG0

MPS0(H)
LY0(H)
KY0(H)
EY0(H)
YH0(H)
YD0(H)
XAC0(C,H)
SH0(H)

TINSR0


FSAV0
IVAD0
Warlas0


CREV0(A)
TCREV0
ResinC0
ResinI0;

** gtax scenario
*** Policy Scenario ***
* Scenario=0 : BAU
* Scenario=1 : Target 1
** Dynamic adjustments**

**=================carbon tax policy parameters=================
**initial tax revenue and tax rate paremeters (set as 0)

CrevI_o=0;
gtaxrate_o=0.0;

CREV0(A)=gtaxrate_o*sam('CO2-c',A)+gtaxrate_o*ghg('process',A);
TCREV0=sum(A,CREV0(A));
*display CREV0;

gtax(GC)=0;
CrevH_share(H)=sam(H,'Gov')/sum(HP,sam(HP,'Gov'));

*** policy scenarios (different gtax rate)

Scenario=1;
parameter
gtaxp_BAU(GC,t)
gtaxp_ctax_1(GC,t)
;
*$include  "..\SAM\param.gc.t.txt";
$include  "..\SAM\parameter\static\gtaxp_BAU.txt";
$include  "..\SAM\parameter\static\gtaxp_ctax_1.txt";
*$include  "..\SAM\parameter\recursive\gtaxp_BAU.txt";
*$include  "..\SAM\parameter\recursive\gtaxp_ctax_1.txt";

*** policy simulation setting****

if (scenario=0,
gtax_policy(GC,t)=gtaxp_BAU(GC,t);
CrevH=0;
CrevC=0;
CrevI=0;
CrevIw(A)=0;
Crevtax=0;


elseif (scenario=1),
gtax(GC)=1;
gtax_policy(GC,t)=gtaxp_ctax_1(GC,t);
CrevH=1;
CrevC=0;
CrevI=0;
CrevIw(A)=0;
Crevtax=0;
);



**====================Comoditiy specific parameters=======================================**

$INCLUDE "..\SAM\parameter\sigmaq.txt";

**====================Growth parameters=======================================**

Parameter
lgrow(t)
Oldpopg(t)
TBg(t)
;
*$include  "..\SAM\param.growth.txt";
$include "..\SAM\parameter\static\lgrow.txt";
$include "..\SAM\parameter\static\Oldpopg.txt";
$include "..\SAM\parameter\static\TBg.txt";
*$include "..\SAM\parameter\recursive\lgrow.txt";
*$include "..\SAM\parameter\recursive\Oldpopg.txt";
*$include "..\SAM\parameter\recursive\TBg.txt";


*display
*CrevI_o,gtaxrate_o,CREV0,TCREV0,gtax,CrevH_share,gtaxp_BAU,gtaxp_ctax,scenario,gtax_policy,CrevH,CrevC,CrevI,CrevIW,Crevtax;

sigmaaVAE(A)=1.02;
sigmaaHKTE(A)=0.8;
sigmaaXEP(A)=0.5;
sigmaaXFL(A)=0.5;
sigmaaXLFL(A)=0.5;
sigmat(C)=-3;

rhoaVAE(A)=(1/sigmaaVAE(A))-1;
rhoaHKTE(A)=(1/sigmaaHKTE(A))-1;
rhoaXEP(A)=(1/sigmaaXEP(A))-1;
rhoaXFL(A)=(1/sigmaaXFL(A))-1;
rhoaXLFL(A)=(1/sigmaaXLFL(A))-1;
rhot(C)$((SAM(C,'ROW') ne 0) and (sum(A,SAM(A,C))>0))=1-(1/sigmat(C));
rhoq(C)$((SAM('ROW',C) ne 0) and (sum(A,SAM(A,C))>0))=(1/sigmaq(C))-1;

*display rhot,rhoq;

*labor productivity
lambdat=1;
lambda(A)=1;
epsilon_L(L)=0.4;

*capital productivity
lambdak=1;
lambdaka(A)=1;

*AEEI
AEEI(C,A)=1;
*Residue coefficeint
alpha_nres(A)=SAMng('NRES',A)/sum(ACT,samng(ACT,A));
thetaRes_c=sum(H,SAMng(H,'NRES'))/sum(A,SAMng('NRES',A));
thetaRes_iv=SAMng('S-I','NRES')/sum(A,SAMng('NRES',A));

*base year capital rent : IO capital payment + IO depreciation/ KPI DB 2010 Total capital stock evaluated in 2010 ppi (Unit: 1,000,000,000 won)

*R0(K)=sum(A,SAM(K,A))/3403090.255;
R0(K)=1;
KD0(K,A)=SAM(K,A)/R0(K);
Ks0(K)=sum(A,KD0(K,A));
display KD0,Ks0;
*base year wage : IO payroll / 2010 employment in Thousand
*W0(L)=sum(A,SAM(L,A))/23890;
W0(L)=1;
LD0(L,A)=SAM(L,A)/W0(L);
*display R0,W0,LD0,KD0;
*depreciation
*delta=0.046;
delta=R0('Capital')*0.390061;
rent0=1;
ZD0(A)$LinkA(A)=0.0*sum(K,R0(K)*KD0(K,A))/rent0;
Zs0=100;
KD0(K,A)$LinkA(A)=1*KD0(K,A);
Ks0(K)=sum(A,KD0(K,A));
display ZD0,zs0,KD0,Ks0;

**Price
PET0(C)$(SAM(C,'ROW') ne 0)=1;
PP0(C)$(sum(A,SAM(A,C))>0)=1;
PC0(A)=1;
PMT0(C)$(SAM('ROW',C) ne 0)=1;
PD0(C)$(sum(A,SAM(A,C))>0)=1;
PA0(C)=1;

** Initial price option to convert money value to TOE.
**To link with Agri model (all money value), we drop this option


*PET0(C)$ELEcgc(C)=    1.242060742        ;
*PET0(C)$Gasgc(C)=    0.957191718        ;
*PET0(C)$Heatgc(C)=    2.439723685        ;
*PET0(C)$oilgc(C)=   1.043578169        ;
*PET0(C)$coalgc(C)=       0.484883817        ;

*PP0(C)$ELEcgc(C)=    1.242060742        ;
*PP0(C)$Gasgc(C)=    0.957191718        ;
*PP0(C)$Heatgc(C)=    2.439723685        ;
*PP0(C)$oilgc(C)=   1.043578169        ;
*PP0(C)$coalgc(C)=       0.484883817        ;

*PC0(C)$ELECgc(C)=    1.242060742        ;
*PC0(C)$Gasgc(C)=    0.957191718        ;
*PC0(C)$Heatgc(C)=    2.439723685        ;
*PC0(C)$oilgc(C)=   1.043578169        ;
*PC0(C)$coalgc(C)=       0.484883817        ;

*PC0(A)$ELECga(A)=        1.242060742        ;
*PC0(A)$Gasga(A)=        0.957191718        ;
*PC0(A)$Heatga(A)=        2.439723685        ;
*PC0(A)$Oilga(A)=        1.043578169        ;
*PC0(A)$Coalga(A)=        0.484883817        ;
*PC0('Coal-a')=        0.484883817        ;

*PMT0(C)$ELECgc(C)=    1.242060742        ;
*PMT0(C)$Gasgc(C)=    0.957191718        ;
*PMT0(C)$Heatgc(C)=    2.439723685        ;
*PMT0(C)$oilgc(C)=   1.043578169        ;
*PMT0(C)$Coalgc(C)=       0.484883817        ;

*PD0(C)$ELECgc(C)=    1.242060742        ;
*PD0(C)$Gasgc(C)=    0.957191718        ;
*PD0(C)$Heatgc(C)=    2.439723685        ;
*PD0(C)$oilgc(C)=   1.043578169        ;
*PD0(C)$coalgc(C)=       0.484883817        ;

*PA0(C)$ELECgc(C)=    1.242060742        ;
*PA0(C)$Gasgc(C)=    0.957191718        ;
*PA0(C)$Heatgc(C)=    2.439723685        ;
*PA0(C)$oilgc(C)=   1.043578169        ;
*PA0(C)$coalgc(C)=       0.484883817        ;

EXR0=1;

XC0(A)$(sum(ACTpp,SAMng(A,ACTpp))>0)=sum(ACT,SAMng(ACT,A))/PC0(A);
QCE0(ENC,A)$(sum(ACTpp,SAMng(A,ACTpp))>0)=SAM(ENC,A)/PA0(ENC);

XAP0(C,A)$(not ENC(C))=SAM(C,A)/PA0(C);

ica(C,A)$(M(C))=XAP0(C,A)/XC0(A);

*display XC0,XAP0,ica;

QVAE0(A)$(sum(ACT,SAM(A,ACT))>0)=XC0(A);
PVAE0(A)$(sum(ACT,SAM(A,ACT))>0)=(sum(F,SAMng(F,A))+sum(C$ELECC(C),SAMng(C,A))+sum(C$ENC(C),SAMng(C,A))+sum(ENC,gtaxrate_o*ghg(ENC,A)))/QVAE0(A);

XAG0(A)$(sum(C$AgriC(C),SAM(C,A))>0)=XC0(A);
PAG0(A)$(sum(C$AgriC(C),SAM(C,A))>0)=sum(C$AgriC(C),SAMng(C,A))/XC0(A);

deltaC(C,A)$(AgriC(C) and SAM(C,A)$AgriC(C)>0)=SAM(C,A)/sum(CP$AgriC(CP),SAM(CP,A));

alphaaAG(A)$(sum(C$AgriC(C),SAM(C,A))>0)=XAG0(A)/prod(C$AgriC(C),XAP0(C,A)**deltaC(C,A));

parameter PAG1(A);

PAG1(A)$(sum(C$AgriC(C),SAM(C,A))>0)=(1/alphaaAG(A))*prod(C$(AgriC(C) and SAM(C,A)$AgriC(C)>0),(PA0(C)/deltaC(C,A))**deltaC(C,A));
display PAG0,PAG1;

parameter XAP1(C,A);

XAP1(C,A)$(Agric(C) and SAM(C,A)$AgriC(C)>0)=deltaC(C,A)*(PAG0(A)*XAG0(A))/PA0(C);
display XAP0,XAP1;


*display QVAE0, PVAE0;

QGE0(GC,C,A)=ghg(C,A);
thetaE(GC,C,A)$(QCE0(C,A)>0)=QGE0(GC,C,A)/QCE0(C,A);
*display QGE0,thetaE;

QINTG0(GC,A)$(ghg('process',A)>0)=ghg('process',A);
thetaP(GC,A)$(XC0(A)>0 and ghg('process',A)>0)=QINTG0(GC,A)/XC0(A);
*display QINTG0,thetaP;

PNEG0(C,A)$(ENC(C) and (sum(ACT,SAM(A,ACT))>0))=PA0(C)+sum(GC,thetaE(GC,C,A)*gtaxrate_o);
QNEG0(C,A)$(ENC(C) and (sum(ACT,SAM(A,ACT))>0))=(QCE0(C,A)*PA0(C)+sum(GC,gtaxrate_o*QGE0(GC,C,A)))/PNEG0(C,A);

*display PNEG0,QNEG0;

parameter
KC_maxind(C,A)
Lmax(A)
KC_XLFL(C,A)
deltaXLFL(A)
KC_XFL(C,A)
KET(C)
KDM(C);

Lmax(A)=smax(C$LfuelA(A,C),SAM(C,A));
display Lmax;
KC_maxind(C,A)$(LfuelA(A,C) and SAM(C,A)=Lmax(A))=1;
display KC_maxind;
*KC_XLFL(C,A)$((Lfuel(C) and not Roilac_S(C)) and (Lfuel_single(A) ne 0) and (SAM(C,A)>0))= ((PNEG0('ROil-c',A)/PNEG0(C,A))**(1-sigmaaXLFL(A))*(SAM(C,A)/SAM('ROil-c',A))*(AEEI(C,A)/AEEI('ROil-c',A))**(1-sigmaaXLFL(A)))**(1/sigmaaXLFL(A));
*KC_XLFL(C,A)$((LfuelA(A,C) and not Roilac_S(C)) and (Lfuel_single(A) ne 0))= ((PNEG0('ROil-c',A)/PNEG0(C,A))**(1-sigmaaXLFL(A))*(SAM(C,A)/SAM('ROil-c',A))*(AEEI(C,A)/AEEI('ROil-c',A))**(1-sigmaaXLFL(A)))**(1/sigmaaXLFL(A));
KC_XLFL(C,A)$((LfuelA(A,C) and not (KC_maxind(C,A)=1)) and (Lfuel_single(A) ne 0))= ((sum(CP$(KC_maxind(CP,A)=1),PNEG0(CP,A))/PNEG0(C,A))**(1-sigmaaXLFL(A))*(SAM(C,A)/sum(CP$(KC_maxind(CP,A)=1),SAM(CP,A)))*(AEEI(C,A)/sum(CP$(KC_maxind(CP,A)=1),AEEI(CP,A)))**(1-sigmaaXLFL(A)))**(1/sigmaaXLFL(A));

*deltaC('Roil-c',A)$(SAM('Roil-c',A) and (Lfuel_single(A) ne 0))=1/(1+sum(C$(Lfuel(C)and(sam(C,A)>0)),KC_XLFL(C,A)));
deltaC(C,A)$((KC_maxind(C,A)=1) and (Lfuel_single(A) ne 0))=1/(1+sum(CP$(Lfuel(CP)and(sam(CP,A)>0) and (KC_maxind(CP,A) ne 1)),KC_XLFL(CP,A)));

*deltaC(C,A)$((LfuelA(A,C) and not Roilac_s(C)) and(Lfuel_single(A) ne 0))=KC_XLFL(C,A)*deltaC('Roil-c',A);
deltaC(C,A)$((LfuelA(A,C) and not (KC_maxind(C,A)=1)) and(Lfuel_single(A) ne 0))=KC_XLFL(C,A)*sum(CP$(KC_maxind(CP,A)=1),deltaC(CP,A));

*deltaF(K,A)=KF_HKTE(K,A)*deltaC('oil-c',A);

deltaC(C,A)$(LfuelA(A,C) and Lfuel_single(A)=0)=1;
display KC_XLFL;
display deltaC;

XLFL0(A)$(Lfuel_single(A)=1)=(sum(C$(Lfuel(C) and (sam(C,A)>0)),deltaC(C,A)*(AEEI(C,A)*QNEG0(C,A))**(-rhoaXLFL(A))))**(-1/rhoaXLFL(A));
PLFL0(A)$(Lfuel_single(A)=1)=(sum(C$Lfuel(C),SAMng(C,A))+sum(C$Lfuel(C),gtaxrate_o*ghg(C,A)))/XLFL0(A);

XLFL0(A)$(Lfuel_single(A)=0)=sum(C$Lfuel(C),QNEG0(C,A));
PLFL0(A)$(Lfuel_single(A)=0)=(sum(C$Lfuel(C),SAMng(C,A))+sum(C$Lfuel(C),gtaxrate_o*ghg(C,A)))/XLFL0(A);

*display XLFL0,PLFL0;

KC_XFL(C,A)$(Sfuel(C) and (sam(C,A)>0))=
((PLFL0(A)/PNEG0(C,A))**(1-sigmaaXFL(A))*((SAM(C,A)+gtaxrate_o*ghg(C,A))/sum(CP$LFuel(CP),SAM(CP,A)+gtaxrate_o*ghg(CP,A)))*(1/AEEI(C,A))**(1-sigmaaXFL(A)))**(1/sigmaaXFL(A));
deltaXLFL(A)=1/(1+sum(C$(sfuel(C)and(sam(C,A)>0)),KC_XFL(C,A)));
deltaC(C,A)$(Sfuel(C) and (sam(C,A)>0))=KC_XFL(C,A)*deltaXLFL(A);

*display deltaC,deltaXLFL;

XFL0(A)$(sum (C$sfuel(C), sam(C,A))>0)=
(sum(C$(sfuel(C) and (sam(C,A)>0)),deltaC(C,A)*(QNEG0(C,A)*AEEI(C,A))**(-rhoaXFL(A)))
+(1-sum(C$(sfuel(C) and (sam(C,A)>0)),deltaC(C,A)))*XLFL0(A)**(-rhoaXFL(A)))**(-1/rhoaXFL(A));

PFL0(A)$(sum (C$sfuel(C), sam(C,A))>0)=
(sum(C$ENC(C),SAMng(C,A))+sum(ENC,gtaxrate_o*ghg(ENC,A)))/XFL0(A);

XFL0(A)$(sum (C$sfuel(C), sam(C,A))=0)=XLFL0(A);
PFL0(A)$(sum (C$sfuel(C), sam(C,A))=0)=
(sum(C$ENC(C),SAMng(C,A))+sum(ENC,gtaxrate_o*ghg(ENC,A)))/XFL0(A);

*display XFL0, PFL0;

parameter
KC_XEP(C,A)
deltaXFL(A)
XEP0(A)
PEP0(A);

KC_XEP(C,A)$(ELECC(C) and (SAM(C,A)>0))=
(
(PFL0(A)/PA0(C))**(1-sigmaaXEP(A))*
(
SAM(C,A)/
sum(CP$ENC(CP),SAMng(CP,A))+sum(ENC,gtaxrate_o*ghg(ENC,A)))
)**(1/sigmaaXEP(A));

deltaXFL(A)=1/(1+sum(C$(ELECC(C) and sam(C,A)>0),KC_XEP(C,A)));
deltaC(C,A)$(ELECC(C) and (SAM(C,A)>0))=KC_XEP(C,A)*deltaXFL(A);

*display deltaXFL,deltaC;


XEP0(A)=
(sum(C$(ELECC(C) and (sam(C,A)>0)),deltaC(C,A)*XAP0(C,A)**(-rhoaXEP(A)))
+deltaXFL(A)*XFL0(A)**(-rhoaXEP(A)))**(-1/rhoaXEP(A));

PEP0(A)=(sum(C$ELECC(C),SAMng(C,A))+sum(C$ENC(C),SAMng(C,A))+sum(ENC,gtaxrate_o*ghg(ENC,A)))/XEP0(A);

*display XEP0,PEP0;

parameter
KK_HKTE(K,A)
deltaXEP(A);

KK_HKTE(K,A)$(SAM(K,A)>0)=((PEP0(A)/R0(K))**(1-sigmaaHKTE(A))*(SAM(K,A)/(sum(C$ELECC(C),SAMng(C,A))+sum(C$ENC(C),SAMng(C,A))+sum(ENC,gtaxrate_o*ghg(ENC,A))))*(lambdak*lambdaka(A))**(1-sigmaaHKTE(A)))**(1/sigmaaHKTE(A));
deltaXEP(A)=1/(1+sum(K,KK_HKTE(K,A)));
deltaF(K,A)$(SAM(K,A)>0)=KK_HKTE(K,A)*deltaXEP(A);

*display deltaXEP,deltaF;

HKTE0(A)$(sum(K,SAM(K,A))>0)=(sum(K,deltaF(K,A)*(lambdak*lambdaka(A)*KD0(K,A))**(-rhoaHKTE(A)))+deltaXEP(A)*XEP0(A)**(-rhoaHKTE(A)))**(-1/rhoaHKTE(A));
HKTE0(A)$(sum(K,SAM(K,A))=0)=XEP0(A);
PHKTE0(A)=(sum(K,SAMng(K,A))+sum(C$ELECC(C),SAMng(C,A))+sum(C$ENC(C),SAMng(C,A))+sum(ENC,gtaxrate_o*ghg(ENC,A)))/HKTE0(A);

*display HKTE0,PHKTE0;

parameter
KL_VAE(L,A)
deltaHKTE(A);

KL_VAE(L,A)$(sum(LP,sam(LP,A))>0)=((PHKTE0(A)/W0(L))**(1-sigmaaVAE(A))*(SAM(L,A)/(sum(K,SAMng(K,A))+sum(C$ELECC(C),SAMng(C,A))+sum(C$ENC(C),SAMng(C,A))+sum(ENC,gtaxrate_o*ghg(ENC,A))))*(lambdat*lambda(A))**(1-sigmaaVAE(A)))**(1/sigmaaVAE(A));
deltaHKTE(A)$(sum(L,sam(L,A))>0)=1/(1+sum(LP,KL_VAE(LP,A)));
deltaF(L,A)$(sum(LP,sam(LP,A))>0)=KL_VAE(L,A)*deltaHKTE(A);
deltaHKTE(A)$(sum(L,sam(L,A))=0)=1;

** when sum(L,sam(L,A))=0 => deltaF(L,A)=0 and deltaHKTE(A)=1, this formula becomes alphaaVAE(A)=QVAE0(A)/HKTE0(A);
alphaaVAE(A)$(sum(ACT,SAM(A,ACT))>0)=QVAE0(A)/(sum(L,deltaF(L,A)*(lambdat*lambda(A)*LD0(L,A))**(-rhoaVAE(A)))+deltaHKTE(A)*HKTE0(A)**(-rhoaVAE(A)))**(-1/rhoaVAE(A));


theta(A,C)$((sum(ACT,SAM(A,ACT))>0) and (sum(AP,SAM(AP,C))>0))=(SAM(A,C)/PP0(C))/XC0(A);

*display theta;
** tax parameters

ta_in(A)$((sum(ACT,SAM(A,ACT))>0))=SAMng('Ptaxin',A)/sum(ACT,samng(ACT,A));
ta_ex(A)$((sum(ACT,SAM(A,ACT))>0))=SAMng('Ptaxetc',A)/sum(ACT,samng(ACT,A));

te(C)$(SAM(C,'ROW') ne 0)=0;
tm(C)$(SAM('ROW',C) ne 0)=SAM('Tarrif',C)/SAM('ROW',C);

*display ta_in, ta_ex, te,tm;

** Trade related parameters
*(i) world price
pwm(C)$(SAM('ROW',C) ne 0)=PMT0(C)/((1+tm(C))*EXR0);
pwe(C)$(SAM(C,'ROW') ne 0)=PET0(C)/((1-te(C))*EXR0);

*display pwm,pwe;

*(ii) CET coefficient**

ES0(C)$(SAM(C,'ROW') ne 0)=SAM(C,'ROW')/PET0(C);
XD0(C)$(sum(A,SAM(A,C))>0)=(sum(A,SAM(A,C))-SAM(C,'ROW'))/PD0(C);

KET(C)$(SAM(C,'ROW') ne 0 and (sum(A,SAM(A,C))>0))=((ES0(C)/XD0(C))*((PET0(C)/PD0(C))**sigmat(C)))**(1/sigmat(C));
deltat(C)$(SAM(C,'ROW') ne 0 and (sum(A,SAM(A,C))>0))=KET(C)/(1+KET(C));

XP0(C)$((sum(A,SAM(A,C))>0))=(PET0(C)*ES0(C)+XD0(C)*PD0(C))/PP0(C);

alphat(C)$(SAM(C,'ROW') ne 0)=XP0(C)/((deltat(C)*(ES0(C)**(rhot(C)))+(1-deltat(C))*(XD0(C))**(rhot(C)))**(1/rhot(C)));

*display ES0,XD0;
*display deltat,alphat;

**(iii) Armington Coefficient**
XMT0(C)$(SAM('ROW',C) ne 0)=(SAM('ROW',C)+SAM('Tarrif',C))/PMT0(C);
XA0(C)=(sum(ACT,SAM(ACT,C))-SAM(C,'ROW'))/PA0(C);
KDM(C)$((SAM('ROW',C) ne 0) and (sum(A,SAM(A,C))>0))=((XD0(C)/XMT0(C))*((PD0(C)/PMT0(C))**sigmaq(C)))**(1/sigmaq(C));
deltaq(C)$((SAM('ROW',C) ne 0)and (sum(A,SAM(A,C))>0))=KDM(C)/(1+KDM(C));

alphaq(C)$((SAM('ROW',C) ne 0)and (sum(A,SAM(A,C))>0))=XA0(C)/((deltaq(C)*(XD0(C)**(-rhoq(C)))+(1-deltaq(C))*(XMT0(C))**(-rhoq(C)))**(-1/rhoq(C)));

*display XMT0,XA0;
*display deltaq,alphaq;

cwrt(C)=sum(H,(SAM(C,H)/PA0(C)))/sum((CP,H),SAM(CP,H));
cpi_o=sum(C,cwrt(C)*PA0(C));

**display deltat, deltaq, alphat, alphaq, cwrt, cpi;

tm_in=SAM('Ptaxin','ROW')/(sum(C,SAM('ROW',C))+sum(C,SAM('Tarrif',C)));
FSAV0=SAM('S-I','ROW');
* FSAD is exogenous. It will be fit to forcasted trade balance growth rate
FSAD=1;


TR0(H)=SAM(H,'Gov');
* Oldpop: 2010 65+ popluation (Census, not projection) in thousand 5424.667 (Kosis)
Oldpop=5424.667;
tr0_per(H)=TR0(H)/(Oldpop*cpi_o);

shr(F,H)=SAM(H,F)/sum(HP,SAM(HP,F));
shrpro(A,H)=1;

Ls0(L)=sum(H,SAM(H,L))/W0(L);
*Ks0(K)=sum(H,SAM(H,K))/R0(K);
LY0(H)=sum(L,SAM(H,L));
*KY0(H)=sum(K,SAM(H,K));
KY0(H)=sum(K,shr(K,H)*Ks0(K)*R0(K));
ResinC0=sum(H,SAM(H,'NRES'));

EY0(H)=sum(A$LinkA(A),
shrpro(A,H)*(
PC0(A)*(1-ta_in(A)-ta_ex(A))*XC0(A)
-PC0(A)*alpha_nres(A)*XC0(A)
-sum(C$(XAPA(C,A) and not (ELECCA(A,C) or FuelA(A,C))),PA0(C)*XAP0(C,A))
-sum(C$ELECCA(A,C),PA0(C)*XAP0(C,A))
-sum(C$FuelA(A,C),PNEG0(C,A)*QNEG0(C,A))
-sum(K,R0(K)*KD0(K,A))
-sum(L,W0(L)*LD0(L,A))
)
)
-sum(A$(LinkA(A) and ghg('process',A)>0), shrpro(A,H)*sum(GC,QINTG0(GC,A)*gtaxrate_o*cpi_o));


YH0(H)=TR0(H)+LY0(H)+KY0(H)+EY0(H)+ResinC0;
TINS0=sum(H,SAM('Ytax',H))/(sum(H,YH0(H))-delta*(sum(K,Ks0(K))));
TINSR0=(sum(H,YH0(H)*TINS0)-TINS0*delta*(sum(K,Ks0(K)))-crevtax*TCREV0)/(sum(H,YH0(H))-delta*(sum(K,Ks0(K))));
YD0(H)=(1-TINSR0)*(YH0(H)-sum(K,shr(K,H)*delta*Ks0(K)));
tc_in=sum(H,SAM('Ptaxin',H))/sum((C,H),SAM(C,H));
XAC0(C,H)=SAM(C,H)/PA0(C);
SH0(H)=SAM('S-I',H);


mu(C,H)=XAC0(C,H)*PA0(C)*(1+tc_in)/YD0(H);
mus(H)=(SH0(H)-sum(K,shr(K,H)*delta*Ks0(K)))/YD0(H);
MPS0(H)=mus(H);

Lw0(L)=Ls0(L)/(((1-TINSR0)*W0(L)/cpi_o)**epsilon_L(L));

**Investment
XAF0('S-I',C)=SAM(C, 'S-I')/PA0(C);
qinv_o(C)=SAM(C, 'S-I')/PA0(C);
IVAD0=sum(C,XAF0('S-I',C))/sum(CP,qinv_o(CP));
tiv_in=SAM('Ptaxin','S-I')/sum(C,SAM(C, 'S-I'));
ResinI0=SAM('S-I','NRES');
*display QINV0,qinv_o,IVAD0,tiv_in,ResinI0;


** Government
qg0(C)=SAM(C,'Gov')/PA0(C);
sg0=SAM('S-I','Gov');
XAF0('Gov',C)=qg0(C)*cpi_o;
SG0=sg0*cpi_o;
tg_in=SAM('Ptaxin','Gov')/sum(C,PA0(C)*XAF0('Gov',C));
qgr0(C)=PA0(C)*(1+tg_in)*qg0(C)/sum(CP,PA0(CP)*XA0(CP));
YG0=SAM('Gov','Ptaxin')+SAM('Gov','Ptaxetc')+SAM('Gov','Tarrif')+SAM('Gov','Ytax');

*display qg0,sg0,YG0,tg_in;

**Warlas dummy initial value


Warlas0=sum(C$(sam(C,'S-I') ne 0),PA0(C)*(1+tiv_in)*XAF0('S-I',C))-sum(H,SH0(H))-SG0-FSAV0*EXR0-ResinI0;

*Values receive from bottom up;
XC_bottom(A)$(LinkA(A))=XC0(A);
XAP_bottom(C,A)=XAP0(C,A);
QNEG_bottom(C,A)=QNEG0(C,A);
KD_bottom(K,A)=KD0(K,A);
LD_bottom(L,A)=LD0(L,A);
ZD_bottom(A)=ZD0(A);

parameter
q_outj0(j);

q_outj0(j)=sum(c,theta_cj(c,j)*xp0(c));
theta_tc_j(tc,j)$(q_outj0(j)>0)=Agricost(tc,j)/q_outj0(j);

display xp0,q_outj0;

parameter
tc_recover(tc,j);


set
TransitA(A)
/ELEC-a,HEAT-a/
;


Model
Agri 53 ind model
* CAUTION!!!! ADD mcp conditions to ALL ADDED equations.
/
ImPr.XMT
ExPr.ES
AspPr.XA
AspPrni.XA
AspPrnd.XA
ProdPr.XD
ProdPrne.XD
ProdPrnd.XD

ComPr.XP
ActR.XC
ActRp.XC
ActRna.XC
ActRpna.XC

ActR_Link.XC
ActRp_Link.XC
ActRna_Link.XC
ActRpna_Link.XC


VAEPr0
VAEPr1
VAEPr2
VAEPr3
VAGPr

HKTEPr0
HKTEPr1
HKTEPr2
HKTEPr3
XEPr0
XEPr1
XEPr2
XEPr3
XFLPr0
XFLPr1
XFLPr2
XFLPr3
XLFLPr2
XLFLPr3
NEGPr.QNEG
NEGPrco.QNEG
NEGPr_Link.QNEG
NEGPrco_Link.QNEG



Norm
CPIfix
Labsup

QVAED
XAGD
HKTED0
HKTED1
XEPD0
XEPD1
XFLD0
XFLD1
XLFLD0
XLFLD1

INTDM
INTDAG0
INTDAG1
INTDE1
INTDE2
INTDE3
INTGD

INTDM_Link
INTDAG0_Link
INTDAG1_Link
INTDE1_Link
INTDE2_Link
INTDE3_Link
INTGD_Link


LDA1
LDA2
LDA3

LDA1_Link
LDA2_Link
LDA3_Link

KDA1
KDA2
KDA3

KDA1_Link
KDA2_Link
KDA3_Link
ZD_Link

NEGDL2.PNEG
NEGDL3.PNEG

NEGDL2_Link.PNEG
NEGDL3_Link.PNEG


NEGDS1.PNEG
NEGDS2.PNEG
NEGDS3.PNEG
NEGDS1_Link.PNEG
NEGDS2_Link.PNEG
NEGDS3_Link.PNEG

NELQCED
NELQCED_Link

GD
GD_Link


ActDC.PC

XDD.PD
XDDni.PD
XMTD.PMT
XMTDnd.PMT

XDS.PP
XDSne.PP
ESS.PET
ESSnd.PET


InvD
HouseLY
HouseKY
HouseEY
HouseY
HouseYD

HouseD
Hsave
Saver


GovE
Tras
Ytax

ForS
GovI


LabM.W
CapM.R


ComMENCN.PA
ComMENCN_Link.PA
ComMENC.PA


CREVE
CREVP
TCREVsum

InvM
CAB
GovB


ResC
ResI/;

PC.L(A)        =        PC0(A)        ;
XC.L(A)        =        XC0(A)        ;
XMT.L(C)        =        XMT0(C)        ;
PMT.L(C)        =        PMT0(C)        ;
XD.L(C)        =        XD0(C)        ;
PD.L(C)        =        PD0(C)        ;
XA.L(C)        =        XA0(C)        ;
PA.L(C)        =        PA0(C)        ;
ES.L(C)        =        ES0(C)        ;
PET.L(C)        =        PET0(C)        ;
XP.L(C)        =        XP0(C)        ;
PP.L(C)        =        PP0(C)        ;
QNEG.L(C,A)        =        QNEG0(C,A)        ;
PNEG.L(C,A)        =        PNEG0(C,A)        ;
PVAE.L(A)        =        PVAE0(A)        ;
QVAE.L(A)        =        QVAE0(A)        ;
PAG.L(A)=PAG0(A);
XAG.L(A)=XAG0(A);
HKTE.L(A)=HKTE0(A);
PHKTE.L(A)=PHKTE0(A);
XEP.L(A)=XEP0(A);
PEP.L(A)=PEP0(A);
XFL.L(A)=XFL0(A);
PFL.L(A)=PFL0(A);
XLFL.L(A)=XLFL0(A);
PLFL.L(A)=PLFL0(A);
XAP.L(C,A)        =        XAP0(C,A)        ;
QINTG.L(GC,A)        =        QINTG0(GC,A)        ;
R.L(K)        =        R0(K)        ;
W.L(L)        =        W0(L)        ;
rent.L          =        rent0;
LD.L(L,A)        =        LD0(L,A)        ;
KD.L(K,A)        =        KD0(K,A)        ;
ZD.L(A)          = ZD0(A);
Ks.Fx(K)        =        Ks0(K)        ;
Ls.L(L)        =        Ls0(L)        ;
Zs.Fx       =        Zs0;
QCE.L(C,A)        =        QCE0(C,A)        ;
QGE.L(GC,C,A)        =        QGE0(GC,C,A)        ;
EXR.L        =        EXR0        ;
YG.L        =        YG0        ;
TR.L(H)        =        TR0(H)        ;
XAF.L(FD,C)        =        XAF0(FD,C)        ;
SG.L        =        SG0        ;
MPS.L(H)        =        MPS0(H)        ;
LY.L(H)        =        LY0(H)        ;
KY.L(H)        =        KY0(H)        ;
EY.L(H)        =        EY0(H)        ;
YH.L(H)        =        YH0(H)        ;
YD.L(H)        =        YD0(H)        ;
XAC.L(C,H)        =        XAC0(C,H)        ;
SH.L(H)        =        SH0(H)        ;
TINSR.L        =        TINSR0        ;
FSAV.L        =        FSAV0        ;
IVAD.L        =        IVAD0        ;
Warlas.L        =        Warlas0        ;
CREV.L(A)        =        CREV0(A)        ;
TCREV.L        =        TCREV0        ;
ResinC.L        =        ResinC0        ;
ResinI.L        =        ResinI0        ;
CPI.L = cpi_o;

Agri.HOLDFIXED=1;

SET ACGDP GDP Items
/GDPMP1  GDP Aggregate Demand_market price
CON_P private consumption
CON_G government consumption
INV   Investment
EXP   EXPORT
IMP   IMPORT
NITAX Indirect tax
NRES  Net Residue
GDPFP GDP Factor Price and Residue
GDPMP2 GDP Aggregate income_market price
GAP GDP_AD-GDP_Y/
ACGDP1(ACGDP)
/CON_P private consumption
CON_G government consumption
INV   Investment
EXP   EXPORT
IMP   IMPORT/

parameters
lg_ag
lg_rcm
lg_fm
lg_man
lg_soc
lg_serv
lg_energy
lg_other
lp_adj
;

lg_ag=  -0.150;
lg_man=  0.0500;
lg_rcm=  -0.030;
lg_fm=   0.0775;
lg_soc= -0.0500;
lg_serv= 0.0400;
lg_other=-0.13;
lg_energy=-0.13;
lp_adj=0.01;
parameters
thetaH(C,H)
;
thetaH(C,'household')$(XAC0(C,'household')>0)=ghg(C,'household')/XAC0(C,'household');
*display thetaH;

parameters
aeg_roil(t)
/0 0/
*/0*15 0.02
*16*25 0.1
*/
aeg_coal(t)
/0 0/

*/0*10 0.0
*11*25 -0.2
*/

aeg_gas(t)
/0 0/

*/0*15 -0.05
*16*25 -0.3
*/

aeg_elec(t)
/0 0/

*/0*15 0.15
*16*25 0.0
*/

aeg_heat(t)
/0 0/

*/0*25 0/
;
parameters
TFP_roil(t)
/0 0/

*/0*10 -0.01
*11*25 -0.02
*/
TFP_coal(t)
/0 0/

*/0*10 0
*11*25 0.04
*/
TFP_gas(t)
/0 0/

*/0*10 0.02
*11*25 0.03
*/
;




parameters
PCREP(A,t)
XCREP(A,t)
XMTREP(C,t)
PMTREP(C,t)
XDREP(C,t)
PDREP(C,t)
XAREP(C,t)
PAREP(C,t)
ESREP(C,t)
PETREP(C,t)
XPREP(C,t)
PPREP(C,t)
QNEGREP(C,A,t)
PNEGREP(C,A,t)
PVAEREP(A,t)
QVAEREP(A,t)
PAGREP(A,t)
XAGREP(A,t)
PHKTEREP(A,t)
HKTEREP(A,t)
PEPREP(A,t)
XEPREP(A,t)
PFLREP(A,t)
XFLREP(A,t)
PLFLREP(A,t)
XLFLREP(A,t)
XAPREP(C,A,t)
QINTGREP(GC,A,t)
RREP(K,t)
WREP(L,t)
rentrep(t)
LDREP(L,A,t)
KDREP(K,A,t)
ZDREP(A,t)
KsREP(K,t)
LsREP(L,t)
ZsREP(t)
QCEREP(C,A,t)
QGEREP(GC,C,A,t)
EXRREP(t)
YGREP(t)
TRREP(H,t)
XAFREP(FD,C,t)
SGREP(t)
*QINVREP(C,t)
MPSREP(H,t)
LYREP(H,t)
KYREP(H,t)
EYREP(H,t)
YHREP(H,t)
YDREP(H,t)
XACREP(C,H,t)
SHREP(H,t)
TINSRREP(t)
FSAVREP(t)
IVADREP(t)
WarlasREP(t)
CREVREP(A,t)
TCREVREP(t)
ResinCREP(t)
ResinIREP(t)
BALCHK (t,ACT)
GDPREP(*,t)
SAMREP(t,ACT,ACTPP)
GCREP(t,GC,ACT,ACTP)
DGCREP(t,GC,A)
VAREP(A,t)
TGC(t,GC)

SAMDIFF(*,ACT,ACTPP)
DiFFT
gtaxrep(GC,t)
CPIREP(t)
;






set TO(t) /0/;
parameter GDP1(t),ygrow(t);

parameter
P_out(LinkC)
P_in(C)
Pfuel_in(C,A)
W_in(L)
R_in(K)
Demand_out(LinkC)
Demand_j(j)
P_out_j(j);

parameter
theta_jc(j,c)
;
theta_jc(j,c)=0;
theta_jc(j,c)$map_jc(j,c)=1;

parameter
theta_ja(j,a)
;
theta_ja(j,a)=0;
theta_ja(j,a)$map_ja(j,a)=1;

parameter

theta_acio(a,c,io)
theta_afio(a,f,io)
;

theta_acio(a,c,io)=0;
theta_acio(a,c,io)=theta_ioc(io,c);
theta_afio(a,f,io)=0;
theta_afio(a,f,io)=theta_iof(io,f);


display theta_jc,theta_ja,theta_acio,theta_afio;
parameter
pc_inputc(c)
pc_inputf(f)
pc_inputins(ins)
p_outj(j)
p_inioj(j,io)
p_inioa(a,io)
q_outj(j);

parameter
P_c(C,A)
Pio_c(io,A)
Pio_w(io,A)
Pio_r(io,A);

parameter
Pio_cj(io,j)
Pio_wj(io,j)
Pio_rj(io,j);

parameter
Ptc_j(tc,j);

parameter
tc_recover_c(tc,c)
tc_recover_j(tc,j);

parameter

iocost(io,j)
inputcostc(c,j)
inputcostf(f,j)
inputcostins(ins,j)
inputcostc_a(c,a)
inputcostf_a(f,a)
inputcostins_a(ins,a)
;

*******************************************************************************
*******************************************************************************
*==============================================================================*
*                      Agricultural bottom-up model of Korea                   *
*                               ver 1.                                         *
*                              2016. 1                                         *
*==============================================================================*


*===============================================================================
* 1. Sets, Alias
*===============================================================================
$ontext
       IO               CGE
1 벼                 7 Rice
2 맥류 및 잡곡       8 Barley
3 콩류               9 Bean
4 감자류            10 Potato
5 채소              11 Vegi
6 과실              12 Fruit
7 약용작물          14 MissCrop
8 기타 식용작물     14 MissCrop
9 잎담배            14 MissCrop
10 화훼작물         13 Flower
11 천연고무         14 MissCrop
12 종자 및 묘목     14 MissCrop
13 기타 비식용작물  14 MissCrop
14 낙농             15 Dairy
15 육우             16 Meat
16 양돈             17 Pork
17 가금             18 Poultry
18 기타 축산        19 MissLstock
35 도축육            6 NEINT
36 가금육            6 NEINT
42 정곡              7 Rice
$offtext


SETS
CROP(J) crops
/ Rice,Barley,Bean,Potato,Vegi,Fruit,Flower,MissCrop /

ANIMAL(J) animals
/ Dairy,Meat,Pork,Poultry,MissLstock /
;

SETS
I region / RGG, RGW, RCB, RCN, RJB, RJN, RKB, RKN, RJJ/
;

$ontext
종자비, 비료비, 농약비, 사료비**, 가축비**, 방역치료비**,
에너지, 수리 및 공공서비스, 소농구비, 대농구비, 영농시설비, 기타 재료비,
기타서비스, 고정자본사용, 피용자보수, 영업잉여, 생산물세 및 잔폐물
$offtext

SETS
NONE(TC) nonenergy intermediates
/ SEED, FERT, PEST, FEED, CUB, MED, WATER, SMACH, LMACH, FACIL,
OINPUT, OSERV,  KCOST, LCOST, SUR/

CROPC(TC) crop cost components
/ SEED, FERT, PEST, ENERGY, WATER, SMACH, LMACH, FACIL,
OINPUT, OSERV, KCOST, LCOST, SUR/

ANIMALC(TC) animal cost components
/ FEED, CUB, MED, ENERGY, WATER, SMACH, LMACH, FACIL,
OINPUT, OSERV, KCOST, LCOST, SUR/
;

SETS
APL acreage herds and price
/ ACRE, HERD, P /
;

$ontext
ACRE=ha, HERD=두 수
$offtext


Alias
         (J, J2), (CROP, CROP2),(ANIMAL, ANIMAL2), (I, I2), (TC, TC2),
         (NONE, NONE2), (CROPC, CROPC2), (ANIMALC, ANIMALC2), (APL, APL2);
;

*===============================================================================
* 2. Data and Calibration
*===============================================================================
TABLE  DATA(I,*,J) Data
$ondelim
$include DataAll_160115.csv
$offdelim;

PARAMETERS
PO0(I,J) output price
PI0(I, TC) input price
X0(I,J) quantity M won that will be rescaled to B won
ACRE(I,J) acreage of each product ha
HERD(I,J) herd of animal
C0(I,TC,J) average cost components
AC0(I,J) average cost
CCOST0(I,TC,J) cost coefficient
NETPRICE(I,J) net price ha
ELAS(J) demand elasticities
LA(I,J) land requirement per unit output
HERDA(I,ANIMAL) number of herds per unit output
TEST(I,J) total cost calculation for testing coding
D0(J) demand of each product at BAU
C_0(TC,J) inputs at BAU
;

PO0(I,J)=DATA(I,"P",J);
PI0(I,TC)=1;
*B Won
X0(I,J)=DATA(I,"Q",J)/1000;
ACRE(I,J)=DATA(I,"ACRE",J);
HERD(I,J)=DATA(I,"HERD",J);
*B Won
C0(I,TC,J)=DATA(I,TC,J)/1000;
AC0(I,CROP)=sum(CROPC, PI0(I,CROPC)*C0(I,CROPC,CROP))/X0(I,CROP);
AC0(I,ANIMAL)=sum(ANIMALC, PI0(I,ANIMALC)*C0(I,ANIMALC,ANIMAL))/X0(I,ANIMAL);
CCOST0(I,TC,J)=C0(I,TC,J)/X0(I,J);
NETPRICE(I,J)=PO0(I,J)-AC0(I,J);
LA(I,J)=ACRE(I,J)/X0(I,J);
HERDA(I,ANIMAL)=HERD(I,ANIMAL)/X0(I,ANIMAL);
TEST(I,J)=sum(TC, DATA(I,TC,J));
D0(J)=sum(I,X0(I,J));
C_0(TC,J)=sum(I, X0(I,J)*CCOST0(I,TC,J));

* demand elasticities: Kwon 2015
ELAS("Rice")=0.322;
ELAS("Barley")=0.322;
ELAS("Bean")=0.322;
ELAS("Potato")=0.440;
ELAS("Vegi")=0.440;
ELAS("Fruit")=0.791;
ELAS("Flower")=1.1;
ELAS("MissCrop")=0.5;
ELAS("Dairy")=0.203;
ELAS("Meat")=.975;
ELAS("Pork")=.800;
ELAS("Poultry")=.700;
ELAS("MissLstock")=1.1;

PARAMETERS
BARA(I) acreage limit;

BARA(I)=sum(J, ACRE(I,J));

display PO0, PI0, X0, ACRE, HERD, AC0, NETPRICE, ELAS, BARA, TEST, D0, C_0;

*$exit

*===============================================================================
* 3. Variables and the Basic Model
*===============================================================================

*=== ordinary model ============================================================

POSITIVE VARIABLES
X(I,J) level of activity;

VARIABLES
Z total profit;

EQUATIONS
OBJF  objective function
LANR(I)  LAND restriction
PMP(I,J)  PMP for all
;

OBJF .. Z =E= SUM((I,J), PO0(I,J)*sum(I2, X(I2,J))*
  (1-(sum(I2, X(I2,J))-2*D0(J))/(2*ELAS(J)*D0(J)))
  -AC0(I,J)*X(I,J)) ;
LANR(I) .. SUM(J, X(I,J)*LA(I,J)) =L= BARA(I) ;
PMP(I,J) .. X(I,J) =L= (1+0.0000001)*X0(I,J);

MODEL SPLAN / OBJF, LANR, PMP /;

OPTION ITERLIM=500000 ;
OPTION RESLIM=10000;

option nlp = conopt ;

X.L(I,J) = X0(I,J);
X.LO(I,J) = 0.01*X0(I,J);

SOLVE SPLAN USING NLP MAXIMIZING Z ;

PARAMETER
DIFF(I,J) differences btw X & X0
MLP(I,J) multipliers
;

DIFF(I,J)$(X0(I,J) NE 0)=100*(X.L(I,J)-X0(I,J))/X0(I,J);
MLP(I,J)= PMP.m(I,J);

display
X0
X.l
Z.L
DIFF
;

*$exit
*===============================================================================
* 4. PMP & Integration
*===============================================================================
PARAMETER
PO(I,J) output price
PI(TC,J) input price
D_A(J) ag demand
wL labor price
wK cost price
AC_BU(I,J) average cost
S_new(J) new supply of each product
C_new(TC,J) new input use

PI_ran random shock for input price
D_ran random shock for demand
;

PARAMETERS
Q(I,J) Q matrix
D(I,J) D matrix
;

Q(I,J)= MLP(I,J)/X0(I,J);

*$exit
VARIABLES
X_BU(I,J) level of regional production
Z_BU total profit
;

POSITIVE VARIABLE X_BU;

EQUATION

OBJF_BU objective function
LANR_BU(I) land constraints
;

OBJF_BU .. Z_BU =E= SUM((I,J), PO(I,J)*sum(I2, X_BU(I2,J))*
  (1-(sum(I2, X_BU(I2,J))-2*D_A(J))/(2*ELAS(J)*D_A(J)))
  - D(I,J)*X_BU(I,J)-.5*Q(I,J)*X_BU(I,J)**2)
;


LANR_BU(I) .. SUM(J, X_BU(I,J)*LA(I,J)) =L= BARA(I) ;

MODEL BU / OBJF_BU, LANR_BU/ ;
BU.workspace = 16;

option nlp = pathnlp ;
*option nlp = EMP;
*option nlp = minos5;
*option nlp = coinipopt ;
*option nlp = conopt;

********************************************************************************
********************************************************************************

********************************************************************************
*          initialize BU variables for the 1st run of TD model
********************************************************************************
C_new(TC,J)=C_0(TC,J);
S_new(J)=D0(J);
********************************************************************************


Loop (t,
SOLVE Agri Using MCP;
*)
display XC.L;
PCREP(A,t)        =        PC.L(A)        ;
XCREP(A,t)        =        XC.L(A)        ;
XMTREP(C,t)        =        XMT.L(C)        ;
PMTREP(C,t)        =        PMT.L(C)        ;
XDREP(C,t)        =        XD.L(C)        ;
PDREP(C,t)        =        PD.L(C)        ;
XAREP(C,t)        =        XA.L(C)        ;
PAREP(C,t)        =        PA.L(C)        ;
ESREP(C,t)        =        ES.L(C)        ;
PETREP(C,t)        =        PET.L(C)        ;
XPREP(C,t)        =        XP.L(C)        ;
PPREP(C,t)        =        PP.L(C)        ;
QNEGREP(C,A,t)        =        QNEG.L(C,A)        ;
PNEGREP(C,A,t)        =        PNEG.L(C,A)        ;
PVAEREP(A,t)        =        PVAE.L(A)        ;
QVAEREP(A,t)        =        QVAE.L(A)        ;
PAGREP(A,t)=PAG.L(A);
XAGREP(A,t)=XAG.L(A);
PHKTEREP(A,t)=PHKTE.L(A);
HKTEREP(A,t)=HKTE.L(A);
PEPREP(A,t)=PEP.L(A);
XEPREP(A,t)=XEP.L(A);
PFLREP(A,t)=PFL.L(A);
XFLREP(A,t)=XFL.L(A);
PLFLREP(A,t)=PLFL.L(A);
XLFLREP(A,t)=XLFL.L(A);
XAPREP(C,A,t)        =        XAP.L(C,A)        ;
QINTGREP(GC,A,t)        =        QINTG.L(GC,A)        ;
RREP(K,t)        =        R.L(K)        ;
WREP(L,t)        =        W.L(L)        ;
rentrep(t)       =        rent.L;
LDREP(L,A,t)        =        LD.L(L,A)        ;
KDREP(K,A,t)        =        KD.L(K,A)        ;
ZDREP(A,t)          =        ZD.L(A);
KsREP(K,t)        =        Ks.L(K)        ;
LsREP(L,t)        =        Ls.L(L)        ;
ZsREP(t)          =        Zs.L;
QCEREP(C,A,t)        =        QCE.L(C,A)        ;
QGEREP(GC,C,A,t)        =        QGE.L(GC,C,A)        ;
EXRREP(t)        =        EXR.L        ;
YGREP(t)        =        YG.L        ;
TRREP(H,t)        =        TR.L(H)        ;
XAFREP(FD,C,t)        =        XAF.L(FD,C)        ;
SGREP(t)        =        SG.L        ;
MPSREP(H,t)        =        MPS.L(H)        ;
LYREP(H,t)        =        LY.L(H)        ;
KYREP(H,t)        =        KY.L(H);
EYREP(H,t)        =        EY.L(H);
YHREP(H,t)        =        YH.L(H)        ;
YDREP(H,t)        =        YD.L(H)        ;
XACREP(C,H,t)        =        XAC.L(C,H)        ;
SHREP(H,t)        =        SH.L(H)        ;
TINSRREP(t)        =        TINSR.L        ;
FSAVREP(t)        =        FSAV.L        ;
IVADREP(t)        =        IVAD.L        ;
WarlasREP(t)        =        Warlas.L        ;
CREVREP(A,t)        =        CREV.L(A)        ;
TCREVREP(t)        =        TCREV.L        ;
ResinCREP(t)        =        ResinC.L        ;
ResinIREP(t)        =        ResinI.L        ;
CPIREP(t)           = CPI.L;
gtaxrep(GC,t)=gtax(GC);

SAMREP(t,ENCN,A)=XAP.L(ENCN,A)*PA.L(ENCN);
SAMREP(t,ENC,A)=QCE.L(ENC,A)*PA.L(ENC);
SAMREP(t,K,A)=KD.L(K,A)*R.L(K);
SAMREP(t,L,A)=LD.L(L,A)*W.L(L);
SAMREP(t,'NRES',A)=alpha_nres(A)*XC.L(A)*PC.L(A);
SAMREP(t,'Ptaxin',A)=ta_in(A)*XC.L(A)*PC.L(A);
SAMREP(t,'Ptaxetc',A)=ta_ex(A)*XC.L(A)*PC.L(A);


SAMREP(t,A,C)=theta(A,C)*XC.L(A)*PC.L(A);
SAMREP(t,'Tarrif',C)=tm(C)*pwm(C)*EXR.L*XMT.L(C);
SAMREP(t,'ROW',C)=pwm(C)*EXR.L*XMT.L(C);



SAMREP(t,H,L)=W.L(L)*shr(L,H)*Ls.L(L);
SAMREP(t,H,K)=R.L(K)*shr(K,H)*Ks.L(K)+sum(A$LinkA(A),shrpro(A,H)*rent.L*ZD.L(A));



SAMREP(t,C,H)=PA.L(C)*XAC.L(C,H);
SAMREP(t,'Ptaxin',H)=tc_in*sum(C,PA.L(C)*XAC.L(C,H));
SAMREP(t,'Ytax',H)=TINSR.L*(YH.L(H)-sum(K,delta*shr(K,H)*KS.L(K)));
SAMREP(t,'S-I',H)=SH.L(H);

SAMREP(t,C,'Gov')=PA.L(C)*XAF.L('Gov',C);
SAMREP(t,H,'Gov')=TR.L(H);
SAMREP(t,'Ptaxin','Gov')=sum(C,tg_in*PA.L(C)*XAF.L('Gov',C));
SAMREP(t,'S-I','Gov')=SG.L;
*
SAMREP(t,'Household','NRES')=ResinC.L;
SAMREP(t,'S-I','NRES')=ResinI.L;

SAMREP(t,'Gov','Ptaxin')=sum(A,ta_in(A)*PC.L(A)*XC.L(A))+(tc_in)*sum((C,H)$(sam(C,H) ne 0),PA.L(C)*XAC.L(C,H))+tg_in*sum(C$(sam(C,'Gov')ne 0),PA.L(C)*XAF.L('Gov',C))+tiv_in*sum(C$(sam(C,'S-I') ne 0),PA.L(C)*XAF.L('S-I',C))+tm_in*sum(C$(sam('ROW',C) ne 0),PMT.L(C)*XMT.L(C));
SAMREP(t,'Gov','Ptaxetc')=sum(A,ta_ex(A)*PC.L(A)*XC.L(A));
SAMREP(t,'Gov','Tarrif')=sum(C$(sam('ROW',c)>0),tm(C)*EXR.L*pwm(C)*XMT.L(C));
SAMREP(t,'GOV','Ytax')=sum(H, TINSR.L*(YH.L(H)-sum(K,delta*shr(K,H)*KS.L(K))));



SAMREP(t,C,'S-I')=PA.L(C)*XAF.L('S-I',C);
SAMREP(t,'Ptaxin','S-I')=sum(C,tiv_in*PA.L(C)*XAF.L('S-I',C));
SAMREP(t,C,'ROW')=PET.L(C)*ES.L(C);
SAMREP(t,'Ptaxin','ROW')=tm_in*sum(C$(sam('ROW',c)>0),PMT.L(C)*XMT.L(C));
SAMREP(t,'S-I','ROW')=FSAV.L*EXR.L;

GDPREP('CON_P',t)=sum((C,H), PA.L(C)*XAC.L(C,H));
GDPREP('CON_G',t)=sum(C,PA.L(C)*XAF.L('Gov',C));
GDPREP('INV',t)=sum(C,PA.L(C)*XAF.L('S-I',C));
GDPREP('EXP',t)=sum(C$(sam(C,'ROW')>0),EXR.L*pwe(C)*ES.L(C));
GDPREP('IMP',t)=-1*sum(C$(sam('ROW',c)>0),EXR.L*pwm(C)*XMT.L(C));
GDPREP('GDPMP1',t)=sum(ACGDP1,GDPREP(ACGDP1,t));
GDPREP('GDPFP',t)=sum((K,A),R.L(K)*KD.L(K,A))+sum((L,A),W.L(L)*LD.L(L,A))+sum(H,EY.L(H));
GDPREP('NITAX',t)=
sum(A$(sum(ACT,SAM(A,ACT))>0),(ta_in(A)+ta_ex(A))*PC.L(A)*XC.L(A))
+sum(C$(sam('ROW',c)>0),tm(C)*pwm(C)*XMT.L(C)*EXR.L)
+sum(C$(sam(C,'ROW')>0),te(C)*pwe(C)*ES.L(C)*EXR.L)
+TCREV.L
-sum(A,crevI*crevIw(A)*CREV.L(A));
GDPREP('NRES',t)=sum(A$(sum(ACT,SAM(A,ACT))>0),alpha_nres(A)*PC.L(A)*XC.L(A));
GDPREP('GDPMP2',t)=GDPREP('GDPFP',t)+GDPREP('NITAX',t)+GDPREP('NRES',t);
GDPREP('GAP',t)=GDPREP('GDPMP1',t)-GDPREP('GDPMP2',t);

VAREP(A,t)=sum(K,R.L(K)*KD.L(K,A))+sum(L,W.L(L)*LD.L(L,A))+(ta_in(A)+ta_ex(A))*PC.L(A)*XC.L(A)+alpha_nres(A)*PC.L(A)*XC.L(A)+ZD.L(A)*rent.L;


GCREP(t,GC,C,A)=QGE.L(GC,C,A);
GCREP(t,GC,'process',A)=QINTG.L(GC,A);
GCREP(t,GC,'Total',A)=sum(ACT,GCREP(t,GC,ACT,A));

DGCREP(t,GC,A)=GCREP(t,GC,'Total',A);
TGC(t,GC)=sum(A,GCREP(t,GC,'Total',A));
BALCHK(t,ACT)=sum(ACTPP,SAMREP(t,ACT,ACTPP))-sum(ACTPP,SAMREP(t,ACTPP,ACT));
**==== Law of Motion =====*
*Ks.Fx('Capital')=Ks.L('Capital')*(1-delta)+sum(C,XAF.L('S-I',C));
*Lw0(L)=Lw0(L)*(1+lgrow(t));
*Oldpop=Oldpop*(1+Oldpopg(t));
*FSAD=FSAD*(1+TBg(t));
*lambdat=lambdat+lpgrow(t);

** Save Top down solution
P_out(LinkC)=PP.L(LinkC);
P_in(C)$(ELECC(C))=PA.L(C);
P_in(C)$(M(C))=PA.L(C);
Pfuel_in(C,A)$(fuelA(A,C) and LinkA(A))=PNEG.L(C,A);
w_in(L)=W.L(L);
r_in(K)=R.L(K);
Demand_out(LinkC)=XP.L(LinkC);

** A. Construct Bottom up cost price index
* step 1. save top down input costs (A is industry in CGE, Crop and Livestock in Bottom up)
P_c(C,A)$(ENC(C) and LinkA(A))=PNEG.L(C,A);
P_c(C,A)$(ELECC(C) or M(C))=PA.L(C);
display p_c;
* step 2. convert top down input costs to io input cost by CGE industry A
Pio_c(io,A)=sum(c,theta_ioc(io,c)*P_c(C,A));
Pio_w(io,A)=sum(l,theta_iof(io,l)*w.l(l));
Pio_r(io,A)=sum(k,theta_iof(io,k)*r.l(k));
display pio_c,pio_w,pio_r;
* step 3. covert io input cost by industry A to io input cost by Crop and Livestock j
Pio_cj(io,j)=sum(a,theta_aj(a,j)*Pio_c(io,a));
Pio_wj(io,j)=sum(a,theta_aj(a,j)*Pio_w(io,a));
Pio_rj(io,j)=sum(a,theta_aj(a,j)*Pio_r(io,a));

*obtain weighted sum (doesn't give TW price)
ptc_j(tc,j)=sum(io,iotc_r(tc,io,j)*Pio_cj(io,j))+sum(io,iotc_r(tc,io,j)*Pio_wj(io,j))+sum(io,iotc_r(tc,io,j)*Pio_rj(io,j));

display ptc_j;

** B. Construct crop and Livestock price and crop and livestock demand by Bottom up catogory j

p_outj(j)=sum(c,theta_jc(j,c)*pp.l(c));
q_outj(j)=sum(c,theta_jc(j,c)*xp.l(c));
display p_outj,q_outj;

** C. Construct fake TC outcome from fake bottom up solution q_outj(j).
** (This should be replaced with actual bottom up solution)
tc_recover(tc,j)=theta_tc_j(tc,j)*q_outj(j);
display Agricost;
display tc_recover;

*******************************************************************************
********************************************************************************
D_A(J)=q_outj(j);
PI(TC,J)=ptc_j(tc,j);
PO(I,J)=p_outj(j);

AC_BU(I,CROP)=sum(CROPC, PI(CROPC,CROP)*C0(I,CROPC,CROP))/X0(I,CROP);
AC_BU(I,ANIMAL)=sum(ANIMALC, PI(ANIMALC,ANIMAL)*C0(I,ANIMALC,ANIMAL))/X0(I,ANIMAL);

D(I,J)= AC_BU(I,J);

display AC0, AC_BU, D, D0, D_A, PO;

SOLVE BU USING NLP MAXIMIZING Z_BU ;

*X_BU.L(I,J) = X0(I,J);
X_BU.LO(I,J) = 0.01*X0(I,J);

S_new(J)=sum(I, X_BU.L(I,J));
C_new(TC,J)=sum(I, X_BU.l(I,J)*CCOST0(I,TC,J));

display
Z_BU.L
X0
X_BU.L
S_new
q_outj
C_new
;


** D. Construct CGE input using bottom up TC solution
*Step1. TC to io input by BU Crop and Livestock j
iocost(io,j)=sum(tc,iotc_r(tc,io,j)*C_new(TC,J));
*iocost(io,j)=sum(tc,iotc_r(tc,io,j)*tc_recover(TC,J));
display iocost;

* Step 2: IO input to CGE input by BU Crop and Livestock j
inputcostc(c,j)=sum(io,theta_ioc(io,c)*iocost(io,j));
inputcostf(f,j)=sum(io,theta_iof(io,f)*iocost(io,j));
inputcostins(ins,j)=sum(io,theta_ioins(io,ins)*iocost(io,j));

*Step 3: CGE input by  CGE industry (A) . Since A and J are identical with only different names, this is one to one conversion.
inputcostc_a(c,a)=sum(j,theta_aj(a,j)*inputcostc(c,j));
inputcostf_a(f,a)=sum(j,theta_aj(a,j)*inputcostf(f,j));
inputcostins_a(ins,a)=sum(j,theta_aj(a,j)*inputcostins(ins,j));

display inputcostc, inputcostf,inputcostins;
display inputcostc_a,inputcostf_a,inputcostins_a;

*Step 4: replace .._bottom variables with new bottom up solution based values.
XC_bottom_1(A)$LinkA(A)=sum(j,theta_aj(a,j)*S_new(J));
LD_bottom_1(L,A)=inputcostf_a(l,a);
KD_bottom_1(K,A)=inputcostf_a(k,a);
XAP_bottom_1(C,A)$((not ENC(C)) and LinkA(A))=inputcostc_a(c,a);
QNEG_bottom_1(C,A)$(ENC(C) and LinkA(A))=inputcostc_a(c,a);

display XC_bottom,XC_bottom_1;
display LD_bottom,LD_bottom_1;
display KD_bottom,KD_bottom_1;
display XAP_bottom,XAP_bottom_1;
display QNEG_bottom,QNEG_bottom_1;

XC_bottom(A)$LinkA(A)=XC_bottom_1(A);
LD_bottom(L,A)$LinkA(A)=LD_bottom_1(L,A);
KD_bottom(K,A)$LinkA(A)=KD_bottom_1(K,A);
XAP_bottom(C,A)$((not ENC(C)) and LinkA(A))=XAP_bottom_1(C,A);
QNEG_bottom(C,A)$(ENC(C) and LinkA(A))=QNEG_bottom_1(C,A);


*lambdat=(1+lp_adj)*lambdat;
*lambdat=(1+0.001)*lambdat;
*lambda(A)=(1+0.001)*lambda(A);
*lambda(A)$Agrimin(A)=(1+lg_ag)*lambda(A);
*lambda(A)$RoilChemM(A)=(1+lg_rcm)*lambda(A);
*lambda(A)$FabMetal(A)=(1+lg_fm)*lambda(A);
*lambda(A)$(Manufact(A) and (not RoilChemM(A)) and (not FabMetal(A)))=(1+lg_man)*lambda(A);
*lambda(A)$SOC(A)=(1+lg_soc)*lambda(A);
*lambda(A)$Service(A)=(1+lg_serv)*lambda(A);
*lambda(A)$Energy(A)=(1+lg_energy)*lambda(A);
*lambda(A)$Other(A)=(1+lg_other)*lambda(A);
*gtax(GC)=gtax(GC)+gtax_policy(GC,t);
*alphaaVAE('Roil-a')=(1+TFP_roil(t))*alphaaVAE('Roil-a');
*alphaaVAE('coal-a')=(1+TFP_coal(t))*alphaaVAE('coal-a');
*alphaaVAE('coalpro-a')=(1+TFP_coal(t))*alphaaVAE('coalpro-a');
*alphaaVAE('Gas-a')=(1+TFP_gas(t))*alphaaVAE('Gas-a');
*AEEI('Roil-c',A)$(not eleca(A) and not heata(a))=(1+aeg_roil(t))*AEEI('Roil-c',A);
*AEEI('coal-c',A)$(not eleca(A) and not heata(a))=(1+aeg_coal(t))*AEEI('Roil-c',A);
*AEEI('coalpro-c',A)$(not eleca(A) and not heata(a))=(1+aeg_coal(t))*AEEI('Roil-c',A);
*AEEI('Gas-c',A)$(not eleca(A) and not heata(a))=(1+aeg_gas(t))*AEEI('Roil-c',A);
*AEEI('Roil-c',A)$(eleca(A))=(1+aeg_elec(t)+aeg_roil(t))*AEEI('Roil-c',A);
*AEEI('coal-c',A)$(eleca(A))=(1+aeg_elec(t)+aeg_roil(t))*AEEI('Roil-c',A);
*AEEI('coalpro-c',A)$(eleca(A))=(1+aeg_elec(t)+aeg_roil(t))*AEEI('Roil-c',A);
*AEEI('Gas-c',A)$(heata(A))=(1+aeg_elec(t)+aeg_roil(t))*AEEI('Roil-c',A);
*AEEI('Roil-c',A)$(heata(A))=(1+aeg_elec(t)+aeg_heat(t))*AEEI('Roil-c',A);
*AEEI('coal-c',A)$(heata(A))=(1+aeg_elec(t)+aeg_heat(t))*AEEI('Roil-c',A);
*AEEI('coalpro-c',A)$(heata(A))=(1+aeg_elec(t)+aeg_heat(t))*AEEI('Roil-c',A);
*AEEI('Gas-c',A)$(heata(A))=(1+aeg_elec(t)+aeg_heat(t))*AEEI('Roil-c',A);
*thetaE(GC,C,'elec-a')=thetaE_adj(t)*thetaE(GC,C,'elec-a')

* =========================== *


);
SAMDIFF('0',ACT,ACTPP)=samng(ACT,ACTPP)-SAMREP('0',ACT,ACTPP);
DiFFT=sum((ACT,ACTPP),SAMDIFF('0',ACT,ACTPP));
GDP1(t)=GDPREP('GDPMP1',t);
loop (t$(not TO(t)),ygrow(t)=(GDP1(t)-GDP1(t-1))/GDP1(t-1));


*parameter
*VAM(t)
*VManu(t)
*VRCM(t)
*VFmetal(t)
*VSOC(t)
*VServ(t)
*;
*VAM(t)=sum(A$Agrimin(A), VAREP(A,t));
*VManu(t)=sum(A$Manufact(A),VAREP(A,t));
*VRCM(t)=sum(A$RoilCHemM(A),VAREP(A,t));
*VFmetal(t)=sum(A$FabMetal(A),VAREP(A,t));
*VSOC(t)=sum(A$SOC(A),VAREP(A,t));
*VServ(t)=sum(A$Service(A),VAREP(A,t));

*parameter
*TE_ELEC(t)
*TE_Heat(t)
*TE_Gas(t)
*TE_Coal(t)
*TE_Coalpro(t)
*TE_ROIL(t)
*;
*TE_ELEC(t)=sum((ELECgc,A),XAPREP(ELECgc,A,t))+sum((ELECgc,H),XACREP(ELECgc,H,t))+sum((ELECgc,FD),XAFREP(FD,ELECgc,t));
*TE_Heat(t)=sum((Heatgc,A),XAPREP(Heatgc,A,t))+sum((Heatgc,H),XACREP(Heatgc,H,t))+sum((Heatgc,FD),XAFREP(FD,Heatgc,t));
*TE_Gas(t)=sum((GASgc,A),QCEREP(GASgc,A,t))+sum((GASgc,H),XACREP(GASgc,H,t))+sum((FD,GASgc),XAFREP(FD,GASgc,t))-sum((GASgc, TransitionA),QCEREP(GASgc,TransitionA,t));
*TE_Coal(t)=sum((Coalgc,A),QCEREP(Coalgc,A,t))+sum((Coalgc,H),XACREP(Coalgc,H,t))+sum((FD,Coalgc),XAFREP(FD,Coalgc,t))-sum((Coalgc,TransitionA),QCEREP(Coalgc,TransitionA,t));
*TE_ROIL(t)=sum((Oilgc,A),QCEREP(Oilgc,A,t))+sum((Oilgc,H),XACREP(Oilgc ,H,t))+sum((FD,Oilgc),XAFREP(FD,Oilgc,t))-sum((Oilgc,TransitionA),QCEREP(Oilgc,TransitionA,t));

*parameter
*TotalGE_adj;
*TotalGE_adj=562/556.1;

*parameter
*TGC_E_ind(t)
*TGC_E_house(t)
*TGC_E(t)
*TGC_elec(t)
*TGC_elec_r(t)
*;
*TGC_E_ind(t)=sum((GC,C,A),GCREP(t,GC,C,A));
*TGC_E_house(t)=sum((C,H),thetaH(C,H)*XACREP(C,H,t));
*TGC_E(t)=TotalGE_adj*(TGC_E_ind(t)+TGC_E_house(t));
*TGC_elec(t)=TotalGE_adj*sum((GC,C),GCREP(t,GC,C,'elec-a'));
*TGC_elec_r(t)=TGC_elec(t)/TE_ELEC(t);

display scenario;
*display samrep;
display warlasREP;
display SAMDIFF;
display DiFFT;
display PCREP,PPREP,PAREP,PDREP,PETREP,PMTREP,RREP,WREP,XCREP,LDREP,KDREP,XPREP,EYREP;

*display GDPrep,GDP1;
*display ygrow;
*display TGC;
*display gtaxrep;
*display rentrep;
*display EYREP,XCREP;
*display thetaE;
*display VAM,VManu,VRCM,VFmetal,VSOC,VServ;
*display TE_ELEC,TE_Heat,TE_gas,TE_coal,TE_ROIL;
*display TGC_E_ind,TGC_E_house,TGC_E;
*display TGC_elec,TGC_elec_r;
*display AEEI;
*display lambda,lambdat;
*display VAREP;
*if (scenario=0,
*$include "unload_BAU_incomp.gms";
*elseif (scenario=1),
*$include "unload_TR_incomp.gms";
*)
*elseif (scenario=2),
*$include "unload_TR2_emix_elec1.gms";
*elseif (scenario=3),
*$include "unload_TR3_emix_elec1.gms";
*else
*$include "unload_TR4_emix_elec1.gms";
*);
