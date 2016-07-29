
Parameters IOTnorm(t,i_s,j_s), IOTdNorm(t,i_s,j_s), IOTmNorm(t,i_s,j_s);
$LIBINCLUDE XLIMPORT IOTnorm Agg\IOT\IOT_KSW.xlsx sme10gross!b2..cg84;
$LIBINCLUDE XLIMPORT IOTdNorm Agg\IOT\IOT_KSW.xlsx sme10domestic!b2..cg84;
$LIBINCLUDE XLIMPORT IOTmNorm Agg\IOT\IOT_KSW.xlsx sme10import!b2..cg84;

Parameters FinalDNorm(t,i_s,j_s), FinalDdNorm(t,i_s,j_s), FinalDmNorm(t,i_s,J_s);
$LIBINCLUDE XLIMPORT FinalDNorm Agg\IOT\IOT_KSW.xlsx sme10gross!ci2..cq84;
$LIBINCLUDE XLIMPORT FinalDdNorm Agg\IOT\IOT_KSW.xlsx sme10domestic!ci2..cq84;
$LIBINCLUDE XLIMPORT FinalDmNorm Agg\IOT\IOT_KSW.xlsx sme10import!ci2..cq84;

*****************************************************************************************
Parameters IOT_b(t,i_s,j_s), IOT_BD(t,i_s,j_s), IOT_bm(t,i_s,j_s);
$LIBINCLUDE XLIMPORT IOT_b Agg\IOT\IOT_KSW.xlsx sme10grossB!b2..cg84;
$LIBINCLUDE XLIMPORT IOT_BD Agg\IOT\IOT_KSW.xlsx sme10domesticB!b2..cg84;
$LIBINCLUDE XLIMPORT IOT_bm Agg\IOT\IOT_KSW.xlsx sme10importB!b2..cg84;

Parameters FinalD_b(t,i_s,j_s), FinalD_BD(t,i_s,j_s), FinalD_bm(t,i_s,J_s);
$LIBINCLUDE XLIMPORT FinalD_b Agg\IOT\IOT_KSW.xlsx sme10grossB!ci2..cq84;
$LIBINCLUDE XLIMPORT FinalD_BD Agg\IOT\IOT_KSW.xlsx sme10domesticB!ci2..cq84;
$LIBINCLUDE XLIMPORT FinalD_bm Agg\IOT\IOT_KSW.xlsx sme10importB!ci2..cq84;

*******************************************************************************************
set Tariff /Tariff/;
set TaxImport /TaxImport/;

Parameters Tar10(t,i_s,Tariff), taxM10(t,i_s,TaxImport)  ;
$LIBINCLUDE XLIMPORT tar10 Agg\IOT\IOT_KSW.xlsx sme10gross!cy2..da84     ;
$LIBINCLUDE XLIMPORT taxM10 Agg\IOT\IOT_KSW.xlsx sme10gross!dc2..de84    ;

set output /output/
*set resout /resout/
parameter xpnorm10(t,i_s,output),xpb10(t,i_s,output), XPnorm(t,i_s), XP_B(t,i_s);
$LIBINCLUDE XLIMPORT xpnorm10 Agg\IOT\IOT_KSW.xlsx sme10gross!cs2..cu84;
$LIBINCLUDE XLIMPORT xpb10 Agg\IOT\IOT_KSW.xlsx sme10grossB!cs2..cu84;
xpnorm(t,i_s) = sum(output, xpnorm10(t,i_s,output)) ;
XP_B(t,i_s) = sum(output, xpb10(t,i_s,output)) ;


*resout : output in the form of scrap
** resoutnorm: producers price residual output . 82 industry
** resoutb10: basic price residual output. 82 industry
parameter resoutnorm(t,i_s,resout),resoutb10(t,i_s,resout),XPN_resout(t,i_s),XPB_resout(t,i_s);
$LIBINCLUDE XLIMPORT resoutnorm Agg\IOT\IOT_KSW.xlsx sme10gross!cv2..cx84;
$LIBINCLUDE XLIMPORT resoutb10 Agg\IOT\IOT_KSW.xlsx sme10grossB!cv2..cx84;

