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

$OFFTEXT
OPTION SYSOUT=ON;
*OPTION limrow=50;
*SETS=================================
*parameter
*recursive;
*recursive=0;
*operation=1;
SET

$include "set_Agri_20151228_static.txt"

*$include "set_Agri_20151228_recursive.txt"





PARAMETERS
alpha_nres(A) net residue to output ratio
ta_in(A)        net producer's tax rate in production a (PTAXin)
ta_ex(A)        etc producer's tax rate in production a (PTAXex)
ica(C,A)      Material(C) intermediate demand coefficient in production A:  XAP(C_A) over XC(A)
ifa(F,A)      Factor demand coefficient in production A (Link Activity only) :LD(L_A) over XC(A) and KD(K_A) over XC(A)
iea(C,A)      Electricity(ELECC) intermediate demand coefficient in production A (Link Activity only):XAP(C_A) over XC(A)
ifuela(C,A)   Fuel(ENC) intermediate demand coefficient in production A (Link Activity only):QCE(C_A) over XC(A)
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
deltaXEP(A)     VAE CES function share parameter for Energy composite XEP
deltaVA(A)      VAE CES function share parameter for Value Added composite VA
deltaf(F,A)     VA CES function share parameter for factor
deltac(C,A)     Leontief perameter for non energy intermediate input and CES share parameter for intermediate energy input (ENC and ENCN)
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
XAP_bottom(C,A)   Bottom up non energy_electricity intermediate input in Agriculture
QNEG_bottom(C,A)  Bottom up fuel intermediate input in Agriculture
;

*VARIABLES========================================================================
positive variables
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
PA(C)           Market price of C
PVAE(A)                Value added energy composite price
QVAE(A)                Demand for Value added energy composite
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

R(K)           rental price of Capital
W(L)           wage
LD(L,A)            labor demand for production A
KD(K,A)            capial demand for production A
Ks(K)           Capital supply
Ls(L)           Labor supply

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
$include b_sam_br_g_1223.csv
$Offdelim

table samng(ACT,ACTP) data in CSV format
$Ondelim
$include b_sam_br_ng_1223.csv
$Offdelim

table ghg(ACT,ACTP) data in CSV format
$Ondelim
$include GHG_BR_p_1223.csv
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
INTDE1(C,A) Electricity intermediate demand for XC(A): CES of VAE
INTGD(GC,A) intermediate demand of CO2 CO2 emission in process

INTDM_Link(C,A) Material intermeidate demand for XC(A): Leontief of XC  (Agricluture only)
INTDE1_Link(C,A) Electricity intermediate demand for XC(A): CES of VAE (Agricluture only)
INTGD_Link(GC,A) intermediate demand of CO2 CO2 emission in process  (Agricluture only)

LDA1(L,A) labor demand LD f of QVAE
KDA1(K,A) Capital demand  KD f of QVAE

LDA1_Link(L,A) labor demand LD f of QVAE (Agricluture only)
KDA1_Link(K,A) Capital demand  KD f of QVAE (Agricluture only)

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
ActR(A)$(sum(C,SAM(A,C))>0 and not ghg('process',A) and not AgriA(A))..PC(A)*alpha_nres(A)+sum(C$M(C),PA(C)*ica(C,A))+PVAE(A)=g=PC(A)*(1-ta_in(A)-ta_ex(A));
ActR.m(A)=1;
*ActRp(A)$(ghg('process',A) ne 0)..PC(A)*alpha_nres(A)*XC(A)+sum(C$M(C),PA(C)*ica(C,A)*XC(A))+sum(GC,thetaP(GC,A)*XC(A)*gtax(GC))+PVAE(A)*QVAE(A)=g=PC(A)*(1-ta_in(A)-ta_ex(A))*XC(A)+crevI*crevIw(A)*CREV(A);
ActRp(A)$((ghg('process',A) ne 0) and not AgriA(A))..PC(A)*alpha_nres(A)+sum(C$M(C),PA(C)*ica(C,A))+sum(GC,thetaP(GC,A)*gtax(GC)*cpi)+PVAE(A)=g=PC(A)*(1-ta_in(A)-ta_ex(A));
ActRP.m(A)=1;

*ActR_Link(A)$(sum(C,SAM(A,C))>0 and not ghg('process',A) and AgriA(A))..PC(A)*alpha_nres(A)+sum(C$M(C),PA(C)*ica(C,A))+sum(C$ELECC(C),PA(C)*iea(C,A))+sum(C$FuelA(A,C),PNEG(C,A)*ifuela(C,A))+sum(K,ifa(K,A)*R(K))+sum(L,ifa(L,A)*W(L))=e=PC(A)*(1-ta_in(A)-ta_ex(A));
ActR_Link(A)$(sum(C,SAM(A,C))>0 and not ghg('process',A) and AgriA(A))..XC(A)=e=XC_bottom(A);

