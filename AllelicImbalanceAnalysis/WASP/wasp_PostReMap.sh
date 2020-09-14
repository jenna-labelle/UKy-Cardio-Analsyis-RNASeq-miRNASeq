#WASP steps 3-6

#Step 3: filter out reads that don't map correctly after allele switching

echo "Filter out incorrectly mapping reads"

#Create list of files to be checked: from original alignment (to remap) + second alignment (remapped)
ls ~/WASP/MyAnalysis/find_intersecting_snps/*to.remap.bam -v > filenames_toremap.txt 
ls /mnt/d/UKy/RealignedBAMs_ForWASP/sortedsorted*.bam -v > filenames_remapped.txt

#Cycle through list of filenames: remove any reads that don't map to the same place following allele switching and realignment
paste filenames_toremap.txt filenames_remapped.txt | while read toremap remapped; do
echo "-in $toremap -out $remapped"
filename=$( cut -d'/' -f6- <<< "$remapped" )
python ~/WASP/mapping/filter_remapped_reads.py $toremap $remapped ~/WASP/MyAnalysis/filter_remapped_reads/$filename
done

#Step 4: Merge together "keep" bams

echo "Merge bams together- keep bams from 1st and 2nd alignments"

#Create list of files to merge: from original alignment (keep, no switching necessary) + second alignment (keep, switching had same results)
ls ~/WASP/MyAnalysis/find_intersecting_snps/*.keep.bam -v > filenames_originalkeep.txt
ls ~/WASP/MyAnalysis/filter_remapped_reads/*.alignments.bam -v > filenames_secondkeep.txt

#Merge bams together: bams from original alignment that did not need alleles switched + bams from 2nd alignment post allele switching
paste filenames_originalkeep.txt filenames_secondkeep.txt | while read original second; do
echo "-original $original -second $second"
filename=$( cut -d'/' -f7- <<< "$second" )
echo "$filename"
samtools merge ~/WASP/MyAnalysis/merge/$filename $second $original
done

#Step 5: sort and index bams

echo "Sorting and indexing bams"

cd ~/WASP/MyAnalysis/merge
for sample in *.keep.merge.bam
do
samtools sort -o "$sample" "sorted_$sample"
samtools index "sorted_$sample"
done

#Step 6: Remove duplicates- create variable with input/output

echo "Removing duplicates"

for input in ~/WASP/MyAnalysis/merge/sortedsortedsorted*.bam
do
echo "$input"
output=$( cut -d'/' -f7- <<< "$input" )
echo "~/WASP/MyAnalysis/FinalWASPOutput_bams/$output"
python ~/WASP/mapping/rmdup_pe.py "$input" "~/WASP/MyAnalysis/FinalWASPOutput_bams/$output"
done

#Step 6: sort and index final bams

echo "Sorting and indexing bams"

cd ~/WASP/MyAnalysis/FinalWASPOutput_bams
for sample in sortedsortedsorted*
do
samtools sort -o "$sample" "Final_$sample"
samtools index "Final_$sample"
done

