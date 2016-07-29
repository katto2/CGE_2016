***** basic priced IOT *****

set by(t) base year /2010/
set ty(t) years to be changed /2010/

*From 2010, we only have basic price IO. We have to recover producers' price IO from basic price IO.
** In basic price IO, import taxes on Total transaction table is always 0. We won't be able to use Tar+Taxm in estimating import table.
** Instead, we use basic price import table A and F to estimate producers' price A and F
** And in checking balances, Domestic interemediate demand + Final demand should be compared with Total VA column sum + Total A column sum + Scrap input + Scrap output. Not VA colum sum + A column sum.
*** If we stick with old practice, then we risk unnecessary distorion in stock variation.

*REVFA_0: nominal price VA/basic price VA in 2010. For years other than 2010, we only have EVFA_K0
*We will use NEVFA_0 = REVFA_0*EVFA_K0.
parameter REVFA_0(by,va,i_sec0), REVFA_00(va,i_sec0);
REVFA_0(by,va,i_sec0)$(EVFA_0(by,va,i_sec0)<>0)=NEVFA_0(by,va,i_sec0)/EVFA_0(by,va,i_sec0);
REVFA_00(va,i_sec0)=sum(by, REVFA_0(by,va,i_sec0));

parameters
R_MFTAX(t,i_sec0,j_sec0)
R_MPTAX(t,i_sec0,fin_demand)
R_PTAX_K00(t,i_sec0) initial output tax rate (xp_b 대비가 아닌 ptax를 뺀 output 대비)
R_Subsidy_K00(t,i_sec0) initial output subsidy rate
R_DFCTAX_K00(t,i_sec0,fin_demand) initial final consumption tax rate for domestic goods
R_MFTAX_K00(t,i_sec0,j_sec0)
R_MFCTAX_K00(t,i_sec0,fin_demand) initial final consumption tax rate for imported goods
R_DFTAX_K00(t,i_sec0,j_sec0) initial tax rate for domestic intermediate input
*R_IFTAX_K00(t,i_sec0,j_sec0) initial tax rate for imported intermediate input
R_DPTAX_K00(t,i_sec0) initial tax rate for domestic private consumption goods
*R_IPTAX_K00(t,i_sec0) initial tax rate for imported private consumption goods
R_DGTAX_K00(t,i_sec0) initial tax rate for domestic government consumption goods
*R_IGTAX_K00(t,i_sec0) initial tax rate for imported government consumption goods
R_DITAX_K00(t,i_sec0) initial tax rate for domestic investment
*R_IITAX_K00(t,i_sec0) initial tax rate for imported investment
*R_TAR_K000(t,i_sec0) initial Tarrif rate
R_IFTAX_K00(t,i_sec0,j_sec0)
R_IPTAX_k00(t,i_sec0,j_sec0)
DFTAX_K00(t,i_sec0,j_sec0)
DFCTAX_K00(t,i_sec0,fin_demand)
IFTAX_K00(t,i_sec0,j_sec0)
IPTAX_k00(t,i_sec0,j_sec0)
TAR_K00(t,i_sec0,j_sec0)
TarP_K00(t,i_sec0,j_sec0)
xp_b0(yeark,i_sec0)
FinalD_b0(t,i_sec0,Fin_demand)
FinalDD0(t,i_sec0,fin_demand)
FinalDM0(t,i_sec0,fin_demand)
FinalD0(t,i_sec0,fin_demand)
IOTD0(t,i_sec0,j_sec0)
IOTM0(t,i_sec0,j_sec0)
IOT0(t,i_sec0,j_sec0)
EVFA_K00(t,va,j_sec0)
NEVFA_K00(t,va,j_sec0)
;
parameter R_DFCTAX_K000(i_sec0,fin_demand), R_DFTAX_K000(i_sec0,j_sec0), R_MFCTAX_K000(i_sec0,fin_demand), R_MFTAX_K000(i_sec0,j_sec0) ;
parameter Distr_FinD(t,i_sec0,Fin_demand), Distr_VA(t,VA0,i_sec0), CAL_PTAX(t,i_sec0), cal_FinalD(t,i_sec0), CAL_STOCK(t,i_sec0) ;
parameters FinalD_bt(t,i_sec0,fin_demand), FinalD_bdt(t,i_sec0,fin_demand), FinalD_bmt(t,i_sec0,fin_demand), cal_IOT_Test(t,i_sec0,Fin_demand) 최종수요 확인;
parameters IOT_bdt(t,i_sec0,j_sec0), IOT_bmt(t,i_sec0,j_sec0), IOT_bt(t,i_sec0,j_sec0), cal_IOT_Test3(t,i_sec0,j_sec0) 중간수요 확인  ;
parameter cal_IOT_Test2(t,i_sec0) 총투입과 총산출 일치 확인 ;;

