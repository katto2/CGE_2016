*Illustrate put of CSV file with utility developed by Tom Rutherford



set i /i1*i3/, j/j1*j3/, k/k1*k3/;
set lessi(i) /i1/;
set lessj(j) /j1/;
set lessk(k) /k2/;

parameter        x(i)                A one-dimensional vector.
                y(i,j,k)        A three dimensional array written with column headers
                z(i,j,k)        A three dimensional array written in list form;

x(i) = uniform(0,1);
y(i,j,k) = uniform(0,1);
loop((i,j,k)$(ord(i)=3 and ord(j)=2 and ord(k)=1),
x(i) = 0;
y(i,j,k) = 0;);
z(i,j,k) = y(i,j,k);

file        kpe /prices.csv/;
*file kout /ex2.csv/;
file        kout /%gams.scrdir%prices.scr/;


put kout;
put 'x without domain' /;
$batinclude "result\gams2csv.gms" x
*$libinclude gams2csv x
put / 'x with lesser domain for i' //;
$batinclude "result\gams2csv.gms" lessi x
*$libinclude gams2csv lessi x
put / 'y without domain' //;
$libinclude gams2csv y
put / 'y with lesser domain for i and j' //;
$libinclude gams2csv lessi,lessj k y
put / 'z without domain' //;
$libinclude gams2csv z
put / 'z with lesser domain for j and k' //;
$libinclude gams2csv i,lessj,lessk z

$ontext
file        kqty /%gams.scrdir%quants.scr/;
set sc /list1 lab1 , list2 lab2/;
put kgty;
put / 'x with a prefix' //;
loop(sc,
$setglobal prefix sc.tl
$libinclude gams2csv x
);
$offtext

putclose kout;
*putclose kqty;

*        Now call XLWRITE:

execute 'xlwrite %gams.scrdir%prices.scr %gams.scrdir%quants.scr ex5.xls';





$ontext
#user model library stuff
Main topic Output via Put
Featured item 1 Put
Featured item 2 GAMS2CSV.gms
Featured item 3
Featured item 4
Description
Illustrate put of CSV file with utility developed by Tom Rutherford
$offtext
