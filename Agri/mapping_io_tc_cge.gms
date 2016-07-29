set
io /1*391/
input/ELEC,GASHeat,OIL,COAL,ENIT,NEINT,Rice,Barley,Bean,Potato,Vegi,Fruit,Flower,MissCrop,Dairy,Meat,Pork,Poultry,MissLstock,Labor,Capital,NRES,Ptaxin,Ptaxetc/
inputc/ELEC-c,GASHeat-c,OIL-c,COAL-c,ENIT-c,NEINT-c,Rice-c,Barley-c,Bean-c,Potato-c,Vegi-c,Fruit-c,Flower-c,MissCrop-c,Dairy-c,Meat-c,Pork-c,Poultry-c,MissLstock-c,Labor,Capital/

inputa/ELEC-a,GASHeat-a,OIL-a,COAL-a,ENIT-a,NEINT-a,Rice-a,Barley-a,Bean-a,Potato-a,Vegi-a,Fruit-a,Flower-a,MissCrop-a,Dairy-a,Meat-a,Pork-a,Poultry-a,MissLstock-a,Labor,Capital/

c /ELEC-c,GASHeat-c,OIL-c,COAL-c,ENIT-c,NEINT-c,Rice-c,Barley-c,Bean-c,Potato-c,Vegi-c,Fruit-c,Flower-c,MissCrop-c,Dairy-c,Meat-c,Pork-c,Poultry-c,MissLstock-c/
ENC(C) /GASHeat-c,OIL-c,COAL-c/
a /ELEC-a,GASHeat-a,OIL-a,COAL-a,ENIT-a,NEINT-a,Rice-a,Barley-a,Bean-a,Potato-a,Vegi-a,Fruit-a,Flower-a,MissCrop-a,Dairy-a,Meat-a,Pork-a,Poultry-a,MissLstock-a/
INS/Household,GoV,NRES,Ptaxin,Ptaxetc,Tarrif,YTAX,S-I,ROW /

f(input)/Labor,Capital/
fc(inputc)/Labor,Capital/

L(f) /Labor/
K(f) /Capital/
J production (13)
/Rice,Barley,Bean,Potato,Vegi,Fruit,Flower,MissCrop,Dairy,Meat,Pork,Poultry,
MissLstock/

TC cost components: M won
/ SEED, FERT, PEST, FEED, CUB, MED, ENERGY, WATER, SMACH, LMACH, FACIL,
OINPUT, OSERV, KCOST, LCOST, SUR, TW/

map_jc(j,c)
/Rice.Rice-c,
Barley.Barley-c,
Bean.Bean-c,
Potato.Potato-c,
Vegi.Vegi-c,
Fruit.Fruit-c,
Flower.Flower-c,
MissCrop.MissCrop-c,
Dairy.Dairy-c,
Meat.Meat-c,
Pork.Pork-c,
Poultry.Poultry-c,
MissLstock.MissLstock-c/
map_ja(j,a)
/Rice.Rice-a,
Barley.Barley-a,
Bean.Bean-a,
Potato.Potato-a,
Vegi.Vegi-a,
Fruit.Fruit-a,
Flower.Flower-a,
MissCrop.MissCrop-a,
Dairy.Dairy-a,
Meat.Meat-a,
Pork.Pork-a,
Poultry.Poultry-a,
MissLstock.MissLstock-a/


