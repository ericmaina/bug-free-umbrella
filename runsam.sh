#!/bin/bash
#sort and convert sam to bam files

set -e 
filelist=$1

if [ $# -eq 0 ]; then 
     echo "Usage: $0  filelist ";
     exit 1;
fi

#check if output folder exsists
if [ ! -d "bam_files" ] 
then
     
  mkdir bam_files;
fi

#create temp folderr for samtools
if [ ! -d "samtools_temp" ]
then
     
  mkdir samtools_temp;
fi



while IFS= read -r line
do
  {
   ##get filename from path
   filename="$(basename $line)"
   
	   ##convert sam to bam and sort
	   #echo converting ${mapped}......;
	   echo samtools view -bS  alignment_output/${filename}.sam\|samtools sort -@ 15 -T samtools_temp -o bam_files/${filename}_sorted.bam;
	   ##extract mapped reads
           #samtools view -h -F 4 -b ${mapped}_sorted.bam > ${mapped}_sorted_mapped.bam;
  }
done <"$filelist"