ActR_Link.m(A)=1;
*ActRp(A)$(ghg('process',A) ne 0)..PC(A)*alpha_nres(A)*XC(A)+sum(C$M(C),PA(C)*ica(C,A)*XC(A))+sum(GC,thetaP(GC,A)*XC(A)*gtax(GC))+PVAE(A)*QVAE(A)=g=PC(A)*(1-ta_in(A)-ta_ex(A))*XC(A)+crevI*crevIw(A)*CREV(A);
*ActRp_Link(A)$((ghg('process',A) ne 0) and AgriA(A))..PC(A)*alpha_nres(A)+sum(C$M(C),PA(C)*ica(C,A))+sum(GC,thetaP(GC,A)*gtax(GC)*cpi)+sum(C$ELECC(C),PA(C)*iea(C,A))+sum(C$FuelA(A,C),PNEG(C,A)*ifuela(C,A))+sum(K,ifa(K,A)*R(K))+sum(L,ifa(L,A)*W(L))=e=PC(A)*(1-ta_in(A)-ta_ex(A));
ActRp_Link(A)$((ghg('process',A) ne 0) and AgriA(A))..XC(A)=e=XC_bottom(A);
ActRP_Link.m(A)=1;


VAEPr0(A)$(sum(ELECC,SAM(ELECC,A))+sum(ENC,SAM(ENC,A))=0 and sum(F,SAM(F,A))>0 and not AgriA(A))..PVAE(A)=e=(1/alphaaVAE(A))*PVA(A);
VAEPr0.m(A)=1;


VAEPr1(A)$(sum(ELECC,SAM(ELECC,A))+sum(ENC,SAM(ENC,A))>0 and sum(F,SAM(F,A))>0 and not AgriA(A))..PVAE(A)=e=(1/alphaaVAE(A))*
(
deltaXEP(A)**sigmaaVAE(A)*PEP(A)**(1-sigmaaVAE(A))
+ deltaVA(A)**sigmaaVAE(A)*PVA(A)**(1-sigmaaVAE(A))
)**(1/(1-sigmaaVAE(A)));
VAEPr1.m(A)=1;

VAEPr2(A)$(sum(ELECC,SAM(ELECC,A))+sum(ENC,SAM(ENC,A))>0 and sum(F,SAM(F,A))=0 and not AgriA(A))..PVAE(A)=e=(1/alphaaVAE(A))*PEP(A);
VAEPr2.m(A)=1;

*VAEPr0_Link(A)$(sum(ELECC,SAM(ELECC,A))+sum(ENC,SAM(ENC,A))=0 and sum(F,SAM(F,A))>0 and AgriA(A))..PVAE(A)=e=(1/alphaaVAE(A))*PVA(A);
*VAEPr0_Link.m(A)=1;


*VAEPr1_Link(A)$(sum(ELECC,SAM(ELECC,A))+sum(ENC,SAM(ENC,A))>0 and sum(F,SAM(F,A))>0 and AgriA(A))..PVAE(A)=e=(1/alphaaVAE(A))*
*(
*deltaXEP(A)**sigmaaVAE(A)*PEP(A)**(1-sigmaaVAE(A))
*+ deltaVA(A)**sigmaaVAE(A)*PVA(A)**(1-sigmaaVAE(A))
*)**(1/(1-sigmaaVAE(A)));
*VAEPr1_Link.m(A)=1;

*VAEPr2_Link(A)$(sum(ELECC,SAM(ELECC,A))+sum(ENC,SAM(ENC,A))>0 and sum(F,SAM(F,A))=0 and AgriA(A))..PVAE(A)=e=(1/alphaaVAE(A))*PEP(A);
*VAEPr2_Link.m(A)=1;



VAPr0(A)$(sum(L,SAM(L,A))>0 and sum(K,SAM(K,A))=0 and not AgriA(A))..PVA(A)=e=
(
     prod(L,(W(L)/(lambdat*lambda(A)*deltaf(L,A)))**(deltaf(L,A)))
);
VAPr0.m(A)=1;


VAPr1(A)$(sum(L,SAM(L,A))>0 and sum(K,SAM(K,A))>0 and not AgriA(A))..PVA(A)=e=
(
     prod(K,(R(K)/(lambdak*lambdaka(A)*deltaf(K,A)))**(deltaf(K,A)))*
     prod(L,(W(L)/(lambdat*lambda(A)*deltaf(L,A)))**(deltaf(L,A)))
);
VAPr1.m(A)=1;

VAPr2(A)$(sum(L,SAM(L,A))=0 and sum(K,SAM(K,A))>0 and not AgriA(A))..PVA(A)=e=
(
     prod(K,(R(K)/(lambdak*lambdaka(A)*deltaf(K,A)))**(deltaf(K,A)))
);
VAPr2.m(A)=1;

*VAPr0_Link(A)$(sum(L,SAM(L,A))>0 and sum(K,SAM(K,A))=0 and AgriA(A))..PVA(A)=e=
*(
*     prod(L,(W(L)/(lambdat*lambda(A)*deltaf(L,A)))**(deltaf(L,A)))
*);
*VAPr0_Link.m(A)=1;


*VAPr1_Link(A)$(sum(L,SAM(L,A))>0 and sum(K,SAM(K,A))>0 and AgriA(A))..PVA(A)=e=
*(
*     prod(K,(R(K)/(lambdak*lambdaka(A)*deltaf(K,A)))**(deltaf(K,A)))*
*     prod(L,(W(L)/(lambdat*lambda(A)*deltaf(L,A)))**(deltaf(L,A)))
*);
*VAPr1_Link.m(A)=1;

*VAPr2_Link(A)$(sum(L,SAM(L,A))=0 and sum(K,SAM(K,A))>0 and AgriA(A))..PVA(A)=e=
*(
*     prod(K,(R(K)/(lambdak*lambdaka(A)*deltaf(K,A)))**(deltaf(K,A)))
*);
*VAPr2_Link.m(A)=1;


