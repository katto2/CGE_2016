*****Define the distributed values from the IO table
parameter Dist(t,i_ene) Distributed value of the energy sectors;
Dist(t,i_ene) = Con_totb(t,i_ene)   ;

*using fixed value for 5 energy sectors
*Dist("2009","0026")= 0;
*Dist("2009","0027")= 0;

Dist(t,"0026")$(not told(t))= Con_totb(t,"0026") - IOT_B0(t,"0026","0100") - IOT_B0(t,"0026","0275") ;
Dist(t,"0027")$(not told(t))= Con_totb(t,"0027") - IOT_B0(t,"0027","0275") ;

set i_naph(i_sec0) industrial sectors related to sector naphtha /

0111*0138
*0112*0138

/;

alias(i_naph,j_naph) ;
*Dist("2009","0101")= 0;
*Dist("2009","0106")= 0;
*Dist("2009","0279")= 0;

Dist(t,"0101")$(not told(t))=Con_totb(t,"0101") - sum(j_naph,IOT_B0(t,"0101",j_naph)) ;
Dist(t,"0106")$(not told(t))=Con_totb(t,"0106")  - IOT_B0(t,"0106","0275") ;
Dist(t,"0279")$(not told(t))=Con_totb(t,"0279")  - IOT_B0(t,"0279","0275") - IOT_B0(t,"0279","0280") ;

*for fire power geneartion and other power generation, combine the amount of energy consumption of two sectors
parameter Dist0(t) Distributed value for sector of Fire power generation and Other power generation;
*Dist0("2009") = 0;
*Dist("2009","0278") = 0;

Dist0(t)$(not told(t)) = Con_totb(t,"0275") + Con_totb(t,"0277")  ;
Dist(t,"0278")$(not told(t)) = Con_totb(t,"0278") - IOT_B0(t, "0278", "0275") ;

*****Construct the Energy IO Table
parameter IOT_energy(t,i_sec0,j_sec0) Energy Input-Output Table;
IOT_energy(t,i_ene,j_sec0) = 0 ;
IOT_energy(t,i_ene,j_sec0)$(not told(t)) = IOT_B0(t,i_ene,j_sec0) / Dist(t,i_ene) * Con_ene(t,i_ene) ;

IOT_energy(t,"0026",j_sec0)$(not told(t)) = IOT_B0(t,"0026",j_sec0) / Dist(t,"0026") * (Con_ene(t,"0026") -  EBS_LLH(t,"ED33","E11") -  (- EBS_LLH(t,"ED21","E11"))) ;
IOT_energy(t,"0027",j_sec0)$(not told(t)) = IOT_B0(t,"0027",j_sec0) / Dist(t,"0027") * (Con_ene(t,"0027") -(- EBS_LLH(t,"ED21","E12")) ) ;
IOT_energy(t,"0101",j_sec0)$(not told(t)) = IOT_B0(t,"0101",j_sec0) / Dist(t,"0101") * (Con_ene(t,"0101") -EBS_LLH(t,"ED3135","E231") ) ;
IOT_energy(t,"0106",j_sec0)$(not told(t)) = IOT_B0(t,"0106",j_sec0) / Dist(t,"0106") * (Con_ene(t,"0106") -(- EBS_LLH(t,"ED21","E214")  -  EBS_LLH(t,"ED21","E215")  -  EBS_LLH(t,"ED21","E216")) ) ;
IOT_energy(t,"0279",j_sec0)$(not told(t)) = IOT_B0(t,"0279",j_sec0) / Dist(t,"0279") * (Con_ene(t,"0279") -(- EBS_LLH(t,"ED21","E3")  -  EBS_LLH(t,"ED21","E4"))  -  (- EBS_LLH(t,"ED22","E3")  -  EBS_LLH(t,"ED22","E4")) ) ;
*renewable: distribute primary consumption other than electricity generation
IOT_energy(t,"0278",j_sec0)$(not told(t)) = IOT_B0(t,"0278",j_sec0) / Dist(t,"0278") * (Con_ene(t,"0278") -(- EBS_LLH(t,"ED21","E9"))) ;

