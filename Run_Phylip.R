#!/usr/bin/Rscript
# args[1]: *.phy
# args[2]: bootstrap time, integer

#setwd("/store/whzhang/storo/SDAU_WBGCAS_Apple/Tree/NJ/rename/NJ_BT10")
library(data.table)
library(ps)
library(stringr)
args <- c("Chr00_17.4dSNP.miss0.01.maf0.01.MergePear.Rename.min4.phy",10)
args <- commandArgs(T)
seqboot <- "/store/whzhang/tools/phylip/phylip-3.697/exe/seqboot"
dnadist <- "/store/whzhang/tools/phylip/phylip-3.697/exe/dnadist"
nj <- "/store/whzhang/tools/phylip/phylip-3.697/exe/neighbor"
consense <- "/store/whzhang/tools/phylip/phylip-3.697/exe/consense"

bt.num <- as.integer(args[2])
p.num <- 10

# Run seqboot
print("Extract bootstrap file...")
seqboot.para <- c(paste0(args[1]),"R",args[2],"Y",7)
fwrite(data.table(seqboot.para),file = paste0("seqboot.",bt.num,".par"),col.names = F, row.names = F,quote = F)
system(paste0(seqboot,"<seqboot.",bt.num,".par"),ignore.stdout = T,wait = T)

# Split seqboot result
line.num <- system("grep -n Pbr outfile", intern = T)
line.num <- as.integer(str_extract(line.num,"^[0-9]*"))-1
line.range <- line.num[2] - line.num[1] - 1
line.dt <- data.table(Boot = seq(1,bt.num), Start = line.num, End = line.num+line.range)
for (i in line.dt$Boot){
  print(paste("Split bootstrap file:",as.character(i)))
  system(paste0("mkdir Bootstrap_",as.character(i)))
  system(paste0("sed -n '",as.character(line.dt[[i,"Start"]]),",",as.character(line.dt[[i,"End"]]),"p' outfile > ./Bootstrap_",as.character(i),"/seqboot",as.character(i),".out"))
}
system("mv outfile seqboot.out")

# Calculate dnadist
for (i in seq(1,bt.num,by = p.num)){
  for (p in seq(i,i+p.num-2)){
    if(p <= bt.num){
      print(paste("Calculate dnadist:",as.character(p)))
      setwd(paste0("Bootstrap_",as.character(p)))
      dnadist.para <- c(paste0("seqboot",as.character(p),".out"),2,"Y")
      fwrite(data.table(dnadist.para),file = paste0("dnadist",as.character(p),".par"),col.names = F, row.names = F,quote = F)
      system(paste0(dnadist,"<dnadist",as.character(p),".par"),ignore.stdout = T,wait = F)
      setwd("../")
    }
  }
  if (i+p.num-1 <= bt.num){
    print(paste("Calculate dnadist:",as.character(i+p.num-1)))
    setwd(paste0("Bootstrap_",as.character(i+p.num-1)))
    dnadist.para <- c(paste0("seqboot",as.character(i+p.num-1),".out"),2,"Y")
    fwrite(data.table(dnadist.para),file = paste0("dnadist",as.character(i+p.num-1),".par"),col.names = F, row.names = F)
    system(paste0(dnadist,"<dnadist",as.character(i+p.num-1),".par"),ignore.stdout = T,wait = T)
    setwd("../")
  }
}

# Wait and check whether all process done
my.p.list <- ps(user = "whzhang")
while ("dnadist" %in% my.p.list$name){
  print("Waiting for other unfinished dnadist...")
  Sys.sleep(60)
  my.p.list <- ps(user = "whzhang")
}
print("All dnadist done!")

# Rename all dnadist file
for (i in line.dt$Boot){
  print(paste("Rename dnadist result:",as.character(i)))
  setwd(paste0("Bootstrap_",as.character(i)))
  system(paste0("mv outfile dnadist",as.character(i),".out"))
  setwd("../")
}

# Combine all dnadist file
print(paste("Combine all dnadist result: 1"))
system("cp ./Bootstrap_1/dnadist1.out ./dnadist.out")
for (i in line.dt$Boot[-1]){
  print(paste("Combine all dnadist result:",as.character(i)))
  setwd(paste0("Bootstrap_",as.character(i)))
  system(paste0("cat dnadist",as.character(i),".out >> ../dnadist.out"))
  setwd("../")
}

# Neighbor tree 
for (i in seq(1,bt.num,by = p.num)){
  for (p in seq(i,i+p.num-2)){
    if(p <= bt.num){
      print(paste("Construct N-J tree:",as.character(p)))
      setwd(paste0("Bootstrap_",as.character(p)))
      nj.para <- c(paste0("dnadist",as.character(p),".out"),"Y")
      fwrite(data.table(nj.para),file = paste0("nj",as.character(p),".par"),col.names = F, row.names = F,quote = F)
      system(paste0(nj,"<nj",as.character(p),".par"),ignore.stdout = T,wait = F)
      setwd("../")
    }
  }
  if (i+p.num-1 <= bt.num){
    print(paste("Construct N-J tree:",as.character(i+p.num-1)))
    setwd(paste0("Bootstrap_",as.character(i+p.num-1)))
    nj.para <- c(paste0("dnadist",as.character(i+p.num-1),".out"),"Y")
    fwrite(data.table(nj.para),file = paste0("nj",as.character(i+p.num-1),".par"),col.names = F, row.names = F)
    system(paste0(nj,"<nj",as.character(i+p.num-1),".par"),ignore.stdout = T,wait = T)
    setwd("../")
  }
}

# Wait and check whether all process done
my.p.list <- ps(user = "whzhang")
while ("neighbor" %in% my.p.list$name){
  print("Waiting for other unfinished N-J...")
  Sys.sleep(60)
  my.p.list <- ps(user = "whzhang")
}
print("All N-J done!")

# Rename all nj file
for (i in line.dt$Boot){
  print(paste("Rename N-J result:",as.character(i)))
  setwd(paste0("Bootstrap_",as.character(i)))
  system(paste0("mv outfile nj",as.character(i),".file"))
  system(paste0("mv outtree nj",as.character(i),".tree"))
  setwd("../")
}

# Combine all nj file
print(paste("Combine all N-J result: 1"))
system("cp ./Bootstrap_1/nj1.tree ./nj.tree")
system("cp ./Bootstrap_1/nj1.file ./nj.file")
for (i in line.dt$Boot[-1]){
  print(paste("Combine all N-J result:",as.character(i)))
  setwd(paste0("Bootstrap_",as.character(i)))
  system(paste0("cat nj",as.character(i),".tree >> ../nj.tree"))
  system(paste0("cat nj",as.character(i),".file >> ../nj.file"))
  setwd("../")
}

# Obtain consensus tree
print(paste("Construct consensus tree..."))
con.para <- c("nj.tree","Y")
fwrite(data.table(con.para), file = "consense.par", col.names = F, row.names = F)
system(paste0(consense,"<consense.par"), ignore.stdout = T, wait = T)
system("mv outfile consense.file")
system("mv outtree consense.nwk")