XEPr0(A)$(sum(ELECC,SAM(ELECC,A))>0 and sum(ENC,SAM(ENC,A))=0 and not AgriA(A) )..PEP(A)=e=prod(C$ELECC(C),(PA(C)/deltaC(C,A))**(deltaC(C,A)));
XEPr0.m(A)=1;



XEPr1(A)$(sum(ELECC,SAM(ELECC,A))>0 and sum(ENC,SAM(ENC,A))>0 and not AgriA(A))..PEP(A)=e=
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
XEPr2(A)$(sum(ELECC,SAM(ELECC,A))=0 and sum(ENC,SAM(ENC,A))>0 and not AgriA(A))..PEP(A)=e=PFL(A);
XEPr2.m(A)=1;

*XEPr0_Link(A)$(sum(ELECC,SAM(ELECC,A))>0 and sum(ENC,SAM(ENC,A))=0 and AgriA(A) )..PEP(A)=e=prod(C$ELECC(C),(PA(C)/deltaC(C,A))**(deltaC(C,A)));
*XEPr0_Link.m(A)=1;



*XEPr1_Link(A)$(sum(ELECC,SAM(ELECC,A))>0 and sum(ENC,SAM(ENC,A))>0 and AgriA(A))..PEP(A)=e=
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
*XEPr2_Link(A)$(sum(ELECC,SAM(ELECC,A))=0 and sum(ENC,SAM(ENC,A))>0 and AgriA(A))..PEP(A)=e=PFL(A);
*XEPr2_Link.m(A)=1;



XFLPr0(A)$(sum(C$sfuel(C),SAM(C,A)=0) and sum(C$Lfuel(C), SAM(C,A))>0 and not AgriA(A))..PFL(A)=e=PLFL(A);
XFLPr0.m(A)=1;

XFLPr1(A)$(sum(C$sfuel(C),SAM(C,A) >0) and sum(C$Lfuel(C), SAM(C,A))>0 and not AgriA(A))..PFL(A)=e=
(
sum(C$SfuelA(A,C),deltaC(C,A)**sigmaaXFL(A)*(PNEG(C,A)/AEEI(C,A))**(1-sigmaaXFL(A)))
+
(1-sum(C$SfuelA(A,C),deltaC(C,A)))**(sigmaaXFL(A))*PLFL(A)**(1-sigmaaXFL(A))
)**(1/(1-sigmaaXFL(A)));
XFLPr1.m(A)=1;

XFLPr2(A)$(sum(C$sfuel(C),SAM(C,A) >0) and sum(C$Lfuel(C), SAM(C,A))=0 and Sfuel_single(A) eq 1 and not AgriA(A))..PFL(A)=e=
(
sum(C$SfuelA(A,C),deltaC(C,A)**sigmaaXFL(A)*(PNEG(C,A)/AEEI(C,A))**(1-sigmaaXFL(A)))
)**(1/(1-sigmaaXFL(A)));
XFLPr2.m(A)=1;

XFLPr3(A)$(sum(C$sfuel(C),SAM(C,A) >0) and sum(C$Lfuel(C), SAM(C,A))=0 and Sfuel_single(A) eq 0 and not AgriA(A))..PFL(A)=e=sum(C$(Sfuel(C) and SfuelA(A,C)),PNEG(C,A))/sum(C$(Sfuel(C) and SfuelA(A,C)),AEEI(C,A));
XFLPr3.m(A)=1;

*XFLPr0_Link(A)$(sum(C$sfuel(C),SAM(C,A)=0) and sum(C$Lfuel(C), SAM(C,A))>0 and AgriA(A))..PFL(A)=e=PLFL(A);
*XFLPr0_Link.m(A)=1;

*XFLPr1_Link(A)$(sum(C$sfuel(C),SAM(C,A) >0) and sum(C$Lfuel(C), SAM(C,A))>0 and AgriA(A))..PFL(A)=e=
*(
*sum(C$SfuelA(A,C),deltaC(C,A)**sigmaaXFL(A)*(PNEG(C,A)/AEEI(C,A))**(1-sigmaaXFL(A)))
*+
*(1-sum(C$SfuelA(A,C),deltaC(C,A)))**(sigmaaXFL(A))*PLFL(A)**(1-sigmaaXFL(A))
*)**(1/(1-sigmaaXFL(A)));
*XFLPr1_Link.m(A)=1;

*XFLPr2_Link(A)$(sum(C$sfuel(C),SAM(C,A) >0) and sum(C$Lfuel(C), SAM(C,A))=0 and Sfuel_single(A) eq 1 and AgriA(A))..PFL(A)=e=
*(
*sum(C$SfuelA(A,C),deltaC(C,A)**sigmaaXFL(A)*(PNEG(C,A)/AEEI(C,A))**(1-sigmaaXFL(A)))
*)**(1/(1-sigmaaXFL(A)));
*XFLPr2_Link.m(A)=1;

*XFLPr3_Link(A)$(sum(C$sfuel(C),SAM(C,A) >0) and sum(C$Lfuel(C), SAM(C,A))=0 and Sfuel_single(A) eq 0 and AgriA(A))..PFL(A)=e=sum(C$(Sfuel(C) and SfuelA(A,C)),PNEG(C,A))/sum(C$(Sfuel(C) and SfuelA(A,C)),AEEI(C,A));
*XFLPr3_Link.m(A)=1;



