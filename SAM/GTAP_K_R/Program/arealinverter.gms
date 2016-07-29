*define parameters if they have not been defined
*this cant be called the first time in a loop
*if it needs to be called in a loop first call with no parameters before the loop

$ifthen not declared inverterset1
   alias (inverterset,inverterset2,*);
   set inverterseti(inverterset) i dimension of matrix to invert;
   set invertersetj(inverterset) j dimension of matrix to invert;
   alias(inverterseti,inverterseti1);
   set mapthem(*,*) map the two sets togther;
   parameter matrixtosend_1(*,*) matrix to send to invert;
   parameter matrixtosend_2(*,*) matrix back from invert;
   scalar invert_count;
$endif

*if called with no parameters then dont do rest
$ifthen not "a%1"=="a"
*        copy the matrix to a temporary place
         matrixtosend_1(%2,%3)=%1(%2,%3);
*        get the sets over which this is defined
         loop((inverterset,inverterset2)$matrixtosend_1(inverterset,inverterset2),
             inverterseti(inverterset)=yes;
             invertersetj(inverterset2)=yes;
             );
*        get the second set into the first
         loop((inverterseti,invertersetj)$(inverterseti.pos=invertersetj.pos),
             mapthem(inverterseti,invertersetj)=yes;
             );
*now make the matrix into the form required by the GAMS INVERT utility
         loop((inverterseti,mapthem(inverterseti1,invertersetj)),
              matrixtosend_2(inverterseti,inverterseti1)=
                  matrixtosend_1(inverterseti,invertersetj));
*abort if row and column dimensions are not the same
         if(card(inverterseti)<>card(invertersetj),abort 'set sizes not the same');
*         display inverterseti,invertersetj,mapthem,matrixtosend_2;

*form the GDX file
         execute_unload 'gdxforinverse.gdx' inverterseti,matrixtosend_2;
*invert
         execute 'invert gdxforinverse.gdx inverterseti matrixtosend_2 gdxfrominverse.gdx matrixtosend_1';
*zero out the recipient matrix
         matrixtosend_1(inverterseti,invertersetj)=0;
*load in the inverse
         execute_load 'gdxfrominverse.gdx' , matrixtosend_1;

*         display matrixtosend_1;
*transform back to original indices but note invert is transposed
         loop((inverterseti,mapthem(inverterseti1,invertersetj)),
              matrixtosend_2(invertersetj,inverterseti)=
                  matrixtosend_1(inverterseti1,inverterseti));
*convert back to original matrix
         loop((%3,invertersetj)$sameas(%3,invertersetj),
            loop((%2,inverterseti)$sameas(%2,inverterseti),
              %4(%3,%2)=matrixtosend_2(invertersetj,inverterseti)));
*         display %4;

*zero out the temporary sets and parameters
         inverterseti(inverterset)=no;
         invertersetj(inverterset)=no;
         mapthem(inverterset,inverterset2)=no;
         matrixtosend_1(inverterset,inverterset2)=0;
         matrixtosend_2(inverterset,inverterset2)=0;
         invert_count=0;

$endif

*arealinverter a2 a2inverse