*******************************************************************************

R_MFTAX(t,i_sec0,j_sec0)$( Tar_0(t,i_sec0) + TaxM_0(t,i_sec0) ) =
         ( IOT_BM0(t,i_sec0,j_sec0)-IOT_M0(t,i_sec0, j_sec0)   )
         / ( Tar_0(t,i_sec0) + TaxM_0(t,i_sec0) ) ;

R_MPTAX(t,i_sec0,fin_demand)$( Tar_0(t,i_sec0) + TaxM_0(t,i_sec0) ) =
         (  FinalD0_bM(t,i_sec0,fin_demand) - FinalDM0(t,i_sec0,fin_demand) )
         / ( Tar_0(t,i_sec0) + TaxM_0(t,i_sec0) ) ;



EVFA_K00(t,va,j_sec0) = EVFA_0(t,va,j_sec0);
NEVFA_K00(t,va,j_sec0)=REVFA_00(va,j_sec0)*EVFA_0(t,va,j_sec0);


R_MFTAX_K00(t,i_sec0,j_sec0)$IOT_bm0(t,i_sec0,j_sec0)
         = ( IOT_BM0(t,i_sec0,j_sec0) - IOT_M0(t,i_sec0,j_sec0) )
          / IOT_M0(t,i_sec0,j_sec0) ;

R_MFCTAX_K00(t,i_sec0,fin_demand)$FinalD0_bM(t,i_sec0,fin_demand)
         = ( FinalD0_bM(t,i_sec0,Fin_demand) - FinalDM0(t,i_sec0,Fin_demand) )
          / FinalDM0(t,i_sec0,fin_demand) ;

R_MPTAX(t,i_sec0,"final_tot") = 0;

*if ((sum(by, sum(i_sec0, abs(sum(j_sec0, IOT_M0(by,i_sec0,j_sec0) - IOT_bm0(by,i_sec0,j_sec0) ) + sum(fin_demand, ( FinalDM0(by,i_sec0,fin_demand) - FinalD0_bM(by,i_sec0,fin_demand) ))
*-  (  FinalDM0(by,i_sec0,"final_tot") - FinalD0_bM(by,i_sec0,"final_tot") ) -  ( Tar_0(by,i_sec0) + TaxM_0(by,i_sec0) ))))) > 0.0001 , Abort   "Check the distribution of Tax and Tariff"  ;
*);

DFTAX_K00(t,i_sec0,j_sec0)$IOT_BD0(t,i_sec0,j_sec0) = IOT_BD0(t,i_sec0,j_sec0) - IOT_D0(t,i_sec0,j_sec0) ;
*DFCTAX_K00(t,i_sec0,fin_demand)$FinalD0_bM(t,i_sec0,Fin_demand) = FinalDD0(t,i_sec0,Fin_demand) - FinalD0_bD(t,i_sec0,Fin_demand) ;
DFCTAX_K00(t,i_sec0,fin_demand)$FinalD0_bM(t,i_sec0,Fin_demand) = FinalD0_bD(t,i_sec0,Fin_demand) - FinalDD0(t,i_sec0,Fin_demand) ;

R_DFTAX_K00(t,i_sec0,j_sec0)$(IOT_bd0(t,i_sec0,j_sec0))
         = DFTAX_K00(t,i_sec0,j_sec0) / IOT_D0(t,i_sec0,j_sec0) ;

