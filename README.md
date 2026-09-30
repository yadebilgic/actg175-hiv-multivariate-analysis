# ACTG 175 HIV Clinical Trial: Multivariate Statistical Analysis

A comprehensive cross-platform multivariate statistical analysis (conducted in R, SAS, and IBM SPSS) evaluating immunological response patterns, treatment efficacy, and clinical progression in 2,139 HIV-1 infected patients from the ACTG 175 randomized clinical trial.

## 🛠️ Tech Stack & Statistical Software

**R & R Markdown:** Multivariate normality testing (Mardia skewness & kurtosis), hierarchical clustering & dendrogram visualization, 2D PCA & cluster projections (`ggplot2`, `factoextra`, `cluster`, `MVN`).
- **SAS Studio:** Advanced modeling via `PROC DISCRIM`, `PROC LOGISTIC`, and `PROC GLM` procedures for cross-platform model validation.
- **IBM SPSS Statistics:** One-Way & Two-Way MANOVA, Principal Component Analysis (PCA), Exploratory Factor Analysis (Varimax), Canonical Discriminant Analysis, and K-Means Clustering.

 ## 📊 Dataset Overview

- **Sample Size (N):** 2,139 patient records[cite: 5]
- **Attributes:** 15 categorical and 9 continuous variables[cite: 5]
- **Key Clinical Measures:**
  - `cd40` & `cd420`: Baseline and Week 20 CD4+ T-cell counts (cells/mm³)[cite: 5]
  - `cd80` & `cd820`: Baseline and Week 20 CD8+ T-cell counts (cells/mm³)[cite: 5]
  - `trt`: 4 randomized treatment arms (ZDV monotherapy, ZDV + ddI, ZDV + Zalcitabine, ddI monotherapy)[cite: 6, 7]
  - `strat`: Antiretroviral pre-treatment history (Naive, Short-term, Long-term)[cite: 6, 15]
  - `label`: Clinical endpoint indicator (0: Censored, 1: Disease progression or death)[cite: 6, 41]
 
  ## 🔬 Multivariate Analysis Pipeline & Key Findings

### 1. Multivariate Analysis of Variance (MANOVA)
- **One-Way MANOVA:** Due to violations of multivariate normality (Mardia tests $p < 0.001$) and equality of covariance matrices (Box's M = 149.38, $F = 4.963, p < 0.001$), **Pillai's Trace** was utilized ($\text{Trace} = 0.056, F = 10.10, p < 0.001$)[cite: 8, 9, 10]. Post-hoc pairwise comparisons revealed that treatment differences were exclusively driven by Week 20 CD4 recovery (`cd420`, $p < 0.001$), where the **ZDV + ddI** combination achieved the highest therapeutic response (mean: 403.17 cells/mm³) compared to ZDV monotherapy (mean: 336.14 cells/mm³)[cite: 7, 12, 14].
- **Two-Way MANOVA:** Prior treatment experience (`strat`) exhibited a significant main effect ($p < 0.001$), whereas the interaction effect (`trt * strat`) was not statistically significant ($p = 0.985$), demonstrating that the relative efficacy of combination regimens remains consistent regardless of patient pre-treatment background[cite: 17, 19].

### 2. Principal Component Analysis (PCA) & Factor Analysis
- **Sampling Adequacy:** The overall KMO measure was 0.367, resulting mathematically from the strong bi-polar orthogonality between the CD4 and CD8 cell lines rather than a lack of correlation[cite: 26, 30]. Bartlett's Test of Sphericity confirmed significant correlation structure ($\chi^2 = 3312.47, p < 0.001$)[cite: 26, 30].
- **Dimensionality Reduction:** The first two principal components had eigenvalues exceeding 1.0 (1.96 and 1.38), retaining **83.50%** of the total variance[cite: 27, 31].
- **Factor Structure:** Orthogonal Varimax rotation converged on a clean simple structure[cite: 33]:
  - **Factor 1 (CD8 Cytotoxic Response):** Highly loaded by `cd80` (0.935) and `cd820` (0.932)[cite: 33].
  - **Factor 2 (CD4 Helper Immune Status):** Highly loaded by `cd40` (0.885) and `cd420` (0.889)[cite: 33].

### 3. Discriminant Analysis
- A canonical discriminant model was developed to separate treatment groups based on cellular dynamics[cite: 34]. Only the first discriminant function reached statistical significance (Wilks' $\Lambda = 0.945, p < 0.001$)[cite: 36].
- Structure matrix coefficients confirmed that Week 20 CD4 count (`cd420`, $r = 0.715$) was the single dominant predictor separating the groups[cite: 36].
- The model achieved a **33.2%** overall classification accuracy, surpassing the proportional chance criterion (25.0%), with the highest discrimination observed in the ZDV monotherapy arm (57.9%)[cite: 38].

### 4. Binary Logistic Regression
- Clinical disease progression (`label`) was modeled using baseline immunological status (`cd40`) and demographic factors (`gender`)[cite: 41, 47].
- Baseline CD4 count was a highly protective and statistically significant predictor (Wald = 71.02, $Exp(B) = 0.996, p < 0.001$), indicating that each additional CD4 cell at baseline reduces the odds of disease progression[cite: 45].
- Patient gender was not statistically significant ($p = 0.062$) and was dropped via stepwise selection[cite: 45, 47]. The final parsimonious model achieved an overall predictive accuracy of **75.5%**[cite: 44, 46].

### 5. Cluster Analysis (K-Means & Hierarchical)
- Silhouette coefficient ($k=2$), elbow within-sum-of-squares (WSS), and hierarchical Ward's dendrogram on a representative subsample established an optimal **3-cluster clinical profile**[cite: 48, 49]:
  - **Cluster 1 (Balanced Majority, $N=835$):** Moderate, stable CD4 and CD8 counts[cite: 51, 52].
  - **Cluster 2 (High Clinical Risk, $N=1,179$):** Lowest CD4 (mean: 335.85) and CD8 (mean: 682.25) levels; represents patients requiring aggressive therapeutic monitoring[cite: 51, 52].
  - **Cluster 3 (Hyper-Immune / Active Battle, $N=125$):** Preserved CD4 levels (mean: 399.09) accompanied by elevated CD8 cytotoxic counts (mean: 2220.71), indicating active viral engagement[cite: 51, 52].
- ANOVA decomposition demonstrated that CD8 cellular variability was the primary statistical driver of cluster separation ($F_{CD80} = 2607.07, p < 0.001$)[cite: 52].

## 👤 Author & Contact

- **Yade İrem Bilgiç** – Statistician / Data Analyst
- **Education:** B.Sc. in Statistics, Mimar Sinan Fine Arts University (2025)[cite: 4]
- **Email:** yadeirem2004@gmail.com