XPN_resout(t,i_s)=sum(resout,resoutnorm(t,i_s,resout));
XPB_resout(t,i_s)=sum(resout,resoutb10(t,i_s,resout));

*resin : input saved by scrap production
**resinnorm: input save in producers' price. 82 ind
**resinb10:input save in basic price. 82 ind
parameter resinnorm(t,resin,i_s),resinb10(t,resin,i_s),XPN_resin(t,i_s),XPB_resin(t,i_s);
$LIBINCLUDE XLIMPORT resinnorm Agg\IOT\IOT_KSW.xlsx sme10gross!b86..cg87;
$LIBINCLUDE XLIMPORT resinb10 Agg\IOT\IOT_KSW.xlsx sme10grossB!b86..cg87;

XPN_resin(t,i_s)=sum(resin,resinnorm(t,resin,i_s));
XPB_resin(t,i_s)=sum(resin,resinb10(t,resin,i_s));



*EVFA_10K: VA in basic price
*NEVFA_10K: VA in producers' price

parameter EVFA_10K(t,i_s,j_s),NEVFA_10K(t,i_s,j_s)  ;
$LIBINCLUDE XLIMPORT EVFA_10K Agg\IOT\IOT_KSW.xlsx sme10grossB!b88..cg93;
$LIBINCLUDE XLIMPORT NEVFA_10K Agg\IOT\IOT_KSW.xlsx sme10gross!b88..cg93;

Parameters Tar0(t,i_s), TaxM0(t,i_s), Tar000(t,i_s), TaxM000(t,i_s) ;
Tar0(t,i_s) = sum(tariff, tar10(t,i_s,Tariff)) ;
TaxM0(t,i_s) =  sum(TaxImport, taxM10(t,i_s,TaxImport)) ;

Tar000(t,i_s) = sum(tariff, tar10(t,i_s,Tariff)) ;
TaxM000(t,i_s) = sum(TaxImport, taxM10(t,i_s,TaxImport)) ;

parameter EVFA_K0(t,i_s,j_s) value added in basic price;
EVFA_K0(t,i_s,j_s) = EVFA_10K(t,i_s,j_s)  ;

*PTAX´Â net value (PTAX + Subsidy)
EVFA_K0(t,"PTAX",j_s) = EVFA_K0(t,"PTAX",j_s) + EVFA_K0(t,"Subsidy",j_s) ;
EVFA_K0(t,"Subsidy",j_s) = 0 ;

parameter NEVFA_K0(t,i_s,j_s) value added in producers' price;
NEVFA_K0(t,i_s,j_s)=NEVFA_10K(t,i_s,j_s);

*PTAX´Â net value (PTAX + Subsidy)
NEVFA_K0(t,"PTAX",j_s) = NEVFA_K0(t,"PTAX",j_s) + NEVFA_K0(t,"Subsidy",j_s) ;
NEVFA_K0(t,"Subsidy",j_s) = 0 ;


Parameter XP_0(t,i_sec0),resout_0(t,i_sec0),resin_0(t,i_sec0),IOT_0(t,i_sec0,j_sec0), Finald0(t,i_sec0,Fin_demand), IOT_D0(t,i_sec0,j_sec0), FinaldD0(t,i_sec0,Fin_demand), IOT_M0(t,i_sec0,j_sec0), FinaldM0(t,i_sec0,Fin_demand), IOT_B0(t,i_sec0,j_sec0), FinalD0_b(t,i_sec0,Fin_Demand), Finald0_bD(t,i_sec0,Fin_demand), Finald0_bM(t,i_sec0,Fin_demand), IOT_BD0(t,i_sec0,j_sec0), IOT_BM0(t,i_sec0,j_sec0), xp_00(t,i_sec0,output), XP_B00(t,i_sec0,output), XP_B0(t,i_sec0),resout_00(t,i_sec0,resout),resout_b00(t,i_sec0,resout),resout_b0(t,i_sec0),resin_00(t,resin,i_sec0),resin_b00(t,resin,i_sec0),resin_b0(t,i_sec0);
$LIBINCLUDE XLIMPORT IOT_0 Agg\IOT\IOT_KSW.xlsx gross_norm!b5..nw774;
$LIBINCLUDE XLIMPORT IOT_D0 Agg\IOT\IOT_KSW.xlsx domestic_norm!b5..nw774;
$LIBINCLUDE XLIMPORT IOT_M0 Agg\IOT\IOT_KSW.xlsx import_norm!b5..nw774;
$LIBINCLUDE XLIMPORT Finald0 Agg\IOT\IOT_KSW.xlsx gross_norm!ny5..og774;
$LIBINCLUDE XLIMPORT FinalDD0 Agg\IOT\IOT_KSW.xlsx domestic_norm!ny5..og774;
$LIBINCLUDE XLIMPORT FinalDM0 Agg\IOT\IOT_KSW.xlsx import_norm!ny5..og774;

