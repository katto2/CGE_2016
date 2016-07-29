set tnew(t) /2010/;
set told(t) /2009/;
parameter con_totB(t,i_sec0);
*총수요가 아닌 중간수요와 가계소비의 합.
con_totB(t,i_sec0) = sum(j_sec0, iot_b0(t,i_sec0,j_sec0)) + FinalD0_b(t,i_sec0,"Final_PC")    ;

parameter Fac_Conv(energy) Conversion Factor from HHV to LHV /
E111     0.989
E112     0.977
E121     0.964
E122     0.96
E211     0.925
E212     0.932
E213     0.934
E214     0.941
E215     0.943
E216     0.944
E217     0.937
E218     0.937
E219     0.937
E221     0.917
E222     0.92
E231     0.925
E232     0.000
E233     0.000
E234     0.935
E235     0.000
E236     0.969
E237     0.93953
E3     0.904
E4     0.905
E5     1
E6     1
E7     1
E8     1
E9     1
/;

***** 저위발열량 기준 (LLH) conversion
set energy0(energy) Aggregation of petroleum for Energy Use /
E211     "Gasoline,휘발유"
E212     "Kerosene,등유"
E213     "Diesel,경유"
E214     "B-A,경질중유"
E215     "B-B,중유"
E216     "B-C,중질중유"
E217     "JA-1,JA-1"
E218     "JP-4,JP-4"
E219     "AVI-G,AVI-G"
/;

set energy1(energy) Aggregation of petroleum for Non-Energy Use /
E231     "Naphtha,나프타"
E232     "Solvent,용제"
E233     "Asphalt,아스팔트"
E234     "Lubricant,윤활기유"
E235     "Paraffin-Wax,파라핀왁스"
E236     "Petroleum Coke,석유코크"
E237     "Other Products,기타제품"
/;

** Inverting the value into the low calorific value (저위발열량으로 변환)
Parameters
EBS_LLH(t,Energy_d,Energy) 저위발열량 기준 Energy Balance sheet
EBS_LLH0(t,Energy_d,Energy) 초기 EBS
;

if(GTAPBASE,
         EBS_LLH(t,Energy_d,Energy) = EBS(t,Energy_d,Energy) ;
         EBS_LLH(t,Energy_d,Energy) = EBS(t,Energy_d,Energy) * Fac_Conv(energy) ;

         EBS_LLH0(t,Energy_d,Energy) = EBS_LLH(t,Energy_d,Energy) ;
         EBS_LLH(t,Energy_d,"E21") = sum(energy0,EBS_LLH(t,Energy_d,energy0))   ;
         EBS_LLH(t,Energy_d,"E22") = EBS_LLH(t,Energy_d,"E221") + EBS_LLH(t,Energy_d,"E222")       ;
         EBS_LLH(t,Energy_d,"E23") = sum(energy1,EBS_LLH(t,Energy_d,energy1))   ;
         EBS_LLH0(t,Energy_d,"E2") = EBS_LLH(t,Energy_d,"E21") + EBS_LLH(t,Energy_d,"E22") + EBS_LLH(t,Energy_d,"E23")          ;

***** GTAP구조에 따라 VST (국제운송서비스)부분은 국내 EBS에서 제외해야함. 한국IO에서도 Export 에서 국제운송서비스부분은 VST로 따로 떼어 냈음.
***** 한국 EBS의 국제벙커링은 국산이 아닌 해외 국적의 선박 혹은 항공인 경우임. 그렇기 때문에 한국 국적의 국제운송서비스 부분을 추가로 떼어내야 함.
***** 가정은 해외국적의 선박 혹은 항공은 모두 국제운송서비스라 보았음.(한국 EBS에서 해외국적의 항공 부분의 벙커링만 따로 볼 수 없기 때문에)
***** 또한 한국 국적의 수상운수는 모두 국제 운송서비스로 보았으며, 항공운수는 일정 비율만 국제 운송서비스인 것으로 보았음.
***** 그렇기 때문에 VST의 과대평가 혹은 한국 배출량의 과소평과가 이뤄질 수 있음.

* (한국 선박) 국제 외항 운송에 따른 에너지 소비량 차감.
* 일단 수상운수에서 소비된 모든 에너지는 해외운송이라 보았으나 추후 일정비율만 넣을 필요가 있음.
         loop(energy, EBS_LLH(t,"ED323",Energy) = 0 );
* (한국 항공사) 국제 항공 운송에 따른 에너지 소비량 차감.
* 항공운수는 전체 운송 매출액 대비 국제운송 비율만큼 제외. (2431664/8483270, 대한항공 2007 영업보고서 참조)
         loop(energy, EBS_LLH(t,"ED324",Energy) = EBS_LLH(t,"ED324",Energy) * (8483270-2431664)/8483270 ) ;

         EBS_LLH(t,"ED32",Energy) = EBS_LLH(t,"ED321",Energy) + EBS_LLH(t,"ED322",Energy) + EBS_LLH(t,"ED323",Energy) + EBS_LLH(t,"ED324",Energy);
         EBS_LLH(t,"ED3",Energy) = EBS_LLH(t,"ED31",Energy) + EBS_LLH(t,"ED32",Energy) + EBS_LLH(t,"ED33",Energy) + EBS_LLH(t,"ED34",Energy) + EBS_LLH(t,"ED35",Energy) ;
         EBS_LLH(t,"ED1",Energy) = EBS_LLH(t,"ED3",Energy) - EBS_LLH(t,"ED2",Energy) ;
);
if(not GTAPBASE,
         EBS_LLH(t,Energy_d,Energy) = EBS(t,Energy_d,Energy) ;
         EBS_LLH(t,Energy_d,Energy) = EBS(t,Energy_d,Energy) * Fac_Conv(energy) ;
);