XLFLPr0(A)$(Lfuel_single(A) eq 0 and not AgriA(A))..PLFL(A)=e=sum(C$(ENC(C) and LfuelA(A,C)),PNEG(C,A))/sum(C$(ENC(C) and LfuelA(A,C)),AEEI(C,A));
XLFLPr0.m(A)=1;

XLFLPr1(A)$(Lfuel_single(A) eq 1 and not AgriA(A))..PLFL(A)=e=
prod(C$LfuelA(A,C),(PNEG(C,A)/(deltaC(C,A)*AEEI(C,A)))**deltaC(C,A))
;
XLFLPr1.m(A)=1;

*XLFLPr0_Link(A)$(Lfuel_single(A) eq 0 and AgriA(A))..PLFL(A)=e=sum(C$(ENC(C) and LfuelA(A,C)),PNEG(C,A))/sum(C$(ENC(C) and LfuelA(A,C)),AEEI(C,A));
*XLFLPr0_Link.m(A)=1;

*XLFLPr1_Link(A)$(Lfuel_single(A) eq 1 and AgriA(A))..PLFL(A)=e=
*prod(C$LfuelA(A,C),(PNEG(C,A)/(deltaC(C,A)*AEEI(C,A)))**deltaC(C,A))
*;
*XLFLPr1_Link.m(A)=1;


NEGPr(C,A)$(FuelA(A,C) and ghg(C,A)=0 and not AgriA(A) )..PA(C)=e=PNEG(C,A);
NEGPr.m(C,A)=1;

NEGPrco(C,A)$(FuelA(A,C) and ghg(C,A)>0 and not AgriA(A))..PA(C)+sum(GC,thetaE(GC,C,A)*cpi*gtax(GC))=e=PNEG(C,A);
NEGPrco.m(C,A)=1;

NEGPr_Link(C,A)$(FuelA(A,C) and ghg(C,A)=0 and AgriA(A))..PA(C)=e=PNEG(C,A);
NEGPr.m(C,A)=1;

NEGPrco_Link(C,A)$(FuelA(A,C) and ghg(C,A)>0 and AgriA(A))..PA(C)+sum(GC,thetaE(GC,C,A)*cpi*gtax(GC))=e=PNEG(C,A);
NEGPrco.m(C,A)=1;



*NEGPr(C,A)$(ghg(C,A)>0)..PA(C)+sum(GC,thetaE(GC,C,A)*gtax(GC)*cpi)=e=PNEG(C,A);
*NEGPr.m(C,A)=1;

*Numeria
Norm..cpi=e=sum(C,PA(C)*cwrt(C));
Norm.m=1;
CPIfix..cpi=e=cpi_o;
CPIfix.m=1;

*Production and Trade block
QVAED(A)$(sum(C,SAM(A,C))>0 and not AgriA(A))..QVAE(A)=e=XC(A);
QVAED.m(A)=1;

*QVAED_Link(A)$(sum(C,SAM(A,C))>0 and AgriA(A))..QVAE(A)=e=XC(A);
*QVAED_Link.m(A)=1;


XVAD0(A)$(sum(ELECC,SAM(ELECC,A))+sum(ENC,SAM(ENC,A))=0 and sum(F,SAM(F,A))>0 and not AgriA(A))..VA(A)=e=(1/alphaaVAE(A))*QVAE(A);
XVAD0.m(A)=1;

XVAD1(A)$(sum(ELECC,SAM(ELECC,A))+sum(ENC,SAM(ENC,A))>0 and sum(F,SAM(F,A))>0 and not AgriA(A))..VA(A)=e=(deltaVA(A)**sigmaaVAE(A))*((PVAE(A)/PVA(A))**sigmaaVAE(A))*( alphaaVAE(A)**(sigmaaVAE(A)-1))*QVAE(A);
XVAD1.m(A)=1;

*XVAD0_Link(A)$(sum(ELECC,SAM(ELECC,A))+sum(ENC,SAM(ENC,A))=0 and sum(F,SAM(F,A))>0  and AgriA(A))..VA(A)=e=(1/alphaaVAE(A))*QVAE(A);
*XVAD0_Link.m(A)=1;

*XVAD1_Link(A)$(sum(ELECC,SAM(ELECC,A))+sum(ENC,SAM(ENC,A))>0 and sum(F,SAM(F,A))>0  and AgriA(A))..VA(A)=e=(deltaVA(A)**sigmaaVAE(A))*((PVAE(A)/PVA(A))**sigmaaVAE(A))*( alphaaVAE(A)**(sigmaaVAE(A)-1))*QVAE(A);
*XVAD1_Link.m(A)=1;


XEPD1(A)$(sum(ELECC,SAM(ELECC,A))+sum(ENC,SAM(ENC,A))>0 and sum(F,SAM(F,A))>0 and not AgriA(A))..XEP(A)=e=(deltaXEP(A)**sigmaaVAE(A))*((PVAE(A)/PEP(A))**sigmaaVAE(A))*( alphaaVAE(A)**(sigmaaVAE(A)-1))*QVAE(A);
XEPD1.m(A)=1;

XEPD2(A)$(sum(ELECC,SAM(ELECC,A))+sum(ENC,SAM(ENC,A))>0 and sum(F,SAM(F,A))=0 and not AgriA(A))..XEP(A)=e=(1/alphaaVAE(A))*QVAE(A);
XEPD2.m(A)=1;