R_DFCTAX_K00(t,i_sec0,fin_demand)$(FinalD0_bD(t,i_sec0,Fin_demand))
         = (FinalD0_bD(t,i_sec0,Fin_demand) - FinalDD0(t,i_sec0,Fin_demand)) / FinalDD0(t,i_sec0,Fin_demand) ;


**********************************************************************

R_DFCTAX_K000(i_sec0,fin_demand)$(sum(by, FinalD0_bD(by,i_sec0,fin_demand))) = sum(by, R_DFCTAX_K00(by,i_sec0,fin_demand));
*R_DFCTAX_K000(i_sec0,fin_demand)$(not sum(by, FinalD_BD(by,i_sec0,fin_demand))) = sum(by2, R_DFCTAX_K00(by2,i_sec0,fin_demand));

R_DFTAX_K000(i_sec0,j_sec0)$(sum(by, IOT_BD0(by,i_sec0,j_sec0))) = sum(by, R_DFTAX_K00(by,i_sec0,j_sec0));
*R_DFTAX_K000(i_sec0,j_sec0)$(not sum(by, IOT_BD(by,i_sec0,j_sec0))) = sum(by2, R_DFTAX_K00(by2,i_sec0,j_sec0));

R_MFCTAX_K000(i_sec0,fin_demand)$(sum(by, FinalD0_bM(by,i_sec0,fin_demand))) = sum(by, R_MFCTAX_K00(by,i_sec0,fin_demand));
*R_MFCTAX_K000(i_sec0,fin_demand)$(not sum(by, FinalD_BM(by,i_sec0,fin_demand))) = sum(by2, R_MFCTAX_K00(by2,i_sec0,fin_demand));

R_MFTAX_K000(i_sec0,j_sec0)$(sum(by, IOT_BM0(by,i_sec0,j_sec0))) = sum(by, R_MFTAX_K00(by,i_sec0,j_sec0));
*R_MFTAX_K000(i_sec0,j_sec0)$(not sum(by, IOT_BM(by,i_sec0,j_sec0))) = sum(by2, R_MFTAX_K00(by2,i_sec0,j_sec0));

loop(t$(ty(t)),
         FinalDD0(t,i_sec0,fin_demand)
                 = FinalD0_bD(t,i_sec0,fin_demand) / (1+ R_DFCTAX_K000(i_sec0,fin_demand) ) ;
         FinalDM0(t,i_sec0,fin_demand)
                 = FinalD0_bM(t,i_sec0,fin_demand) / (1+ R_MFCTAX_K000(i_sec0,fin_demand) ) ;
         FinalDD0(t,i_sec0,"Final_EX") = FinalD0_bD(t,i_sec0,"Final_Ex") ;
         FinalDD0(t,i_sec0,"Final_tot") = sum(Fin_DD, FinalDD0(t,i_sec0,Fin_DD)) + sum(Fin_DX, FinalDD0(t,i_sec0,Fin_DX));
         FinalDM0(t,i_sec0,"Final_tot") = sum(Fin_DD, FinalDM0(t,i_sec0,Fin_DD));
         FinalD0(t,i_sec0,Fin_demand) = FinalDD0(t,i_sec0,Fin_demand) + FinalDM0(t,i_sec0,Fin_demand) ;
);

loop(t$(ty(t)),
         IOT_D0(t,i_sec0,j_sec0)
                 = IOT_BD0(t,i_sec0,j_sec0)  / (1+ R_DFTAX_K000(i_sec0,j_sec0) );
         DFTAX_K00(t,i_sec0,j_sec0)
                 = IOT_BD0(t,i_sec0,j_sec0)  * R_DFTAX_K000(i_sec0,j_sec0) / (1 + R_DFTAX_K000(i_sec0,j_sec0) ) ;
         IOT_M0(t,i_sec0,j_sec0)
                 = IOT_bM0(t,i_sec0,j_sec0)/(1+R_MFTAX_K000(i_sec0,j_sec0) );
         IOT_0(t,i_sec0,j_sec0) = IOT_D0(t,i_sec0,j_sec0) + IOT_M0(t,i_sec0,j_sec0);
);

