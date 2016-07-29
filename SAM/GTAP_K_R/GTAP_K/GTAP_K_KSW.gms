*REVFA_K0: nominal price VA/basic price VA in 2010. For years other than 2010, we only have EVFA_K0
*We will use EVFA_K0 = REVFA_K0*EVFA_K0.
parameter REVFA_K0(i_s,j_s), EVFA_b_K0(t,i_s,j_s);
REVFA_K0(i_s,j_s)$(EVFA_K0("2010",i_s,j_s)<>0)=NEVFA_K0("2010",i_s,j_s)/EVFA_K0("2010",i_s,j_s);
EVFA_b_K0(t,i_s,j_s)=EVFA_k0(t,i_s,j_s);
*display REVFA_K0,EVFA_K0,EVFA_b_K0,NEVFA_K0;
EVFA_K0(t,i_s,j_s)=REVFA_K0(i_s,j_s)*EVFA_K0(t,i_s,j_s);
*display EVFA_K0, NEVFA_K0, EVFA_b_K0;
parameter check30(t),check3_1(t),check3_2(t);
* Obtain residual input row from VA
** XPN_resin is in producers' price. XPB_resin is in basic price. But, they are exactly the same.

*parameter resin_norm(t,i_s),resin_b10(t,i_s);
*resin_norm(t,i_s)=NEVFA_K0(t,"resin",i_s);
*resin_b10(t,i_s)=EVFA_K0(t,"resin",i_s);
display XPN_resin,XPB_resin,XPN_resout,XPB_resout;
* Real values (value in 2007 price ) of residual variables
parameters XPB_resin_R(t,i_s),XPB_resout_R(t,i_s),XPN_resin_R(t,i_s),XPN_resout_R(t,i_s);