*XEPD1_Link(A)$(sum(ELECC,SAM(ELECC,A))+sum(ENC,SAM(ENC,A))>0 and sum(F,SAM(F,A))>0  and AgriA(A))..XEP(A)=e=(deltaXEP(A)**sigmaaVAE(A))*((PVAE(A)/PEP(A))**sigmaaVAE(A))*( alphaaVAE(A)**(sigmaaVAE(A)-1))*QVAE(A);
*XEPD1_Link.m(A)=1;

*XEPD2_Link(A)$(sum(ELECC,SAM(ELECC,A))+sum(ENC,SAM(ENC,A))>0 and sum(F,SAM(F,A))=0  and AgriA(A))..XEP(A)=e=(1/alphaaVAE(A))*QVAE(A);
*XEPD2_Link.m(A)=1;



LDA1(L,A)$(sum(LP,SAM(LP,A))>0 and not AgriA(A))..LD(L,A)=e=deltaf(L,A)*(PVA(A)*VA(A))/W(L);
LDA1.m(L,A)=1;

KDA1(K,A)$(sum(KP,SAM(KP,A))>0 and not AgriA(A))..KD(K,A)=e=deltaf(K,A)*(PVA(A)*VA(A))/R(K);
KDA1.m(K,A)=1;

*LDA1_Link(L,A)$(sum(LP,SAM(LP,A))>0 and AgriA(A))..LD(L,A)=e=deltaf(L,A)*(PVA(A)*VA(A))/W(L);
*LDA1_Link.m(L,A)=1;

*KDA1_Link(K,A)$(sum(KP,SAM(KP,A))>0 and AgriA(A))..KD(K,A)=e=deltaf(K,A)*(PVA(A)*VA(A))/R(K);
*KDA1_Link.m(K,A)=1;

*LDA1_Link(L,A)$(sum(LP,SAM(LP,A))>0 and AgriA(A))..LD(L,A)=e=ifa(L,A)*XC(A);
LDA1_Link(L,A)$(sum(LP,SAM(LP,A))>0 and AgriA(A))..LD(L,A)=e=LD_bottom(L,A);
LDA1_Link.m(L,A)=1;

*KDA1_Link(K,A)$(sum(KP,SAM(KP,A))>0 and AgriA(A))..KD(K,A)=e=ifa(K,A)*XC(A);
KDA1_Link(K,A)$(sum(KP,SAM(KP,A))>0 and AgriA(A))..KD(K,A)=e=KD_bottom(K,A);
KDA1_Link.m(K,A)=1;


XFLD1(A)$(sum(ELECC,SAM(ELECC,A))>0 and sum(ENC,SAM(ENC,A))>0 and not AgriA(A))..XFL(A)=e=(1-sum(C$ELECC(C),deltaC(C,A)))*(PEP(A)/PFL(A))*XEP(A);
XFLD1.m(A)=1;
XFLD2(A)$(sum(ELECC,SAM(ELECC,A))=0 and sum(ENC,SAM(ENC,A))>0 and not AgriA(A))..XFL(A)=e=XEP(A);
XFLD2.m(A)=1;

*XFLD1_Link(A)$(sum(ELECC,SAM(ELECC,A))>0 and sum(ENC,SAM(ENC,A))>0 and AgriA(A))..XFL(A)=e=(1-sum(C$ELECC(C),deltaC(C,A)))*(PEP(A)/PFL(A))*XEP(A);
*XFLD1_Link.m(A)=1;
*XFLD2_Link(A)$(sum(ELECC,SAM(ELECC,A))=0 and sum(ENC,SAM(ENC,A))>0 and AgriA(A))..XFL(A)=e=XEP(A);
*XFLD2_Link.m(A)=1;


INTDE1(C,A)$(ELECC(C) and SAM(C,A)$ELECC(C)>0 and not AgriA(A))..XAP(C,A)=e= deltaC(C,A)*(PEP(A)/PA(C))*XEP(A);
INTDE1.m(C,A)=1;

*INTDE1_Link(C,A)$(ELECC(C) and SAM(C,A)$ELECC(C)>0 and AgriA(A))..XAP(C,A)=e= deltaC(C,A)*(PEP(A)/PA(C))*XEP(A);
*INTDE1_Link.m(C,A)=1;

*INTDE1_Link(C,A)$(ELECC(C) and SAM(C,A)$ELECC(C)>0 and AgriA(A))..XAP(C,A)=e= iea(C,A)*XC(A);
INTDE1_Link(C,A)$(ELECC(C) and SAM(C,A)$ELECC(C)>0 and AgriA(A))..XAP(C,A)=e= XAP_bottom(C,A);
INTDE1_Link.m(C,A)=1;


XLFLD0(A)$(sum(C$sfuel(C),SAM(C,A)=0) and (sum(CP$Lfuel(CP),SAM(CP,A)) >0) and not AgriA(A))..XLFL(A)=e=XFL(A);
XLFLD0.m(A)=1;

*XLFLD0_Link(A)$(sum(C$sfuel(C),SAM(C,A)=0) and (sum(CP$Lfuel(CP),SAM(CP,A)) >0) and AgriA(A))..XLFL(A)=e=XFL(A);
*XLFLD0_Link.m(A)=1;



NEGDS1(C,A)$(SfuelA(A,C) and (sum(CP$Lfuel(CP),SAM(CP,A)) >0) and not AgriA(A))..QNEG(C,A)=e=                (deltaC(C,A)**sigmaaXFL(A))*((PFL(A)/PNEG(C,A))**sigmaaXFL(A))*((AEEI(C,A))**(sigmaaXFL(A)-1))*XFL(A);
NEGDS1.m(C,A)=1;