$LIBINCLUDE XLIMPORT XP_00 Agg\IOT\IOT_KSW.xlsx gross_norm!oi5..ok812;
$LIBINCLUDE XLIMPORT resout_00 Agg\IOT\IOT_KSW.xlsx gross_norm!ol5..on812;
$LIBINCLUDE XLIMPORT resin_00 Agg\IOT\IOT_KSW.xlsx gross_norm!b789..nw791;


$LIBINCLUDE XLIMPORT IOT_B0 Agg\IOT\IOT_KSW.xlsx IOT_Basic!b5..nw389;
$LIBINCLUDE XLIMPORT IOT_BD0 Agg\IOT\IOT_KSW.xlsx IOT_BasicD!b5..nw389;
$LIBINCLUDE XLIMPORT IOT_BM0 Agg\IOT\IOT_KSW.xlsx IOT_BasicM!b5..nw389;
$LIBINCLUDE XLIMPORT FinalD0_b Agg\IOT\IOT_KSW.xlsx IOT_Basic!ny5..og389;
$LIBINCLUDE XLIMPORT FinalD0_bD Agg\IOT\IOT_KSW.xlsx IOT_BasicD!ny5..og389;
$LIBINCLUDE XLIMPORT FinalD0_bM Agg\IOT\IOT_KSW.xlsx IOT_BasicM!ny5..og389;

$LIBINCLUDE XLIMPORT XP_B00 Agg\IOT\IOT_KSW.xlsx IOT_Basic!oi5..ok389;
$LIBINCLUDE XLIMPORT resout_B00 Agg\IOT\IOT_KSW.xlsx IOT_Basic!ol5..on389;
$LIBINCLUDE XLIMPORT resin_B00 Agg\IOT\IOT_KSW.xlsx IOT_Basic!b391..nw392;

XP_0(t,i_sec0) = sum(output, xp_00(t,i_sec0,output)) ;
XP_B0(t,i_sec0) = sum(output, xp_B00(t,i_sec0,output)) ;

resout_0(t,i_sec0)=sum(resout,resout_00(t,i_sec0,resout));
resout_b0(t,i_sec0)=sum(resout,resout_b00(t,i_sec0,resout));

resin_0(t,i_sec0)=sum(resin,resin_00(t,resin,i_sec0));
resin_b0(t,i_sec0)=sum(resin,resin_b00(t,resin,i_sec0));


Parameters Tar_0(t,i_sec0), TaxM_0(t,i_sec0), Tar_00(t,i_sec0,Tariff), TaxM_00(t,i_sec0,TaxImport) ;
$LIBINCLUDE XLIMPORT Tar_00 Agg\IOT\IOT_KSW.xlsx gross_norm!oo5..oq774;
$LIBINCLUDE XLIMPORT TaxM_00 Agg\IOT\IOT_KSW.xlsx gross_norm!or5..ot774;

Tar_0(t,i_sec0) = sum(tariff, tar_00(t,i_sec0,Tariff)) ;
TaxM_0(t,i_sec0) =  sum(TaxImport, taxM_00(t,i_sec0,TaxImport)) ;