* Aggregation (합계)
EBS_LLH(t,Energy_d,"E11") = EBS_LLH(t,Energy_d,"E111") + EBS_LLH(t,Energy_d,"E112")       ;
EBS_LLH(t,Energy_d,"E12") = EBS_LLH(t,Energy_d,"E121") + EBS_LLH(t,Energy_d,"E122")       ;
EBS_LLH(t,Energy_d,"E1") = EBS_LLH(t,Energy_d,"E11") + EBS_LLH(t,Energy_d,"E12")          ;
EBS_LLH(t,Energy_d,"E21") = sum(energy0,EBS_LLH(t,Energy_d,energy0))   ;
EBS_LLH(t,Energy_d,"E22") = EBS_LLH(t,Energy_d,"E221") + EBS_LLH(t,Energy_d,"E222")       ;
EBS_LLH(t,Energy_d,"E23") = sum(energy1,EBS_LLH(t,Energy_d,energy1))   ;
EBS_LLH(t,Energy_d,"E2") = EBS_LLH(t,Energy_d,"E21") + EBS_LLH(t,Energy_d,"E22") + EBS_LLH(t,Energy_d,"E23")          ;
EBS_LLH(t,Energy_d,"E10") = EBS_LLH(t,Energy_d,"E1") + EBS_LLH(t,Energy_d,"E2") + EBS_LLH(t,Energy_d,"E3") + EBS_LLH(t,Energy_d,"E4") + EBS_LLH(t,Energy_d,"E5") + EBS_LLH(t,Energy_d,"E6") + EBS_LLH(t,Energy_d,"E7") + EBS_LLH(t,Energy_d,"E8") + EBS_LLH(t,Energy_d,"E9")   ;