NEGDS2(C,A)$(SfuelA(A,C) and (sum(CP$Lfuel(CP),SAM(CP,A))=0) and Sfuel_single(A) eq 1 and not AgriA(A))..QNEG(C,A)=e=                (deltaC(C,A)**sigmaaXFL(A))*((PFL(A)/PNEG(C,A))**sigmaaXFL(A))*((AEEI(C,A))**(sigmaaXFL(A)-1))*XFL(A);
NEGDS2.m(C,A)=1;

NEGDS3(C,A)$(SfuelA(A,C) and (sum(CP$Lfuel(CP),SAM(CP,A))=0) and Sfuel_single(A) eq 0 and not AgriA(A))..QNEG(C,A)=e=(1/AEEI(C,A))*XFL(A);
NEGDS3.m(C,A)=1;

*NEGDS1_Link(C,A)$(SfuelA(A,C) and (sum(CP$Lfuel(CP),SAM(CP,A)) >0) and AgriA(A))..QNEG(C,A)=e=                (deltaC(C,A)**sigmaaXFL(A))*((PFL(A)/PNEG(C,A))**sigmaaXFL(A))*((AEEI(C,A))**(sigmaaXFL(A)-1))*XFL(A);
*NEGDS1_Link.m(C,A)=1;

*NEGDS2_Link(C,A)$(SfuelA(A,C) and (sum(CP$Lfuel(CP),SAM(CP,A))=0) and Sfuel_single(A) eq 1 and AgriA(A))..QNEG(C,A)=e=                (deltaC(C,A)**sigmaaXFL(A))*((PFL(A)/PNEG(C,A))**sigmaaXFL(A))*((AEEI(C,A))**(sigmaaXFL(A)-1))*XFL(A);
*NEGDS2_Link.m(C,A)=1;

*NEGDS3_Link(C,A)$(SfuelA(A,C) and (sum(CP$Lfuel(CP),SAM(CP,A))=0) and Sfuel_single(A) eq 0 and AgriA(A))..QNEG(C,A)=e=(1/AEEI(C,A))*XFL(A);
*NEGDS3_Link.m(C,A)=1;

*NEGDS1_Link(C,A)$(SfuelA(A,C) and (sum(CP$Lfuel(CP),SAM(CP,A)) >0) and AgriA(A))..QNEG(C,A)=e=ifuela(C,A)*XC(A);
NEGDS1_Link(C,A)$(SfuelA(A,C) and (sum(CP$Lfuel(CP),SAM(CP,A)) >0) and AgriA(A))..QNEG(C,A)=e=QNEG_bottom(C,A);
NEGDS1_Link.m(C,A)=1;

*NEGDS2_Link(C,A)$(SfuelA(A,C) and (sum(CP$Lfuel(CP),SAM(CP,A))=0) and Sfuel_single(A) eq 1 and AgriA(A))..QNEG(C,A)=e=ifuela(C,A)*XC(A);
NEGDS2_Link(C,A)$(SfuelA(A,C) and (sum(CP$Lfuel(CP),SAM(CP,A))=0) and Sfuel_single(A) eq 1 and AgriA(A))..QNEG(C,A)=e=QNEG_bottom(C,A);
NEGDS2_Link.m(C,A)=1;

*NEGDS3_Link(C,A)$(SfuelA(A,C) and (sum(CP$Lfuel(CP),SAM(CP,A))=0) and Sfuel_single(A) eq 0 and AgriA(A))..QNEG(C,A)=e=ifuela(C,A)*XC(A);
NEGDS3_Link(C,A)$(SfuelA(A,C) and (sum(CP$Lfuel(CP),SAM(CP,A))=0) and Sfuel_single(A) eq 0 and AgriA(A))..QNEG(C,A)=e=QNEG_bottom(C,A);
NEGDS3_Link.m(C,A)=1;



XLFLD1(A)$(sum(C$sfuel(C),SAM(C,A) >0) and (sum(CP$Lfuel(CP),SAM(CP,A)) >0) and not AgriA(A))..XLFL(A)=e=(1-sum(C$sfuel(C),deltaC(C,A)))**sigmaaXFL(A)*(PFL(A)/PLFL(A))**(sigmaaXFL(A))*XFL(A);
XLFLD1.m(A)=1;

*XLFLD1_Link(A)$(sum(C$sfuel(C),SAM(C,A) >0) and (sum(CP$Lfuel(CP),SAM(CP,A)) >0) and AgriA(A))..XLFL(A)=e=(1-sum(C$sfuel(C),deltaC(C,A)))**sigmaaXFL(A)*(PFL(A)/PLFL(A))**(sigmaaXFL(A))*XFL(A);
*XLFLD1_Link.m(A)=1;


NEGDL0(C,A)$(LfuelA(A,C) and Lfuel_single(A) eq 0 and not AgriA(A))..QNEG(C,A)=e= (1/AEEI(C,A))*XLFL(A);
NEGDL0.m(C,A)=1;

NEGDL1(C,A)$(LfuelA(A,C) and Lfuel_single(A) eq 1 and not AgriA(A))..QNEG(C,A)=e=deltaC(C,A)*(PLFL(A)/PNEG(C,A))*XLFL(A);
NEGDL1.m(C,A)=1;

