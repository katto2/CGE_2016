set tnew(t) /2010/;
set told(t) /2009/;
parameter con_totB(t,i_sec0);
*�Ѽ��䰡 �ƴ� �߰������ ����Һ��� ��.
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

***** �����߿��� ���� (LLH) conversion
set energy0(energy) Aggregation of petroleum for Energy Use /
E211     "Gasoline,�ֹ���"
E212     "Kerosene,����"
E213     "Diesel,����"
E214     "B-A,��������"
E215     "B-B,����"
E216     "B-C,��������"
E217     "JA-1,JA-1"
E218     "JP-4,JP-4"
E219     "AVI-G,AVI-G"
/;

set energy1(energy) Aggregation of petroleum for Non-Energy Use /
E231     "Naphtha,����Ÿ"
E232     "Solvent,����"
E233     "Asphalt,�ƽ���Ʈ"
E234     "Lubricant,��Ȱ����"
E235     "Paraffin-Wax,�Ķ��ɿν�"
E236     "Petroleum Coke,������ũ"
E237     "Other Products,��Ÿ��ǰ"
/;

** Inverting the value into the low calorific value (�����߿������� ��ȯ)
Parameters
EBS_LLH(t,Energy_d,Energy) �����߿��� ���� Energy Balance sheet
EBS_LLH0(t,Energy_d,Energy) �ʱ� EBS
;

if(GTAPBASE,
         EBS_LLH(t,Energy_d,Energy) = EBS(t,Energy_d,Energy) ;
         EBS_LLH(t,Energy_d,Energy) = EBS(t,Energy_d,Energy) * Fac_Conv(energy) ;

         EBS_LLH0(t,Energy_d,Energy) = EBS_LLH(t,Energy_d,Energy) ;
         EBS_LLH(t,Energy_d,"E21") = sum(energy0,EBS_LLH(t,Energy_d,energy0))   ;
         EBS_LLH(t,Energy_d,"E22") = EBS_LLH(t,Energy_d,"E221") + EBS_LLH(t,Energy_d,"E222")       ;
         EBS_LLH(t,Energy_d,"E23") = sum(energy1,EBS_LLH(t,Energy_d,energy1))   ;
         EBS_LLH0(t,Energy_d,"E2") = EBS_LLH(t,Energy_d,"E21") + EBS_LLH(t,Energy_d,"E22") + EBS_LLH(t,Energy_d,"E23")          ;

***** GTAP������ ���� VST (������ۼ���)�κ��� ���� EBS���� �����ؾ���. �ѱ�IO������ Export ���� ������ۼ��񽺺κ��� VST�� ���� ���� ����.
***** �ѱ� EBS�� ������Ŀ���� ������ �ƴ� �ؿ� ������ ���� Ȥ�� �װ��� �����. �׷��� ������ �ѱ� ������ ������ۼ��� �κ��� �߰��� ����� ��.
***** ������ �ؿܱ����� ���� Ȥ�� �װ��� ��� ������ۼ��񽺶� ������.(�ѱ� EBS���� �ؿܱ����� �װ� �κ��� ��Ŀ���� ���� �� �� ���� ������)
***** ���� �ѱ� ������ �������� ��� ���� ��ۼ��񽺷� ��������, �װ������ ���� ������ ���� ��ۼ����� ������ ������.
***** �׷��� ������ VST�� ������ Ȥ�� �ѱ� ���ⷮ�� ��������� �̷��� �� ����.

* (�ѱ� ����) ���� ���� ��ۿ� ���� ������ �Һ� ����.
* �ϴ� ���������� �Һ�� ��� �������� �ؿܿ���̶� �������� ���� ���������� ���� �ʿ䰡 ����.
         loop(energy, EBS_LLH(t,"ED323",Energy) = 0 );
* (�ѱ� �װ���) ���� �װ� ��ۿ� ���� ������ �Һ� ����.
* �װ������ ��ü ��� ����� ��� ������� ������ŭ ����. (2431664/8483270, �����װ� 2007 �������� ����)
         loop(energy, EBS_LLH(t,"ED324",Energy) = EBS_LLH(t,"ED324",Energy) * (8483270-2431664)/8483270 ) ;

         EBS_LLH(t,"ED32",Energy) = EBS_LLH(t,"ED321",Energy) + EBS_LLH(t,"ED322",Energy) + EBS_LLH(t,"ED323",Energy) + EBS_LLH(t,"ED324",Energy);
         EBS_LLH(t,"ED3",Energy) = EBS_LLH(t,"ED31",Energy) + EBS_LLH(t,"ED32",Energy) + EBS_LLH(t,"ED33",Energy) + EBS_LLH(t,"ED34",Energy) + EBS_LLH(t,"ED35",Energy) ;
         EBS_LLH(t,"ED1",Energy) = EBS_LLH(t,"ED3",Energy) - EBS_LLH(t,"ED2",Energy) ;
);
if(not GTAPBASE,
         EBS_LLH(t,Energy_d,Energy) = EBS(t,Energy_d,Energy) ;
         EBS_LLH(t,Energy_d,Energy) = EBS(t,Energy_d,Energy) * Fac_Conv(energy) ;
);

* Aggregation (�հ�)
EBS_LLH(t,Energy_d,"E11") = EBS_LLH(t,Energy_d,"E111") + EBS_LLH(t,Energy_d,"E112")       ;
EBS_LLH(t,Energy_d,"E12") = EBS_LLH(t,Energy_d,"E121") + EBS_LLH(t,Energy_d,"E122")       ;
EBS_LLH(t,Energy_d,"E1") = EBS_LLH(t,Energy_d,"E11") + EBS_LLH(t,Energy_d,"E12")          ;
EBS_LLH(t,Energy_d,"E21") = sum(energy0,EBS_LLH(t,Energy_d,energy0))   ;
EBS_LLH(t,Energy_d,"E22") = EBS_LLH(t,Energy_d,"E221") + EBS_LLH(t,Energy_d,"E222")       ;
EBS_LLH(t,Energy_d,"E23") = sum(energy1,EBS_LLH(t,Energy_d,energy1))   ;
EBS_LLH(t,Energy_d,"E2") = EBS_LLH(t,Energy_d,"E21") + EBS_LLH(t,Energy_d,"E22") + EBS_LLH(t,Energy_d,"E23")          ;
EBS_LLH(t,Energy_d,"E10") = EBS_LLH(t,Energy_d,"E1") + EBS_LLH(t,Energy_d,"E2") + EBS_LLH(t,Energy_d,"E3") + EBS_LLH(t,Energy_d,"E4") + EBS_LLH(t,Energy_d,"E5") + EBS_LLH(t,Energy_d,"E6") + EBS_LLH(t,Energy_d,"E7") + EBS_LLH(t,Energy_d,"E8") + EBS_LLH(t,Energy_d,"E9")   ;


***** EB energy sector into IO energy sector  (�������ǥ���� ������-�������� 21�� ����-���� �Ҵ�)
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
