#!/bin/bash
#1 pop1 vcf
#2 pop2 vcf
#3 chr
#4 chr num
#5 pop1 name
#6 pop2 name

genetic_map=/stort/whzhang/XPCLR/Genetic_map/$3_new

sed -n '/^Chr/p' $1 |awk -v file=${genetic_map} -f /stort/whzhang/XPCLR/Genetic_map/xpclr.awk > $3.$5.$6.geneticmap
sed -n '/^Chr/p' $1 | awk -f /stort/whzhang/XPCLR/Genetic_map/xpclr_allels2.awk > $1.$5.$6.count
sed -n '/^Chr/p' $2 |awk -f /stort/whzhang/XPCLR/Genetic_map/xpclr_allels2.awk > $2.$5.$6.count
file1_name=$1.$5.$6.count
file2_name=$2.$5.$6.count
awk -v FS="\t" -v file1=${file1_name} -v file2=${file2_name} -f /stort/whzhang/XPCLR/Genetic_map/for_xpclr_input.awk $3.$5.$6.geneticmap > $3.$5.$6.count
/stort/whzhang/XPCLR/Genetic_map/xpclr_clean_count.R $3.$5.$6.count
/store/whzhang/tools/XP_CLR/COPY/src/XPCLR -c $3.$5.$6.clean.count $3.$5.$6 -w1 0.0001 100 100 $4
#rm $3.$5.$6.geneticmap
#rm $1.$5.$6.count
#rm $2.$5.$6.count
