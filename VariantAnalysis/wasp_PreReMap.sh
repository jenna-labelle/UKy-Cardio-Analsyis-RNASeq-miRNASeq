#Step 1 of WASP
#Find SNPs (generated from wasp_SplitSNPsByChr.sh) in each bam file

for sample in /mnt/d/UKy/Merged_Bams/*.alignments.bam
do
echo "${sample}"
python /home/jenna/WASP/mapping/find_intersecting_snps.py --is_paired_end -p --is_sorted --output_dir find_intersecting_snps/ --snp_dir ExomeSNPs_Position "${sample}"
done

