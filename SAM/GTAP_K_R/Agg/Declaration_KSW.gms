parameters
CR(yeark) Currency Rate based on BOK
GDPDF(yeark) GDP Deflator from WB
GDP_BR(t) Real GDP
GDP_BN(t) Norminal GDP
GDP_MR(t)
GDP_MR2(t)
GDP_MN(t)
GDP_CC(t)
GDP_GC(t)
GDP_IN(t)
GDP_X(t)
GDP_M(t)
GDP_St(t)
;

parameters
finald_BMR(t,i_s,j_s), finald_BDR(t,i_s,j_s), finald_BR(t,i_s,j_s),
IOT_BR(t,i_s,j_s), IOT_BDR(t,i_s,j_s), IOT_BMR(t,i_s,j_s),
FinalDD(t,i_s,fin_demand), FinalDM(t,i_s,fin_demand), FinalD(t,i_s,fin_demand), IOTD(t,i_s,j_s), IOTM(t,i_s,j_s), IOT(t,i_s,j_s)
XP_BR(t,i_s), XP(t,i_s)
;

Parameters
R_Tar_K00(t,i_s), TarPR_K00(t,i_s,fin_demand), TARR_k00(t,i_s,j_s) ;

parameters
VST_K(t,marg_comm) margin exports
VST_K_L(t,i_s) margin export in 82 industries
VIMS_K(t,i0) imports at market prices (rest of the world -> Korea)
VIWS_K(t,i0) imports at world prices (rest of the world -> Korea)
VIFM_K(t,i0,j0) import purchases by firms at market prices (rest of the world -> Korea)
VIFA_K(t,i0,j0) import purchases by firms at agents' prices (rest of the world -> Korea)
VIPM_K(t,i0) import purchases by households at market prices (rest of the world -> Korea)
VIPA_K(t,i0) import purchases by households at agents' prices (rest of the world -> Korea)
VIGM_K(t,i0) import purchases by government at market prices (rest of the world -> Korea)
VIGA_K(t,i0) import purchases by government at agents' prices (rest of the world -> Korea)
VXWD_K(t,i0) non-margin exports at world prices (Korea -> rest of the world)
VXMD_K(t,i0) non-margin exports at market prices (Korea -> rest of the world)
VDFM_K(t,i0,j0) domestic purchases by firms at market prices
VDFA_K(t,i0,j0) domestic purchases by firms at agents' prices
VDPM_K(t,i0) domestic purchases by households at market prices
VDGM_K(t,i0) domestic purchases by government at market prices
VDPA_K(t,i0) domestic purchases by households at agents' prices
VDGA_K(t,i0) domestic purchases by government at agents' prices
INVchange_K(t,i0) inventory changes
*Investment_K(t,i0) Invenstment
INVD_K(t,i0) Capital Formation by domestic goods (stock changes not included)
INVI_K(t,i0) Capital Formation by imported goods (stock changes not included)
SCDK_K(t,i0) Domestic Stock changes
SCIK_K(t,i0) Imported Stock changes
;