map_ioc(io,c)
/
1.Rice-c
2.Barley-c
3.Bean-c
4.Potato-c
5.Vegi-c
6.Fruit-c
7.MissCrop-c
8.MissCrop-c
9.MissCrop-c
10.Flower-c
11.MissCrop-c
12.MissCrop-c
13.MissCrop-c
14.Dairy-c
15.Meat-c
16.Pork-c
17.Poultry-c
18.MissLstock-c
19.ENIT-c
20.ENIT-c
21.ENIT-c
22.ENIT-c
23.ENIT-c
24.ENIT-c
25.NEINT-c
26.COAL-c
27.COAL-c
28.OIL-c
29.GASHeat-c
30.ENIT-c
31.ENIT-c
32.ENIT-c
33.ENIT-c
34.ENIT-c
35.NEINT-c
36.NEINT-c
37.NEINT-c
38.NEINT-c
39.NEINT-c
40.NEINT-c
41.NEINT-c
42.Rice-c
43.NEINT-c
44.NEINT-c
45.NEINT-c
46.NEINT-c
47.NEINT-c
48.NEINT-c
49.NEINT-c
50.NEINT-c
51.NEINT-c
52.NEINT-c
53.NEINT-c
54.NEINT-c
55.NEINT-c
56.NEINT-c
57.NEINT-c
58.NEINT-c
59.NEINT-c
60.NEINT-c
61.NEINT-c
62.NEINT-c
63.NEINT-c
64.NEINT-c
65.NEINT-c
66.NEINT-c
67.NEINT-c
68.NEINT-c
69.NEINT-c
70.NEINT-c
71.NEINT-c
72.NEINT-c
73.NEINT-c
74.NEINT-c
75.NEINT-c
76.NEINT-c
77.NEINT-c
78.NEINT-c
79.NEINT-c
80.NEINT-c
81.NEINT-c
82.NEINT-c
83.NEINT-c
84.NEINT-c
85.NEINT-c
86.NEINT-c
87.NEINT-c
88.NEINT-c
89.NEINT-c
90.NEINT-c
91.NEINT-c
92.NEINT-c
93.NEINT-c
94.NEINT-c
95.NEINT-c
96.NEINT-c
97.NEINT-c
98.NEINT-c
99.COAL-c
100.COAL-c
101.OIL-c
102.OIL-c
103.OIL-c
104.OIL-c
105.OIL-c
106.OIL-c
107.OIL-c
108.OIL-c
109.OIL-c
110.OIL-c
111.ENIT-c
112.ENIT-c
113.ENIT-c
114.NEINT-c
115.NEINT-c
116.NEINT-c
117.NEINT-c
118.NEINT-c
119.ENIT-c
120.ENIT-c
121.ENIT-c
122.NEINT-c
123.NEINT-c
124.NEINT-c
125.NEINT-c
126.NEINT-c
127.NEINT-c
128.NEINT-c
129.NEINT-c
130.NEINT-c
131.NEINT-c
132.ENIT-c
133.ENIT-c
134.ENIT-c
135.ENIT-c
136.ENIT-c
137.ENIT-c
138.ENIT-c
139.ENIT-c
140.ENIT-c
141.ENIT-c
142.ENIT-c
143.ENIT-c
144.ENIT-c
145.ENIT-c
146.ENIT-c
147.ENIT-c
148.ENIT-c
149.ENIT-c
150.ENIT-c
151.ENIT-c
152.ENIT-c
153.ENIT-c
154.ENIT-c
155.ENIT-c
156.ENIT-c
157.ENIT-c
158.ENIT-c
159.ENIT-c
160.ENIT-c
161.ENIT-c
162.ENIT-c
163.ENIT-c
164.ENIT-c
165.ENIT-c
166.ENIT-c
167.ENIT-c
168.ENIT-c
169.NEINT-c
170.NEINT-c
171.NEINT-c
172.NEINT-c
173.NEINT-c
174.NEINT-c
175.NEINT-c
176.NEINT-c
177.NEINT-c
178.NEINT-c
179.NEINT-c
180.NEINT-c
181.NEINT-c
182.NEINT-c
183.NEINT-c
184.NEINT-c
185.NEINT-c
186.NEINT-c
187.NEINT-c
188.NEINT-c
189.NEINT-c
190.NEINT-c
191.NEINT-c
192.NEINT-c
193.NEINT-c
194.NEINT-c
195.NEINT-c
196.NEINT-c
197.NEINT-c
198.NEINT-c
199.NEINT-c
200.NEINT-c
201.NEINT-c
202.NEINT-c
203.NEINT-c
204.NEINT-c
205.NEINT-c
206.NEINT-c
207.NEINT-c
208.NEINT-c
209.NEINT-c
210.NEINT-c
211.NEINT-c
212.NEINT-c
213.NEINT-c
214.NEINT-c
215.NEINT-c
216.NEINT-c
217.NEINT-c
218.NEINT-c
219.NEINT-c
220.NEINT-c
221.NEINT-c
222.NEINT-c
223.NEINT-c
224.NEINT-c
225.NEINT-c
226.NEINT-c
227.NEINT-c
228.NEINT-c
229.NEINT-c
230.NEINT-c
231.NEINT-c
232.NEINT-c
233.NEINT-c
234.NEINT-c
235.NEINT-c
236.NEINT-c
237.NEINT-c
238.NEINT-c
239.NEINT-c
240.NEINT-c
241.NEINT-c
242.NEINT-c
243.NEINT-c
244.NEINT-c
245.NEINT-c
246.NEINT-c
247.NEINT-c
248.NEINT-c
249.NEINT-c
250.NEINT-c
251.NEINT-c
252.NEINT-c
253.NEINT-c
254.NEINT-c
255.NEINT-c
256.NEINT-c
257.NEINT-c
258.NEINT-c
259.NEINT-c
260.NEINT-c
261.NEINT-c
262.NEINT-c
263.NEINT-c
264.NEINT-c
265.NEINT-c
266.NEINT-c
267.NEINT-c
268.NEINT-c
269.NEINT-c
270.NEINT-c
271.NEINT-c
272.NEINT-c
273.NEINT-c
274.ELEC-c
275.ELEC-c
276.ELEC-c
277.ELEC-c
278.ELEC-c
279.GASHeat-c
280.GASHeat-c
281.NEINT-c
282.NEINT-c
283.NEINT-c
284.NEINT-c
285.NEINT-c
286.NEINT-c
287.NEINT-c
288.NEINT-c
289.NEINT-c
290.NEINT-c
291.NEINT-c
292.NEINT-c
293.NEINT-c
294.NEINT-c
295.NEINT-c
296.NEINT-c
297.NEINT-c
298.NEINT-c
299.NEINT-c
300.NEINT-c
301.NEINT-c
302.NEINT-c
303.NEINT-c
304.ENIT-c
305.ENIT-c
306.ENIT-c
307.ENIT-c
308.ENIT-c
309.ENIT-c
310.ENIT-c
311.ENIT-c
312.ENIT-c
313.ENIT-c
314.ENIT-c
315.ENIT-c
316.ENIT-c
317.ENIT-c
318.NEINT-c
319.NEINT-c
320.NEINT-c
321.NEINT-c
322.NEINT-c
323.NEINT-c
324.NEINT-c
325.NEINT-c
326.NEINT-c
327.NEINT-c
328.NEINT-c
329.NEINT-c
330.NEINT-c
331.NEINT-c
332.NEINT-c
333.NEINT-c
334.NEINT-c
335.NEINT-c
336.NEINT-c
337.NEINT-c
338.NEINT-c
339.NEINT-c
340.NEINT-c
341.NEINT-c
342.NEINT-c
343.NEINT-c
344.NEINT-c
345.NEINT-c
346.NEINT-c
347.NEINT-c
348.NEINT-c
349.NEINT-c
350.NEINT-c
351.NEINT-c
352.NEINT-c
353.NEINT-c
354.NEINT-c
355.NEINT-c
356.NEINT-c
357.NEINT-c
358.NEINT-c
359.NEINT-c
360.NEINT-c
361.NEINT-c
362.NEINT-c
363.NEINT-c
364.NEINT-c
365.NEINT-c
366.NEINT-c
367.NEINT-c
368.NEINT-c
369.NEINT-c
370.NEINT-c
371.NEINT-c
372.NEINT-c
373.NEINT-c
374.NEINT-c
375.NEINT-c
376.NEINT-c
377.NEINT-c
378.NEINT-c
379.NEINT-c
380.NEINT-c
381.NEINT-c
382.NEINT-c
383.NEINT-c
384.NEINT-c
/
map_iof(io,f)
/
387.Labor
388.Capital
389.Capital
/
map_ioins(io,ins)
/385.Ptaxin
386.Nres
390.Ptaxetc
/