*NEGDL0_Link(C,A)$(LfuelA(A,C) and Lfuel_single(A) eq 0 and AgriA(A))..QNEG(C,A)=e= (1/AEEI(C,A))*XLFL(A);
*NEGDL0_Link.m(C,A)=1;

*NEGDL1_Link(C,A)$(LfuelA(A,C) and Lfuel_single(A) eq 1 and AgriA(A))..QNEG(C,A)=e=deltaC(C,A)*(PLFL(A)/PNEG(C,A))*XLFL(A);
*NEGDL1_Link.m(C,A)=1;

*NEGDL0_Link(C,A)$(LfuelA(A,C) and Lfuel_single(A) eq 0 and AgriA(A))..QNEG(C,A)=e= ifuela(C,A)*XC(A);
NEGDL0_Link(C,A)$(LfuelA(A,C) and Lfuel_single(A) eq 0 and AgriA(A))..QNEG(C,A)=e=QNEG_bottom(C,A);
NEGDL0_Link.m(C,A)=1;

*NEGDL1_Link(C,A)$(LfuelA(A,C) and Lfuel_single(A) eq 1 and AgriA(A))..QNEG(C,A)=e=ifuela(C,A)*XC(A);
NEGDL1_Link(C,A)$(LfuelA(A,C) and Lfuel_single(A) eq 1 and AgriA(A))..QNEG(C,A)=e=QNEG_bottom(C,A);
NEGDL1_Link.m(C,A)=1;




INTDM(C,A)$(M(C) and SAM(C,A)$M(C)>0 and not AgriA(A))..XAP(C,A)=e=ica(C,A)*XC(A);
INTDM.m(C,A)=1;
INTGD(GC,A)$(ghg('process',A)>0 and not AgriA(A))..QINTG(GC,A)=e=thetaP(GC,A)*XC(A);
INTGD.m(GC,A)=1;

*INTDM_Link(C,A)$(M(C) and SAM(C,A)$M(C)>0 and AgriA(A))..XAP(C,A)=e=ica(C,A)*XC(A);
INTDM_Link(C,A)$(M(C) and SAM(C,A)$M(C)>0 and AgriA(A))..XAP(C,A)=e=XAP_bottom(C,A);
INTDM_Link.m(C,A)=1;
INTGD_Link(GC,A)$(ghg('process',A)>0 and AgriA(A))..QINTG(GC,A)=e=thetaP(GC,A)*XC(A);
INTGD_Link.m(GC,A)=1;



NELQCED(C,A)$(ENC(C) and SAM(C,A)$ENC(C)>0  and not AgriA(A))..QCE(C,A)=e=QNEG(C,A);
NELQCED.m(C,A)=1;

NELQCED_Link(C,A)$(ENC(C) and SAM(C,A)$ENC(C)>0  and AgriA(A))..QCE(C,A)=e=QNEG(C,A);
NELQCED_Link.m(C,A)=1;


GD(GC,C,A)$(GfuelA(A,C) and not AgriA(A))..QGE(GC,C,A)=e=thetaE(GC,C,A)*QNEG(C,A);
GD.m(GC,C,A)=1;

GD_Link(GC,C,A)$(GfuelA(A,C) and AgriA(A))..QGE(GC,C,A)=e=thetaE(GC,C,A)*QNEG(C,A);
GD.m(GC,C,A)=1;