*for fire power geneartion and other power generation, combine the amount of energy consumption of two sectors
*IOT_energy("2009","0275",j_sec0) = 0;
*IOT_energy("2009","0277",j_sec0) = 0;

IOT_energy(t,"0275",j_sec0)$(not told(t)) = IOT_B0(t,"0275",j_sec0) / Dist0(t) * (Con_ene(t,"0275") + Con_ene(t,"0277")) ;
IOT_energy(t,"0277",j_sec0)$(not told(t)) = IOT_B0(t,"0277",j_sec0) / Dist0(t) * (Con_ene(t,"0275") + Con_ene(t,"0277")) ;

*for Naphtha
*IOT_energy("2009","0101",i_naph) = 0;

IOT_energy(t,"0101",i_naph)$(not told(t)) = IOT_B0(t,"0101",i_naph) / sum(j_naph,IOT_B0(t,"0101",j_naph)) * EBS_LLH(t,"ed3135","e231")        ;

*for input to fire power generation,
IOT_energy(t,"0026","0100")$(not told(t)) =  EBS_LLH(t,"ED33","E11")        ;
IOT_energy(t,"0026","0275")$(not told(t)) =  0 - EBS_LLH(t,"ED21","E11")        ;
IOT_energy(t,"0027","0275")$(not told(t)) =  0 - EBS_LLH(t,"ED21","E12")        ;
IOT_energy(t,"0106","0275")$(not told(t)) =  0 - EBS_LLH(t,"ED21","E214")  -  EBS_LLH(t,"ED21","E215")  -  EBS_LLH(t,"ED21","E216")        ;
IOT_energy(t,"0279","0275")$(not told(t)) =  0 - EBS_LLH(t,"ED21","E3")  -  EBS_LLH(t,"ED21","E4")        ;
*renewable in electricity generation
IOT_energy(t,"0278","0275")$(not told(t)) = 0 - EBS_LLH(t,"ED21","E9") ;


*for input to Steam and hot water supply,
IOT_energy(t,"0279","0280")$(not told(t)) =  0 - EBS_LLH(t,"ED22","E3")  -  EBS_LLH(t,"ED22","E4")        ;

*for final demand category
parameter IOT_energy_FinD(t,i_sec0,Fin_Demand) Energy Consumption by final demand;
IOT_energy_FinD(t,i_ene,"Final_pc") = 0;
IOT_energy_FinD(t,i_ene,"Final_tot") = 0;

IOT_energy_FinD(t,i_ene,"Final_pc")$(not told(t)) = FinalD0_b(t,i_ene,"Final_pc")/ Dist(t,i_ene) * Con_ene(t,i_ene)   ;
IOT_energy_FinD(t,"0026","Final_pc")$(not told(t)) = FINALD0_B(t,"0026","Final_pc") / Dist(t,"0026") * (Con_ene(t,"0026") -  EBS_LLH(t,"ED33","E11") -  (- EBS_LLH(t,"ED21","E11"))) ;
IOT_energy_FinD(t,"0027","Final_pc")$(not told(t)) = FINALD0_B(t,"0027","Final_pc") / Dist(t,"0027") * (Con_ene(t,"0027") -(- EBS_LLH(t,"ED21","E12")) ) ;
IOT_energy_FinD(t,"0101","Final_pc")$(not told(t)) = FINALD0_B(t,"0101","Final_pc") / Dist(t,"0101") * (Con_ene(t,"0101") -EBS_LLH(t,"ED3135","E231") ) ;
IOT_energy_FinD(t,"0106","Final_pc")$(not told(t)) = FINALD0_B(t,"0106","Final_pc") / Dist(t,"0106") * (Con_ene(t,"0106") -(- EBS_LLH(t,"ED21","E214")  -  EBS_LLH(t,"ED21","E215")  -  EBS_LLH(t,"ED21","E216")) ) ;
IOT_energy_FinD(t,"0279","Final_pc")$(not told(t)) = FINALD0_B(t,"0279","Final_pc") / Dist(t,"0279") * (Con_ene(t,"0279") -(- EBS_LLH(t,"ED21","E3")  -  EBS_LLH(t,"ED21","E4"))  -  (- EBS_LLH(t,"ED22","E3")  -  EBS_LLH(t,"ED22","E4")) ) ;
IOT_energy_FinD(t,"0275","Final_pc")$(not told(t)) = FINALD0_B(t,"0275","Final_pc") / Dist0(t) * (Con_ene(t,"0275") + Con_ene(t,"0277")) ;
IOT_energy_FinD(t,"0277","Final_pc")$(not told(t)) = FINALD0_B(t,"0277","Final_pc") / Dist0(t) * (Con_ene(t,"0275") + Con_ene(t,"0277")) ;
* renewables distribute primary energy - electricity generation
IOT_energy_FinD(t,"0278","Final_pc")$(not told(t)) = FINALD0_B(t,"0278","Final_pc")/Dist(t,"0278")* (Con_ene(t,"0278") -(- EBS_LLH(t,"ED21","E9"))) ;
IOT_energy_FinD(t,i_ene,"Final_tot")$(not told(t)) = IOT_energy_FinD(t,i_ene,"Final_pc") ;


