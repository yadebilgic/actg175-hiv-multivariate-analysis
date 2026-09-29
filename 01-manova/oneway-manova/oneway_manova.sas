ODS GRAPHICS OFF; 

PROC IMPORT DATAFILE="/home/u64410525/sasuser.v94/MANOVA/aids_veri.csv"
    OUT= WORK.AIDS_Data   
    DBMS= CSV             
    REPLACE;              
    GETNAMES= YES;        
RUN;


PROC PRINT DATA=WORK.AIDS_Data (OBS=10);
    TITLE 'MANOVA Klasöründen Yüklenen AIDS Verisi';
RUN;

ODS LISTING; 
OPTIONS PAGENO=1;

/*MANOVA */
PROC GLM DATA=WORK.AIDS_Data; 
    CLASS trt; 
    MODEL cd40 cd420 cd80 cd820 = trt; 
    MANOVA H=trt / SUMMARY; 
RUN;


/* Levene Testi 1: cd40 */
PROC ANOVA DATA=WORK.AIDS_Data;
    CLASS trt;
    MODEL cd40 = trt;
    MEANS trt / HOVTEST=LEVENE;
RUN;

/* Levene Testi 2: cd420 */
PROC ANOVA DATA=WORK.AIDS_DATA;
    CLASS trt;
    MODEL cd420 = trt;
    MEANS trt / HOVTEST=LEVENE;
RUN;

/* Levene Testi 3: cd80 */
PROC ANOVA DATA=WORK.AIDS_DATA;
    CLASS trt;
    MODEL cd80 = trt;
    MEANS trt / HOVTEST=LEVENE;
RUN;

/* Levene Testi 4: cd820 */
PROC ANOVA DATA=WORK.AIDS_DATA;
    CLASS trt;
    MODEL cd820 = trt;
    MEANS trt / HOVTEST=LEVENE;
RUN;

ODS GRAPHICS ON; 


ODS GRAPHICS OFF; 

/* POST HOC TESTLERİ (TUKEY HSD) */


/* Post Hoc Test (Tukey) for cd40 */
PROC ANOVA DATA=WORK.AIDS_Data;
    CLASS trt;
    MODEL cd40 = trt;
    MEANS trt / TUKEY; 
RUN;

/* Post Hoc Test (Tukey) for cd420 */
PROC ANOVA DATA=WORK.AIDS_Data;
    CLASS trt;
    MODEL cd420 = trt;
    MEANS trt / TUKEY;
RUN;

/* Post Hoc Test (Tukey) for cd80 */
PROC ANOVA DATA=WORK.AIDS_Data;
    CLASS trt;
    MODEL cd80 = trt;
    MEANS trt / TUKEY;
RUN;

/* Post Hoc Test (Tukey) for cd820 */
PROC ANOVA DATA=WORK.AIDS_Data;
    CLASS trt;
    MODEL cd820 = trt;
    MEANS trt / TUKEY;
RUN;

ODS GRAPHICS ON;