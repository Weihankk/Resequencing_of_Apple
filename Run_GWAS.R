#!/usr/bin/Rscript
# Input :
# [1]: Phenotype file
# [2]: Output prefix
library(data.table)
library(tidyr)
library(showtext)
#setwd("/store/whzhang/stort/whzhang/GWAS/EMMAX/PA")
#args <- c("B2_2014","B2_2014")
args <- commandArgs(T)


# Make work dir
system(paste("mkdir ",args[2],"_emmax_output",sep = ""), wait = T)
pt <- fread(args[1])
pt$V3 <- as.numeric(pt$V3)
pt.ln <- data.table(V1 = pt$V1, V2 = pt$V2, V3 = log(pt$V3))
pt.ln$V3[is.infinite(pt.ln$V3)] <- 0
setwd(paste(args[2],"_emmax_output",sep = ""))

# Phenotype

tfam <- fread("/stort/whzhang/GWAS/Chr00_17.minDP3.maf0.01.window20k.overlap5k.iter25.reheader.setID.461.maf0.05.biallelic.snps.tfam")
pt.temp <- data.table(V1 = pt$V1, V3 = pt$V3)
tfam.temp <- data.table(V1 = tfam$V1)
pt.order <- pt.temp[tfam.temp, on = "V1"]
pt.order.ot <- data.table(V1=pt.order$V1, V2=pt.order$V1, V3=pt.order$V3)
write.table(pt.order.ot, file = paste(args[2],".ptfile",sep = ""), col.names = F, quote = F, row.names = F)


pt.ln.temp <- data.table(V1 = pt.ln$V1, V3 = pt.ln$V3)
tfam.ln.temp <- data.table(V1 = tfam$V1)
pt.ln.order <- pt.ln.temp[tfam.ln.temp, on = "V1"]
pt.order.ln.ot <- data.table(V1=pt.ln.order$V1, V2=pt.ln.order$V1, V3=pt.ln.order$V3)
write.table(pt.order.ln.ot, file = paste(args[2],".ln.ptfile",sep = ""), col.names = F, quote = F, row.names = F)

# Run EMMAX with no covariate ln
system(paste("/stort/whzhang/GWAS/EMMAX/emmax -v -d 10 -t /stort/whzhang/GWAS/Chr00_17.minDP3.maf0.01.window20k.overlap5k.iter25.reheader.setID.461.maf0.05.biallelic.snps -k /stort/whzhang/GWAS/Chr00_17.minDP3.maf0.01.window20k.overlap5k.iter25.reheader.setID.461.maf0.05.biallelic.snps.hBN.kinf -p ",args[2],".ln.ptfile ","-o ",args[2],".ln.NOC",sep = ""), wait = F)

# Run EMMAX with covariate ln
system(paste("/stort/whzhang/GWAS/EMMAX/emmax -v -d 10 -t /stort/whzhang/GWAS/Chr00_17.minDP3.maf0.01.window20k.overlap5k.iter25.reheader.setID.461.maf0.05.biallelic.snps -k /stort/whzhang/GWAS/Chr00_17.minDP3.maf0.01.window20k.overlap5k.iter25.reheader.setID.461.maf0.05.biallelic.snps.hBN.kinf -c /stort/whzhang/GWAS/Chr01_17.minDP3.maf0.01.window20k.overlap5k.iter25.reheader.setID.461.maf0.05.EMMAX.cov -p ",args[2],".ln.ptfile ","-o ",args[2],".ln.COV",sep = ""), wait = F)

# Run EMMAX with no covariate
system(paste("/stort/whzhang/GWAS/EMMAX/emmax -v -d 10 -t /stort/whzhang/GWAS/Chr00_17.minDP3.maf0.01.window20k.overlap5k.iter25.reheader.setID.461.maf0.05.biallelic.snps -k /stort/whzhang/GWAS/Chr00_17.minDP3.maf0.01.window20k.overlap5k.iter25.reheader.setID.461.maf0.05.biallelic.snps.hBN.kinf -p ",args[2],".ptfile ","-o ",args[2],".raw.NOC",sep = ""), wait = F)

# Run EMMAX with covariate
system(paste("/stort/whzhang/GWAS/EMMAX/emmax -v -d 10 -t /stort/whzhang/GWAS/Chr00_17.minDP3.maf0.01.window20k.overlap5k.iter25.reheader.setID.461.maf0.05.biallelic.snps -k /stort/whzhang/GWAS/Chr00_17.minDP3.maf0.01.window20k.overlap5k.iter25.reheader.setID.461.maf0.05.biallelic.snps.hBN.kinf -c /stort/whzhang/GWAS/Chr01_17.minDP3.maf0.01.window20k.overlap5k.iter25.reheader.setID.461.maf0.05.EMMAX.cov -p ",args[2],".ptfile ","-o ",args[2],".raw.COV",sep = ""), wait = T)


Sys.sleep(180)


# Plot RAW NOC
system(paste("/usr/bin/Rscript ~/whtools0.10/bin/EMMAXplot.R",args[1],args[2],"raw","NOC",sep = " "),wait = F)

# Plot RAW COV
system(paste("/usr/bin/Rscript ~/whtools0.10/bin/EMMAXplot.R",args[1],args[2],"raw","COV",sep = " "),wait = F)

# Plot LN NOC
system(paste("/usr/bin/Rscript ~/whtools0.10/bin/EMMAXplot.R",args[1],args[2],"ln","NOC",sep = " "),wait = F)

# Plot LN COV
system(paste("/usr/bin/Rscript ~/whtools0.10/bin/EMMAXplot.R",args[1],args[2],"ln","COV",sep = " "),wait = T)
