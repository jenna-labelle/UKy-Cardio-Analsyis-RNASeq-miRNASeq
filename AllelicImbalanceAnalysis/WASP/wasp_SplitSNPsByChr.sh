#Split csv file of SNPs with chromosome # as first column into multiple csv files, one per chromosome
#Script should be executed in same directory as csv file containing snps across all chromosomes. Will generate 1 txt file per chromosome, to be used for WASP

awk -F, '{print > $1}' AllExomeSNPs.csv

#Remove first column (chr number) from all files
sed -i -e '1d' -e 's/[^,]*,//' chr*  

#Convert to .txt files
sed -i 's/,/\t/g' chr*
