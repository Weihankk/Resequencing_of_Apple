picard SortSam INPUT=$MAPPING/$i.sam OUTPUT=$MAPPING/$i.sorted.bam VALIDATION_STRINGENCY=LENIENT CREATE_INDEX=TRUE SO=coordinate

samtools view -h -b -q 20 -o $BAMFILTER/$i.sorted.uniquely.q20.bam

picard FixMateInformation INPUT=$BAMFILTER/$i.sorted.uniquely.q20.bam OUTPUT=$BAMFILTER/$i.sorted.uniquely.q20.fxmt.bam SO=coordinate VALIDATION_STRINGENCY=LENIENT CREATE_INDEX=TRUE

picard MarkDuplicates INPUT=$BAMFILTER/$i.sorted.uniquely.q20.fxmt.bam OUTPUT=$BAMFILTER/$i.sorted.uniquely.q20.fxmt.mkdup.bam METRICS_FILE=$BAMFILTER/$i.sorted.uniquely.q20.fxmt.mkdup.metrics VALIDATION_STRINGENCY=LENIENT CREATE_INDEX=TRUE MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=1000

picard AddOrReplaceReadGroups INPUT=$BAMFILTER/$i.sorted.uniquely.q20.fxmt.mkdup.bam OUTPUT=$BAMFILTER/$i.sorted.uniquely.q20.fxmt.mkdup.addrep.bam RGID=$i RGLB=$i RGPL=Illumina RGPU=$i RGSM=$i RGCN=HZAU_WeihanZhang
