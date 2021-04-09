#!/bin/bash
# Usage:
# $1: ped/fam prefix
# Will creat a directory named PCA_prefix in Output directory to stored results

PREFIX=$1
NAME=${PREFIX##*/}
BD=$(cd `dirname $0`; pwd)


# Work directory: eg:/store/whzhang
# Store result dir: eg:/store/whzhang/PCA_test
# Creat a directory to store results
mkdir PCA_${NAME}
OD="PCA_${NAME}"

#echo "Change short ID....."
awk '{print $2}' ${PREFIX}.map |cut -d "_" -f 1-2 > ${OD}/${NAME}.short.ID
awk '{print $1}' ${PREFIX}.map  > ${OD}/${NAME}.chr
awk '{print $3,$4}' ${PREFIX}.map  > ${OD}/${NAME}.2c
############################################################################
cat ${PREFIX}.map > ${OD}/${NAME}.map

echo "Change ped phenotype value to 1"
awk '{$1=$1;$2=$2;$3=$3;$4=$4;$5=$5;$6=1;print $0}' ${PREFIX}.ped > ${OD}/${NAME}.ped


# ----- Convert format -----
# Creat a par file for convetf
echo "genotypename:    ${OD}/${NAME}.ped
snpname:         ${OD}/${NAME}.map
indivname:       ${OD}/${NAME}.ped
outputformat:    EIGENSTRAT
genotypeoutname: ${OD}/${NAME}.eigenstratgeno
snpoutname:      ${OD}/${NAME}.snp
indivoutname:    ${OD}/${NAME}.ind
familynames:     NO" > ${OD}/par.PED.EIGENSTRAT

# Convert ped/fam format to EIGENSOFT format
${BD}/../soft/eigensoft/bin/convertf -p ${OD}/par.PED.EIGENSTRAT


# ----- PCA -----
# Creat a par file for smartpca 
echo "genotypename:     ${OD}/${NAME}.eigenstratgeno
snpname:          ${OD}/${NAME}.snp
indivname:        ${OD}/${NAME}.ind
evecoutname:      ${OD}/${NAME}.evec
evaloutname:      ${OD}/${NAME}.eval
numthreads:       10
numoutlieriter:   0" > ${OD}/par.smartpca

# Run smartpca analysis
${BD}/../soft/eigensoft/bin/smartpca -p ${OD}/par.smartpca > ${OD}/smartpca.log
#
