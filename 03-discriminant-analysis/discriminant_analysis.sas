PROC IMPORT DATAFILE="/home/u64410525/sasuser.v94/MANOVA/aids_veri.csv"
    OUT= WORK.AIDS_Data   
    DBMS= CSV             
    REPLACE;              
    GETNAMES= YES;        
RUN;

/*Veri Dağılımı Kontrolü*/
proc freq data=WORK.AIDS_Data;
  tables trt;
run;

/*Çoklu Bağlantı Kontrolü*/
proc corr data=WORK.AIDS_Data spearman; 
   var cd40 cd420 cd80 cd820;
run;

/*Normallik Testi*/
proc univariate data=WORK.AIDS_Data normal;
   var cd40 cd420 cd80 cd820; 
   histogram / normal; 
run;

/*Diskriminant Analizi*/
proc discrim data=WORK.AIDS_Data 
   can       
   simple    
   pool=test;
   class trt;
   var cd40 cd420 cd80 cd820;
   priors proportional;
run;

/*Adımsal Diskriminant Analizi*/
proc stepdisc method=stepwise  data=WORK.AIDS_Data;
   class trt;
   var cd40 cd420 cd80 cd820;
run;

