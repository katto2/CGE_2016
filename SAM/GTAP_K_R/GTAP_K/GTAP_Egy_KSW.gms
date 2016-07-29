parameters
EDF_K(t,j0,i0) usage of domestic product by firms (Mtoe)
EDP_K(t,j0) private comsunption of domestic product (Mtoe)
MDF_K(t,j0,i0) emissions from domestic product in current production (MtCO2)
MDP_K(t,j0) emissions from private consumption of domestic product (MtCO2)
NDF_K(t,i0) Process emissions from domestic production (MtCO2)
NDF_K_GHG(t,GHGs,j0)
*EVST_K(t,j0,i0) energy consumption of international transport services (Mtoe)
*MVST_K(t,j0,i0) emissions from international transport services (MtCO2)
;

EDF_K(t,i0,j0)$(not told(t)) = sum(i_sec0$(mapi_SEC0(i_sec0,i0)),  sum(j_sec0$(mapi_SEC0(j_sec0,j0)), IOT_energy(t,i_sec0,j_sec0))) /1000;
EDP_K(t,i0)$(not told(t)) = sum(i_sec0$(mapi_SEC0(i_sec0,i0)), IOT_energy_FinD(t,i_sec0,"Final_PC")) / 1000      ;
MDF_K(t,i0,j0)$(not told(t)) = sum(i_sec0$(mapi_SEC0(i_sec0,i0)), ( sum(j_sec0$(mapi_SEC0(j_sec0,j0)), Emit_Dir0(t,i_sec0,j_sec0) ))) / 1000000;
MDP_K(t,i0)$(not told(t)) = sum(i_sec0$(mapi_SEC0(i_sec0,i0)),  Emit_Dir0_FinD(t,i_sec0,"Final_PC")) / 1000000   ;
NDF_K(t,j0)$(not told(t)) = sum(j_sec0$(mapi_SEC0(j_sec0,j0)), sum(GHGs, Emit_Prcs(t,GHGs,j_sec0) )) / 1000000;
NDF_K_GHG(t,GHGs,j0)$(not told(t)) =  sum(j_sec0$(mapi_SEC0(j_sec0,j0)),  Emit_Prcs(t,GHGs,j_sec0) ) / 1000000;
