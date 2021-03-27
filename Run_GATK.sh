samtools index -b $BAMFILTER/$i.sorted.uniquely.q20.fxmt.mkdup.addrep.bam -@ 4


java -Xmx60g -jar GenomeAnalysisTK.jar -T HaplotypeCaller -R GDDH13_1-1_formatted.fasta -I Allsamples.bam.basename.list -L Chr00 -o Chr01.vcf -nct 20
java -Xmx60g -jar GenomeAnalysisTK.jar -T HaplotypeCaller -R GDDH13_1-1_formatted.fasta -I Allsamples.bam.basename.list -L Chr01 -o Chr01.vcf -nct 20
java -Xmx60g -jar GenomeAnalysisTK.jar -T HaplotypeCaller -R GDDH13_1-1_formatted.fasta -I Allsamples.bam.basename.list -L Chr02 -o Chr02.vcf -nct 20
java -Xmx60g -jar GenomeAnalysisTK.jar -T HaplotypeCaller -R GDDH13_1-1_formatted.fasta -I Allsamples.bam.basename.list -L Chr03 -o Chr03.vcf -nct 20
java -Xmx60g -jar GenomeAnalysisTK.jar -T HaplotypeCaller -R GDDH13_1-1_formatted.fasta -I Allsamples.bam.basename.list -L Chr04 -o Chr04.vcf -nct 20
java -Xmx60g -jar GenomeAnalysisTK.jar -T HaplotypeCaller -R GDDH13_1-1_formatted.fasta -I Allsamples.bam.basename.list -L Chr05 -o Chr05.vcf -nct 20
java -Xmx60g -jar GenomeAnalysisTK.jar -T HaplotypeCaller -R GDDH13_1-1_formatted.fasta -I Allsamples.bam.basename.list -L Chr06 -o Chr06.vcf -nct 20
java -Xmx60g -jar GenomeAnalysisTK.jar -T HaplotypeCaller -R GDDH13_1-1_formatted.fasta -I Allsamples.bam.basename.list -L Chr07 -o Chr07.vcf -nct 20
java -Xmx60g -jar GenomeAnalysisTK.jar -T HaplotypeCaller -R GDDH13_1-1_formatted.fasta -I Allsamples.bam.basename.list -L Chr08 -o Chr08.vcf -nct 20
java -Xmx60g -jar GenomeAnalysisTK.jar -T HaplotypeCaller -R GDDH13_1-1_formatted.fasta -I Allsamples.bam.basename.list -L Chr09 -o Chr09.vcf -nct 20
java -Xmx60g -jar GenomeAnalysisTK.jar -T HaplotypeCaller -R GDDH13_1-1_formatted.fasta -I Allsamples.bam.basename.list -L Chr10 -o Chr10.vcf -nct 20
java -Xmx60g -jar GenomeAnalysisTK.jar -T HaplotypeCaller -R GDDH13_1-1_formatted.fasta -I Allsamples.bam.basename.list -L Chr11 -o Chr11.vcf -nct 20
java -Xmx60g -jar GenomeAnalysisTK.jar -T HaplotypeCaller -R GDDH13_1-1_formatted.fasta -I Allsamples.bam.basename.list -L Chr12 -o Chr12.vcf -nct 20
java -Xmx60g -jar GenomeAnalysisTK.jar -T HaplotypeCaller -R GDDH13_1-1_formatted.fasta -I Allsamples.bam.basename.list -L Chr13 -o Chr13.vcf -nct 20
java -Xmx60g -jar GenomeAnalysisTK.jar -T HaplotypeCaller -R GDDH13_1-1_formatted.fasta -I Allsamples.bam.basename.list -L Chr14 -o Chr14.vcf -nct 20
java -Xmx60g -jar GenomeAnalysisTK.jar -T HaplotypeCaller -R GDDH13_1-1_formatted.fasta -I Allsamples.bam.basename.list -L Chr15 -o Chr15.vcf -nct 20
java -Xmx60g -jar GenomeAnalysisTK.jar -T HaplotypeCaller -R GDDH13_1-1_formatted.fasta -I Allsamples.bam.basename.list -L Chr16 -o Chr16.vcf -nct 20
java -Xmx60g -jar GenomeAnalysisTK.jar -T HaplotypeCaller -R GDDH13_1-1_formatted.fasta -I Allsamples.bam.basename.list -L Chr17 -o Chr17.vcf -nct 20
