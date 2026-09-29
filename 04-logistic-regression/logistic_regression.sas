PROC IMPORT DATAFILE="/home/u64410525/sasuser.v94/MANOVA/aids_veri.csv"
    OUT= WORK.AIDS_Data   
    DBMS= CSV             
    REPLACE;              
    GETNAMES= YES;        
RUN;

/* Lojistik Regresyon - Enter Yöntemi */
proc logistic data=WORK.AIDS_Data;

   class gender (ref="0") / param=ref;   
   model label(ref="0") = cd40 gender / expb lackfit rsquare;
  
   output out=outdata predprobs=(individual);
run;

/* Sınıflandırma Tablosu (Atama Tablosu) */
proc freq data=outdata;
   tables _FROM_ * _INTO_ / nocol nopercent;
run;


/* Stepwise Lojistik Regresyon */
proc logistic data=WORK.AIDS_Data;
   
  
   class gender (ref="0") / param=ref; 
   
  
   model label(ref="0") = cd40 gender / expb lackfit rsquare selection=backward;
   
   
   output out=outdata_step predprobs=(individual);
run;

/* Stepwise Atama Tablosu (Confusion Matrix) */
proc freq data=outdata_step;
   /* Gerçek (Label) ve Tahmin edilen (_INTO_) sınıfları karşılaştırır */
   tables label * _INTO_ / nocol nopercent;
run;