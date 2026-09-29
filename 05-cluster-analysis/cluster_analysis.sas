PROC IMPORT DATAFILE="/home/u64410525/sasuser.v94/MANOVA/aids_veri.csv"
    OUT= WORK.AIDS_Data   
    DBMS= CSV             
    REPLACE;              
    GETNAMES= YES;        
RUN;

/*Hiyerarşik Kümeleme*/
proc surveyselect data=WORK.AIDS_Data 
                  method=srs 
                  n=500 
                  out=AIDS_Sample;
run;

ODS GRAPHICS ON;

/*Ward*/
PROC CLUSTER DATA=AIDS_Sample 
             METHOD=WARD 
             RMSSTD
             SIMPLE
             OUTTREE=ward 
             PLOTS(MAXPOINTS=500)=DENDROGRAM; 
    VAR cd40 cd420 cd80 cd820;
RUN;

/* Average - Karşılaştırma için */
proc cluster data=AIDS_Sample method=average outtree=tree_avg PLOTS(MAXPOINTS=500)=DENDROGRAM;
    var cd40 cd420 cd80 cd820;
run;

/* Complete - Karşılaştırma için */
proc cluster data=AIDS_Sample method=complete outtree=tree_comp PLOTS(MAXPOINTS=500)=DENDROGRAM;
    var cd40 cd420 cd80 cd820;
run;         
 
 /*Dendogram*/
proc tree data=ward nclusters=3;
run;


/*K-Means*/
proc fastclus data=WORK.AIDS_Data 
              maxclusters=3 
              maxiter=100   
              converge=0  
              distance         
              out=AIDS_Kume_Sonuc; 
    var cd40 cd420 cd80 cd820;
run;    


/*ANOVA*/
/* Başlangıç CD4 ölçümü için test */
proc glm data=AIDS_Kume_Sonuc; 
    class cluster; 
    model cd40 = cluster;
    title "CD4 Başlangıç Ölçümleri ANOVA Analizi";
run;

/* 20. Haftadaki CD4 ölçümü için test */
proc glm data=AIDS_Kume_Sonuc; 
    class cluster; 
    model cd420 = cluster;
    title "CD4 20. Hafta Ölçümleri ANOVA Analizi";
run;

/* Başlangıç CD8 ölçümü için test */
proc glm data=AIDS_Kume_Sonuc; 
    class cluster; 
    model cd80 = cluster;
    title "CD8 Başlangıç Ölçümleri ANOVA Analizi";
run;

/* 20. Haftadaki CD8 ölçümü için test */
proc glm data=AIDS_Kume_Sonuc; 
    class cluster; 
    model cd820 = cluster;
    title "CD8 20. Hafta Ölçümleri ANOVA Analizi";
run;