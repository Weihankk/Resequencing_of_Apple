convert2annovar.pl -format vcf4 Chr.minDP3.maf0.01.imputation.vcf -outfile Chr.minDP3.maf0.01.avinput -allsample -withfreq
annotate_variation.pl -out Chr.minDP3.maf0.01 -buildver apple Chr.minDP3.maf0.01.avinput apple/ &