***** EB energy sector into IO energy sector  (산업연관표상의 에너지-전력포함 21개 섹터-별로 할당)
parameter Con_ene(t,i_ene) Energy Consumption for sector J ;
Con_ene(t,"0026")   =   EBS_LLH(t,"ED1","E11")     ;
Con_ene(t,"0027")   =   EBS_LLH(t,"ED1","E12")     ;
Con_ene(t,"0029")   =   EBS_LLH(t,"ED1","E3")     ;
Con_ene(t,"0100")   =   EBS_LLH(t,"ED33","E11")    ;
Con_ene(t,"0101")   =   EBS_LLH(t,"ED1","E231")     ;
Con_ene(t,"0102")   =   EBS_LLH(t,"ED1","E211")     ;
Con_ene(t,"0103")   =   EBS_LLH(t,"ED1","E217")     ;
Con_ene(t,"0104")   =   EBS_LLH(t,"ED1","E212")     ;
Con_ene(t,"0105")   =   EBS_LLH(t,"ED1","E213")     ;
Con_ene(t,"0106")   =   EBS_LLH(t,"ED1","E214")  +  EBS_LLH(t,"ED1","E215")  +  EBS_LLH(t,"ED1","E216")     ;
Con_ene(t,"0107")   =   EBS_LLH(t,"ED1","E22")     ;
Con_ene(t,"0108")   =   EBS_LLH(t,"ED1","E234")*  447/770     ;
Con_ene(t,"0109")   =   EBS_LLH(t,"ED1","E234")*  323/770     ;
Con_ene(t,"0110")   =   EBS_LLH(t,"ED1","E236")  +  EBS_LLH(t,"ED1","E237")     ;
Con_ene(t,"0274")   =   EBS_LLH(t,"ED1","E5")  *  860  /  2150     ;
Con_ene(t,"0276")   =   EBS_LLH(t,"ED1","E6")  *  860  /  2150    ;
Con_ene(t,"0279")   =   EBS_LLH(t,"ED1","E3")       ;
Con_ene(t,"0280")   =   EBS_LLH(t,"ED3","E8") - EBS_LLH(t,"ED13","E8") - EBS_LLH(t,"ED14","E8") - EBS_LLH(t,"ED15","E8")  -   EBS_LLH(t,"ED21","E8")$(EBS_LLH(t,"ED21","E8") le 0)  -   EBS_LLH(t,"ED22","E8")$(EBS_LLH(t,"ED22","E8") le 0)  -   EBS_LLH(t,"ED23","E8")$(EBS_LLH(t,"ED23","E8") le 0)  -   EBS_LLH(t,"ED24","E8")$(EBS_LLH(t,"ED24","E8") le 0)     ;


*Coke and other coal product
Con_ene(t,"0099")$(not told(t))   = ( EBS_LLH(t,"ED1","E12") + EBS_LLH(t,"ED21","E12") ) * IOT_b0(t,"0027","0099") / ( con_totB(t,"0027") - IOt_b0(t,"0027","0275")   )       ;

*For Fire power generation and Other generation,
Con_ene(t,"0275")$(not told(t))   =  Con_totb(t,"0275")/(Con_totB(t,"0275") + Con_totB(t,"0277")) * ( EBS_LLH(t,"ED3","E7")  -  EBS_LLH(t,"ED13","E7")  -   EBS_LLH(t,"ED14","E7")  -  EBS_LLH(t,"ED15","E7")  -  EBS_LLH(t,"ED21","E7")$(EBS_LLH(t,"ED21","E7") le 0)  -   EBS_LLH(t,"ED22","E7")$(EBS_LLH(t,"ED22","E7") le 0)  -  EBS_LLH(t,"ED23","E7")$(EBS_LLH(t,"ED23","E7") le 0)  -  EBS_LLH(t,"ED24","E7")$(EBS_LLH(t,"ED24","E7") le 0) + EBS_LLH(t,"ED21","E9")$(EBS_LLH(t,"ED21","E9") le 0) -  Con_ene(t,"0274")  -  Con_ene(t,"0276")  )   ;
Con_ene(t,"0277")$(not told(t))   =  Con_totB(t,"0277")/(Con_totB(t,"0275") + Con_totB(t,"0277")) * ( EBS_LLH(t,"ED3","E7")  -  EBS_LLH(t,"ED13","E7")  -   EBS_LLH(t,"ED14","E7")  -  EBS_LLH(t,"ED15","E7")  -  EBS_LLH(t,"ED21","E7")$(EBS_LLH(t,"ED21","E7") le 0)  -   EBS_LLH(t,"ED22","E7")$(EBS_LLH(t,"ED22","E7") le 0)  -  EBS_LLH(t,"ED23","E7")$(EBS_LLH(t,"ED23","E7") le 0)  -  EBS_LLH(t,"ED24","E7")$(EBS_LLH(t,"ED24","E7") le 0) + EBS_LLH(t,"ED21","E9")$(EBS_LLH(t,"ED21","E9") le 0) -  Con_ene(t,"0274")  -  Con_ene(t,"0276")  )   ;
*Renewable energy
Con_ene(t,"0278")$(not told(t))   =  EBS_LLH(t,"ED1","E9")     ;


display con_totB,EBS_LLH,Con_ene;
