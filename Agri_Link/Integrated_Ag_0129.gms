$TITLE Hybrid model top down module trial version
$ONTEXT
- Oct 31. 2015
This model is for testing hybrid alogrithm only.
We have only 7 industries.
Production function and Utility function don't have any nesting structure.
Data : 2010 IO table. Basic price data.

- Sep. 22. 2015
Non nested version test-run is complete

-Sep. 23.24. 2015
Changing notation. Simplify equation using conditional set fuelA,XAPA,XEPA,FD_C

-Sep. 24. 2015 .Depreciation cost is subtracted from household taxable income.

Dep(H)=shr(K,H)*delta*K(S) (deprecation cost is proportional to household capital endowment)
Tax is imposed on factor income + residue sales income - deprecitaion cost
YD becomes (1-Tinsr)*(LY+KY+ResinC-Dep(H))
XAC is still mpc*YD
SH becomes mps*YD+Dep(H)
YH=sum(mpc.mpc*(1-TINSR)*(LY+KY+ResinC-Dep(H)))+mps*(1-TINSR)*(LY+KY+ResinC-Dep(H))+TINSR(LY+KY+ResinC-Dep(H))+Dep(H)

delta: deprecation ratio =Return rate *[[depreciation cost]/[depreciation cost+operation surplus]]=Return rate*0.39 (2010 IO basic price table)

- Sep 25. 2015. nesting begins.
step 1. Leontief input (Materials)
step 2. Labor

- Sep 26. 2015. nesting goes on
Step 3. Kapital
Setp 4. Electricity

-Setp.27. 2015. Final nest
Setp 5. Coal

-Oct. 7. Impose BR(2009) nesting structure
-Oct. 8 (Lafayett, IN USA). calibration /initiation are completed.

-Dec. 4 Redefine Agri. Previously it was Agriculture, Forestry and Fishery. FF(Forestry and Fishery) is reclassifieda as a part of ENIT. Due to heavy
use of Oil in Fishery, FF becomes energy intensive indutry.

-Dec. 23
Agricluture becomes 13 (8 crops and 5 meats)

Recieve
ACTR(A) : XC(A) Agriclutural Product Output
LD1(L,A): LD(Labor, Agri-A) Labor input in Agriculture
KD1(K,A): KD(Capital,Agri-A) Capital input in Agriculture
INTDE1(ELECC,Agri-A): XAP(ELECC,Agri-A) Electricity input in Agriculture
NEFDS*(Sfuel,Agri-A): QNEG(COAL, Agri-A) Coal input in  Agriculture
NEFDL*(Lfuel,Agri-A): QNEG([GAS,OIL],Agri-A)  Liquid Fuel input in Agriculture
INTDM*(C,A):XPA([Agri,NEINT],Agri-A)  Non energy intermediate input in Agricluture

Send
Agriclutural Product: Total Demand[Domestic Demand + Export Demand] - Import Demand
Agriclutural Price: Domestic Market Price[Armington Price]


