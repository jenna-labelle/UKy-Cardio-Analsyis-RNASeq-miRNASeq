## Variant analysis: comparison to WES and Allelic imbalance analysis



# Allelic imbalance analysis
*Approach based on Gonorazky et al, 2019*

**Goal:** Identify genes that possess significant allelic imbalance, indicating potential NMD

**Two steps:**

*Note: prior to performing these steps, WASP should ideally be used to reduce reference allele bias, a major problem in allelic imbalance analyses*

1. Filter RNASeq SNPs used for analysis. Two options considered:
    a. Use Gonorazky et al approach: filter by depth and #SNPs/gene. Additionaly, we also filtered based on Exome SNPs
    b. Use ASEReadCounter from GATK
2. Statistical testing for allelic imbalance. Two options considered:
    a. Use Gonorazky et al approach: Compare median allelic expression values for SNPs from experimental samples to median AE values for SNPs from control samples
    b. Use beta-binomial testing: MBASED, available in Bioconductor

![AI](VariantAnalysis/AIApproach.PNG)