*EVFA_10K: VA in basic price 82sector
*NEVFA_10K: VA in producers' price 82sector
parameter EVFA_0(t,va,j_sec0) value added in basic price 384sectors;
parameter NEVFA_0(t,va,j_sec0) value added in producers' price 384sectors;
$LIBINCLUDE XLIMPORT EVFA_0 Agg\IOT\IOT_KSW.xlsx IOT_Basic!b393..nw398;
$LIBINCLUDE XLIMPORT NEVFA_0 Agg\IOT\IOT_KSW.xlsx gross_norm!b776..nw787;

*PTAX´Â net value (PTAX + Subsidy)
EVFA_0(t,"PTAX",j_sec0) = EVFA_0(t,"PTAX",j_sec0) + EVFA_0(t,"Subsidy",j_sec0) ;
EVFA_0(t,"Subsidy",j_sec0) = 0 ;

NEVFA_0(t,"PTAX",j_sec0) = NEVFA_0(t,"PTAX",j_sec0) + NEVFA_0(t,"Subsidy",j_sec0) ;
NEVFA_0(t,"Subsidy",j_sec0) = 0 ;


*****Importing the Energy Balance Sheet
Parameters EBS(yeark,Energy_d,Energy), EBS2011(Energy_d,Energy), EBS2010(Energy_d,Energy), EBS2009(Energy_d,Energy), EBS2007(Energy_d,Energy), EBS2005(Energy_d,Energy), EBS2003(Energy_d,Energy);
$LIBINCLUDE XLIMPORT EBS2011 Energy_Estimation\Energy_Balance_Sheet.xlsx EBS2011!b6..AM47;
$LIBINCLUDE XLIMPORT EBS2010 Energy_Estimation\Energy_Balance_Sheet.xlsx EBS2010!b6..AM47;
$LIBINCLUDE XLIMPORT EBS2009 Energy_Estimation\Energy_Balance_Sheet.xlsx EBS2009!b6..AM47;
$LIBINCLUDE XLIMPORT EBS2007 Energy_Estimation\Energy_Balance_Sheet.xlsx EBS2007!b6..AM47;
$LIBINCLUDE XLIMPORT EBS2005 Energy_Estimation\Energy_Balance_Sheet.xlsx EBS2005!b6..AM47;
$LIBINCLUDE XLIMPORT EBS2003 Energy_Estimation\Energy_Balance_Sheet.xlsx EBS2003!b6..AM47;
EBS("2011",Energy_d,Energy) = EBS2011(Energy_d,Energy) ;
EBS("2010",Energy_d,Energy) = EBS2010(Energy_d,Energy) ;
EBS("2009",Energy_d,Energy) = EBS2009(Energy_d,Energy) ;
EBS("2007",Energy_d,Energy) = EBS2007(Energy_d,Energy) ;
EBS("2005",Energy_d,Energy) = EBS2005(Energy_d,Energy) ;
EBS("2003",Energy_d,Energy) = EBS2003(Energy_d,Energy) ;

execute_unload 'ioimport_KSW.gdx',
IOTnorm, IOTdNorm, IOTmNorm, FinalDNorm, FinalDdNorm, FinalDmNorm, tar10, taxM10, xpnorm10, EVFA_10K, xpnorm, Tar0, TaxM0, Tar000, TaxM000, EVFA_K0, output, Tariff, TaxImport, IOT_b, IOT_BD, IOT_bm, FinalD_b, FinalD_BD, FinalD_bm, xpb10, XP_B, IOT_B0, FinalD0_b, IOT_BM0, XP_B0, EBS, IOT_0, Finald0, IOT_D0, FinaldD0, IOT_M0, FinaldM0, IOT_BD0, Finald0_bD, Finald0_bM, XP_0, Tar_0, TaxM_0, EVFA_0,resoutnorm,resoutb10,NEVFA_10k,NEVFA_k0,resout_00,resout_b00,NEVFA_0,XPN_resout,XPB_resout,resin_0,resin_00,resin_b00,resin_b0,XPN_resin,XPB_resin
;
*$offtext