****** TaX
Parameters
Tar(t,i_s,j_s) Tariff for intermediate product Matrix
TarF(t,i_s,Fin_Demand)  Tariff vector for final products
TaxMT(t,i_s,j_s) Import tax + Tarrif on products Matrix
TaxM(t,i_s,j_s) Tax for imported products Matrix
TaxD(t,i_s,j_s) Tax for domestic products Matrix
DFTAX_K(t,i0,j0)  domestic intermediate input tax
IFTAX_K(t,i0,j0) imported intermediate input tax
DPTAX_K(t,i0) private consumption tax for domestic goods
IPTAX_K(t,i0) private consumption tax for imported goods
DGTAX_K(t,i0) government consumption tax for domestic goods
IGTAX_K(t,i0) government consumption tax for imported goods
DITAX_K(t,i0) investment tax for domestic goods
IITAX_K(t,i0) investment consumption tax for imported goods
DSTAX_K(t,i0) Stock changes tax for domestic goods
ISTAX_K(t,i0) Stock changes tax for imported goods
PTAX_K(t,i0) Output tax (basic price)
PTAX_K_N(t,i0) Output tax (producers' price)
TFRV_K(t,i0,j0) Import duty
R_PTAX_K0(t,i0) initial output tax rate
R_PTAX_K_N_0(t,i0) initial output tax rate (tax in producer's price)
R_DFTAX_K0(t,i0,j0) initial domestic intermediate input tax rate
R_IFTAX_K0(t,i0,j0) initial imported intermediate input tax rate
R_DPTAX_K0(t,i0) initial private consumption for domestic goods tax rate
R_IPTAX_K0(t,i0) initial private consumption for imported goods tax rate
R_DGTAX_K0(t,i0) initial government consumption for domestic goods tax rate
R_IGTAX_K0(t,i0) initial government consumption for imported goods tax rate
*R_PTAX_K00(t,i_sec) initial output tax rate
*R_DFTAX_K00(t,i_sec,j_sec) initial domestic intermediate input tax rate
*R_IFTAX_K00(t,i_sec,j_sec) initial imported intermediate input tax rate
*R_DPTAX_K00(t,i_sec) initial private consumption for domestic goods tax rate
*R_IPTAX_K00(t,i_sec) initial private consumption for imported goods tax rate
*R_DGTAX_K00(t,i_sec) initial government consumption for domestic goods tax rate
*R_IGTAX_K00(t,i_sec) initial government consumption for imported goods tax rate
R_TAR_K0(t,i_s) Tarrif rate
R_TAR_K(t,i0) Tarrif rate
R_Tax_MT(t,i_s,j_s) producers' tax in imports
Check_Tariff(t,i_s,j_s)
Imp_Sub(t,i0)
;
parameter VVII(t,i0), VVID(t,i0);
parameters
VFM_K(t,fact,i0) Endowment- Firm's purchase at market price
EVFA_K(t,fact,i0) Factor income
NEVFA_K(t,fact,i0) Factor income in producers' price (the same with EVGA_K)
NVFM_K(t,fact,i0) Endowment-Firm's purchase at producers' price (the same with VFM_K)
;
parameters
VOA_K(t,i0) volume of output at agents' prices
VOM_K(t,i0) volume of output at market prices
CCA(t,i0)
CCB(t,fact,i0)
CCC(t,i0)
CCd(t,i0)
CCe(t,i0)
;

parameters
Check1(t,i0,j0) VIFM and VIFA
Check2(t,i0,j0) VDFM and VDFA
Check6(t,i0) Checking the value (gross input) between BOK IO and GTAP_K IO
Check5(t,i0) Checking the value (gross output) between BOK IO and GTAP_K IO
CheckX(t,i_s)
Check10(t,fact,i0)
VST_CHECK1(t,i_s)
VST_CHECK2(t,i_s)
;

parameters VAL_dgc(t), VAL_dpc(t), VAL_dinv(t), VAL_x(t), VAL_dfc(t), VAL_vom(t), check3(t,i0);
parameter check_VOA(t),check_PTAX(t),check_VOM(t), check_FinD(t), check_IOTd(t), check_VDFA(t), check_VIFA(t), check_VFM(t) ;
parameters
VFM_K0(t,i_s,j_s) initial value
INVD_K0(t,i0) initial value
VDPM_K0(t,i0) initial value
VOA_K0(t,i0) initial value
VOM_K0(t,i0) initial value
;
parameters
Av_Surplus(i0) yearly averages of surplus
AvR_Surplus(i0) average rate of surplus
CAL_surplus(t,i0) calibration for too low surplus
CALVOM_K(t,i0) calibration for increased output value
R_surplus(t,i0) rate of surplus (by VOA)
cc1(t,fact,i0)
cc2(t,i0)
cc3(t,i0)
cc4(t)
;
parameters
CAL_VDFM_K(t,i0,j0)
CAL_VIFM_K(t,i0,j0)
;
parameters
CAL_FINALD_BD(t,i_s,fin_demand)
XP_B_CAL2(t,i_s)
XP_B_CAL3(t,i_s)
CAL_EVFA_k0(t,i_s,j_s)
CALINVD_K(t,i0) calibration for INVESTMENT of domestic goods
CALINVI_K(t,i0) calibration for INVESTMENT of domestic goodscalibration for non-zero value added
CALVDPM_K(t,i0)
CALVA_K(t,i0)
R_EVFA_K(t,ENDW,i0)
xp_b_CAL(t,i_s)
CAL_SUM_INV(t,i0)
CAL_RAT_INV(t,i0,Fin_demand)
CAL_FinalD_PC(t,i0)
CAL_FinalD_GC(t,i0)
CAL_FinalD_INV(t,i0)
;
parameter CHECK_R_PTAX(t,i0);
parameters VAL_dgc(t), VAL_dpc(t), VAL_dinv(t), VAL_dsc(t), VAL_x(t), VAL_dfc(t), VAL_vom(t), Val_IMP_SUB(t), check3(t,i0);
parameter CHECK4(t,i0);
parameters
xmtpmtT(i,t) Import
esppeT(i,t) Export
tarifKT(i,t) Tariff rate in the Korean IOT
VFM_K00(t,fp,i)
Dep_K(t,i) Capital stock depreciation
prdtax(t,i)
;