-Dec. 28
Agriclutrual sector is expanded to 13 subsectors. Now the model has 19 sectors
8 crop sectors  (Rice-a,Barley-a,Bean-a,Potato-a,Vegi-a,Fruit-a,Flower-a,MissCrop-a)
5 Livestock sectors (Dairy-a,Meat-a,Pork-a,Poultry-a,MissLstock-a)
1 electricty (
3 fuel
2 industries (ENIT NEINT)

-Dec.28
Separate production function for agriculture

-Jan.04
Add Profit to household income

-Jan.09

Introduce Agriculture specific asset Z to account for non zero profit.


-Jan.13

Introduce Cobb-Douglas Agriculture composite XAG and the price of XAG, PAG


*$ONempty
$OFFTEXT
OPTION SYSOUT=ON;
OPTION limrow=50;
*SETS=================================
*parameter
*recursive;
*recursive=0;
*operation=1;
SET

$include "set_Agri_20160119_static.txt"

*$include "set_Agri_20160119_recursive.txt"
set
io /1*391/
J /Rice,Barley,Bean,Potato,Vegi,Fruit,Flower,MissCrop,Dairy,Meat,Pork,Poultry,
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
19.ENIT-c
20.ENIT-c
21.ENIT-c
22.ENIT-c
23.ENIT-c
24.ENIT-c
25.NEINT-c
26.COAL-c
27.COAL-c
28.OIL-c
29.GASHeat-c
30.ENIT-c
31.ENIT-c
32.ENIT-c
33.ENIT-c
34.ENIT-c
35.NEINT-c
36.NEINT-c
37.NEINT-c
38.NEINT-c
39.NEINT-c
40.NEINT-c
41.NEINT-c
42.Rice-c
43.NEINT-c
44.NEINT-c
45.NEINT-c
46.NEINT-c
47.NEINT-c
48.NEINT-c
49.NEINT-c
50.NEINT-c
51.NEINT-c
52.NEINT-c
53.NEINT-c
54.NEINT-c
55.NEINT-c
56.NEINT-c
57.NEINT-c
58.NEINT-c
59.NEINT-c
60.NEINT-c
61.NEINT-c
62.NEINT-c
63.NEINT-c
64.NEINT-c
65.NEINT-c
66.NEINT-c
67.NEINT-c
68.NEINT-c
69.NEINT-c
70.NEINT-c
71.NEINT-c
72.NEINT-c
73.NEINT-c
74.NEINT-c
75.NEINT-c
76.NEINT-c
77.NEINT-c
78.NEINT-c
79.NEINT-c
80.NEINT-c
81.NEINT-c
82.NEINT-c
83.NEINT-c
84.NEINT-c
85.NEINT-c
86.NEINT-c
87.NEINT-c
88.NEINT-c
89.NEINT-c
90.NEINT-c
91.NEINT-c
92.NEINT-c
93.NEINT-c
94.NEINT-c
95.NEINT-c
96.NEINT-c
97.NEINT-c
98.NEINT-c
99.COAL-c
100.COAL-c
101.OIL-c
102.OIL-c
103.OIL-c
104.OIL-c
105.OIL-c
106.OIL-c
107.OIL-c
108.OIL-c
109.OIL-c
110.OIL-c
111.ENIT-c
112.ENIT-c
113.ENIT-c
114.NEINT-c
115.NEINT-c
116.NEINT-c
117.NEINT-c
118.NEINT-c
119.ENIT-c
120.ENIT-c
121.ENIT-c
122.NEINT-c
123.NEINT-c
124.NEINT-c
125.NEINT-c
126.NEINT-c
127.NEINT-c
128.NEINT-c
129.NEINT-c
130.NEINT-c
131.NEINT-c
132.ENIT-c
133.ENIT-c
134.ENIT-c
135.ENIT-c
136.ENIT-c
137.ENIT-c
138.ENIT-c
139.ENIT-c
140.ENIT-c
141.ENIT-c
142.ENIT-c
143.ENIT-c
144.ENIT-c
145.ENIT-c
146.ENIT-c
147.ENIT-c
148.ENIT-c
149.ENIT-c
150.ENIT-c
151.ENIT-c
152.ENIT-c
153.ENIT-c
154.ENIT-c
155.ENIT-c
156.ENIT-c
157.ENIT-c
158.ENIT-c
159.ENIT-c
160.ENIT-c
161.ENIT-c
162.ENIT-c
163.ENIT-c
164.ENIT-c
165.ENIT-c
166.ENIT-c
167.ENIT-c
168.ENIT-c
169.NEINT-c
170.NEINT-c
171.NEINT-c
172.NEINT-c
173.NEINT-c
174.NEINT-c
175.NEINT-c
176.NEINT-c
177.NEINT-c
178.NEINT-c
179.NEINT-c
180.NEINT-c
181.NEINT-c
182.NEINT-c
183.NEINT-c
184.NEINT-c
185.NEINT-c
186.NEINT-c
187.NEINT-c
188.NEINT-c
189.NEINT-c
190.NEINT-c
191.NEINT-c
192.NEINT-c
193.NEINT-c
194.NEINT-c
195.NEINT-c
196.NEINT-c
197.NEINT-c
198.NEINT-c
199.NEINT-c
200.NEINT-c
201.NEINT-c
202.NEINT-c
203.NEINT-c
204.NEINT-c
205.NEINT-c
206.NEINT-c
207.NEINT-c
208.NEINT-c
209.NEINT-c
210.NEINT-c
211.NEINT-c
212.NEINT-c
213.NEINT-c
214.NEINT-c
215.NEINT-c
216.NEINT-c
217.NEINT-c
218.NEINT-c
219.NEINT-c
220.NEINT-c
221.NEINT-c
222.NEINT-c
223.NEINT-c
224.NEINT-c
225.NEINT-c
226.NEINT-c
227.NEINT-c
228.NEINT-c
229.NEINT-c
230.NEINT-c
231.NEINT-c
232.NEINT-c
233.NEINT-c
234.NEINT-c
235.NEINT-c
236.NEINT-c
237.NEINT-c
238.NEINT-c
239.NEINT-c
240.NEINT-c
241.NEINT-c
242.NEINT-c
243.NEINT-c
244.NEINT-c
245.NEINT-c
246.NEINT-c
247.NEINT-c
248.NEINT-c
249.NEINT-c
250.NEINT-c
251.NEINT-c
252.NEINT-c
253.NEINT-c
254.NEINT-c
255.NEINT-c
256.NEINT-c
257.NEINT-c
258.NEINT-c
259.NEINT-c
260.NEINT-c
261.NEINT-c
262.NEINT-c
263.NEINT-c
264.NEINT-c
265.NEINT-c
266.NEINT-c
267.NEINT-c
268.NEINT-c
269.NEINT-c
270.NEINT-c
271.NEINT-c
272.NEINT-c
273.NEINT-c
274.ELEC-c
275.ELEC-c
276.ELEC-c
277.ELEC-c
278.ELEC-c
279.GASHeat-c
280.GASHeat-c
281.NEINT-c
282.NEINT-c
283.NEINT-c
284.NEINT-c
285.NEINT-c
286.NEINT-c
287.NEINT-c
288.NEINT-c
289.NEINT-c
290.NEINT-c
291.NEINT-c
292.NEINT-c
293.NEINT-c
294.NEINT-c
295.NEINT-c
296.NEINT-c
297.NEINT-c
298.NEINT-c
299.NEINT-c
300.NEINT-c
301.NEINT-c
302.NEINT-c
303.NEINT-c
304.ENIT-c
305.ENIT-c
306.ENIT-c
307.ENIT-c
308.ENIT-c
309.ENIT-c
310.ENIT-c
311.ENIT-c
312.ENIT-c
313.ENIT-c
314.ENIT-c
315.ENIT-c
316.ENIT-c
317.ENIT-c
318.NEINT-c
319.NEINT-c
320.NEINT-c
321.NEINT-c
322.NEINT-c
323.NEINT-c
324.NEINT-c
325.NEINT-c
326.NEINT-c
327.NEINT-c
328.NEINT-c
329.NEINT-c
330.NEINT-c
331.NEINT-c
332.NEINT-c
333.NEINT-c
334.NEINT-c
335.NEINT-c
336.NEINT-c
337.NEINT-c
338.NEINT-c
339.NEINT-c
340.NEINT-c
341.NEINT-c
342.NEINT-c
343.NEINT-c
344.NEINT-c
345.NEINT-c
346.NEINT-c
347.NEINT-c
348.NEINT-c
349.NEINT-c
350.NEINT-c
351.NEINT-c
352.NEINT-c
353.NEINT-c
354.NEINT-c
355.NEINT-c
356.NEINT-c
357.NEINT-c
358.NEINT-c
359.NEINT-c
360.NEINT-c
361.NEINT-c
362.NEINT-c
363.NEINT-c
364.NEINT-c
365.NEINT-c
366.NEINT-c
367.NEINT-c
368.NEINT-c
369.NEINT-c
370.NEINT-c
371.NEINT-c
372.NEINT-c
373.NEINT-c
374.NEINT-c
375.NEINT-c
376.NEINT-c
377.NEINT-c
378.NEINT-c
379.NEINT-c
380.NEINT-c
381.NEINT-c
382.NEINT-c
383.NEINT-c
384.NEINT-c
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

;

TABLE  iotc_r(tc,io,J) io_TC ratio
$ondelim
$include iocost_r_Agri_0121.csv
$offdelim;

Table Agricost(tc,j)
$ondelim
$include cost_Agri_0121.csv
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

display Agricost;

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
deltaXEP(A)     VAE CES function share parameter for Energy composite XEP
deltaVA(A)      VAE CES function share parameter for Value Added composite VA
deltaf(F,A)     VA CES function share parameter for factor
deltac(C,A)     Leontief perameter for non energy intermediate input: Cobb Douglas parameter for Agri intermediate input and CES share parameter for intermediate energy input (ENC and ENCN)
rhoaVAE(A)      VAE CES function exponent
sigmaaVAE(A)    1 over (1+rhoaVAE(A))
rhoaXFL(A)      XFL CES function exponent (fuel)
sigmaaXFL(A)    1 over (1+rhoaXLF(A))

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

cpi_o          Consumer price index
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

;

*VARIABLES========================================================================
positive variables
PA(C)           Market price of C
PC(A)           Activity price
XMT(C)           Import composite of good C
PMT(C)           Import composite price of good C
XD(C)           Domestic supply of domestic production C
PD(C)           Price of domestic supply of domestic production C

XA(C)           Supply of C
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
PAG(A)                 Agriculture composite price
XAG(A)                 Demand for Agriculture composite
PVA(A)                 Value Added composite price
VA(A)                  Demand for Value Added composite
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
CPI           Consumer price index
*** Loading Data

table sam(ACT,ACTP) data in CSV format
$Ondelim
$include b_sam_br_g_20160119.csv
$Offdelim

table samng(ACT,ACTP) data in CSV format
$Ondelim
$include b_sam_br_ng_20160119.csv
$Offdelim

table ghg(ACT,ACTP) data in CSV format
$Ondelim
$include GHG_BR_p_20160119.csv
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
ActR(A) Activity revenue and costs with C02 not in process non Agriculture
ActR_Link(A) Activity revenue and costs with C02 not in process Agriculture only
ActRp(A) Activity Revenue and costs with C02 in process non Agriculture
ActRp_Link(A) Activity Revenue and costs with C02 in process Agriculture only

VAEPr0(A) KLEM composite price non Agriculutre
VAEPr1(A) KLEM composite price with VA and XEP non Agriculutre
VAEPr2(A) KLEM composite price with XEP only (without VA) non Agriculutre

VAEPr0_Link(A) KLEM composite price Agriculutre only
VAEPr1_Link(A) KLEM composite price with VA and XEP Agriculutre only
VAEPr2_Link(A) KLEM composite price with XEP only (without VA) Agriculutre only

VAGPr (A) Agriculture composite price
VAGPr_Link(A) Agriculture compostie price for Linked industry

VAPr0(A)  VA composite price non Agricluture
VAPr1(A)  VA composite price with labor only non Agricluture
VAPr2(A)  VA composite price with capital only non Agricluture

VAPr0_Link(A)  VA composite price (Agricluture only)
VAPr1_Link(A)  VA composite price with labor only (Agricluture only)
VAPr2_Link(A)  VA composite price with capital only  (Agricluture only)


XEPr0 (A) Energy composite price
XEPr1 (A) Energy composite price (XEP with fuel)
XEPr2 (A) Energy composite price (XEP without electricity)

XEPr0_Link (A) Energy composite price (Agricluture only)
XEPr1_Link (A) Energy composite price (XEP with fuel)  (Agricluture only)
XEPr2_Link (A) Energy composite price (XEP without electricity)  (Agricluture only)

XFLPr0(A) Fuel composite price type 0 (XFL without solid fuel)
XFLPr1(A) Fuel composite price type 1 (XFL with solid fuel)
XFLPr2(A) Fuel composite price type 2 (XFL solid fuel only with multiple solid fuel)
XFLPr3(A) Feul composite price type 3 (XFL solid fuel only with single solid fuel)

XFLPr0_Link(A) Fuel composite price type 0 (XFL without solid fuel)(Agricluture only)
XFLPr1_Link(A) Fuel composite price type 1 (XFL with solid fuel) (Agricluture only)
XFLPr2_Link(A) Fuel composite price type 2 (XFL solid fuel only with multiple solid fuel)  (Agricluture only)
XFLPr3_Link(A) Feul composite price type 3 (XFL solid fuel only with single solid fuel) (Agricluture only)


XLFLPr0 (A) Liquid Fuel composite price (single Liquid fuel)
XLFLPr1 (A) Liquid Fuel composite price (multiple Liquid fuel)
XLFLPr0_Link(A) Liquid Fuel composite price (single Liquid fuel)(Agricluture only)
XLFLPr1_Link(A) Liquid Fuel composite price (multiple Liquid fuel)(Agricluture only)


NEGPr(C,A) Non Electricity price without CO2 PNEG =PA
NEGPrco(C,A) Non Electricity GHG composite price with CO2 PNEG f of PA of fuel and PG

NEGPr_Link(C,A) Non Electricity price without CO2 PNEG =PA (Agricluture only)
NEGPrco_Link(C,A) Non Electricity GHG composite price with CO2 PNEG f of PA of fuel and PG (Agricluture only)


Norm   Definition of Consummer Price Index
CPIfix Fixing CPI
Labsup(L) Labor supply

*Production and Trade block
QVAED(A) value added - Energy composite demand QVAE f of XC
QVAED_Link(A) value added - Energy composite demand QVAE f of XC (Agricluture only)

XVAD0(A) valude added demand VA f of QVAE without XEP
XVAD1(A) valude added demand VA f of QVAE

XVAD0_Link(A) valude added demand VA f of QVAE without XEP (Agricluture only)
XVAD1_Link(A) valude added demand VA f of QVAE (Agricluture only)

XAGD(A) Agriculture composite demand XAG. f of XC
XAGD_Link(A) Agriculture composite demand XAG. f of XC (Agriculture only)

XEPD1(A)  Energy composite demand XEP function of QVAE
XEPD2(A)  Energy composite demand XEP function of QVAE without VA

XEPD1_Link(A)  Energy composite demand XEP function of QVAE  (Agricluture only)
XEPD2_Link(A)  Energy composite demand XEP function of QVAE without VA (Agricluture only)

XFLD1(A)  Fuel composite demand XFL function of XEP (XEP without electricity and fuel)
XFLD2(A)  Fuel composite demand XFL function of XEP (XEP without electricity)

XFLD1_Link(A)  Fuel composite demand XFL function of XEP (XEP without electricity and fuel) (Agricluture only)
XFLD2_Link(A)  Fuel composite demand XFL function of XEP (XEP without electricity) (Agricluture only)

XLFLD0(A) liquid fuel composite demand XFLD function of XFL(Single Liquid fuel)
XLFLD1(A) liquid fuel composite demand XFLD function of XFL(multiple Liqudi fuel)
XLFLD0_Link(A) liquid fuel composite demand XFLD function of XFL(Single Liquid fuel) (Agricluture only)
XLFLD1_Link(A) liquid fuel composite demand XFLD function of XFL(multiple Liqudi fuel) (Agricluture only)


INTDM(C,A) Material intermeidate demand for XC(A): Leontief of XC
INTDAG0(C,A) Agriculture intermediate demand for XC(A) :Cobb Douglas of XAG Ag singleton
INTDAG1(C,A) Agriculture intermediate demand for XC(A) :Cobb Douglas of XAG Ag more than one
INTDE1(C,A) Electricity intermediate demand for XC(A): CES of VAE
INTGD(GC,A) intermediate demand of CO2 CO2 emission in process

INTDM_Link(C,A) Material intermeidate demand for XC(A): Leontief of XC  (Agricluture only)
INTDAG0_Link(C,A) Agriculture intermediate demand for XC(A): Cobb Douglas of XAG Ag singleton (Agriculture only)
INTDAG1_Link(C,A) Agriculture intermediate demand for XC(A): Cobb Douglas of XAG Ag more than one(Agriculture only)
INTDE1_Link(C,A) Electricity intermediate demand for XC(A): CES of VAE (Agricluture only)
INTGD_Link(GC,A) intermediate demand of CO2 CO2 emission in process  (Agricluture only)

LDA1(L,A) labor demand LD f of QVAE
KDA1(K,A) Capital demand  KD f of QVAE

LDA1_Link(L,A) labor demand LD f of QVAE (Agricluture only)
KDA1_Link(K,A) Capital demand  KD f of QVAE (Agricluture only)
ZD_Link(A) Agriculture Resource demand ZD f of XC (Agriculture only)

NEGDL0(C,A) Fuel-CO2 composite Demand: Liquid Singleton. f of XLFL
NEGDL1(C,A) Fuel-CO2 composite Demand: Liquid. Multi input . f of XLFL

NEGDL0_Link(C,A) Fuel-CO2 composite Demand: Liquid Singleton. f of XLFL  (Agricluture only)
NEGDL1_Link(C,A) Fuel-CO2 composite Demand: Liquid. Multi input . f of XLFL (Agricluture only)

NEGDS1(C,A) Fuel-CO2 composite Demand: Solid . f of XFL
NEGDS2(C,A) Fuel-CO2 composite Demand: Solid . f of XFL (XFL without Liquid fuel demand. Multiple solid fuel)
NEGDS3(C,A) Fuel-CO2 composite Demand: Solid . f of XFL (XFL without Liquid fuel demand. single solid fuel)

NEGDS1_Link(C,A) Fuel-CO2 composite Demand: Solid . f of XFL (Agricluture only)
NEGDS2_Link(C,A) Fuel-CO2 composite Demand: Solid . f of XFL (XFL without Liquid fuel demand. Multiple solid fuel)(Agricluture only)
NEGDS3_Link(C,A) Fuel-CO2 composite Demand: Solid . f of XFL (XFL without Liquid fuel demand. single solid fuel) (Agricluture only)

NELQCED(C,A) fuel demand QCE f of QNEG
NELQCED_Link(C,A) fuel demand QCE f of QNEG (Agricluture only)

GD(GC,C,A) CO2 Demand(emission) in fuel use QGE f of QCE
GD_Link(GC,C,A) CO2 Demand(emission) in fuel use QGE f of QCE (Agricluture only)

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

ComMENCN(C) Market clearing: non agriculture non fuel
ComMENCN_Link(C) Market clearing: agriculture
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

*ActR(A)$(sum(C,SAM(A,C))>0 and not ghg('process',A))..PC(A)*alpha_nres(A)*XC(A)+sum(C$M(C),PA(C)*ica(C,A)*XC(A))+PVAE(A)*QVAE(A)=g=PC(A)*(1-ta_in(A)-ta_ex(A))*XC(A)+crevI*crevIw(A)*CREV(A);
ActR(A)$(sum(C,SAM(A,C))>0 and not ghg('process',A) and not LinkA(A))..PC(A)*alpha_nres(A)+sum(C$(M(C) and not AgriC(C)),PA(C)*ica(C,A))+PAG(A)+PVAE(A)=g=PC(A)*(1-ta_in(A)-ta_ex(A));
ActR.m(A)=1;
*ActRp(A)$(ghg('process',A) ne 0)..PC(A)*alpha_nres(A)*XC(A)+sum(C$M(C),PA(C)*ica(C,A)*XC(A))+sum(GC,thetaP(GC,A)*XC(A)*gtax(GC))+PVAE(A)*QVAE(A)=g=PC(A)*(1-ta_in(A)-ta_ex(A))*XC(A)+crevI*crevIw(A)*CREV(A);
ActRp(A)$((ghg('process',A) ne 0) and not LinkA(A))..PC(A)*alpha_nres(A)+sum(C$(M(C) and not AgriC(C)),PA(C)*ica(C,A))+sum(GC,thetaP(GC,A)*gtax(GC)*cpi)+PAG(A)+PVAE(A)=g=PC(A)*(1-ta_in(A)-ta_ex(A));
ActRP.m(A)=1;

*ActR_Link(A)$(sum(C,SAM(A,C))>0 and not ghg('process',A) and LinkA(A))..PC(A)*alpha_nres(A)+sum(C$M(C),PA(C)*ica(C,A))+sum(C$ELECC(C),PA(C)*iea(C,A))+sum(C$FuelA(A,C),PNEG(C,A)*ifuela(C,A))+sum(K,ifa(K,A)*R(K))+sum(L,ifa(L,A)*W(L))=e=PC(A)*(1-ta_in(A)-ta_ex(A));
ActR_Link(A)$(sum(C,SAM(A,C))>0 and not ghg('process',A) and LinkA(A))..XC(A)=e=XC_bottom(A);

ActR_Link.m(A)=1;
*ActRp(A)$(ghg('process',A) ne 0)..PC(A)*alpha_nres(A)*XC(A)+sum(C$M(C),PA(C)*ica(C,A)*XC(A))+sum(GC,thetaP(GC,A)*XC(A)*gtax(GC))+PVAE(A)*QVAE(A)=g=PC(A)*(1-ta_in(A)-ta_ex(A))*XC(A)+crevI*crevIw(A)*CREV(A);
*ActRp_Link(A)$((ghg('process',A) ne 0) and LinkA(A))..PC(A)*alpha_nres(A)+sum(C$M(C),PA(C)*ica(C,A))+sum(GC,thetaP(GC,A)*gtax(GC)*cpi)+sum(C$ELECC(C),PA(C)*iea(C,A))+sum(C$FuelA(A,C),PNEG(C,A)*ifuela(C,A))+sum(K,ifa(K,A)*R(K))+sum(L,ifa(L,A)*W(L))=e=PC(A)*(1-ta_in(A)-ta_ex(A));
ActRp_Link(A)$((ghg('process',A) ne 0) and LinkA(A))..XC(A)=e=XC_bottom(A);
ActRP_Link.m(A)=1;


VAEPr0(A)$(sum(ELECC,SAM(ELECC,A))+sum(ENC,SAM(ENC,A))=0 and sum(F,SAM(F,A))>0 and not LinkA(A))..PVAE(A)=e=(1/alphaaVAE(A))*PVA(A);
VAEPr0.m(A)=1;


VAEPr1(A)$(sum(ELECC,SAM(ELECC,A))+sum(ENC,SAM(ENC,A))>0 and sum(F,SAM(F,A))>0 and not LinkA(A))..PVAE(A)=e=(1/alphaaVAE(A))*
(
deltaXEP(A)**sigmaaVAE(A)*PEP(A)**(1-sigmaaVAE(A))
+ deltaVA(A)**sigmaaVAE(A)*PVA(A)**(1-sigmaaVAE(A))
)**(1/(1-sigmaaVAE(A)));
VAEPr1.m(A)=1;

VAEPr2(A)$(sum(ELECC,SAM(ELECC,A))+sum(ENC,SAM(ENC,A))>0 and sum(F,SAM(F,A))=0 and not LinkA(A))..PVAE(A)=e=(1/alphaaVAE(A))*PEP(A);
VAEPr2.m(A)=1;

*VAEPr0_Link(A)$(sum(ELECC,SAM(ELECC,A))+sum(ENC,SAM(ENC,A))=0 and sum(F,SAM(F,A))>0 and LinkA(A))..PVAE(A)=e=(1/alphaaVAE(A))*PVA(A);
*VAEPr0_Link.m(A)=1;


*VAEPr1_Link(A)$(sum(ELECC,SAM(ELECC,A))+sum(ENC,SAM(ENC,A))>0 and sum(F,SAM(F,A))>0 and LinkA(A))..PVAE(A)=e=(1/alphaaVAE(A))*
*(
*deltaXEP(A)**sigmaaVAE(A)*PEP(A)**(1-sigmaaVAE(A))
*+ deltaVA(A)**sigmaaVAE(A)*PVA(A)**(1-sigmaaVAE(A))
*)**(1/(1-sigmaaVAE(A)));
*VAEPr1_Link.m(A)=1;

*VAEPr2_Link(A)$(sum(ELECC,SAM(ELECC,A))+sum(ENC,SAM(ENC,A))>0 and sum(F,SAM(F,A))=0 and LinkA(A))..PVAE(A)=e=(1/alphaaVAE(A))*PEP(A);
*VAEPr2_Link.m(A)=1;

VAGPr(A)$(sum(C$AgriC(C),SAM(C,A))>0 and not LinkA(A))..PAG(A)=e=(1/alphaaAG(A))*prod(C$(XAPA(C,A) and AgriC(C)),(PA(C)/deltaC(C,A))**deltaC(C,A));
VAGPr.m(A)=1;
*VAGPr_Link(A)$(sum(C$AgriC(C),SAM(C,A))>0 and LinkA(A))..PAG(A)=e=(1/alphaaAG(A))*prod(C$(XAPA(C,A) and AgriC(C)),(PA(C)/deltaC(C,A))**deltaC(C,A));
*VAGPr_Link.m(A)=1;


VAPr0(A)$(sum(L,SAM(L,A))>0 and sum(K,SAM(K,A))=0 and not LinkA(A))..PVA(A)=e=
(
     prod(L,(W(L)/(lambdat*lambda(A)*deltaf(L,A)))**(deltaf(L,A)))
);
VAPr0.m(A)=1;


VAPr1(A)$(sum(L,SAM(L,A))>0 and sum(K,SAM(K,A))>0 and not LinkA(A))..PVA(A)=e=
(
     prod(K,(R(K)/(lambdak*lambdaka(A)*deltaf(K,A)))**(deltaf(K,A)))*
     prod(L,(W(L)/(lambdat*lambda(A)*deltaf(L,A)))**(deltaf(L,A)))
);
VAPr1.m(A)=1;

VAPr2(A)$(sum(L,SAM(L,A))=0 and sum(K,SAM(K,A))>0 and not LinkA(A))..PVA(A)=e=
(
     prod(K,(R(K)/(lambdak*lambdaka(A)*deltaf(K,A)))**(deltaf(K,A)))
);
VAPr2.m(A)=1;

*VAPr0_Link(A)$(sum(L,SAM(L,A))>0 and sum(K,SAM(K,A))=0 and LinkA(A))..PVA(A)=e=
*(
*     prod(L,(W(L)/(lambdat*lambda(A)*deltaf(L,A)))**(deltaf(L,A)))
*);
*VAPr0_Link.m(A)=1;


*VAPr1_Link(A)$(sum(L,SAM(L,A))>0 and sum(K,SAM(K,A))>0 and LinkA(A))..PVA(A)=e=
*(
*     prod(K,(R(K)/(lambdak*lambdaka(A)*deltaf(K,A)))**(deltaf(K,A)))*
*     prod(L,(W(L)/(lambdat*lambda(A)*deltaf(L,A)))**(deltaf(L,A)))
*);
*VAPr1_Link.m(A)=1;

*VAPr2_Link(A)$(sum(L,SAM(L,A))=0 and sum(K,SAM(K,A))>0 and LinkA(A))..PVA(A)=e=
*(
*     prod(K,(R(K)/(lambdak*lambdaka(A)*deltaf(K,A)))**(deltaf(K,A)))
*);
*VAPr2_Link.m(A)=1;


XEPr0(A)$(sum(ELECC,SAM(ELECC,A))>0 and sum(ENC,SAM(ENC,A))=0 and not LinkA(A) )..PEP(A)=e=prod(C$ELECC(C),(PA(C)/deltaC(C,A))**(deltaC(C,A)));
XEPr0.m(A)=1;



XEPr1(A)$(sum(ELECC,SAM(ELECC,A))>0 and sum(ENC,SAM(ENC,A))>0 and not LinkA(A))..PEP(A)=e=
  prod(C$ELECC(C),(PA(C)/deltaC(C,A))**(deltaC(C,A)))*
(
PFL(A)/
(1-sum(C$ELECC(C),deltaC(C,A)))
)**
(
1-sum(C$ELECC(C),deltaC(C,A))
)
;
XEPr1.m(A)=1;
XEPr2(A)$(sum(ELECC,SAM(ELECC,A))=0 and sum(ENC,SAM(ENC,A))>0 and not LinkA(A))..PEP(A)=e=PFL(A);
XEPr2.m(A)=1;

*XEPr0_Link(A)$(sum(ELECC,SAM(ELECC,A))>0 and sum(ENC,SAM(ENC,A))=0 and LinkA(A) )..PEP(A)=e=prod(C$ELECC(C),(PA(C)/deltaC(C,A))**(deltaC(C,A)));
*XEPr0_Link.m(A)=1;



*XEPr1_Link(A)$(sum(ELECC,SAM(ELECC,A))>0 and sum(ENC,SAM(ENC,A))>0 and LinkA(A))..PEP(A)=e=
*  prod(C$ELECC(C),(PA(C)/deltaC(C,A))**(deltaC(C,A)))*
*(
*PFL(A)/
*(1-sum(C$ELECC(C),deltaC(C,A)))
*)**
*(
*1-sum(C$ELECC(C),deltaC(C,A))
*)
*;
*XEPr1_Link.m(A)=1;
*XEPr2_Link(A)$(sum(ELECC,SAM(ELECC,A))=0 and sum(ENC,SAM(ENC,A))>0 and LinkA(A))..PEP(A)=e=PFL(A);
*XEPr2_Link.m(A)=1;



XFLPr0(A)$(sum(C$sfuel(C),SAM(C,A)=0) and sum(C$Lfuel(C), SAM(C,A))>0 and not LinkA(A))..PFL(A)=e=PLFL(A);
XFLPr0.m(A)=1;

XFLPr1(A)$(sum(C$sfuel(C),SAM(C,A) >0) and sum(C$Lfuel(C), SAM(C,A))>0 and not LinkA(A))..PFL(A)=e=
(
sum(C$SfuelA(A,C),deltaC(C,A)**sigmaaXFL(A)*(PNEG(C,A)/AEEI(C,A))**(1-sigmaaXFL(A)))
+
(1-sum(C$SfuelA(A,C),deltaC(C,A)))**(sigmaaXFL(A))*PLFL(A)**(1-sigmaaXFL(A))
)**(1/(1-sigmaaXFL(A)));
XFLPr1.m(A)=1;

XFLPr2(A)$(sum(C$sfuel(C),SAM(C,A) >0) and sum(C$Lfuel(C), SAM(C,A))=0 and Sfuel_single(A) eq 1 and not LinkA(A))..PFL(A)=e=
(
sum(C$SfuelA(A,C),deltaC(C,A)**sigmaaXFL(A)*(PNEG(C,A)/AEEI(C,A))**(1-sigmaaXFL(A)))
)**(1/(1-sigmaaXFL(A)));
XFLPr2.m(A)=1;

XFLPr3(A)$(sum(C$sfuel(C),SAM(C,A) >0) and sum(C$Lfuel(C), SAM(C,A))=0 and Sfuel_single(A) eq 0 and not LinkA(A))..PFL(A)=e=sum(C$(Sfuel(C) and SfuelA(A,C)),PNEG(C,A))/sum(C$(Sfuel(C) and SfuelA(A,C)),AEEI(C,A));
XFLPr3.m(A)=1;

*XFLPr0_Link(A)$(sum(C$sfuel(C),SAM(C,A)=0) and sum(C$Lfuel(C), SAM(C,A))>0 and LinkA(A))..PFL(A)=e=PLFL(A);
*XFLPr0_Link.m(A)=1;

*XFLPr1_Link(A)$(sum(C$sfuel(C),SAM(C,A) >0) and sum(C$Lfuel(C), SAM(C,A))>0 and LinkA(A))..PFL(A)=e=
*(
*sum(C$SfuelA(A,C),deltaC(C,A)**sigmaaXFL(A)*(PNEG(C,A)/AEEI(C,A))**(1-sigmaaXFL(A)))
*+
*(1-sum(C$SfuelA(A,C),deltaC(C,A)))**(sigmaaXFL(A))*PLFL(A)**(1-sigmaaXFL(A))
*)**(1/(1-sigmaaXFL(A)));
*XFLPr1_Link.m(A)=1;

*XFLPr2_Link(A)$(sum(C$sfuel(C),SAM(C,A) >0) and sum(C$Lfuel(C), SAM(C,A))=0 and Sfuel_single(A) eq 1 and LinkA(A))..PFL(A)=e=
*(
*sum(C$SfuelA(A,C),deltaC(C,A)**sigmaaXFL(A)*(PNEG(C,A)/AEEI(C,A))**(1-sigmaaXFL(A)))
*)**(1/(1-sigmaaXFL(A)));
*XFLPr2_Link.m(A)=1;

*XFLPr3_Link(A)$(sum(C$sfuel(C),SAM(C,A) >0) and sum(C$Lfuel(C), SAM(C,A))=0 and Sfuel_single(A) eq 0 and LinkA(A))..PFL(A)=e=sum(C$(Sfuel(C) and SfuelA(A,C)),PNEG(C,A))/sum(C$(Sfuel(C) and SfuelA(A,C)),AEEI(C,A));
*XFLPr3_Link.m(A)=1;



XLFLPr0(A)$(Lfuel_single(A) eq 0 and not LinkA(A))..PLFL(A)=e=sum(C$(ENC(C) and LfuelA(A,C)),PNEG(C,A))/sum(C$(ENC(C) and LfuelA(A,C)),AEEI(C,A));
XLFLPr0.m(A)=1;

XLFLPr1(A)$(Lfuel_single(A) eq 1 and not LinkA(A))..PLFL(A)=e=
prod(C$LfuelA(A,C),(PNEG(C,A)/(deltaC(C,A)*AEEI(C,A)))**deltaC(C,A))
;
XLFLPr1.m(A)=1;

*XLFLPr0_Link(A)$(Lfuel_single(A) eq 0 and LinkA(A))..PLFL(A)=e=sum(C$(ENC(C) and LfuelA(A,C)),PNEG(C,A))/sum(C$(ENC(C) and LfuelA(A,C)),AEEI(C,A));
*XLFLPr0_Link.m(A)=1;

*XLFLPr1_Link(A)$(Lfuel_single(A) eq 1 and LinkA(A))..PLFL(A)=e=
*prod(C$LfuelA(A,C),(PNEG(C,A)/(deltaC(C,A)*AEEI(C,A)))**deltaC(C,A))
*;
*XLFLPr1_Link.m(A)=1;


NEGPr(C,A)$(FuelA(A,C) and ghg(C,A)=0 and not LinkA(A) )..PA(C)=e=PNEG(C,A);
NEGPr.m(C,A)=1;

NEGPrco(C,A)$(FuelA(A,C) and ghg(C,A)>0 and not LinkA(A))..PA(C)+sum(GC,thetaE(GC,C,A)*cpi*gtax(GC))=e=PNEG(C,A);
NEGPrco.m(C,A)=1;

NEGPr_Link(C,A)$(FuelA(A,C) and ghg(C,A)=0 and LinkA(A))..PA(C)=e=PNEG(C,A);
NEGPr.m(C,A)=1;

NEGPrco_Link(C,A)$(FuelA(A,C) and ghg(C,A)>0 and LinkA(A))..PA(C)+sum(GC,thetaE(GC,C,A)*cpi*gtax(GC))=e=PNEG(C,A);
NEGPrco.m(C,A)=1;



*NEGPr(C,A)$(ghg(C,A)>0)..PA(C)+sum(GC,thetaE(GC,C,A)*gtax(GC)*cpi)=e=PNEG(C,A);
*NEGPr.m(C,A)=1;

*Numeria
Norm..cpi=e=sum(C,PA(C)*cwrt(C));
Norm.m=1;
CPIfix..cpi=e=cpi_o;
CPIfix.m=1;

*Production and Trade block
QVAED(A)$(sum(C,SAM(A,C))>0 and not LinkA(A))..QVAE(A)=e=XC(A);
QVAED.m(A)=1;

*QVAED_Link(A)$(sum(C,SAM(A,C))>0 and LinkA(A))..QVAE(A)=e=XC(A);
*QVAED_Link.m(A)=1;


XVAD0(A)$(sum(ELECC,SAM(ELECC,A))+sum(ENC,SAM(ENC,A))=0 and sum(F,SAM(F,A))>0 and not LinkA(A))..VA(A)=e=(1/alphaaVAE(A))*QVAE(A);
XVAD0.m(A)=1;

XVAD1(A)$(sum(ELECC,SAM(ELECC,A))+sum(ENC,SAM(ENC,A))>0 and sum(F,SAM(F,A))>0 and not LinkA(A))..VA(A)=e=(deltaVA(A)**sigmaaVAE(A))*((PVAE(A)/PVA(A))**sigmaaVAE(A))*( alphaaVAE(A)**(sigmaaVAE(A)-1))*QVAE(A);
XVAD1.m(A)=1;

*XVAD0_Link(A)$(sum(ELECC,SAM(ELECC,A))+sum(ENC,SAM(ENC,A))=0 and sum(F,SAM(F,A))>0  and LinkA(A))..VA(A)=e=(1/alphaaVAE(A))*QVAE(A);
*XVAD0_Link.m(A)=1;

*XVAD1_Link(A)$(sum(ELECC,SAM(ELECC,A))+sum(ENC,SAM(ENC,A))>0 and sum(F,SAM(F,A))>0  and LinkA(A))..VA(A)=e=(deltaVA(A)**sigmaaVAE(A))*((PVAE(A)/PVA(A))**sigmaaVAE(A))*( alphaaVAE(A)**(sigmaaVAE(A)-1))*QVAE(A);
*XVAD1_Link.m(A)=1;

XAGD(A)$(sum(AgriC,SAM(AgriC,A))>0 and not linkA(A))..XAG(A)=e=XC(A);
XAGD.m(A)=1;
*XAGD_Link(A)$(sum(AgriC,SAM(AgriC,A))>0 and linkA(A))..XAG(A)=e=XC(A);
*XAGD_Link.m(A)=1;

XEPD1(A)$(sum(ELECC,SAM(ELECC,A))+sum(ENC,SAM(ENC,A))>0 and sum(F,SAM(F,A))>0 and not LinkA(A))..XEP(A)=e=(deltaXEP(A)**sigmaaVAE(A))*((PVAE(A)/PEP(A))**sigmaaVAE(A))*( alphaaVAE(A)**(sigmaaVAE(A)-1))*QVAE(A);
XEPD1.m(A)=1;

XEPD2(A)$(sum(ELECC,SAM(ELECC,A))+sum(ENC,SAM(ENC,A))>0 and sum(F,SAM(F,A))=0 and not LinkA(A))..XEP(A)=e=(1/alphaaVAE(A))*QVAE(A);
XEPD2.m(A)=1;

*XEPD1_Link(A)$(sum(ELECC,SAM(ELECC,A))+sum(ENC,SAM(ENC,A))>0 and sum(F,SAM(F,A))>0  and LinkA(A))..XEP(A)=e=(deltaXEP(A)**sigmaaVAE(A))*((PVAE(A)/PEP(A))**sigmaaVAE(A))*( alphaaVAE(A)**(sigmaaVAE(A)-1))*QVAE(A);
*XEPD1_Link.m(A)=1;

*XEPD2_Link(A)$(sum(ELECC,SAM(ELECC,A))+sum(ENC,SAM(ENC,A))>0 and sum(F,SAM(F,A))=0  and LinkA(A))..XEP(A)=e=(1/alphaaVAE(A))*QVAE(A);
*XEPD2_Link.m(A)=1;



LDA1(L,A)$(sum(LP,SAM(LP,A))>0 and not LinkA(A))..LD(L,A)=e=deltaf(L,A)*(PVA(A)*VA(A))/W(L);
LDA1.m(L,A)=1;

KDA1(K,A)$(sum(KP,SAM(KP,A))>0 and not LinkA(A))..KD(K,A)=e=deltaf(K,A)*(PVA(A)*VA(A))/R(K);
KDA1.m(K,A)=1;

*LDA1_Link(L,A)$(sum(LP,SAM(LP,A))>0 and LinkA(A))..LD(L,A)=e=deltaf(L,A)*(PVA(A)*VA(A))/W(L);
*LDA1_Link.m(L,A)=1;

*KDA1_Link(K,A)$(sum(KP,SAM(KP,A))>0 and LinkA(A))..KD(K,A)=e=deltaf(K,A)*(PVA(A)*VA(A))/R(K);
*KDA1_Link.m(K,A)=1;

*LDA1_Link(L,A)$(sum(LP,SAM(LP,A))>0 and LinkA(A))..LD(L,A)=e=ifa(L,A)*XC(A);
LDA1_Link(L,A)$(sum(LP,SAM(LP,A))>0 and LinkA(A))..LD(L,A)=e=LD_bottom(L,A);
LDA1_Link.m(L,A)=1;

*KDA1_Link(K,A)$(sum(KP,SAM(KP,A))>0 and LinkA(A))..KD(K,A)=e=ifa(K,A)*XC(A);
KDA1_Link(K,A)$(sum(KP,SAM(KP,A))>0 and LinkA(A))..KD(K,A)=e=KD_bottom(K,A);
KDA1_Link.m(K,A)=1;

*ZD_Link(A)$(LinkA(A))..ZD(A)=e=iza(A)*XC(A);
ZD_Link(A)$(LinkA(A))..ZD(A)=e=ZD_bottom(A);
ZD_Link.m(A)=1;

XFLD1(A)$(sum(ELECC,SAM(ELECC,A))>0 and sum(ENC,SAM(ENC,A))>0 and not LinkA(A))..XFL(A)=e=(1-sum(C$ELECC(C),deltaC(C,A)))*(PEP(A)/PFL(A))*XEP(A);
XFLD1.m(A)=1;
XFLD2(A)$(sum(ELECC,SAM(ELECC,A))=0 and sum(ENC,SAM(ENC,A))>0 and not LinkA(A))..XFL(A)=e=XEP(A);
XFLD2.m(A)=1;

*XFLD1_Link(A)$(sum(ELECC,SAM(ELECC,A))>0 and sum(ENC,SAM(ENC,A))>0 and LinkA(A))..XFL(A)=e=(1-sum(C$ELECC(C),deltaC(C,A)))*(PEP(A)/PFL(A))*XEP(A);
*XFLD1_Link.m(A)=1;
*XFLD2_Link(A)$(sum(ELECC,SAM(ELECC,A))=0 and sum(ENC,SAM(ENC,A))>0 and LinkA(A))..XFL(A)=e=XEP(A);
*XFLD2_Link.m(A)=1;


INTDE1(C,A)$(ELECC(C) and SAM(C,A)$ELECC(C)>0 and not LinkA(A))..XAP(C,A)=e= deltaC(C,A)*(PEP(A)/PA(C))*XEP(A);
INTDE1.m(C,A)=1;

*INTDE1_Link(C,A)$(ELECC(C) and SAM(C,A)$ELECC(C)>0 and LinkA(A))..XAP(C,A)=e= deltaC(C,A)*(PEP(A)/PA(C))*XEP(A);
*INTDE1_Link.m(C,A)=1;

*INTDE1_Link(C,A)$(ELECC(C) and SAM(C,A)$ELECC(C)>0 and LinkA(A))..XAP(C,A)=e= iea(C,A)*XC(A);
INTDE1_Link(C,A)$(ELECC(C) and SAM(C,A)$ELECC(C)>0 and LinkA(A))..XAP(C,A)=e= XAP_bottom(C,A);
INTDE1_Link.m(C,A)=1;


XLFLD0(A)$(sum(C$sfuel(C),SAM(C,A)=0) and (sum(CP$Lfuel(CP),SAM(CP,A)) >0) and not LinkA(A))..XLFL(A)=e=XFL(A);
XLFLD0.m(A)=1;

*XLFLD0_Link(A)$(sum(C$sfuel(C),SAM(C,A)=0) and (sum(CP$Lfuel(CP),SAM(CP,A)) >0) and LinkA(A))..XLFL(A)=e=XFL(A);
*XLFLD0_Link.m(A)=1;



NEGDS1(C,A)$(SfuelA(A,C) and (sum(CP$Lfuel(CP),SAM(CP,A)) >0) and not LinkA(A))..QNEG(C,A)=e=                (deltaC(C,A)**sigmaaXFL(A))*((PFL(A)/PNEG(C,A))**sigmaaXFL(A))*((AEEI(C,A))**(sigmaaXFL(A)-1))*XFL(A);
NEGDS1.m(C,A)=1;

NEGDS2(C,A)$(SfuelA(A,C) and (sum(CP$Lfuel(CP),SAM(CP,A))=0) and Sfuel_single(A) eq 1 and not LinkA(A))..QNEG(C,A)=e=                (deltaC(C,A)**sigmaaXFL(A))*((PFL(A)/PNEG(C,A))**sigmaaXFL(A))*((AEEI(C,A))**(sigmaaXFL(A)-1))*XFL(A);
NEGDS2.m(C,A)=1;

NEGDS3(C,A)$(SfuelA(A,C) and (sum(CP$Lfuel(CP),SAM(CP,A))=0) and Sfuel_single(A) eq 0 and not LinkA(A))..QNEG(C,A)=e=(1/AEEI(C,A))*XFL(A);
NEGDS3.m(C,A)=1;

*NEGDS1_Link(C,A)$(SfuelA(A,C) and (sum(CP$Lfuel(CP),SAM(CP,A)) >0) and LinkA(A))..QNEG(C,A)=e=                (deltaC(C,A)**sigmaaXFL(A))*((PFL(A)/PNEG(C,A))**sigmaaXFL(A))*((AEEI(C,A))**(sigmaaXFL(A)-1))*XFL(A);
*NEGDS1_Link.m(C,A)=1;

*NEGDS2_Link(C,A)$(SfuelA(A,C) and (sum(CP$Lfuel(CP),SAM(CP,A))=0) and Sfuel_single(A) eq 1 and LinkA(A))..QNEG(C,A)=e=                (deltaC(C,A)**sigmaaXFL(A))*((PFL(A)/PNEG(C,A))**sigmaaXFL(A))*((AEEI(C,A))**(sigmaaXFL(A)-1))*XFL(A);
*NEGDS2_Link.m(C,A)=1;

*NEGDS3_Link(C,A)$(SfuelA(A,C) and (sum(CP$Lfuel(CP),SAM(CP,A))=0) and Sfuel_single(A) eq 0 and LinkA(A))..QNEG(C,A)=e=(1/AEEI(C,A))*XFL(A);
*NEGDS3_Link.m(C,A)=1;

*NEGDS1_Link(C,A)$(SfuelA(A,C) and (sum(CP$Lfuel(CP),SAM(CP,A)) >0) and LinkA(A))..QNEG(C,A)=e=ifuela(C,A)*XC(A);
NEGDS1_Link(C,A)$(SfuelA(A,C) and (sum(CP$Lfuel(CP),SAM(CP,A)) >0) and LinkA(A))..QNEG(C,A)=e=QNEG_bottom(C,A);
NEGDS1_Link.m(C,A)=1;

*NEGDS2_Link(C,A)$(SfuelA(A,C) and (sum(CP$Lfuel(CP),SAM(CP,A))=0) and Sfuel_single(A) eq 1 and LinkA(A))..QNEG(C,A)=e=ifuela(C,A)*XC(A);
NEGDS2_Link(C,A)$(SfuelA(A,C) and (sum(CP$Lfuel(CP),SAM(CP,A))=0) and Sfuel_single(A) eq 1 and LinkA(A))..QNEG(C,A)=e=QNEG_bottom(C,A);
NEGDS2_Link.m(C,A)=1;

*NEGDS3_Link(C,A)$(SfuelA(A,C) and (sum(CP$Lfuel(CP),SAM(CP,A))=0) and Sfuel_single(A) eq 0 and LinkA(A))..QNEG(C,A)=e=ifuela(C,A)*XC(A);
NEGDS3_Link(C,A)$(SfuelA(A,C) and (sum(CP$Lfuel(CP),SAM(CP,A))=0) and Sfuel_single(A) eq 0 and LinkA(A))..QNEG(C,A)=e=QNEG_bottom(C,A);
NEGDS3_Link.m(C,A)=1;



XLFLD1(A)$(sum(C$sfuel(C),SAM(C,A) >0) and (sum(CP$Lfuel(CP),SAM(CP,A)) >0) and not LinkA(A))..XLFL(A)=e=(1-sum(C$sfuel(C),deltaC(C,A)))**sigmaaXFL(A)*(PFL(A)/PLFL(A))**(sigmaaXFL(A))*XFL(A);
XLFLD1.m(A)=1;

*XLFLD1_Link(A)$(sum(C$sfuel(C),SAM(C,A) >0) and (sum(CP$Lfuel(CP),SAM(CP,A)) >0) and LinkA(A))..XLFL(A)=e=(1-sum(C$sfuel(C),deltaC(C,A)))**sigmaaXFL(A)*(PFL(A)/PLFL(A))**(sigmaaXFL(A))*XFL(A);
*XLFLD1_Link.m(A)=1;


NEGDL0(C,A)$(LfuelA(A,C) and Lfuel_single(A) eq 0 and not LinkA(A))..QNEG(C,A)=e= (1/AEEI(C,A))*XLFL(A);
NEGDL0.m(C,A)=1;

NEGDL1(C,A)$(LfuelA(A,C) and Lfuel_single(A) eq 1 and not LinkA(A))..QNEG(C,A)=e=deltaC(C,A)*(PLFL(A)/PNEG(C,A))*XLFL(A);
NEGDL1.m(C,A)=1;

*NEGDL0_Link(C,A)$(LfuelA(A,C) and Lfuel_single(A) eq 0 and LinkA(A))..QNEG(C,A)=e= (1/AEEI(C,A))*XLFL(A);
*NEGDL0_Link.m(C,A)=1;

*NEGDL1_Link(C,A)$(LfuelA(A,C) and Lfuel_single(A) eq 1 and LinkA(A))..QNEG(C,A)=e=deltaC(C,A)*(PLFL(A)/PNEG(C,A))*XLFL(A);
*NEGDL1_Link.m(C,A)=1;

*NEGDL0_Link(C,A)$(LfuelA(A,C) and Lfuel_single(A) eq 0 and LinkA(A))..QNEG(C,A)=e= ifuela(C,A)*XC(A);
NEGDL0_Link(C,A)$(LfuelA(A,C) and Lfuel_single(A) eq 0 and LinkA(A))..QNEG(C,A)=e=QNEG_bottom(C,A);
NEGDL0_Link.m(C,A)=1;

*NEGDL1_Link(C,A)$(LfuelA(A,C) and Lfuel_single(A) eq 1 and LinkA(A))..QNEG(C,A)=e=ifuela(C,A)*XC(A);
NEGDL1_Link(C,A)$(LfuelA(A,C) and Lfuel_single(A) eq 1 and LinkA(A))..QNEG(C,A)=e=QNEG_bottom(C,A);
NEGDL1_Link.m(C,A)=1;




INTDM(C,A)$((M(C) and not AgriC(C)) and SAM(C,A)$(M(C) and not AgriC(C))>0 and not LinkA(A))..XAP(C,A)=e=ica(C,A)*XC(A);
INTDM.m(C,A)=1;
INTDAG0(C,A)$(AgriC(C) and SAM(C,A)$AgriC(C)>0 and not LinkA(A) and Agri_single(A) eq 0)..XAP(C,A)=e=(1/alphaaAG(A))*XAG(A);
INTDAG0.m(C,A)=1;
INTDAG1(C,A)$(AgriC(C) and SAM(C,A)$AgriC(C)>0 and not LinkA(A) and Agri_single(A) eq 1)..XAP(C,A)=e=deltaC(C,A)*(PAG(A)/PA(C))*XAG(A);
INTDAG1.m(C,A)=1;
INTGD(GC,A)$(ghg('process',A)>0 and not LinkA(A))..QINTG(GC,A)=e=thetaP(GC,A)*XC(A);
INTGD.m(GC,A)=1;

*INTDM_Link(C,A)$(M(C) and SAM(C,A)$M(C)>0 and LinkA(A))..XAP(C,A)=e=ica(C,A)*XC(A);
INTDM_Link(C,A)$((M(C) and not AgriC(C)) and SAM(C,A)$(M(C) and not AgriC(C))>0 and LinkA(A))..XAP(C,A)=e=XAP_bottom(C,A);
INTDM_Link.m(C,A)=1;
*INTDAG0_Link(C,A)$(AgriC(C) and SAM(C,A)$AgriC(C)>0 and LinkA(A) and Agri_single(A) eq 0)..XAP(C,A)=e=(1/alphaaAG(A))*XAG(A);
INTDAG0_Link(C,A)$(AgriC(C) and SAM(C,A)$AgriC(C)>0 and LinkA(A) and Agri_single(A) eq 0)..XAP(C,A)=e=XAP_bottom(C,A);
INTDAG0_Link.m(C,A)=1;
*INTDAG1_Link(C,A)$(AgriC(C) and SAM(C,A)$AgriC(C)>0 and LinkA(A) and Agri_single(A) eq 1)..XAP(C,A)=e=deltaC(C,A)*(PAG(A)/PA(C))*XAG(A);
INTDAG1_Link(C,A)$(AgriC(C) and SAM(C,A)$AgriC(C)>0 and LinkA(A) and Agri_single(A) eq 1)..XAP(C,A)=e=XAP_bottom(C,A);
INTDAG1_Link.m(C,A)=1;
INTGD_Link(GC,A)$(ghg('process',A)>0 and LinkA(A))..QINTG(GC,A)=e=thetaP(GC,A)*XC(A);
INTGD_Link.m(GC,A)=1;



NELQCED(C,A)$(ENC(C) and SAM(C,A)$ENC(C)>0  and not LinkA(A))..QCE(C,A)=e=QNEG(C,A);
NELQCED.m(C,A)=1;

NELQCED_Link(C,A)$(ENC(C) and SAM(C,A)$ENC(C)>0  and LinkA(A))..QCE(C,A)=e=QNEG(C,A);
NELQCED_Link.m(C,A)=1;


GD(GC,C,A)$(GfuelA(A,C) and not LinkA(A))..QGE(GC,C,A)=e=thetaE(GC,C,A)*QNEG(C,A);
GD.m(GC,C,A)=1;

GD_Link(GC,C,A)$(GfuelA(A,C) and LinkA(A))..QGE(GC,C,A)=e=thetaE(GC,C,A)*QNEG(C,A);
GD.m(GC,C,A)=1;

*GD(GC,ENC,A)$(ghg(ENC,A)>0)..QGE(GC,ENC,A)=e=thetaE(GC,ENC,A)*QNEG(ENC,A);
*GD.m(GC,ENC,A)=1;

ActDC(A)$(sum(C,SAM(A,C))>0)..XC(A)=e=sum(C$XPXC(C,A),theta(A,C)*XP(C));
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
*ResM..Zs=g=sum(A$LinkA(A),ZD(A));
ResM..rent=e=sum(H,EY(H))/Zs;
ResM.m=1;


ComMENCN(C)$(ENCN(C)and not LinkC(C))..XA(C)=g=sum(A$XAPA(C,A),XAP(C,A))      +sum(H$XACH(H,C),XAC(C,H))+sum(FD$FD_C(C,FD),XAF(FD,C));
ComMENCN.m(C)=1;
ComMENCN_Link(C)$(ENCN(C) and LinkC(C))..XA(C)=e=sum(A$XAPA(C,A),XAP(C,A))      +sum(H$XACH(H,C),XAC(C,H))+sum(FD$FD_C(C,FD),XAF(FD,C));
ComMENCN_Link.m(C)=1;
ComMENC(C)$(ENC(C))..XA(C)=g=sum(A$XEPA(C,A) ,QCE(C,A ))+sum(H$XACH(H,C),XAC(C,H))+sum(FD$FD_C(C,FD),XAF(FD,C));
ComMENC.m(C)=1;





CREVE(A)$(ghg('process',A) eq 0)..CREV(A)=e=sum(GC,gtax(GC)*cpi*sum(C$GfuelA(A,C),QGE(GC,C,A)));
CREVE.m(A)=1;
CREVP(A)$(ghg('process',A) ne 0)..CREV(A)=e=sum(GC,gtax(GC)*cpi*sum(C$GfuelA(A,C),QGE(GC,C,A)))+sum(GC,gtax(GC)*QINTG(GC,A));
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
PVA0(A)
VA0(A)
PAG0(A)
XAG0(A)
*HKTE0(A)
*PHKTE0(A)
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

**initial point creating paremeters set as 0


CrevI_o=0;
gtaxrate_o=0.0;

CREV0(A)=gtaxrate_o*sam('CO2-c',A)+gtaxrate_o*ghg('process',A);
TCREV0=sum(A,CREV0(A));
*display CREV0;

*** Policy Scenario ***
* Scenario=0 : BAU
* Scenario=1 : TR
* Scenario=2 : GE
* Scenario=3 : GS
* Scenario=4 : LCUT
* Scenario=5 : NCUT
** Dynamic adjustments**

**carbon tax policy parameters
gtax(GC)=0;
CrevH_share(H)=sam(H,'Gov')/sum(HP,sam(HP,'Gov'));
parameter
gtaxp_BAU(GC,t)
/CO2-c.0 0/
*/CO2-c.0*19 0/

gtaxp_ctax(GC,t)
/CO2-c.0 1
*CO2-c.0*4 0
* CO2-c.5*9 1
* CO2-c.10*19  0
* CO2-c.20*21  0
/

;

*** policy simulation setting****
Scenario=0;
if (scenario=0,
gtax_policy(GC,t)=gtaxp_BAU(GC,t);
CrevH=0;
CrevC=0;
CrevI=0;
CrevIw(A)=0;
Crevtax=0;
elseif (scenario=1),
gtax(GC)=1;
gtax_policy(GC,t)=gtaxp_ctax(GC,t);
CrevH=1;
CrevC=0;
CrevI=0;
CrevIw(A)=0;
Crevtax=0;

elseif (scenario=2),
gtax_policy(GC,t)=gtaxp_ctax(GC,t);
CrevH=0;
CrevC=1;
CrevI=0;
CrevIw(A)=0;
Crevtax=0;

elseif (scenario=3),
gtax_policy(GC,t)=gtaxp_ctax(GC,t);
CrevH=0;
CrevC=0;
CrevI=0;
CrevIw(A)=0;
Crevtax=0;

else
gtax_policy(GC,t)=gtaxp_ctax(GC,t);
CrevH=0;
CrevC=0;
CrevI=0;
CrevIw(A)=0;
Crevtax=1;
);

*display
*CrevI_o,gtaxrate_o,CREV0,TCREV0,gtax,CrevH_share,gtaxp_BAU,gtaxp_ctax,scenario,gtax_policy,CrevH,CrevC,CrevI,CrevIW,Crevtax;

sigmaaVAE(A)=0.5;
sigmaaXFL(A)=0.5;
sigmat(C)=-0.3;
sigmaq('ELEC-c')=0.3;
sigmaq('GASHeat-c')=0.3;
sigmaq('OIL-c')=2.1;
sigmaq('COAL-c')=3.05;
sigmaq('ENIT-c')=3;
sigmaq('NEINT-c')=1.9;
*sigmaq(AgriC)=0.25;
sigmaq(LinkC)=0.25;


rhoaVAE(A)=(1/sigmaaVAE(A))-1;
rhoaXFL(A)=(1/sigmaaXFL(A))-1;
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
alpha_nres(A)=SAMng('NRES',A)/sum(ACT,samng(ACT,A));
thetaRes_c=sum(H,SAMng(H,'NRES'))/sum(A,SAMng('NRES',A));
thetaRes_iv=SAMng('S-I','NRES')/sum(A,SAMng('NRES',A));


*base year capital rent : IO capital payment + IO depreciation/ KPI DB 2010 Total capital stock evaluated in 2010 ppi (Unit: 1,000,000,000 won)

*R0(K)=sum(A,SAM(K,A))/3403090.255;
*R0(K)=sum(A,SAM(K,A))/6599755.655;
R0(K)=1;
KD0(K,A)=SAM(K,A)/R0(K);
Ks0(K)=sum(A,KD0(K,A));
display KD0,Ks0;
*KD_bottom(K,A)=KD0(K,A);
*base year wage : IO payroll / 2010 employment in Thousand
*W0(L)=sum(A,SAM(L,A))/23890;
W0(L)=1;
LD0(L,A)=SAM(L,A)/W0(L);
*depreciation
** delta=0.046;
delta=R0('Capital')*0.390061;
*rent0=0.05;
rent0=1;
ZD0(A)$LinkA(A)=0.0*sum(K,R0(K)*KD0(K,A))/rent0;
*Zs0=sum(A$LinkA(A),ZD0(A))
zs0=100;
KD0(K,A)$LinkA(A)=1*KD0(K,A);
Ks0(K)=sum(A,KD0(K,A));
display ZD0,zs0,KD0,Ks0;

*LD_bottom(L,A)=LD0(L,A);
**Price
PET0(C)$(SAM(C,'ROW') ne 0)=1;
PP0(C)$(sum(A,SAM(A,C))>0)=1;
PC0(A)=1;
PMT0(C)$(SAM('ROW',C) ne 0)=1;
PD0(C)$(sum(A,SAM(A,C))>0)=1;
PA0(C)=1;
EXR0=1;

XC0(A)$(sum(ACTpp,SAMng(A,ACTpp))>0)=sum(ACT,SAMng(ACT,A))/PC0(A);
*XC_bottom(A)$(LinkA(A))=XC0(A);
QCE0(ENC,A)$(sum(ACTpp,SAMng(A,ACTpp))>0)=SAM(ENC,A)/PA0(ENC);
XAP0(C,A)$(not ENC(C))=SAM(C,A)/PA0(C);

*ica(C,A)$(M(C) and not AgriC(C))=XAP0(C,A)/XC0(A);
ica(C,A)$(M(C))=XAP0(C,A)/XC0(A);
ifa(L,A)$(LinkA(A))=LD0(L,A)/XC0(A);
ifa(K,A)$(LinkA(A))=KD0(K,A)/XC0(A);
iea(C,A)$(EleccA(A,C) and LinkA(A))=XAP0(C,A)/XC0(A);
ifuela(C,A)$(FuelA(A,C) and LinkA(A))=(SAM(C,A)/PA0(C))/XC0(A);
iza(A)$(LinkA(A))=ZD0(A)/XC0(A);

display ica,ifa,iea,ifuela,iza;
display XC0;

QVAE0(A)$(sum(ACT,SAM(A,ACT))>0)=XC0(A);
PVAE0(A)$(sum(ACT,SAM(A,ACT))>0)=(sum(F,SAMng(F,A))+sum(C$ELECC(C),SAMng(C,A))+sum(C$ENC(C),SAMng(C,A))+sum(ENC,gtaxrate_o*ghg(ENC,A)))/QVAE0(A);

XAG0(A)$(sum(C$AgriC(C),SAM(C,A))>0)=XC0(A);
PAG0(A)$(sum(C$AgriC(C),SAM(C,A))>0)=sum(C$AgriC(C),SAMng(C,A))/XC0(A);

display XAG0,PAG0;

deltaC(C,A)$(AgriC(C) and SAM(C,A)$AgriC(C)>0)=SAM(C,A)/sum(CP$AgriC(CP),SAM(CP,A));

alphaaAG(A)$(sum(C$AgriC(C),SAM(C,A))>0)=XAG0(A)/prod(C$AgriC(C),XAP0(C,A)**deltaC(C,A));

*display deltaC,alphaaAG;

parameter PAG1(A);

PAG1(A)$(sum(C$AgriC(C),SAM(C,A))>0)=(1/alphaaAG(A))*prod(C$(AgriC(C) and SAM(C,A)$AgriC(C)>0),(PA0(C)/deltaC(C,A))**deltaC(C,A));
display PAG1;

parameter XAP1(C,A);

XAP1(C,A)$(Agric(C) and SAM(C,A)$AgriC(C)>0)=deltaC(C,A)*(PAG0(A)*XAG0(A))/PA0(C);
display XAP0,XAP1;

QGE0(GC,C,A)=ghg(C,A);
thetaE(GC,C,A)$(QCE0(C,A)>0)=QGE0(GC,C,A)/QCE0(C,A);

QINTG0(GC,A)$(ghg('process',A)>0)=ghg('process',A);
thetaP(GC,A)$(XC0(A)>0 and ghg('process',A)>0)=QINTG0(GC,A)/XC0(A);

PNEG0(C,A)$(ENC(C) and (sum(ACT,SAM(A,ACT))>0))=PA0(C)+sum(GC,thetaE(GC,C,A)*gtaxrate_o);
QNEG0(C,A)$(ENC(C) and (sum(ACT,SAM(A,ACT))>0))=(QCE0(C,A)*PA0(C)+sum(GC,gtaxrate_o*QGE0(GC,C,A)))/PNEG0(C,A);

deltaF(L,A)=SAM(L,A)/sum(F,SAM(F,A));
deltaF(K,A)=SAM(K,A)/sum(F,SAM(F,A));


VA0(A)$(sum(ACT,SAM(ACT,A)>0))=prod(L,(lambdat*lambda(A)*LD0(L,A))**deltaF(L,A))*prod(K,(lambdak*lambdaka(A)*KD0(K,A))**deltaF(K,A));
PVA0(A)$(sum(ACT,SAM(ACT,A)>0))=sum(F,SAM(F,A))/VA0(A);



deltaC(C,A)$(Lfuel(C) and (SAM(C,A)>0))=SAM(C,A)/sum(CP$Lfuel(CP),sam(CP,A));

parameter

XLFL0(A)
PLFL0(A);

XLFL0(A)=prod(C$Lfuel(C),(AEEI(C,A)*QNEG0(C,A))**deltac(C,A));

PLFL0(A)=(sum(C$Lfuel(C),SAMng(C,A))+sum(C$Lfuel(C),gtaxrate_o*ghg(C,A)))/XLFL0(A);





parameter

deltaXLFL(A)
KC_XFL(C,A)
KET(C)
KDM(C);

KC_XFL(C,A)$(Sfuel(C) and (sam(C,A)>0))=
((PLFL0(A)/PNEG0(C,A))**(1-sigmaaXFL(A))*((SAM(C,A)+gtaxrate_o*ghg(C,A))/sum(CP$LFuel(CP),SAM(CP,A)+gtaxrate_o*ghg(CP,A)))*(1/AEEI(C,A))**(1-sigmaaXFL(A)))**(1/sigmaaXFL(A));
deltaXLFL(A)=1/(1+sum(C$(sfuel(C)and(sam(C,A)>0)),KC_XFL(C,A)));
deltaC(C,A)$(Sfuel(C) and (sam(C,A)>0))=KC_XFL(C,A)*deltaXLFL(A);


XFL0(A)$(sum (C$sfuel(C), sam(C,A))>0)=
(sum(C$(sfuel(C) and (sam(C,A)>0)),deltaC(C,A)*(QNEG0(C,A)*AEEI(C,A))**(-rhoaXFL(A)))
+(1-sum(C$(sfuel(C) and (sam(C,A)>0)),deltaC(C,A)))*XLFL0(A)**(-rhoaXFL(A)))**(-1/rhoaXFL(A));

XFL0(A)$(sum (C$sfuel(C), sam(C,A)=0))=XLFL0(A);

PFL0(A)$(sum (C$sfuel(C), sam(C,A))>0)=
(sum(C$ENC(C),SAMng(C,A))+sum(ENC,gtaxrate_o*ghg(ENC,A)))/XFL0(A);

PFL0(A)$(sum(C$sfuel(C),SAM(C,A)=0))=PLFL0(A);





deltaC(C,A)$(ELECC(C) and (SAM(C,A)>0))=SAM(C,A)/(sum(CP$ENC(CP),SAMng(CP,A))+sum(CP$ELECC(CP),SAMng(CP,A))+sum(ENC,gtaxrate_o*ghg(ENC,A)));

XEP0(A)=prod(C$ELECC(C),XAP0(C,A)**deltaC(C,A))*(XFL0(A)**(1-sum(C$ELECC(C),deltaC(C,A))));

PEP0(A)=(sum(C$ELECC(C),SAMng(C,A))+sum(C$ENC(C),SAMng(C,A))+sum(ENC,gtaxrate_o*ghg(ENC,A)))/XEP0(A);

parameter
KEP(A)
;

KEP(A)=
(
 (PEP0(A)/PVA0(A))**(sigmaaVAE(A)-1)*
 (
  (
   sum(C$ELECC(C),SAMng(C,A))+sum(C$ENC(C),SAMng(C,A))+sum(ENC,gtaxrate_o*ghg(ENC,A))
   )
   /
    sum(F,SAMng(F,A))
  )
)**(1/sigmaaVAE(A));
deltaXEP(A)=KEP(A)/(1+KEP(A));
deltaVA(A)=1/(1+KEP(A));

alphaaVAE(A)$(sum(ACT,SAM(A,ACT))>0)=QVAE0(A)/(deltaXEP(A)*XEP0(A)**(-rhoaVAE(A))+deltaVA(A)*VA0(A)**(-rhoaVAE(A)))**(-1/rhoaVAE(A));


theta(A,C)$((sum(ACT,SAM(A,ACT))>0) and (sum(AP,SAM(AP,C))>0))=(SAM(A,C)/PP0(C))/XC0(A);


** tax parameters

ta_in(A)$((sum(ACT,SAM(A,ACT))>0))=SAMng('Ptaxin',A)/sum(ACT,samng(ACT,A));
ta_ex(A)$((sum(ACT,SAM(A,ACT))>0))=SAMng('Ptaxetc',A)/sum(ACT,samng(ACT,A));

te(C)$(SAM(C,'ROW') ne 0)=0;
tm(C)$(SAM('ROW',C) ne 0)=SAM('Tarrif',C)/SAM('ROW',C);

** Trade related parameters
*(i) world price
pwm(C)$(SAM('ROW',C) ne 0)=PMT0(C)/((1+tm(C))*EXR0);
pwe(C)$(SAM(C,'ROW') ne 0)=PET0(C)/((1-te(C))*EXR0);

*(ii) CET coefficient**

ES0(C)$(SAM(C,'ROW') ne 0)=SAM(C,'ROW')/PET0(C);
XD0(C)$(sum(A,SAM(A,C))>0)=(sum(A,SAM(A,C))-SAM(C,'ROW'))/PD0(C);

KET(C)$(SAM(C,'ROW') ne 0 and (sum(A,SAM(A,C))>0))=((ES0(C)/XD0(C))*((PET0(C)/PD0(C))**sigmat(C)))**(1/sigmat(C));
deltat(C)$(SAM(C,'ROW') ne 0 and (sum(A,SAM(A,C))>0))=KET(C)/(1+KET(C));

XP0(C)$((sum(A,SAM(A,C))>0))=(PET0(C)*ES0(C)+XD0(C)*PD0(C))/PP0(C);

alphat(C)$(SAM(C,'ROW') ne 0)=XP0(C)/((deltat(C)*(ES0(C)**(rhot(C)))+(1-deltat(C))*(XD0(C))**(rhot(C)))**(1/rhot(C)));


**(iii) Armington Coefficient**
XMT0(C)$(SAM('ROW',C) ne 0)=(SAM('ROW',C)+SAM('Tarrif',C))/PMT0(C);
XA0(C)=(sum(ACT,SAM(ACT,C))-SAM(C,'ROW'))/PA0(C);
KDM(C)$((SAM('ROW',C) ne 0) and (sum(A,SAM(A,C))>0))=((XD0(C)/XMT0(C))*((PD0(C)/PMT0(C))**sigmaq(C)))**(1/sigmaq(C));
deltaq(C)$((SAM('ROW',C) ne 0)and (sum(A,SAM(A,C))>0))=KDM(C)/(1+KDM(C));

alphaq(C)$((SAM('ROW',C) ne 0)and (sum(A,SAM(A,C))>0))=XA0(C)/((deltaq(C)*(XD0(C)**(-rhoq(C)))+(1-deltaq(C))*(XMT0(C))**(-rhoq(C)))**(-1/rhoq(C)));




cwrt(C)=sum(H,SAM(C,H)/PA0(C))/sum((CP,H),SAM(CP,H));
cpi_o=sum(C,cwrt(C)*PA0(C));

*display deltat, deltaq, alphat, alphaq, cwrt, cpi;

tm_in=SAM('Ptaxin','ROW')/(sum(C,SAM('ROW',C))+sum(C,SAM('Tarrif',C)));
FSAV0=SAM('S-I','ROW');
* FSAD is exogenous. It will be fit to forcasted trade balance growth rate
FSAD=1;

** Household **

TR0(H)=SAM(H,'Gov');
* Oldpop: 2010 65+ popluation (Census, not projection) in thousand 5424.667 (Kosis)
Oldpop=5424.667;
tr0_per(H)=TR0(H)/Oldpop;

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
*mu(C)=SAM22(C,'Household')/(SAM22('Household','Total')-SAM22('inc_tax','Household'));
*mus=SAM22('S-I','Household')/(SAM22('Household','Total')-SAM22('inc_tax','Household'));
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

*tc_recover(tc,j)=theta_tc_j(tc,j)*q_outj0(j);

*display Agricost,tc_recover;


Model
BRAgri Agri specific model with 19 inds
/ImPr.XMT
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
ActR_Link
ActRp_Link

VAEPr0
VAEPr1
VAEPr2
*VAEPr0_Link
*VAEPr1_Link
*VAEPr2_Link

VAGPr
*VAGPr_Link

VAPr0
VAPr1
VApr2
*VAPr0_Link
*VAPr1_Link
*VApr2_Link

XEPr0
XEPr1
XEPr2
*XEPr0_Link
*XEPr1_Link
*XEPr2_Link

XFLPr0
XFLPr1
XFLPr2
XFLPr3
*XFLPr0_Link
*XFLPr1_Link
*XFLPr2_Link
*XFLPr3_Link

XLFLPr0
XLFLPr1
*XLFLPr0_Link
*XLFLPr1_Link

NEGPr.QNEG
NEGPrco.QNEG
NEGPr_Link.QNEG
NEGPrco_Link.QNEG

Norm
CPIfix
QVAED
*QVAED_Link
*HKTED
XVAD0
XVAD1
*XVAD0_Link
*XVAD1_Link
XAGD
*XAGD_Link

XEPD1
XEPD2
*XEPD1_Link
*XEPD2_Link

XFLD1
XFLD2
*XFLD1_Link
*XFLD2_Link

XLFLD0
XLFLD1
*XLFLD0_Link
*XLFLD1_Link

INTDM
INTDE1
INTDAG0
INTDAG1
INTGD

INTDM_Link
INTDE1_Link
INTGD_Link
INTDAG0_Link
INTDAG1_Link


LDA1
KDA1

LDA1_Link
KDA1_Link
ZD_Link

NEGDL0.PNEG
NEGDL1.PNEG
NEGDL0_Link.PNEG
NEGDL1_Link.PNEG

NEGDS1.PNEG
NEGDS2.PNEG
NEGDS3.PNEG
NEGDS1_Link.PNEG
NEGDS2_Link.PNEG
NEGDS3_Link.PNEG


NELQCED
GD
NELQCED_Link
GD_Link

ActDC.PC
XDD.PD
XDDni.PD

XMTD.PMT
XMTDnd.PMT

ESS.PET
ESSnd.PET

XDS.PP
XDSne.PP

Labsup

InvD
HouseLY
HouseKY
HouseEY
HouseYD
HouseY
Saver
HouseD
Hsave
GovE
Tras
Ytax
ForS
GovI

LabM.W
CapM.R
ResM
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


*** setting up initial values *****

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
PVA.L(A)=PVA0(A);
VA.L(A)=VA0(A);
PAG.L(A)=PAG0(A);
XAG.L(A)=XAG0(A);
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
BRAgri.HOLDFIXED=1;

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
PVAREP(A,t)
VAREP(A,t)
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

TGC(t,GC)

SAMDIFF(*,ACT,ACTPP)
DiFFT
gtaxrep(GC,t)
CPIREP(t)
XCRANDOMREP(t)
;

**====================Growth parameters=======================================**
parameter
P_out(LinkC)
P_in(C)
Pfuel_in(C,A)
W_in(L)
R_in(K)
Demand_out(LinkC)
Demand_j(j)
P_out_j(j)
XC_random
input_random;

Parameter
lgrow(t)
/
0        0.012448977
/

*/
*0        0.012448977
*1        0.008892301
*2        0.008096868
*3        0.00728179
*4        0.006615232
*5        0.006001972
*6        0.005021899
*7        0.004052835
*8        0.00298126
*9        0.00179908
*10        0.000834248
*11        -0.000893969
*12        -0.002016679
*13        -0.002728503
*14        -0.003829394
*15        -0.004314396
*16        -0.005025214
*17        -0.005086038
*18        -0.005678136
*19        -0.006222761
*20       -0.002
*21        0
*/

lpgrow(t)


/0    0.02575/
*/0*3  0.02575
*4*9   0.03975
*10*14 0.03975
*15*18 0.03975
*19    0.03975
*20    0.0124
*21    0
*/

Oldpopg(t)

/
0        0.037322398
/

*/
*0        0.037322398
*1        0.041316374
*2        0.042112171
*3        0.040382703
*4        0.037359454
*5        0.03613763
*6        0.037182778
*7        0.038948803
*8        0.043209213
*9        0.047767604
*10        0.049596764
*11        0.050243481
*12        0.050359098
*13        0.050615125
*14        0.050558217
*15        0.049255571
*16        0.046129876
*17        0.041706764
*18        0.037901921
*19        0.035134785
*20        0.0351
*21        0
*/

TBg(t)

/0        0.073/

*/0        0.073
*1        0.073
*2        0.056
*3        -0.101
*4        -0.009
*5        0.097
*6        0.081
*7        0.049
*8        0.066
*9        0.060
*10        0.057
*11        0.028
*12        0.041
*13        0.023
*14        0.042
*15        0.020
*16        0.021
*17        0.037
*18        0.015
*19        0.012
*20        0.012
*21        0
*/
;

**============================================================================**
set TO(t) /0/;
parameter GDP1(t),ygrow(t);
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


SOLVE BRAgri Using MCP;
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
PVAREP(A,t)=PVA.L(A);
VAREP(A,t)=VA.L(A);
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
SAMREP(t,K,A)=KD.L(K,A)*R.L(K)+ZD.L(A)*rent.L;
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
*gtax(GC)=gtax(GC)+gtax_policy(GC,t);
*ifuela(C,A)=0.5*ifuela(C,A);

** Save Top down solution
P_out(LinkC)=PP.L(LinkC);
P_in(C)$(ELECC(C))=PA.L(C);
P_in(C)$(M(C))=PA.L(C);
Pfuel_in(C,A)$(fuelA(A,C) and LinkA(A))=PNEG.L(C,A);
w_in(L)=W.L(L);
r_in(K)=R.L(K);
Demand_out(LinkC)=XP.L(LinkC);

********************************************************************************
** A. Construct Bottom up cost price index
* step 1. save top down input costs (A is industry in CGE, Crop and Livestock in Bottom up)
P_c(C,A)$(ENC(C) and LinkA(A))=PNEG.L(C,A);
P_c(C,A)$(ELECC(C) or M(C))=PA.L(C);
* step 2. convert top down input costs to io input cost by CGE industry A
Pio_c(io,A)=sum(c,theta_ioc(io,c)*P_c(C,A));
Pio_w(io,A)=sum(l,theta_iof(io,l)*w.l(l));
Pio_r(io,A)=sum(k,theta_iof(io,k)*r.l(k));

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
*display p_outj,q_outj,p_inioa,p_inioj;

** C. Construct fake TC outcome from fake bottom up solution q_outj(j).
** (This should be replaced with actual bottom up solution)
tc_recover(tc,j)=theta_tc_j(tc,j)*q_outj(j);



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
*iocost(io,j)=sum(tc,iotc_r(tc,io,j)*tc_recover(TC,J));
iocost(io,j)=sum(tc,iotc_r(tc,io,j)*C_new(TC,J));
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
*xc_random=uniform(0.95,1.05);
*input_random=uniform(0.95,1.05);
*XC_bottom(A)=xc_random*XC_bottom(A);
*XC :0.75~1.23
*LD_bottom(L,A)=input_random*ifa(L,A)*XC_bottom(A);
*KD_bottom(K,A)=input_random*ifa(K,A)*XC_bottom(A);
*ZD_bottom(A)=input_random*iza(A)*ZD_bottom(A);
*XAP_bottom(C,A)$ELECC(C)=input_random*iea(C,A)*XC_bottom(A);
*XAP_bottom(C,A)$M(C)=input_random*ica(C,A)*XC_bottom(A);
*QNEG_bottom(C,A)=input_random*ifuela(C,A)*XC_bottom(A);
*XCrandomrep(t)=xc_random;
*LD,KD,XAP,QNEG:0.5~1.5
* =========================== *

*P_in(C,t)$(ENCN(C))=PAREP(C,t);


**************************************************************************************


);
SAMDIFF('0',ACT,ACTPP)=samng(ACT,ACTPP)-SAMREP('0',ACT,ACTPP);
DiFFT=sum((ACT,ACTPP),SAMDIFF('0',ACT,ACTPP));

