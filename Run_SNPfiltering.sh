vcftools --vcf Chr.raw.vcf --minDP 3 --recode --out Chr.minDP3

vcftools --vcf Chr.minDP3.recode.vcf --maf 0.01 --recode --out Chr.minDP3.maf0.01
