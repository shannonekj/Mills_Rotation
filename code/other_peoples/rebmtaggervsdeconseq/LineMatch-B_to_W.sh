#!/bin/bash -l
#
#SBATCH --mail-user=sakre@ucdavis.edu
#SBATCH --mail-type=ALL
#SBATCH --array=0-16%2
#SBATCH --error=LineMatch-B_to_W-1.err
#SBATCH --partition=med
#SBATCH --account=millsgrp

module load python

i=$SLURM_ARRAY_TASK_ID


ids=("DMDT001B" "DMDT001C" "DMDT001D" "DMDT001E" "DMDT001F" "DMDT001G" "DMDT001H" "DMDT001J" "DMDT001L" "DMDT001M" "DMDT001N" "DMDT001P" "DMDT001Q" "DMDT001R" "DMDT001S" "DMDT001T" "DMDT001U" "DMDT001W")
bmtCont="/home/dhtaft/WGS/${ids[$i]}_human"
deconCont=$(find "/home/sakre/deconseqResults/${ids[$i]}" -name "*_cont.fq")

python ~/projects/bmt_decon/lineMatch/lineMatch.py ${ids[i]} $deconCont $bmtCont


#Ran with
#sbatch -p med -A millsgrp -t 03:00:00 --mem 1500 --array=0-16%2 LineMatch-B_to_W.sh