set tb(t) /2010/
loop(t$(not told(t)),

*********
CR("2007") =  929.26 ;
CR("2009") =  CR("2007") ;
CR("2010") =  CR("2007") ;
*********
*GDPDF("2003") = ( (1+0.030) * (1+0.007) * (1-0.001) * (1+0.021) ) ;
*GDPDF("2005") = ( (1-0.001) * (1+0.021) ) ;
GDPDF("2007") = 1 ;
GDPDF("2009") = 1 / ( (1+0.029) * (1+0.034) )  ;
GDPDF("2010") = 1 / ( (1+0.029) * (1+0.034) * (1+0.036) )  ;
*GDPDF("2011") = 1 / ( (1+0.029) * (1+0.034) * (1+0.036) * (1+0.015) )  ;
Display EVFA_K0, NEVFA_K0;
*********** 행열 합계 조정  - 열합계를 기준으로 재고증가에서 열합계 조정***********

IOT_B(t,i_s,j_s) = IOT_BD(t,i_s,j_s) + IOT_BM(t,i_s,j_s) ;
FinalD_BD(t,i_s,"Final_tot") = sum(Fin_DD, FinalD_BD(t,i_s,Fin_DD)) + FinalD_BD(t,i_s,"Final_EX") ;
xp_b(t,j_s) = sum(i_s, IOT_B(t,i_s,j_s) + EVFA_K0(t,i_s,j_s) ) ;
xp_b_CAL(t,i_s) = xp_b(t,i_s) +XPB_resin(t,i_s)+XPB_resout(t,i_s)- ( sum(j_s, IOT_BD(t,i_s,j_s) ) + FinalD_BD(t,i_s,"final_tot") ) ;
Display XP_B_CAL;

loop(i_s$(FinalD_BD(t,i_s,"Final_tot")), CAL_FINALD_BD(t,i_s,fin_demand) = FinalD_BD(t,i_s,fin_demand) / FinalD_BD(t,i_s,"Final_tot")) ;
loop(j_s$(sum(k_s, EVFA_k0(t,k_s,j_s))), CAL_EVFA_k0(t,i_s,j_s) = EVFA_k0(t,i_s,j_s) / sum(k_s, EVFA_k0(t,k_s,j_s)) );
loop(i_s,
         If(FinalD_BD(t,i_s,"final_ST")>0,
         FinalD_BD(t,i_s,"final_ST") = xp_b_CAL(t,i_s) + FinalD_BD(t,i_s,"Final_ST") ;
         FinalD_BD(t,i_s,"Final_tot") = sum(Fin_DD, FinalD_BD(t,i_s,Fin_DD)) + FinalD_BD(t,i_s,"Final_EX") ;
         FinalD_B(t,i_s,j_s) = FinalD_BD(t,i_s,j_s) + FinalD_BM(t,i_s,j_s) ;
         xp_b_CAL(t,i_s) = xp_b(t,i_s)+XPB_resin(t,i_s)+XPB_resout(t,i_s) - ( sum(j_s, IOT_BD(t,i_s,j_s) ) + FinalD_BD(t,i_s,"final_tot") ) ;
         );
         Display XP_B_CAL;
);
loop(i_s,
         If(FinalD_BD(t,i_s,"final_ST") le 0 and abs(xp_b_CAL(t,i_s)) < abs(FinalD_BD(t,i_s,"Final_tot")/2),
         FinalD_BD(t,i_s,"Final_tot") = xp_b_CAL(t,i_s) + FinalD_BD(t,i_s,"Final_tot") ;
         FinalD_BD(t,i_s,fin_demand) = FinalD_BD(t,i_s,"Final_tot") * CAL_FINALD_BD(t,i_s,fin_demand) ;
         FinalD_BD(t,i_s,"Final_tot") = sum(Fin_DD, FinalD_BD(t,i_s,Fin_DD)) + FinalD_BD(t,i_s,"Final_EX") ;
         FinalD_B(t,i_s,j_s) = FinalD_BD(t,i_s,j_s) + FinalD_BM(t,i_s,j_s) ;
         xp_b_CAL(t,i_s) = xp_b(t,i_s)+XPB_resin(t,i_s)+XPB_resout(t,i_s) - ( sum(j_s, IOT_BD(t,i_s,j_s) ) + FinalD_BD(t,i_s,"final_tot") ) ;
         );
         Display XP_B_CAL ;
);
loop(i_s,
         If(FinalD_BD(t,i_s,"final_ST") le 0 and abs(xp_b_CAL(t,i_s)) ge abs(FinalD_BD(t,i_s,"Final_tot")/2) ,

         XP_B_CAL2(t,i_s)$(XP_B_CAL(t,i_s)>0 and FinalD_BD(t,i_s,"Final_tot")>0) = XP_B_CAL(t,i_s) - (FinalD_BD(t,i_s,"Final_tot")/2) ;
         XP_B_CAL2(t,i_s)$(XP_B_CAL(t,i_s)>0 and FinalD_BD(t,i_s,"Final_tot")<0) = XP_B_CAL(t,i_s) + (FinalD_BD(t,i_s,"Final_tot")/2) ;
         XP_B_CAL2(t,i_s)$(XP_B_CAL(t,i_s)<0 and FinalD_BD(t,i_s,"Final_tot")>0) = XP_B_CAL(t,i_s) + (FinalD_BD(t,i_s,"Final_tot")/2) ;
         XP_B_CAL2(t,i_s)$(XP_B_CAL(t,i_s)<0 and FinalD_BD(t,i_s,"Final_tot")<0) = XP_B_CAL(t,i_s) - (FinalD_BD(t,i_s,"Final_tot")/2) ;

         FinalD_BD(t,i_s,"Final_tot")$(XP_B_CAL(t,i_s)>0 and FinalD_BD(t,i_s,"Final_tot")>0) = FinalD_BD(t,i_s,"Final_tot") *3/2 ;
         FinalD_BD(t,i_s,"Final_tot")$(XP_B_CAL(t,i_s)>0 and FinalD_BD(t,i_s,"Final_tot")<0) = FinalD_BD(t,i_s,"Final_tot") *1/2 ;
         FinalD_BD(t,i_s,"Final_tot")$(XP_B_CAL(t,i_s)<0 and FinalD_BD(t,i_s,"Final_tot")>0) = FinalD_BD(t,i_s,"Final_tot") *1/2 ;
         FinalD_BD(t,i_s,"Final_tot")$(XP_B_CAL(t,i_s)<0 and FinalD_BD(t,i_s,"Final_tot")<0) = FinalD_BD(t,i_s,"Final_tot") *3/2 ;

         FinalD_BD(t,i_s,fin_demand) = FinalD_BD(t,i_s,"Final_tot") * CAL_FINALD_BD(t,i_s,fin_demand) ;
         FinalD_BD(t,i_s,"Final_tot") = sum(Fin_DD, FinalD_BD(t,i_s,Fin_DD)) + FinalD_BD(t,i_s,"Final_EX") ;
         FinalD_B(t,i_s,j_s) = FinalD_BD(t,i_s,j_s) + FinalD_BM(t,i_s,j_s) ;
         XP_B_CAL(t,i_s) = XP_B_CAL2(t,i_s) ;
                 If( abs(xp_b_CAL(t,i_s)) < sum(j_s, EVFA_K0(t,j_s,i_s)/2),
                 EVFA_k0(t,j_s,i_s) = (sum(k_s, EVFA_k0(t,k_s,i_s)) - xp_b_CAL(t,i_s) ) * CAL_EVFA_k0(t,j_s,i_s) ;
                 xp_b(t,j_s) = sum(k_s, IOT_B(t,k_s,j_s) + EVFA_k0(t,k_s,j_s) ) ;
                 xp_b_CAL(t,i_s) = xp_b(t,i_s)+XPB_resin(t,i_s)+XPB_resout(t,i_s) - ( sum(j_s, IOT_BD(t,i_s,j_s) ) + FinalD_BD(t,i_s,"final_tot") ) ;
                 else
                 XP_B_CAL3(t,i_s)$(XP_B_CAL(t,i_s)>0) = XP_B_CAL(t,i_s) - SUM(k_s, evfa_k0(t,k_s,i_s)/2) ;
                 XP_B_CAL3(t,i_s)$(XP_B_CAL(t,i_s)<0) = XP_B_CAL(t,i_s) + SUM(k_s, evfa_k0(t,k_s,i_s)/2) ;
                 EVFA_k0(t,j_s,i_s)$(XP_B_CAL(t,i_s)>0) = (sum(k_s, EVFA_k0(t,k_s,i_s))*1/2 ) * CAL_EVFA_k0(t,j_s,i_s) ;
                 EVFA_k0(t,j_s,i_s)$(XP_B_CAL(t,i_s)<0) = (sum(k_s, EVFA_k0(t,k_s,i_s))*3/2 ) * CAL_EVFA_k0(t,j_s,i_s) ;
                 EVFA_K0(t,"PTAX",j_s) = EVFA_K0(t,"PTAX",j_s) - XP_B_CAL3(t,i_s) ;
                 xp_b(t,j_s) = sum(k_s, IOT_B(t,k_s,j_s) + EVFA_k0(t,k_s,j_s) ) ;
                 xp_b_CAL(t,i_s) = xp_b(t,i_s)+XPB_resin(t,i_s)+XPB_resout(t,i_s) - ( sum(j_s, IOT_BD(t,i_s,j_s) ) + FinalD_BD(t,i_s,"final_tot") ) ;
                 );
         Display XP_B_CAL ;
         );
);

Display EVFA_K0;

xp_b_CAL(t,i_s) = xp_b(t,i_s)+XPB_resin(t,i_s)+XPB_resout(t,i_s) - ( sum(j_s, IOT_BD(t,i_s,j_s) ) + FinalD_BD(t,i_s,"final_tot") ) ;
If (sum(i_s, abs(xp_b_CAL(t,i_s))) > 1, Abort   "Check the difference between low Sum and Column Sum")  ;
*************************************************************************************************************

IOTNORM(t,i_s,j_s) = IOTDNORM(t,i_s,j_s) + IOTMNORM(t,i_s,j_s) ;
FinalDDnorm(t,i_s,"Final_tot") = sum(Fin_DD, FinalDDnorm(t,i_s,Fin_DD)) + FinalDDnorm(t,i_s,"Final_EX") ;
xpnorm(t,j_s) = sum(i_s, IOTNORM(t,i_s,j_s) + EVFA_K0(t,i_s,j_s) ) ;
xp_b_CAL(t,i_s) = xpnorm(t,i_s)+XPN_resin(t,i_s)+XPN_resout(t,i_s) - ( sum(j_s, IOTDNORM(t,i_s,j_s) ) + FinalDDnorm(t,i_s,"final_tot") ) ;
Display XP_B_CAL;

loop(i_s$(FinalDDnorm(t,i_s,"Final_tot")), CAL_FINALD_BD(t,i_s,fin_demand) = FinalDDnorm(t,i_s,fin_demand) / FinalDDnorm(t,i_s,"Final_tot")) ;
loop(j_s$(sum(k_s, EVFA_k0(t,k_s,j_s))), CAL_EVFA_k0(t,i_s,j_s) = EVFA_k0(t,i_s,j_s) / sum(k_s, EVFA_k0(t,k_s,j_s)) );
loop(i_s,
         If(FinalDDnorm(t,i_s,"final_ST")>0,
         FinalDDnorm(t,i_s,"final_ST") = xp_b_CAL(t,i_s) + FinalDDnorm(t,i_s,"Final_ST") ;
         FinalDDnorm(t,i_s,"Final_tot") = sum(Fin_DD, FinalDDnorm(t,i_s,Fin_DD)) + FinalDDnorm(t,i_s,"Final_EX") ;
         FinalDnorm(t,i_s,j_s) = FinalDDnorm(t,i_s,j_s) + FinalDMnorm(t,i_s,j_s) ;
         xp_b_CAL(t,i_s) = xpnorm(t,i_s)+XPN_resin(t,i_s)+XPN_resout(t,i_s) - ( sum(j_s, IOTDNORM(t,i_s,j_s) ) + FinalDDnorm(t,i_s,"final_tot") ) ;
         );
         Display XP_B_CAL;
);
loop(i_s,
         If(FinalDDnorm(t,i_s,"final_ST") le 0 and abs(xp_b_CAL(t,i_s)) < abs(FinalDDnorm(t,i_s,"Final_tot")/2),
         FinalDDnorm(t,i_s,"Final_tot") = xp_b_CAL(t,i_s) + FinalDDnorm(t,i_s,"Final_tot") ;
         FinalDDnorm(t,i_s,fin_demand) = FinalDDnorm(t,i_s,"Final_tot") * CAL_FINALD_BD(t,i_s,fin_demand) ;
         FinalDDnorm(t,i_s,"Final_tot") = sum(Fin_DD, FinalDDnorm(t,i_s,Fin_DD)) + FinalDDnorm(t,i_s,"Final_EX") ;
         FinalDnorm(t,i_s,j_s) = FinalDDnorm(t,i_s,j_s) + FinalDMnorm(t,i_s,j_s) ;
         xp_b_CAL(t,i_s) = xpnorm(t,i_s)+XPN_resin(t,i_s)+XPN_resout(t,i_s) - ( sum(j_s, IOTDNORM(t,i_s,j_s) ) + FinalDDnorm(t,i_s,"final_tot") ) ;
         );
         Display XP_B_CAL ;
);
loop(i_s,
         If(FinalDDnorm(t,i_s,"final_ST") le 0 and abs(xp_b_CAL(t,i_s)) ge abs(FinalDDnorm(t,i_s,"Final_tot")/2) ,

         XP_B_CAL2(t,i_s)$(XP_B_CAL(t,i_s)>0 and FinalDDnorm(t,i_s,"Final_tot")>0) = XP_B_CAL(t,i_s) - (FinalDDnorm(t,i_s,"Final_tot")/2) ;
         XP_B_CAL2(t,i_s)$(XP_B_CAL(t,i_s)>0 and FinalDDnorm(t,i_s,"Final_tot")<0) = XP_B_CAL(t,i_s) + (FinalDDnorm(t,i_s,"Final_tot")/2) ;
         XP_B_CAL2(t,i_s)$(XP_B_CAL(t,i_s)<0 and FinalDDnorm(t,i_s,"Final_tot")>0) = XP_B_CAL(t,i_s) + (FinalDDnorm(t,i_s,"Final_tot")/2) ;
         XP_B_CAL2(t,i_s)$(XP_B_CAL(t,i_s)<0 and FinalDDnorm(t,i_s,"Final_tot")<0) = XP_B_CAL(t,i_s) - (FinalDDnorm(t,i_s,"Final_tot")/2) ;

         FinalDDnorm(t,i_s,"Final_tot")$(XP_B_CAL(t,i_s)>0 and FinalDDnorm(t,i_s,"Final_tot")>0) = FinalDDnorm(t,i_s,"Final_tot") *3/2 ;
         FinalDDnorm(t,i_s,"Final_tot")$(XP_B_CAL(t,i_s)>0 and FinalDDnorm(t,i_s,"Final_tot")<0) = FinalDDnorm(t,i_s,"Final_tot") *1/2 ;
         FinalDDnorm(t,i_s,"Final_tot")$(XP_B_CAL(t,i_s)<0 and FinalDDnorm(t,i_s,"Final_tot")>0) = FinalDDnorm(t,i_s,"Final_tot") *1/2 ;
         FinalDDnorm(t,i_s,"Final_tot")$(XP_B_CAL(t,i_s)<0 and FinalDDnorm(t,i_s,"Final_tot")<0) = FinalDDnorm(t,i_s,"Final_tot") *3/2 ;

         FinalDDnorm(t,i_s,fin_demand) = FinalDDnorm(t,i_s,"Final_tot") * CAL_FINALD_BD(t,i_s,fin_demand) ;
         FinalDDnorm(t,i_s,"Final_tot") = sum(Fin_DD, FinalDDnorm(t,i_s,Fin_DD)) + FinalDDnorm(t,i_s,"Final_EX") ;
         FinalDnorm(t,i_s,j_s) = FinalDDnorm(t,i_s,j_s) + FinalDMnorm(t,i_s,j_s) ;
         XP_B_CAL(t,i_s) = XP_B_CAL2(t,i_s) ;
                 If( abs(xp_b_CAL(t,i_s)) < sum(j_s, EVFA_K0(t,j_s,i_s)/2),
                 EVFA_k0(t,j_s,i_s) = (sum(k_s, EVFA_k0(t,k_s,i_s)) - xp_b_CAL(t,i_s) ) * CAL_EVFA_k0(t,j_s,i_s) ;
                 xpnorm(t,j_s) = sum(k_s, IOTNORM(t,k_s,j_s) + EVFA_k0(t,k_s,j_s) ) ;
                 xp_b_CAL(t,i_s) = xpnorm(t,i_s)+XPN_resin(t,i_s)+XPN_resout(t,i_s) - ( sum(j_s, IOTDNORM(t,i_s,j_s) ) + FinalDDnorm(t,i_s,"final_tot") ) ;
                 else
                 XP_B_CAL3(t,i_s)$(XP_B_CAL(t,i_s)>0) = XP_B_CAL(t,i_s) - SUM(k_s, evfa_k0(t,k_s,i_s)/2) ;
                 XP_B_CAL3(t,i_s)$(XP_B_CAL(t,i_s)<0) = XP_B_CAL(t,i_s) + SUM(k_s, evfa_k0(t,k_s,i_s)/2) ;
                 EVFA_k0(t,j_s,i_s)$(XP_B_CAL(t,i_s)>0) = (sum(k_s, EVFA_k0(t,k_s,i_s))*1/2 ) * CAL_EVFA_k0(t,j_s,i_s) ;
                 EVFA_k0(t,j_s,i_s)$(XP_B_CAL(t,i_s)<0) = (sum(k_s, EVFA_k0(t,k_s,i_s))*3/2 ) * CAL_EVFA_k0(t,j_s,i_s) ;
                 EVFA_K0(t,"PTAX",j_s) = EVFA_K0(t,"PTAX",j_s) - XP_B_CAL3(t,i_s) ;
                 xpnorm(t,j_s) = sum(k_s, IOTNORM(t,k_s,j_s) + EVFA_k0(t,k_s,j_s) ) ;
                 xp_b_CAL(t,i_s) = xpnorm(t,i_s)+XPN_resin(t,i_s)+XPN_resout(t,i_s) - ( sum(j_s, IOTDNORM(t,i_s,j_s) ) + FinalDDnorm(t,i_s,"final_tot") ) ;
                 );
         Display XP_B_CAL ;
         );
);

Display EVFA_K0;

xp_b_CAL(t,i_s) = xpnorm(t,i_s)+XPN_resin(t,i_s)+XPN_resout(t,i_s) - ( sum(j_s, IOTDNORM(t,i_s,j_s) ) + FinalDDnorm(t,i_s,"final_tot") ) ;
If (sum(i_s, abs(xp_b_CAL(t,i_s))) > 1, Abort   "Check the difference between low Sum and Column Sum")  ;


**************************************************************************************
xp_b_CAL(t,i_s) = xpnorm(t,i_s)- xp_b(t,i_s);

FinalD_BD(t,i_s,"final_ST") = xp_b_CAL(t,i_s) + FinalD_BD(t,i_s,"Final_ST") ;

IOT_B(t,i_s,j_s) = IOT_BD(t,i_s,j_s) + IOT_BM(t,i_s,j_s) ;
FinalD_BD(t,i_s,"Final_tot") = sum(Fin_DD, FinalD_BD(t,i_s,Fin_DD)) + FinalD_BD(t,i_s,"Final_EX") ;
FinalD_B(t,i_s,j_s) = FinalD_BD(t,i_s,j_s) + FinalD_BM(t,i_s,j_s) ;

xp_b(t,i_s) = sum(j_s, IOT_BD(t,i_s,j_s)) + FinalD_bD(t,i_s,"final_tot") ;
xp_b_CAL(t,i_s) = xpnorm(t,i_s)- xp_b(t,i_s)+XPB_resin(t,i_s)+XPB_resout(t,i_s) ;
display xp_b_cal;
If (sum(i_s, abs(xp_b_CAL(t,i_s))) > 1, Abort   "Check the difference between OUTPUTS")  ;



**************************************************************************************

         FinalD_BDR(t,i_s,fin_demand) = FinalD_BD(t,i_s,fin_demand) * GDPDF(t) ;
         FinalD_BMR(t,i_s,fin_demand) = FinalD_BM(t,i_s,fin_demand) * GDPDF(t) ;
         FinalD_BR(t,i_s,fin_demand) = FinalD_B(t,i_s,fin_demand) * GDPDF(t) ;
         IOT_BDR(t,i_s,j_s) = IOT_BD(t,i_s,j_s) * GDPDF(t) ;
         IOT_BMR(t,i_s,j_s) = IOT_BM(t,i_s,j_s) * GDPDF(t) ;
         IOT_BR(t,i_s,j_s) = IOT_B(t,i_s,j_s) * GDPDF(t) ;
         XP_BR(t,i_s) = XP_B(t,i_s) * GDPDF(t) ;

         EVFA_k0(t,i_s,j_s) = EVFA_k0(t,i_s,j_s) * GDPDF(t) ;
         NEVFA_k0(t,i_s,j_s)= NEVFA_k0(t,i_s,j_s) * GDPDF(t) ;

         FinalDD(t,i_s,fin_demand) = FinalDDnorm(t,i_s,fin_demand) * GDPDF(t) ;
         FinalDM(t,i_s,fin_demand) = FinalDMnorm(t,i_s,fin_demand) * GDPDF(t) ;
         FinalD(t,i_s,fin_demand) = FinalDnorm(t,i_s,fin_demand) * GDPDF(t) ;
         IOTD(t,i_s,j_s) = IOTDnorm(t,i_s,j_s) * GDPDF(t) ;
         IOTM(t,i_s,j_s) = IOTMnorm(t,i_s,j_s) * GDPDF(t) ;
         IOT(t,i_s,j_s) = IOTnorm(t,i_s,j_s) * GDPDF(t) ;
         XP(t,i_s) = XPnorm(t,i_s) * GDPDF(t) ;
         XPB_resin_R(t,i_s)=XPB_resin(t,i_s)*GDPDF(t);
         XPB_resout_R(t,i_s)=XPB_resout(t,i_s)*GDPDF(t);
         XPN_resin_R(t,i_s)=XPN_resin(t,i_s)*GDPDF(t);
         XPN_resout_R(t,i_s)=XPN_resout(t,i_s)*GDPDF(t);
*display IOTD;

*         EVFA_k0(t,i_s,j_s) = EVFA_k0(t,i_s,j_s) * GDPDF(t) ;
*********


***** 국제선실적 - 여객 매출: 4,591십억원, 화물 매출: 2,432십억원 ( 대한항공 2007 영업보고서 참고 )
* Shipping과 Aviation을 나눌경우,
VST_CHECK1(t,i_s) = FinalD_BR(t,i_s,"final_EX") ;

VST_K_L(t,TRANSPT)=Finald_br(t,TRANSPT,"Final_EX")*2432/(4591+2432)/CR(t) ;
VST_K(t,i0_TR) = sum(TRANSPT$(mapi_TRANS(TRANSPT,i0_TR)), VST_K_L(t,TRANSPT));

Finald_bdr(t,TRANSPT,"Final_Ex") = Finald_bdr(t,TRANSPT,"Final_Ex") * 4591 / (4591+2432);
Finald_bmr(t,TRANSPT,"Final_Ex") = Finald_bmr(t,TRANSPT,"Final_Ex") * 4591 / (4591+2432);
FinalD(t,TRANSPT,"Final_Ex") = FinalD(t,TRANSPT,"Final_Ex") * 4591 / (4591+2432);
Finald_bdr(t,i_s,"Final_tot") = Finald_bdr(t,i_s,"Final_PC") + Finald_bdr(t,i_s,"Final_GC") +  Finald_bdr(t,i_s,"Final_PK") +  Finald_bdr(t,i_s,"Final_GK") +  Finald_bdr(t,i_s,"Final_St") +  Finald_bdr(t,i_s,"Final_EX");
Finald_bmr(t,i_s,"Final_tot") = Finald_bmr(t,i_s,"Final_PC") + Finald_bMr(t,i_s,"Final_GC") +  Finald_bMr(t,i_s,"Final_PK") +  Finald_bMr(t,i_s,"Final_GK") +  Finald_bMr(t,i_s,"Final_St") +  Finald_bMr(t,i_s,"Final_EX");
Finald_br(t,i_s,Fin_demand) = Finald_bdr(t,i_s,Fin_demand) + Finald_bMr(t,i_s,Fin_demand)  ;

FinalDD(t,i_s,"Final_tot") = FinalDD(t,i_s,"Final_PC") + FinalDD(t,i_s,"Final_GC") +  FinalDD(t,i_s,"Final_PK") +  FinalDD(t,i_s,"Final_GK") +  FinalDD(t,i_s,"Final_St") +  FinalDD(t,i_s,"Final_EX");

FinalD(t,i_s,Fin_demand) = FinalDD(t,i_s,Fin_demand) + FinalDM(t,i_s,Fin_demand)  ;

VST_CHECK2(t,i_s) = VST_CHECK1(t,i_s) -  FinalD_BR(t,i_s,"final_ex") - VST_K_L(t,i_s) * cr(t) ;

if (sum(i_s,abs(VST_CHECK2(t,i_s)))> 0.1, Abort   "Check VST_K")  ;

VXMD_K(t,i0) = sum(i_s$(mapi_G(i_s,i0)), Finald_br(t,i_s,"final_Ex") )/ CR(t)        ;

*****************************************************************************************
** In 2010 IO, we don't have tarrif and import tax. We only have production tax on imports. Since global model needs tarrif variable, we need some artificial tarrif
** We might be able to use tarrif rate in 2009 converted in 2010 industries. But mapping from 2009 to 2010 is not perfect. (Something to think of)
** Instead we use min_j (MN_ij-MB_ij)/MB_ij for our atrifical tarrif. MN is Import IO table in producers' price. MB is Import IO table in basic price.
** We assume that tarrif rate should be equal for all industries using same good. So the row minimum should be a close proxy.
** Once we get the tarrif rate, then TaxM=TaxMT-tarrif rate*TaxMT should be the import tax on productions.

** TaxMT=Tariff + Import Tax
TaxMT(t,i_s,j_s)=IOTm(t,i_s,j_s) - IOT_bmR(t,i_s,j_s);
R_Tax_MT(t,i_s,j_s)$(IOT_bmR(t,i_s,j_s)<>0)=TaxMT(t,i_s,j_s)/IOT_bmR(t,i_s,j_s);
R_Tar_K00(t,i_s)=smin(j_s$(IOT_bmR(t,i_s,j_s)<>0),R_Tax_MT(t,i_s,j_s));
* 업종별 Tariff rate 산출
*R_Tar_K00(t,i_s)$( sum(j_s, IOTMnorm(t,i_s,j_s)) + FinalDMnorm(t,i_s,"final_tot") ) = Tar0(t,i_s) / ( sum(j_s, IOTMnorm(t,i_s,j_s)) + FinalDMnorm(t,i_s,"final_tot") ) ;
* 실질최종수요(수입)에 대한 관세 계산
TarPR_K00(t,i_s,fin_demand) = FinalD_bmR(t,i_s,fin_demand) * R_Tar_K00(t,i_s) ;
TarPR_K00(t,i_s,"final_tot") = sum(Fin_DD, TarPR_K00(t,i_s,Fin_DD)) + sum(Fin_DX, TarPR_K00(t,i_s,Fin_DX) );
*실질중간수요(수입)에 대한 관세 계산
TARR_k00(t,i_s,j_s) = IOT_BMR(t,i_s,j_s) * R_Tar_K00(t,i_s)  ;
* 업종별 tariff rate 재산출
R_Tar_K0(t,i_s)$( sum(j_s, IOT_bmR(t,i_s,j_s)) + Finald_bmr(t,i_s,"final_tot") ) = (sum(j_s, TARR_k00(t,i_s,j_s)) + TarPR_K00(t,i_s,"final_tot")) / ( sum(j_s, IOT_bmR(t,i_s,j_s)) + Finald_bmr(t,i_s,"final_tot") ) ;

CheckX(t,i_s) = R_Tar_K0(t,i_s) - R_Tar_K00(t,i_s);
*if ((sum(i_s, CheckX(t,i_s))) > 0.001, Abort   "Check the Tax Rate")  ;

* 실질중간수요(수입)에 대한 관세 계산
Tar(t,i_s,j_s) = R_Tar_K0(t,i_s) * IOT_bmR(t,i_s,j_s) ;
* 실질수입경상표 - 실질수입기초표 - 관세 = 수입세
TaxM(t,i_s,j_s) = IOTm(t,i_s,j_s) - IOT_bmR(t,i_s,j_s) - Tar(t,i_s,j_s) ;
* 관세율 * 실질수입최종수요 = 최종수요수입에 따른 관세
TarF(t,i_s,Fin_demand) = R_Tar_K0(t,i_s) * Finald_bmr(t,i_s,Fin_Demand) ;

Check_Tariff(t,i_s,j_s) = Tar(t,i_s,j_s) + TaxM(t,i_s,j_s) -  IOTm(t,i_s,j_s) + IOT_bmR(t,i_s,j_s)  ;

TaxD(t,i_s,j_s) = IOTd(t,i_s,j_s) - IOT_bdR(t,i_s,j_s)  ;

IFTAX_K(t,i0,j0) = sum(j_s$(mapi_G(j_s,j0)),  sum(i_s$(mapi_G(i_s,i0)),  TaxM(t,i_s,j_s))) / CR(t) ;
DFTAX_K(t,i0,j0) = sum(j_s$(mapi_G(j_s,j0)),  sum(i_s$(mapi_G(i_s,i0)),  TaxD(t,i_s,j_s))) / CR(t) ;
*DFTAX_K(t,i0,j0) = sum(j_sec$(mapi_G(j_sec,j0)), sum(i_sec$(mapi_G(i_sec,i0)), (IOTd(t,i_sec,j_sec) - IOT_bdR(t,i_sec,j_sec)))) / CR(t) ;
TFRV_K(t,i0,j0) = sum(j_s$(mapi_G(j_s,j0)),  sum(i_s$(mapi_G(i_s,i0)),  Tar(t,i_s,j_s))) / CR(t) ;



***** PTAX는 기타생산세 + subsidy
PTAX_K(t,i0) = sum(i_s$(mapi_G(i_s,i0)),  EVFA_K0(t,"PTAX",i_s)) /cr(t) ;
*PTAX_K_N(t,i0) = sum(i_s$(mapi_G(i_s,i0)),  NEVFA_K0(t,"PTAX",i_s)) /cr(t) ;

* BOK IO에서 수출세는 0
VXWD_K(t,i0) = VXMD_K(t,i0)    ;

VIWS_K(t,i0) = sum(i_s$(mapi_G(i_s,i0)), (sum(j_s, IOT_bmR(t,i_s,j_s)) + Finald_bmr(t,i_s,"Final_PC") + Finald_bmr(t,i_s,"Final_GC")  ))  / CR(t) ;
VIMS_K(t,i0) = sum(i_s$(mapi_G(i_s,i0)), (sum(j_s, (IOT_bmR(t,i_s,j_s) + Tar(t,i_s,j_s))) + Finald_bmr(t,i_s,"Final_PC") + Finald_bmr(t,i_s,"Final_GC")  ))  / CR(t) ;

VDPM_K(t,i0) = sum(i_s$(mapi_G(i_s,i0)), Finald_bdr(t,i_s,"Final_pc")) / CR(t)        ;
VDGM_K(t,i0) = sum(i_s$(mapi_G(i_s,i0)), Finald_bdr(t,i_s,"Final_Gc")) / CR(t)        ;
VDPA_K(t,i0) = sum(i_s$(mapi_G(i_s,i0)), Finaldd(t,i_s,"Final_pc")) / CR(t)        ;
VDGA_K(t,i0) = sum(i_s$(mapi_G(i_s,i0)), Finaldd(t,i_s,"Final_Gc")) / CR(t)        ;

VIPM_K(t,i0) = sum(i_s$(mapi_G(i_s,i0)), (Finald_bmr(t,i_s,"final_pc") + TarF(t,i_s,"Final_PC") )) / CR(t)        ;
VIGM_K(t,i0) = sum(i_s$(mapi_G(i_s,i0)), (Finald_bmr(t,i_s,"final_Gc") + TarF(t,i_s,"Final_GC") )) / CR(t)        ;
VIPA_K(t,i0) = sum(i_s$(mapi_G(i_s,i0)), Finaldm(t,i_s,"Final_pc"))  / CR(t)        ;
VIGA_K(t,i0) = sum(i_s$(mapi_G(i_s,i0)), Finaldm(t,i_s,"Final_Gc"))  / CR(t)        ;

INVD_K(t,i0) = sum(i_s$(mapi_G(i_s,i0)), ( Finald_bdr(t,i_s,"Final_PK") + Finald_bdr(t,i_s,"Final_GK") + Finald_bdr(t,i_s,"Final_St") )) / CR(t) ;
INVI_K(t,i0) = sum(i_s$(mapi_G(i_s,i0)), ( Finald_bmr(t,i_s,"Final_PK") + Finald_bmr(t,i_s,"Final_GK") + Finald_bmr(t,i_s,"Final_St"))) / CR(t) ;
SCDK_K(t,i0) = 0 ;
SCIK_K(t,i0) = 0 ;

DPTAX_K(t,i0) = VDPA_K(t,i0) - VDPM_K(t,i0);
R_DPTAX_K0(t,i0)$(VDPM_K(t,i0)) = DPTAX_K(t,i0) / VDPM_K(t,i0);
IPTAX_K(t,i0) = VIPA_K(t,i0) - VIPM_K(t,i0) ;
R_IPTAX_K0(t,i0)$(VIPM_K(t,i0)) = IPTAX_K(t,i0) / VIPM_K(t,i0);

DGTAX_K(t,i0) = VDGA_K(t,i0) - VDGM_K(t,i0);
R_DGTAX_K0(t,i0)$(VDGM_K(t,i0)) = DGTAX_K(t,i0) / VDGM_K(t,i0);
IGTAX_K(t,i0) = VIGA_K(t,i0) - VIGM_K(t,i0) ;
R_IGTAX_K0(t,i0)$(VIGM_K(t,i0)) = IGTAX_K(t,i0) / VIGM_K(t,i0);

DITAX_K(t,i0) = sum(i_s$(mapi_G(i_s,i0)), ( Finaldd(t,i_s,"Final_PK") + Finaldd(t,i_s,"Final_GK") + Finaldd(t,i_s,"Final_ST") )) / CR(t)  - INVD_K(t,i0) ;
IITAX_K(t,i0) = sum(i_s$(mapi_G(i_s,i0)), ( Finaldm(t,i_s,"Final_PK") + Finaldm(t,i_s,"Final_GK") + Finaldm(t,i_s,"Final_ST"))) / CR(t)  - INVI_K(t,i0) ;

DSTAX_K(t,i0) = 0 ;
ISTAX_K(t,i0) = 0 ;

* VDPM + VDGM + VDFM + VXMD + VTWR + INVD + SCDK= VOM (국내 총산출)

VIFM_K(t,i0,j0) = sum(j_s$(mapi_G(j_s,j0)),  sum(i_s$(mapi_G(i_s,i0)), (IOT_bmR(t,i_s,j_s) + Tar(t,i_s,j_s)))) / CR(t)   ;
*VIFM_K(t,i0,"CGDS") = sum(i_sec$(mapi_G(i_sec,i0)), (Finald_bmr(t,i_sec,"Final_Pk") + TarF(t,i_sec,"Final_PK") + Finald_bmr(t,i_sec,"Final_Gk") + TarF(t,i_sec,"Final_GK")) ) / CR(t)   ;
VDFM_K(t,i0,j0) = sum(j_s$(mapi_G(j_s,j0)),  sum(i_s$(mapi_G(i_s,i0)), (IOT_bdR(t,i_s,j_s)))) / CR(t)   ;
*VDFM_K(t,i0,"CGDS") = sum(i_sec$(mapi_G(i_sec,i0)), (Finald_bdr(t,i_sec,"Final_Pk") + Finald_bdr(t,i_sec,"Final_Gk") ) ) / CR(t)   ;

VIFA_K(t,i0,j0) = VIFM_K(t,i0,j0) + IFTAX_K(t,i0,j0) ;
VDFA_K(t,i0,j0) = VDFM_K(t,i0,j0) + DFTAX_K(t,i0,j0) ;


R_Tar_k(t,i0)$(sum(j0, VIFM_K(t,i0,j0)) + VIPM_K(t,i0) + VIGM_K(t,i0) + INVI_K(t,i0) + SCIK_K(t,i0) )
          = sum(i_s$(mapi_G(i_s,i0)), (sum(j_s, TARR_k00(t,i_s,j_s)) + tarpR_k00(t,i_s,"final_tot"))) / (sum(j0, VIFM_K(t,i0,j0)) + VIPM_K(t,i0) + VIGM_K(t,i0) + INVI_K(t,i0) + SCIK_K(t,i0) ) / cr(t) ;

VVII(t,i0) = sum(i_s$(mapi_G(i_s,i0)), sum(j_s, IOT_bmR(t,i_s,j_s) + Tar(t,i_s,j_s))) - (sum(j0, VIFm_K(t,i0,j0))*cr(t));
VVID(t,i0) = sum(i_s$(mapi_G(i_s,i0)), sum(j_s, IOT_bdR(t,i_s,j_s))) - (sum(j0, VDFM_K(t,i0,j0))*cr(t));

R_DFTAX_K0(t,i0,j0)$(VDFM_K(t,i0,j0)) = DFTAX_K(t,i0,j0) / VDFM_K(t,i0,j0) ;
R_IFTAX_K0(t,i0,j0)$(VIFM_K(t,i0,j0)) = IFTAX_K(t,i0,j0) / VIFM_K(t,i0,j0) ;

EVFA_K(t,fact,i0) = sum(i_s$(mapi_G(i_s,i0)), EVFA_K0(t,fact,i_s)) / CR(t) ;
VFM_K(t,ENDW,i0) = EVFA_K(t,endw,i0) ;
*NEVFA_K(t,fact,i0) = sum(i_s$(mapi_G(i_s,i0)), NEVFA_K0(t,fact,i_s)) / CR(t) ;
*NVFM_K(t,ENDW,i0) = NEVFA_K(t,endw,i0) ;


*VOA_K(t,i0) = sum(j0, ( VDFM_K(t,j0,i0) + VIFM_K(t,j0,i0)) I + sum(fact, VFM_K(t,fact,i0)) ;
VOA_K(t,i0) = sum(j0, ( VDFA_K(t,j0,i0) + VIFA_K(t,j0,i0)) ) + sum(fact, VFM_K(t,fact,i0)) ;
VOM_K(t,i0) = VOA_K(t,i0) + PTAX_K(t,i0) ;
* Ptax rate =basic price ptax/producers price column sum + factor sum (excluding PTAX)
R_PTAX_K0(t,i0)$(VOA_K(t,i0)) = PTAX_K(t,i0) / VOA_K(t,i0) ;
* NPtax rate = producers' price ptax/producers' price column sum +factor sum (excluding NPTAX)
*R_PTAX_K_N_0(t,i0)$(VOA_K(t,i0)) = PTAX_K_N(t,i0) / VOA_K(t,i0) ;

****************************GTAP_K IO 작성 체크
display IOTD;
Check1(t,i0,j0) = VIFA_K(t,i0,j0) -  sum(j_s$(mapi_G(j_s,j0)), sum(i_s$(mapi_G(i_s,i0)), ( IOTm(t,i_s,j_s) )))/cr(t) ;
Check2(t,i0,j0)= VDFA_K(t,i0,j0) -sum(j_s$(mapi_G(j_s,j0)),  sum(i_s$(mapi_G(i_s,i0)), ( IOTd(t,i_s,j_s) )))/cr(t) ;
Check5(t,i0) = VOM_K(t,i0) +sum(i_s$(mapi_G(i_s,i0)),XPN_resin_r(t,i_s))/CR(t)+sum(i_s$(mapi_G(i_s,i0)),XPN_resout_r(t,i_s))/CR(t)- sum(i_s$(mapi_G(i_s,i0)), ( sum(j_s, IOTD(t,i_s,j_s)) + FinalDD(t,i_s,"final_tot"))) /CR(t) ;
Check6(t,i0) = VOM_K(t,i0) - sum(i_s$(mapi_G(i_s,i0)), ( sum(j_s, IOT(t,i_s,j_s)) + sum(fact, EVFA_K0(t,fact,i_s))))/CR(t) - PTAX_K(t,i0)     ;

*수요(구매)측면에서의 총산출과 부가가치 측면에서의 총투입이 일치되는지 확인.

VAL_dgc(t) = sum(i0,vdgm_k(t,i0)) * cr(t) ;
VAL_dpc(t) = sum(i0,vdpm_k(t,i0)) * cr(t) ;
VAL_dinv(t) = sum(i0,invd_k(t,i0)) * cr(t) ;
VAL_dsc(t) = sum(i0, scdk_k(t,i0)) * cr(t) ;
VAL_x(t) = sum(i0,(vxmd_k(t,i0) + vst_k(t,i0))) * cr(t) ;
VAL_dfc(t) = (sum(i0, sum(j0, vdfm_K(t,i0,j0)) ) )* cr(t) ;
Val_vom(t) = (sum(i0, vom_K(t,i0)) ) * cr(t) ;
CHECK3(t,i0) = VAL_vom(t)+sum(i_s,XPB_resin_r(t,i_s))+sum(i_s,XPB_resout_r(t,i_s)) - VAL_dfc(t) - VAL_x(t) - VAL_dinv(t) - VAL_dsc(t) - val_dpc(t) - val_dgc(t) ;
check30(t)=sum(i0,check3(t,i0));
display check30;
check_VOA(t) = sum(i0, VOA_K(t,i0)) * cr(t) ;
check_PTAX(t) = sum(i0, PTAX_K(t,i0)) * cr(t)  ;
check_VOM(t) = VAL_vom(t) / cr(t)               ;
check_FinD(t) =  (VAL_x(t) + VAL_dinv(t) + val_dpc(t) + val_dgc(t) +  VAL_dsc(t) )  ;
check_IOTd(t) = VAL_dfc(t) ;
check_VDFA(t) = sum(i0, sum(j0, ( VDFA_K(t,j0,i0) ) ) ) * cr(t);
check_VIFA(t) = sum(i0, sum(j0, ( VIFA_K(t,j0,i0)) ) )* cr(t);
check_VFM(t) = sum(i0, sum(fact, VFM_K(t,fact,i0))) * cr(t);

if (sum(j0, sum(i0, Check1(t,i0,j0))) > 1, Abort   "Check the VIFA_K or IFTAX_K")  ;
if (sum(j0, sum(i0, Check2(t,i0,j0))) > 1, Abort   "Check the VDFA_K or DFTAX_K")  ;
if (sum(i0, abs(Check3(t,i0))) > 1, Abort   "Check the VOM_K")  ;

);

********************** 최종수요 조정 (0이하의 최종수요(민간소비, 투자) 재조정)


* 0보다 작은 민간소비와 투자(재고증감 제외)합산.
CALVDPM_K(t,i0)$(VDPM_K(t,i0)<=0) = VDPM_K(t,i0) ;
CALINVD_K(t,i0)$(INVD_K(t,i0)<=0) = INVD_K(t,i0) ;
CALINVI_K(t,i0)$(INVI_K(t,i0)<=0) = INVI_K(t,i0) ;
* 기존 수요액에서 이를 제외 (음수인 숫자를 0으로 만듦)
VDPM_K(t,i0)$(CALVDPM_K(t,i0)) = VDPM_K(t,i0) - CALVDPM_K(t,i0) ;
INVD_K(t,i0)$(CALINVD_K(t,i0)) = INVD_K(t,i0) - CALINVD_K(t,i0) ;
INVI_K(t,i0)$(CALINVI_K(t,i0)) = INVI_K(t,i0) - CALINVI_K(t,i0) ;

* 부가가치액조정, 부가가치별 비중 계산
CALVA_K(t,i0) = sum(endw, EVFA_K(t,ENDW,i0));
loop(endw, R_EVFA_K(t,ENDW,i0)$(CALVA_K(t,i0)) = EVFA_K(t,ENDW,i0) / CALVA_K(t,i0));
* 부가가치액 상승액 계산(수입산에 대한 투자는 제외하고, 국산에 대한 투자만 포함. 이는 국산에 대한 투자만이 산출액 및 부가가치에 영향을 미치기 떄문)
CALVA_K(t,i0) = CALVA_K(t,i0) - CALINVD_K(t,i0) - CALVDPM_K(t,i0) ;
* 부가가치액 증가분 부가가치별로 배분
loop(endw, EVFA_K(t,ENDW,i0) = CALVA_K(t,i0) * R_EVFA_K(t,ENDW,i0)) ;
* VOA_K 다시계산 (최종수요 상승분?매?상승)
*VOA_K(t,i0) = sum(j0, ( VDFM_K(t,j0,i0) + VIFM_K(t,j0,i0)) ) + sum(fact, EVFA_K(t,fact,i0)) ;
VOA_K(t,i0) = sum(j0, ( VDFA_K(t,j0,i0) + VIFA_K(t,j0,i0)) ) + sum(fact, EVFA_K(t,fact,i0)) ;
* VOM_K(산출액) 다시계산
VOM_K(t,i0) = VOA_K(t,i0) + PTAX_K(t,i0) ;


*수요(구매)측면에서의 총산출과 부가가치 측면에서의 총투입이 일치되는지 확인.

VAL_dgc(t) = sum(i0,vdgm_k(t,i0)) * cr(t) ;
VAL_dpc(t) = sum(i0,vdpm_k(t,i0)) * cr(t) ;
VAL_dinv(t) = sum(i0,invd_k(t,i0)) * cr(t) ;
VAL_x(t) = sum(i0,(vxmd_k(t,i0) + vst_k(t,i0))) * cr(t) ;
VAL_dfc(t) = (sum(i0, sum(j0, vdfm_K(t,i0,j0))))* cr(t) ;
Val_vom(t) = (sum(i0, vom_K(t,i0)) ) * cr(t) ;
CHECK3(t,i0) = VAL_vom(t) +sum(i_s,XPB_resin_r(t,i_s))+sum(i_s,XPB_resout_r(t,i_s))- VAL_dfc(t) - VAL_x(t) - VAL_dinv(t) - VAL_dsc(t) - val_dpc(t) - val_dgc(t)  ;
check3_1(t)=sum(i0,check3(t,i0));
display check3,check3_1;
if ((sum(t, sum(i0, Check3(t,i0)))) > 1 , Abort   "Check the VOM_K"  ;
elseif ( sum(t, sum(i0, Check3(t,i0)))) <-1 , Abort   "Check the VOM_K" ;
);


* 음수 조정 check

;
CHECK4(t,i0) =
sum(j0, VDFM_K(t,i0,j0)$(VDFM_K(t,i0,j0)<=0))
+ sum(j0, VIFM_K(t,i0,j0)$(VIFM_K(t,i0,j0)<=0))
+ INVD_K(t,i0)$(INVD_K(t,i0)<=0)
+ INVI_K(t,i0)$(INVI_K(t,i0)<=0)
+ sum(endw, VFM_K(t,ENDW,i0)$(VFM_K(t,ENDW,i0)<= 0))
;
if ( sum(t, sum(i0, Check4(t,i0))) <-0.00001 , Abort   "negative value" );


***** Agent price 및 산출액 재 계산 *****
VFM_K(t,ENDW,i0) = EVFA_K(t,endw,i0) ;
VDPA_K(t,i0) = VDPM_K(t,i0) + DPTAX_K(t,i0);
VIPA_K(t,i0) = VIPM_K(t,i0) + IPTAX_K(t,i0);
VDGA_K(t,i0) = VDGM_K(t,i0) + DGTAX_K(t,i0);
VIGA_K(t,i0) = VIGM_K(t,i0) + IGTAX_K(t,i0);

* VOA_K 다시계산 (최종수요 상승분만큼 상승)
*VOA_K(t,i0) = sum(j0, ( VDFM_K(t,j0,i0) + VIFM_K(t,j0,i0)) ) + sum(fact, EVFA_K(t,fact,i0)) ;
VOA_K(t,i0) = sum(j0, ( VDFA_K(t,j0,i0) + VIFA_K(t,j0,i0)) ) + sum(fact, EVFA_K(t,fact,i0)) ;
* VOM_K(산출액) 다시계산
VOM_K(t,i0) = VOA_K(t,i0) + PTAX_K(t,i0) ;

*수요(구매)측면에서의 총산출과 부가가치 측면에서의 총투입이 일치되는지 확인.
VAL_dgc(t) = sum(i0,vdgm_k(t,i0)) * cr(t) ;
VAL_dpc(t) = sum(i0,vdpm_k(t,i0)) * cr(t) ;
VAL_dinv(t) = sum(i0,invd_k(t,i0)) * cr(t) ;
VAL_x(t) = sum(i0,(vxmd_k(t,i0) + vst_k(t,i0))) * cr(t) ;
VAL_dfc(t) = (sum(i0, sum(j0, vdfm_K(t,i0,j0))))* cr(t) ;
Val_vom(t) = (sum(i0, vom_K(t,i0)) ) * cr(t) ;
CHECK3(t,i0) = VAL_vom(t)+sum(i_s,XPB_resin_r(t,i_s))+sum(i_s,XPB_resout_r(t,i_s)) - VAL_dfc(t) - VAL_x(t) - VAL_dinv(t) - VAL_dsc(t) - val_dpc(t) - val_dgc(t) ;
check3_2(t)=sum(i0,check3(t,i0));
display check3_2;

if (sum(t, sum(i0, Check3(t,i0))) > 1 , Abort   "Check the VOM_K"  ;
elseif (sum(t,  sum(i0, Check3(t,i0)))) <-1 , Abort   "Check the VOM_K" ;
);



*for KEI_LINKAGE MODEL

prdtax(t,i) = ptax_K(t,i) ;
VFM_K00(t,"Capital",i) = VFM_K(t,"surplus",i) + VFM_K(t,"DEP",i) ;
VFM_K00(t,"LAB",i) = VFM_K(t,"labor",i) ;
Dep_K(t,i) = EVFA_K(t,"dep",i);
loop(i,
xmtpmtT(i,t) = VIWS_K(t,i) ;
tarifKT(i,t) = R_TAR_K(t,i) ;
esppeT(i,t) = VXMD_K(t,i) ;
);




