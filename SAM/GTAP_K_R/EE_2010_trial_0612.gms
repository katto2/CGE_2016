$offglobal
$offwarning

set yeark year/
1990*2030
/

set t(yeark) years with IO tables /
2010 "2010"
2009 "2009"
/

$include "Agg\Sectors_KSW.gms"
$include "Agg\Declaration_KSW.gms"

****** when changing the IO table *******
*$include "Agg\IOT\IOimport_KSW.gms"
*$exit
*****************************************

$GDXIN iOimport_KSW.gdx
set output, Tariff, TaxImport;
$LOAD output, Tariff, TaxImport
Parameters IOTnorm(t,i_s,j_s), IOTdNorm(t,i_s,j_s), IOTmNorm(t,i_s,j_s),FinalDNorm(t,i_s,j_s), FinalDdNorm(t,i_s,j_s), FinalDmNorm(t,i_s,J_s), Tar10(t,i_s,Tariff), TaxM10(t,i_s,TaxImport), xpnorm10(t,i_s,output), xpnorm(t,i_s), EVFA_10K(t,i_s,j_s), Tar0(t,i_s), TaxM0(t,i_s), Tar000(t,i_s), TaxM000(t,i_s), EVFA_K0(t,I_s,j_s),
IOT_b(t,i_s,j_s), IOT_bd(t,i_s,j_s), IOT_bm(t,i_s,j_s), FinalD_b(t,i_s,j_s), FinalD_bd(t,i_s,j_s), FinalD_bm(t,i_s,J_s), xpb10(t,i_s,output), XP_B(t,i_s), IOT_B0(yeark,i_sec0,j_sec0), XP_0(t,i_sec0), Tar_0(t,i_sec0), TaxM_0(t,i_sec0), FinalD0_b(yeark,i_sec0,Fin_Demand), IOT_BM0(yeark,i_sec0,j_sec0), XP_B0(yeark,i_sec0), IOT_0(t,i_sec0,j_sec0), Finald0(t,i_sec0,Fin_demand), IOT_D0(t,i_sec0,j_sec0), FinaldD0(t,i_sec0,Fin_demand), IOT_M0(t,i_sec0,j_sec0), FinaldM0(t,i_sec0,Fin_demand), IOT_BD0(t,i_sec0,j_sec0), Finald0_bD(t,i_sec0,Fin_demand), Finald0_bM(t,i_sec0,Fin_demand), EVFA_0(t,va,j_sec0) ;
$LOAD IOTnorm, IOTdNorm, IOTmNorm, FinalDNorm, FinalDdNorm, FinalDmNorm, Tar10, TaxM10, xpnorm10, EVFA_10K, xpnorm, Tar0, TaxM0, Tar000, TaxM000, EVFA_K0, IOT_b, IOT_bd, IOT_bm, FinalD_b, FinalD_bd, FinalD_bm, xpb10, XP_B, IOT_B0, FinalD0_b, IOT_BM0, XP_B0, IOT_0, Finald0, IOT_D0, FinaldD0, IOT_M0, FinaldM0, IOT_BD0, Finald0_bD, Finald0_bM, XP_0, Tar_0, TaxM_0, EVFA_0
parameters resoutnorm(t,i_s,resout),resoutb10(t,i_s,resout),NEVFA_10k(t,i_s,j_s),NEVFA_k0(t,i_s,j_s),resout_0(t,i_sec0),resout_00(t,i_sec0,resout),resout_b00(t,i_sec0,resout),NEVFA_0(t,va,j_sec0),XPN_resout(t,i_s),XPB_resout(t,i_s),resin_0(t,i_sec0),resin_00(t,resin,i_sec0),resin_b00(t,resin,i_sec0),resin_b0(t,i_sec0),XPN_resin(t,i_s),XPB_resin(t,i_s);
$LOAD resoutnorm,resoutb10,NEVFA_10k,NEVFA_k0,resout_00,resout_b00,NEVFA_0,XPN_resout,XPB_resout,resin_0,resin_00,resin_b00,resin_b0,XPN_resin,XPB_resin

resout_0(t,i_sec0)=sum(resout,resout_00(t,i_sec0,resout));

Parameter EBS(yeark,Energy_d,Energy);
$LOAD EBS
$GDXIN


***Options****
parameters
GTAPBASE GTAP based energy accounting (without vst)
Prcs_ratio using next year's ratio between industries when allocating the process GHGs emissions into industries
;

GTAPBASE = 1 ;
Prcs_ratio = 0;
****************

$include "Agg\cal_IOT_KSW.gms"

$include "Energy_Estimation\Energy_Estimation_KSW.gms"
$include "emissions_estimation\Emission_Estimation_KSW2.gms"
$include "emissions_estimation\Emission_IP_KSW.gms"

$include "GTAP_K\GTAP_K_KSW.gms"
*display IOTD;
$include "GTAP_K\GTAP_Egy_KSW.gms"
