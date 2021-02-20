#!/bin/bash
#
#run with "sbatch -p med -A millsgrp -t 1-12:00:00 --mem MaxMemPerNode deconseq_hg38_db.sh"
#
#SBATCH --mail-user=sejoslin@ucdavis.edu
#SBATCH --mail-type=ALL
#SBATCH --job-name=deconseq_hg38_db
#SBATCH --error=deconseq_hg38_db.err
#SBATCH --partition=med
#SBATCH --account=millsgrp
#
# script for building sequence data 
# March 2017
# Human build 38 ref_GRCh38.p7
# modified from http://deconseq.sourceforge.net/manual.html

#download sequence data from NCBI
for i in {1..22} X Y MT
do
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/H_sapiens/Assembled_chromosomes/seq/hs_ref_GRCh38.p7_chr$i.fa.gz
done

#extract seq and join into a single file 
for i in {1..22} X Y MT
do
gzip -dvc hs_ref_GRCh38.p7_chr$i.fa.gz >>hs_ref_GRCh38.p7.fa
done
for i in {1..22} X Y MT
do
rm hs_ref_GRCh38.p7_chr$i.fa.gz
done

#split sequences by long repeats of ambiguous base N
	# Need to remove b/c BWA and BWA-SW replace N with ACTG randomly and can lead to false positives.
	# reason for the replacement of ambiguous bases is the 2 bit representation of sequence data that
	# only allows to store/represent four different bases (as 00, 01, 10 and 11)
cat hs_ref_GRCh38.p7.fa | perl -p -e 's/N\n/N/' | perl -p -e 's/^N+//;s/N+$//;s/N{200,}/\n>split\n/' >hs_ref_GRCh38_p7_split.fa
rm hs_ref_GRCh38.p7.fa

#filter sequences
	# After splitting the genomic sequences, it is possible that a query sequence will be longer than a sequence in the database
	# causes problems when query seq aligns over multiple concatenated seqs in db
	# removes short and duplicate sequences
	# sequences  filtered with PRINSEQ (http://prinseq.sourceforge.net)
perl /home/sejoslin/downloads/prinseq-lite-0.20.4/prinseq-lite.pl -log -verbose -fasta hs_ref_GRCh38_p7_split.fa -min_len 200 \
-ns_max_p 10 -derep 12345 -out_good hs_ref_GRCh38_p7_split_prinseq -seq_id hs_ref_GRCh38_p7_ -rm_header -out_bad null
rm hs_ref_GRCh38_p7_split.fa

#create database
	#from FASTA file format
	#note: bigger datasets bwtsw algorithm should be used, max size = 4Gb <- to generate larger split data into chunks <4Gb
bwa index -p hs_ref_GRCh38_p7 -a bwtsw hs_ref_GRCh38_p7_split_prinseq.fasta >bwa.log 2>&1 &

