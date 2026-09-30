/*TBA*/
PROC IMPORT DATAFILE="/home/u64410525/sasuser.v94/MANOVA/aids_veri.csv"
    OUT= WORK.AIDS_Data   
    DBMS= CSV             
    REPLACE;              
    GETNAMES= YES;        
RUN;

PROC PRINCOMP data=WORK.AIDS_Data
    n=3
    plots=(scree loading);
    var cd40 cd420 cd80 cd820;
    
     TITLE 'Temel Bileşenler Analizi (PCA)';
run;

/*FAKTÖR*/
PROC FACTOR data=WORK.AIDS_Data
    corr
    method=principal
    nfactors=2
    maxiter=25
    rotate=varimax
    reorder
    msa
    plots=(scree eigen initloadings loading);
    var cd40 cd420 cd80 cd820;
    TITLE 'Faktör Analizi(FA)';
run; 