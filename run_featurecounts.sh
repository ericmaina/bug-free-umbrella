#!/bin/bash
#get read counts falling on exon regions

set -e 

filelist=$1
gtffile=$2

if [ $# -ne 2 ]; then 
     echo "Usage: $0  filelist  gtf_file";
     exit 1;
fi

while IFS= read -r line
do
      	
	{
       	##get filename from path
       	filename="$(basename $line)"

        ##single end file, multi mapping counted
        #echo featureCounts -T 16 -M -t exon -g gene_id -a ${gtffile}  -o ${filename}_counts bam_files/${line}_sorted.bam

        ##paired end file, multi mapping counted
        echo  featureCounts -p -C -T 16 -M -t exon -g gene_id -a ${gtffile} -o raw_count_files/${filename}_counts bam_files/${line}_sorted.bam
            
        ##extract counts 
        echo cut -f1,7  raw_count_files/${filename}_counts \> raw_count_files/${filename}_counts.tab;
        echo sed -i '1,2d' raw_count_files/${filename}_counts.tab;
	}

done <"$filelist"