GDP1(t)=GDPREP('GDPMP1',t);
loop (t$(not TO(t)),ygrow(t)=(GDP1(t)-GDP1(t-1))/GDP1(t-1));

parameter
Rnet(K,t);
Rnet(K,t)=RREP(K,t)-delta;

display scenario;
display SAMDIFF,DiFFT;
display BALCHK;
*display CREVREP,TCREVREP;
display warlasrep;
*display PVAEREP,QVAEREP;
*display PHKTEREP,HKTEREP;
*display SAMREP;
*display GDPrep,GDP1;
*display ygrow;
*display TGC;
display PCREP,PPREP,PAREP,PDREP,PETREP,PMTREP,RREP,WREP,XCREP,XPREP,EYREP;
display rentrep;
*display XCrandomrep;
*display XCREP;
*display XDREP;
*display XMTREP;


*Values sending to bottom up

*P_out(LinkC,t)=PPREP(LinkC,t);
*P_in(C,t)$(ENCN(C))=PAREP(C,t);
*P_in(C,t)$(ELECC(C))=PAREP(C,t);
*Pfuel_in(C,A,t)$(fuelA(A,C) and LinkA(A))=PNEGREP(C,A,t);
*w_in(L,t)=WREP(L,t);
*r_in(K,t)=RREP(K,t);
*Demand_out(LinkC,t)=XPREP(LinkC,t);
*Demand_in(C,LinkA,t)$(ENCN(C))=XAPREP(C,LinkA,t);
*Demand_in(C,LinkA,t)$(ELECC(C))=XAPREP(C,LinkA,t);
*Demand_in(C,LinkA,t)$(ENC(C))=QNEGREP(C,LinkA,t);
*LD_in(L,LinkA,t)=LDREP(L,LinkA,t);
*KD_in(K,LinkA,t)=KDREP(K,LinkA,t);

*display P_out,P_in,Pfuel_in,W_in,R_in,Demand_out;

*display gtaxrep;
*display PNEGREP;
*display pprep,pcrep;
*display xcrep,xprep;
*display CPIrep;
*display R0,delta;
*display RREP,Rnet;

*if (scenario=0,
*$include "unload_BAU_agr_19.gms";
*elseif (scenario=1),
*$include "unload_TR_agr_19.gms";
*);