TABLE  iotc_r(tc,io,J) Data
$ondelim
$include iocost_r_Agri_0121.csv
$offdelim;

Table Agricost(tc,j)
$ondelim
$include cost_Agri_0121.csv
$offdelim;


display iotc_r,Agricost;


** A: From BU Total cost to CGE commodity/factor input
*Step1. TC to io input by BU item

parameter

iocost(io,j)
;

iocost(io,j)=sum(tc,iotc_r(tc,io,j)*(Agricost(tc,j)/1000));

display iocost;

parameter
theta_aj(a,j)
theta_cj(c,j);

theta_aj(a,j)=0;
theta_cj(c,j)=0;
theta_aj(a,j)$map_ja(j,a)=1;
theta_cj(c,j)$map_jc(j,c)=1;



parameter
theta_ioc(io,c)
theta_iof(io,f)
theta_ioins(io,ins);
theta_ioc(io,c)=0;
theta_iof(io,f)=0;
theta_ioins(io,ins)=0;
theta_ioc(io,c)$map_ioc(io,c)=1;
theta_iof(io,f)$map_iof(io,f)=1;
theta_ioins(io,ins)$map_ioins(io,ins)=1;



display theta_ioc,theta_iof,theta_ioins;

* Step 2: IO input to CGE input by BU item