*GD(GC,ENC,A)$(ghg(ENC,A)>0)..QGE(GC,ENC,A)=e=thetaE(GC,ENC,A)*QNEG(ENC,A);
*GD.m(GC,ENC,A)=1;

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
HouseEY(H)..EY(H)=e=sum(A$AgriA(A),
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
-sum(A$(AgriA(A) and ghg('process',A)>0), shrpro(A,H)*sum(GC,QINTG(GC,A)*gtax(GC)*cpi))
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


ComMENCN(C)$(ENCN(C)and not AgriC(C))..XA(C)=g=sum(A$XAPA(C,A),XAP(C,A))      +sum(H$XACH(H,C),XAC(C,H))+sum(FD$FD_C(C,FD),XAF(FD,C));
ComMENCN.m(C)=1;
ComMENCN_Link(C)$(ENCN(C) and AgriC(C))..XA(C)=e=sum(A$XAPA(C,A),XAP(C,A))      +sum(H$XACH(H,C),XAC(C,H))+sum(FD$FD_C(C,FD),XAF(FD,C));
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
LD0(L,A)
KD0(K,A)
Ks0(K)
Ls0(L)

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
sigmat(C)=-3;
sigmaq('ELEC-c')=0.3;
sigmaq('GASHeat-c')=0.3;
sigmaq('OIL-c')=2.1;
sigmaq('COAL-c')=3.05;
sigmaq('ENIT-c')=3;
sigmaq('NEINT-c')=1.9;
sigmaq(AgriC)=0.25;


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
R0(K)=sum(A,SAM(K,A))/6599755.655;
KD0(K,A)=SAM(K,A)/R0(K);
*KD_bottom(K,A)=KD0(K,A);
*base year wage : IO payroll / 2010 employment in Thousand
W0(L)=sum(A,SAM(L,A))/23890;
LD0(L,A)=SAM(L,A)/W0(L);
*depreciation
** delta=0.046;
delta=R0('Capital')*0.390061;
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
*XC_bottom(A)$(AgriA(A))=XC0(A);
QCE0(ENC,A)$(sum(ACTpp,SAMng(A,ACTpp))>0)=SAM(ENC,A)/PA0(ENC);
XAP0(C,A)$(not ENC(C))=SAM(C,A)/PA0(C);

ica(C,A)$(M(C))=XAP0(C,A)/XC0(A);
ifa(L,A)$(AgriA(A))=LD0(L,A)/XC0(A);
ifa(K,A)$(AgriA(A))=KD0(K,A)/XC0(A);
iea(C,A)$(EleccA(A,C) and AgriA(A))=XAP0(C,A)/XC0(A);
ifuela(C,A)$(FuelA(A,C) and AgriA(A))=(SAM(C,A)/PA0(C))/XC0(A);

display ica,ifa,iea,ifuela;


QVAE0(A)$(sum(ACT,SAM(A,ACT))>0)=XC0(A);
PVAE0(A)$(sum(ACT,SAM(A,ACT))>0)=(sum(F,SAMng(F,A))+sum(C$ELECC(C),SAMng(C,A))+sum(C$ENC(C),SAMng(C,A))+sum(ENC,gtaxrate_o*ghg(ENC,A)))/QVAE0(A);



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
Ks0(K)=sum(H,SAM(H,K))/R0(K);
LY0(H)=sum(L,SAM(H,L));
KY0(H)=sum(K,SAM(H,K));
ResinC0=sum(H,SAM(H,'NRES'));
EY0(H)=sum(A$AgriA(A),
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
-sum(A$(AgriA(A) and ghg('process',A)>0), shrpro(A,H)*sum(GC,QINTG0(GC,A)*gtaxrate_o*cpi_o));
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
XC_bottom(A)$(AgriA(A))=XC0(A);
XAP_bottom(C,A)=XAP0(C,A);
QNEG_bottom(C,A)=QNEG0(C,A);
KD_bottom(K,A)=KD0(K,A);
LD_bottom(L,A)=LD0(L,A);

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
INTGD
INTDM_Link
INTDE1_Link
INTGD_Link

LDA1
KDA1

LDA1_Link
KDA1_Link

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
ComMENCN.PA
ComMENCN_Link
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
LD.L(L,A)        =        LD0(L,A)        ;
KD.L(K,A)        =        KD0(K,A)        ;
Ks.Fx(K)        =        Ks0(K)        ;
Ls.L(L)        =        Ls0(L)        ;
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
LDREP(L,A,t)
KDREP(K,A,t)
KsREP(K,t)
LsREP(L,t)
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
;

**====================Growth parameters=======================================**

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

Loop (t,
SOLVE BRAgri Using MCP;
*)
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
LDREP(L,A,t)        =        LD.L(L,A)        ;
KDREP(K,A,t)        =        KD.L(K,A)        ;
KsREP(K,t)        =        Ks.L(K)        ;
LsREP(L,t)        =        Ls.L(L)        ;
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
SAMREP(t,H,K)=R.L(K)*shr(K,H)*Ks.L(K)+EY.L(H);



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
Ks.Fx('Capital')=Ks.L('Capital')*(1-delta)+sum(C,XAF.L('S-I',C));
*Lw0(L)=Lw0(L)*(1+lgrow(t));
*Oldpop=Oldpop*(1+Oldpopg(t));
*FSAD=FSAD*(1+TBg(t));
*lambdat=lambdat+lpgrow(t);
*gtax(GC)=gtax(GC)+gtax_policy(GC,t);
*ifuela(C,A)=0.5*ifuela(C,A);

*XC_bottom(A)=1.1*XC_bottom(A);
*XC :0.75~1.23
*LD_bottom(L,A)=0.5*LD_bottom(L,A);
*KD_bottom(K,A)=0.5*KD_bottom(K,A);
*XAP_bottom(C,A)=0.5*XAP_bottom(C,A);
*QNEG_bottom(C,A)=0.5*QNEG_bottom(C,A);
*LD,KD,XAP,QNEG:0.5~1.5
* =========================== *


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
display GDPrep,GDP1;
*display ygrow;
display TGC;
display PCREP,PPREP,PAREP,PDREP,PETREP,PMTREP,RREP,WREP,XCREP,XPREP,EYREP;
*display XCREP;
*display XDREP;
*display XMTREP;


*Values sending to bottom up
parameter
P_out(AgriC,t)
P_in(C,t)
Pfuel_in(C,A,t)
W_in(L,t)
R_in(K,t)
Demand_out(AgriC,t);
*Demand_in(C,AgriA,t)
*LD_in(L,AgriA,t)
*KD_in(K,AgriA,t);

P_out(AgriC,t)=PPREP(AgriC,t);
P_in(C,t)$(ENCN(C))=PAREP(C,t);
P_in(C,t)$(ELECC(C))=PAREP(C,t);
Pfuel_in(C,A,t)$(fuelA(A,C) and AgriA(A))=PNEGREP(C,A,t);
w_in(L,t)=WREP(L,t);
r_in(K,t)=RREP(K,t);
Demand_out(AgriC,t)=XPREP(AgriC,t);
*Demand_in(C,AgriA,t)$(ENCN(C))=XAPREP(C,AgriA,t);
*Demand_in(C,AgriA,t)$(ELECC(C))=XAPREP(C,AgriA,t);
*Demand_in(C,AgriA,t)$(ENC(C))=QNEGREP(C,AgriA,t);
*LD_in(L,AgriA,t)=LDREP(L,AgriA,t);
*KD_in(K,AgriA,t)=KDREP(K,AgriA,t);

display P_out,P_in,Pfuel_in,W_in,R_in,Demand_out;

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