*Estimate CO2 emissions by using the IPCC Emission Factor
parameter Emit_Fact0(i_ene) IPCC 1996 Emission Factor/
0026        1.1
0027        1.059
0028        0.829
0029        0.63
0100        1.1
0099        1.059
0101        0.829
0102        0.783
0103        0.808
0104        0.812
0105        0.837
0106        0.875
0107        0.713
0108        0.829
0109        0.829
0110        0.829
0279        0.637
*배출량 집계하지 않는 5가지 섹터; 화력 수력 원자력 기타발전 증기및온수공급업+ renewable (0278) doesn't generate GHG
0274        0
0275        0
0276        0
0277        0
0278        0
0280        0
/;

*중복집계 제외

IOT_energy(t,"0026","0100")$(not told(t)) =  0;
IOT_energy(t,"0027","0100")$(not told(t)) =  0;
IOT_energy(t,"0026","0099")$(not told(t)) =  0;
IOT_energy(t,"0027","0099")$(not told(t)) =  0;
IOT_energy(t,"0280",j_sec0)$(not told(t)) =  0;
IOT_energy_FinD(t,"0280",Fin_Demand)$(not told(t)) = 0 ;

set i_temp(i_sec0) /
0101*0110
/ ;

alias(i_temp,j_temp)     ;

parameter Emit_Fact(i_ene) CO2 Emission Factor;
Emit_Fact(i_ene) = Emit_Fact0(i_ene) * 44/12    ;

*나프타, 윤활유제품 몰입탄소율 반영
Emit_Fact("0101") = Emit_Fact("0101") * 0.25 ;
Emit_Fact("0108") = Emit_Fact("0108") * 0.5 ;
Emit_Fact("0109") = Emit_Fact("0109") * 0.5 ;

** We cannot say that renewables are double counted. They simply don't generate ghg.
parameter Del_Dummy(t,i_ene,j_sec0), Del_Dummy_FinD(t,i_ene,Fin_Demand) Delete dummy sectors    ;
Del_Dummy(t,i_ene,j_sec0) = 1       ;
Del_Dummy(t,"0274",j_sec0) = 0     ;
Del_Dummy(t,"0275",j_sec0) = 0     ;
Del_Dummy(t,"0276",j_sec0) = 0     ;
Del_Dummy(t,"0277",j_sec0) = 0     ;
Del_Dummy(t,"0280",j_sec0) = 0     ;
Del_Dummy(t,"0026","0100") = 0     ;
Del_Dummy(t,"0026","0099") = 0     ;
Del_Dummy(t,"0027","0100") = 0     ;
Del_Dummy(t,"0027","0099") = 0     ;
Del_Dummy(t,"0028",j_temp) = 0  ;
Del_Dummy(t,"0029","0279") = 0 ;
*Del_Dummy(t,"0139","0302") = 0 ;
Del_Dummy_FinD(t,i_ene,Fin_Demand) = 1       ;
Del_Dummy_FinD(t,"0274",Fin_Demand) = 0     ;
Del_Dummy_FinD(t,"0275",Fin_Demand) = 0     ;
Del_Dummy_FinD(t,"0276",Fin_Demand) = 0     ;
Del_Dummy_FinD(t,"0277",Fin_Demand) = 0     ;
Del_Dummy_FinD(t,"0280",Fin_Demand) = 0     ;


