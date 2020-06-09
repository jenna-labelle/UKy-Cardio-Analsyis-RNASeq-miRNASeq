# Idenfication of potentially pathogenic splice sites

Here, all junctions within CM samples are filtered to identify abberant splice sites that may be pathogenic. Junctions are confirmed in IGV; a large proportion of junctions identified in this analysis **show clear abberant splicing in IGV.**

<br/>

## Input files required:

1) .csv files of all junctions in experimental samples (CM samples here). This .csv file should contain, minimally, columns for chromosome, start of junction, end of junction, depth of junction, gene junction is found in. Each sample should have a separate .csv file.
2) .csv files of all junctions in each control sample. This .csv file should contain, minimally, columns for chromosome, start of junction, end of junction, depth of junction, gene junction is found in. Each sample should have a separate .csv file.

These .csv files should be optionally filtered to only include junctions in genes of interest (here, genes found to be involved in CM)

## Two databases based on **junctions found in control samples** are used when filtering CM junctions:

1) List of ***Control Junctions***: built from *junctions* found in control samples. Composed of **junctions that appear in at least 2 control samples with at least 5 reads**
2) List of ***Canonical splice sites***: A canonical splice site is defined as a *splice site* occuring in **all 5 control samples with at least 80% of mean depth for that gene for that sample**. The 80% threshold is somewhat arbitrary and can be adjusted within the function.  
*Example: Junction chr1_100-200 is split into SpliceSiteA_chr1_100. This splice site is found in all 5 controls. In Control 1, its depth is 10 and the mean depth for all junctions in that gene is 15 (>50% depth, passes for Control 1). The same is true for Controls 2-5. SpliceSiteA_chr1_100, therefore, **is considered "canonical"** and is added to the list of Canonical splice sites*
<br/>

## Filtering of junctions is performed with 4 potential filters- 

1) Remove junction based on **depth of reads supporting the junction.** Two options (can both be used if desired):  
  a) Remove if depth is below some **static threshold** (default=10)  
  b) Remove if depth is below some percentage (default=10%) of the **mean depth of all junctions in that sample.**  
    *Example: Junction chr1_100-200 has a depth of 10 in Sample 1 in gene X. On average, all junctions in gene X in Sample 1 have a depth of 200. Since Junction chr1_100-200 is at <10% mean depth, this junction is removed in this filter*
2) Remove junction if found in list of **Control Junctions**
3) Remove junction if **both** splice sites of the junction are classified as **"Canonical Splice Sites"**.  
*Example: CM junction chr1_100-300 is split into SpliceSiteA_chr1_100 and SpliceSiteB_chr1_300. SpliceSiteA_chr1_100 is considered "Canonical" (i.e., found in the "Canonical Splice Sites" list constructed previously). SpliceSiteB_chr1_300 is **not** considered canoncial. This junction, therefore, will **not** be removed in this filter.*
4) Remove junction if **neither** splice sites of the junction are classified as **"Canonical Splice Sites"**.  
*Example: CM junction chr1_150-300 is split into SpliceSiteA_chr1_150 and SpliceSiteB_chr1_300. Neither splice site is considered canonical, so this junction is removed in this filter. 

*All filters found in `AbberantSplicing_Functions.Rmd` This file also contains functions necessary for reformating of data*

<br/>

## For our analysis, filters 1b (set at 10%) and 2-4 were used. The complete analysis, including creation of Control sample junction/splice site databases, can be found in `AbberantSplicing_Analysis.Rmd`

<br/>



## The resulting list of abberant splice sites is combined with allelic imbalance information to split abberant splice sites into **two potential biologically distinct groups:**

1) Abberant sites resulting in nonsense mediated decay (NMD)- *if gene shows allelic imbalance*
2) Abberant sites that do not result in NMD, but instead may result in an abnormal protein product - *if gene does not show allelic imbalance*
