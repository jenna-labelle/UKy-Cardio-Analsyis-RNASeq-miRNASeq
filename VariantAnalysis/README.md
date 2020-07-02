# Variant analysis: comparison to WES and Allelic imbalance analysis

## RNASeq variant calling: comparison to WES variant calling

WES variant calling is generally more robust and subject to fewer sources of error (alignment, differences in expression, differences in transcripts, etc) compared to RNASeq variant calling. WES variant filtration was performed by PPM clinical bioFX team- using the same pipeline that is applied to clinical samples. Thus these variants are of very high confidence; we use these variants for allelic imbalance to filter RNASeq variants.

RNASeq variant calling performed using Isaac variant caller with default settings. Variants filtered by list of genes potentially involved in CM to simplify and focus analysis. Variants additionally filtered by coverage (15X total, 2X ref and alt). List of variants compared to WES variants to confirm robust nature of strategy, prior to continuing to allelic imbalance analysis.


## Allelic imbalance analysis
*Approach based on Gonorazky et al, 2019*

**Goal:** Identify genes that possess significant allelic imbalance, indicating potential NMD

**Two steps:**

*Note: prior to performing these steps, WASP should ideally be used to reduce reference allele bias, a major problem in allelic imbalance analyses*

1. Filter RNASeq SNPs used for analysis. Two options considered:

    a. Use Gonorazky et al approach: filter by depth and #SNPs/gene. Additionaly, we also filtered based on Exome SNPs ('`AlleleImbalance_Final.Rmd`)
    
    b. Use ASEReadCounter from GATK (see https://appdoc.app/artifact/org.broadinstitute/gatk/4.0.4.0/org/broadinstitute/hellbender/tools/walkers/rnaseq/ASEReadCounter.html)
    
    *SNP filtration and ASEReadCounter tool applied in `Snakemake` file*
    
2. Statistical testing for allelic imbalance. Two options considered:

    a. Use Gonorazky et al approach: Compare median allelic expression values for SNPs from experimental samples to median AE values for SNPs from control samples ('`AlleleImbalance_Final.Rmd`)
    
    b. Use beta-binomial testing: MBASED, available in Bioconductor (`MBASED_AllelicImbalanceAnalysis.Rmd`)

**Graphical representation of approach *(Options #1+2 for filtration, option #1 for statistical testing)*:**
![AI](https://github.com/jenna-labelle/UKy-Cardio-Analsyis-RNASeq-miRNASeq/blob/master/VariantAnalysis/AIApproach.PNG)