Parameters Emit_Dir0(t,i_sec0,j_sec0), Emit_Dir0_FinD(t,i_sec0,Fin_Demand) ;
Emit_Dir0(t,i_ene,j_sec0) =  IOT_energy(t,i_ene,j_sec0) * Emit_Fact(i_ene) * Del_Dummy(t,i_ene,j_sec0)  ;
Emit_Dir0_FinD(t,i_ene,Fin_Demand) = IOT_energy_FinD(t,i_ene,Fin_Demand) * Emit_Fact(i_ene) * Del_Dummy_FinD(t,i_ene,Fin_Demand)  ;

Parameters Emit_Dir1(t,j_sec0), Emit_Dir1_FinD(t,Fin_Demand);
Emit_Dir1(t,j_sec0)  =  0 ;
Emit_Dir1(t,j_sec0) = sum(i_ene, ( IOT_energy(t,i_ene,j_sec0) * Emit_Fact(i_ene)) * Del_Dummy(t,i_ene,j_sec0) ) ;
Emit_Dir1_FinD(t,Fin_Demand) = 0 ;
Emit_Dir1_FinD(t,Fin_Demand) = sum(i_ene, ( IOT_energy_FinD(t,i_ene,Fin_Demand) * Emit_Fact(i_ene)) * Del_Dummy_FinD(t,i_ene,Fin_Demand) ) ;

*Final Demands excluding HH demand equal zero
Emit_Dir1_FinD(t,"Final_PK") = 0  ;
Emit_Dir1_FinD(t,"Final_gk") = 0  ;
Emit_Dir1_FinD(t,"Final_st") = 0  ;
Emit_Dir1_FinD(t,"Final_Ex") = 0  ;
Emit_Dir1_FinD(t,"Final_tot") = Emit_Dir1_FinD(t,"Final_pc")   ;
*Total Demand

*rescaling
Emit_Dir0(t,i_ene,j_sec0) = Emit_Dir0(t,i_ene,j_sec0) * 1000 ;
Emit_Dir0_FinD(t,i_ene,Fin_Demand) = Emit_Dir0_FinD(t,i_ene,Fin_Demand) * 1000 ;
Emit_Dir1(t,i_sec0) = Emit_Dir1(t,i_sec0) * 1000 ;
Emit_Dir1_FinD(t,Fin_Demand) = Emit_Dir1_FinD(t,Fin_Demand) * 1000;

Parameter Emit_Dir(t,i_sec0) Direct Emissions by Industrial Sectors       ;
Parameter Emit_Dir_FinD(t,i_sec0,Fin_Demand) Direct Emissions by Final Demand   ;
Emit_Dir(t,i_sec0) = Emit_Dir1(t,i_sec0)  ;
Emit_Dir_FinD(t,i_ene,Fin_Demand) = Emit_Dir0_FinD(t,i_ene,Fin_Demand)  ;

Parameter Emit_Dir_Ene(t,i_sec0) Direct Emissions by energy ;
Emit_Dir_Ene(t,i_ene) = sum(j_sec0, Emit_Dir0(t,i_ene,j_sec0)) + Emit_Dir0_FinD(t,i_ene,"final_pc") ;

Parameter Emit_Dir_G(t) ;
Emit_Dir_G(t) = sum(i_sec0, Emit_Dir(t,i_sec0) +  Emit_Dir_FinD(t,i_sec0,"final_pc") ) ;