parameter
inputcostc(c,j)
inputcostf(f,j)
inputcostins(ins,j)
;

inputcostc(c,j)=sum(io,theta_ioc(io,c)*iocost(io,j));
inputcostf(f,j)=sum(io,theta_iof(io,f)*iocost(io,j));
inputcostins(ins,j)=sum(io,theta_ioins(io,ins)*iocost(io,j));
display inputcostc,inputcostf,inputcostins;

*Step 3: BU item to IO industry  (one to one)

parameter

inputcostc_a(c,a)
inputcostf_a(f,a)
inputcostins_a(ins,a)
;

inputcostc_a(c,a)=sum(j,theta_aj(a,j)*inputcostc(c,j));
inputcostf_a(f,a)=sum(j,theta_aj(a,j)*inputcostf(f,j));
inputcostins_a(ins,a)=sum(j,theta_aj(a,j)*inputcostins(ins,j));

display inputcostc_a,inputcostf_a,inputcostins_a;

parameter

inputcosta(a);

inputcosta(a)=sum(c,inputcostc_a(c,a))+sum(f,inputcostf_a(f,a))+sum(ins,inputcostins_a(ins,a));

display inputcosta;

** B: From CGE armingtion price to BU Total cost price index

parameter
PA(C)
PNEG(C,A)
W(L)
R(K)
P_c(C,A)
;
PA(C)=1;
PA(C)$ENC(C)=0;
PNEG(C,A)$ENC(C)=1;
W(L)=1;
R(K)=1;
P_c(C,A)$ENC(C)=PNEG(C,A);
P_c(C,A)$(not ENC(C))=PA(C);
display PA,PNEG, W, R, P_c;

parameter
P_c(C,A)
Pio_c(io,A)
Pio_w(io,A)
Pio_r(io,A);

P_c(C,A)$ENC(C)=PNEG(C,A);
P_c(C,A)$(not ENC(C))=PA(C);
Pio_c(io,A)=sum(c,theta_ioc(io,c)*P_c(C,A));
Pio_w(io,A)=sum(l,theta_iof(io,l)*w(l));
Pio_r(io,A)=sum(k,theta_iof(io,k)*r(k));

display Pio_c,Pio_w,Pio_r;

parameter
Pio_cj(io,j)
Pio_wj(io,j)
Pio_rj(io,j);

Pio_cj(io,j)=sum(a,theta_aj(a,j)*Pio_c(io,a));
Pio_wj(io,j)=sum(a,theta_aj(a,j)*Pio_w(io,a));
Pio_rj(io,j)=sum(a,theta_aj(a,j)*Pio_r(io,a));

display Pio_cj,Pio_wj,Pio_rj;

parameter
Ptc_j(tc,j);

ptc_j(tc,j)=sum(io,iotc_r(tc,io,j)*Pio_cj(io,j))+sum(io,iotc_r(tc,io,j)*Pio_wj(io,j))+sum(io,iotc_r(tc,io,j)*Pio_rj(io,j));

display ptc_j;



