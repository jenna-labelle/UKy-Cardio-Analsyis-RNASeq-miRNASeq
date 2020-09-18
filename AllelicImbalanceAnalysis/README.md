# Allelic imbalance analysis
*Approach based on Gonorazky et al, 2019*

**Goal:** Identify genes that possess significant allelic imbalance, indicating potential NMD

**Three steps:**

1. Account for reference allele bias using WASP (https://github.com/bmvdgeijn/WASP)

    a. Split SNPs from single csv --> 1 txt file per chromosome ( `WASP/wasp_SplitSNPsByChromosome.sh` )
    
    b. Perform alignment as usual (STAR alignment using BaseSpace sequencing hub used here; default settings)
    
    c. Switch alleles in all sample bams (`WASP/wasp_PreReMap.sh`)
    
    d. Remap fastqs from switched alleles- same as step b, but no trimming of adapters
    
    e. Check if reads remap to the same place as before switching. If not: remove. If they do: merge with un-switched reads from step c. (`WASP/wasp_PostReMap.sh`)

2. Filter RNASeq SNPs used for analysis. Two options considered:

    a. Use Gonorazky et al approach: filter by depth and #SNPs/gene. Additionaly, we also filtered based on Exome SNPs ('`AlleleImbalance_FromVcfs.Rmd`)
    
    b. Use ASEReadCounter from GATK (see https://appdoc.app/artifact/org.broadinstitute/gatk/4.0.4.0/org/broadinstitute/hellbender/tools/walkers/rnaseq/ASEReadCounter.html). This approach chosen for downstream analysis due to improved ability to deal with duplication, reference allele bias, etc. 
    
    *ASEReadCounter tool applied in `WASP/Snakefile` file*
    
3. Statistical testing for allelic imbalance. Two options considered:

    a. Use Gonorazky et al approach: Compare median allelic expression values for SNPs from experimental samples to median AE values for SNPs from control samples ('`AlleleImbalance_FromVcfs.Rmd` or `AlleleImbalance_FromASEReadCounter.Rmd`)
    
    b. Use beta-binomial testing: MBASED, available in Bioconductor (`MBASED_AllelicImbalanceAnalysis.Rmd`). This approach chosen for downstream analysis. Only ASEReadCounter counts analyzed using this method.

**Graphical representation of approach *(Options #1+2 for filtration, option #1 for statistical testing)*:**
![AI](https://github.com/jenna-labelle/UKy-Cardio-Analsyis-RNASeq-miRNASeq/blob/master/VariantAnalysis/AIApproach.PNG)