** Since we don't have Tax data in basic IO table, we won't be able to check if Tax data are preserved
*if ((sum(ty, sum(i_sec0, abs(sum(j_sec0, IOT_M0(ty,i_sec0,j_sec0) - IOT_bm0(ty,i_sec0,j_sec0) ) + sum(fin_demand, ( FinalDM0(ty,i_sec0,fin_demand) - FinalD0_bM(ty,i_sec0,fin_demand) ))
*-  (  FinalDM0(ty,i_sec0,"final_tot") - FinalD0_bM(ty,i_sec0,"final_tot") ) -  ( Tar_0(ty,i_sec0) + TaxM_0(ty,i_sec0) ))))) > 0.0001 , Abort   "Check the distribution of Tax and Tariff"  ;
*);


***** 조정: 중간수요에 비해 최종수요가 상대적으로 크게 증가하면서, 재고증가가 커져 xp가 음수가 되는 경우가 발생. 이럴 경우 생산자표의 xp에 맞춰주고 차액만큼 재고증가에서 증가.
*2011년의 경우 해당 없음.

loop(t$(ty(t)),
         xp_0(t,i_sec0) = sum(j_sec0, IOT_B0(t,i_sec0,j_sec0)) + FinalDD0(t,i_sec0,"final_tot") ;
         FinalDD0(t,i_sec0,"final_ST")$(xp_0(t,i_sec0)<0) = FinalDD0(t,i_sec0,"final_ST") - xp_0(t,i_sec0) + XP_b0(t,i_sec0)+resin_0(t,i_sec0)+resout_0(t,i_sec0)  ;
** continue in June 11th.
FinalD0_bD(t,i_sec0,"Final_tot") = sum(Fin_DD, FinalD0_bD(t,i_sec0,Fin_DD)) + sum(Fin_DX, FinalD0_bD(t,i_sec0,Fin_DX));
         FinalDM0(t,i_sec0,"Final_tot") = sum(Fin_DD, FinalDM0(t,i_sec0,Fin_DD));
         FinalD0(t,i_sec0,Fin_demand) = FinalDD0(t,i_sec0,Fin_demand) + FinalDM0(t,i_sec0,Fin_demand) ;
         xp_0(t,i_sec0) = sum(j_sec0, IOT_D0(t,i_sec0,j_sec0)) + FinalDD0(t,i_sec0,"final_tot");
);
**Still, xp_b0 should be updated for the adjustment
****************************

loop(t$(ty(t)),
         cal_FinalD(t,i_sec0) = sum(VA, REVFA_00(va,i_sec0)*EVFA_0(t,VA,i_sec0)) + sum(j_sec0, IOT_0(t,j_sec0,i_sec0))+resin_0(t,i_sec0)+resout_0(t,i_sec0) - xp_0(t,i_sec0) ;
         FinalDD0(t,i_sec0,"final_st") = cal_FinalD(t,i_sec0) + FinalDD0(t,i_sec0,"final_st") ;
         FinalDD0(t,i_sec0,"Final_tot") = sum(Fin_DD, FinalDD0(t,i_sec0,Fin_DD)) + sum(Fin_DX, FinalDD0(t,i_sec0,Fin_DX));
         FinalDM0(t,i_sec0,"Final_tot") = sum(Fin_DD, FinalDM0(t,i_sec0,Fin_DD));
         FinalD0(t,i_sec0,Fin_demand) = FinalDD0(t,i_sec0,Fin_demand) + FinalDM0(t,i_sec0,Fin_demand) ;
         xp_0(t,i_sec0) = sum(j_sec0, IOT_D0(t,i_sec0,j_sec0)) + FinalDD0(t,i_sec0,"final_tot");
);

***** 총투입과 총산출 일치 확인
loop(t$(ty(t)),
         cal_IOT_Test2(t,i_sec0)
         = xp_0(t,i_sec0) - sum(j_sec0, IOT_0(t,j_sec0,i_sec0) ) - sum(va, REVFA_00(va,i_sec0)*EVFA_0(t,va,i_sec0))-resin_0(t,i_sec0)-resout_0(t,i_sec0) ;
);
display cal_IOT_Test2;

if ((sum(ty, sum(i_sec0, abs(cal_IOT_Test2(ty,i_sec0))))) > 0.001, Abort   "Check the gross output"  ;);


