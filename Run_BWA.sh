bwa index GDDH13_1-1_formatted.fasta
bwa mem -t 10 -M GDDH13_1-1_formatted.fasta sample_1.fastq sample_2.fastq > ./alignment/sample.sam
