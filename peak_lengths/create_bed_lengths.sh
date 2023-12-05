#!/bin/bash
for dir in */
do
    # Check if directory name is a number
    if [[ $dir =~ ^[0-9]+/$ ]]; then
        # Remove the trailing slash from directory name
        dir_name=${dir%/}
        
        # Call your Python script with the directory name
        echo "Processing directory: " $dir_name
	#python /home/sjgibson/atac_data_pipeline/scripts/preprocessing.py expand_peaks -l $dir_name -i /home/sjgibson/data/THP1_monocyte/CompBio/THP1_monocytes.idr.optimal_peak.narrowPeak -o /home/sjgibson/data/THP1_monocyte/CompBio/peak_lengths/$dir_name/temp.bed

	#python /home/sjgibson/atac_data_pipeline/scripts/preprocessing.py filter_length -i /home/sjgibson/data/THP1_monocyte/CompBio/peak_lengths/$dir_name/temp.bed -o /home/sjgibson/data/THP1_monocyte/CompBio/peak_lengths/$dir_name/THP1_peaks.bed --conditions "<=$dir_name" ">=$dir_name"
	#python /path/to/script.py $dir_name
	
	#rm /home/sjgibson/data/THP1_monocyte/CompBio/peak_lengths/$dir_name/temp.bed

	# Get the positives fasta file
	#bedtools getfasta -fi /home/sjgibson/data/genomes/hg38/hg38.fa -bed /home/sjgibson/data/THP1_monocyte/CompBio/peak_lengths/$dir_name/THP1_peaks.bed > /home/sjgibson/data/THP1_monocyte/CompBio/peak_lengths/$dir_name/THP1_peaks.fa
    
	# Use biasaway to get GC matched negative sequences
	#biasaway g -f /home/sjgibson/data/THP1_\
#monocyte/CompBio/peak_lengths/$dir_name/THP1_peaks.fa -r /home/sjgibson/data/ifb_background/hg38_background_lengths/$dir_name/hg_38_background_$dir_name > /home/sjgibson/data/THP1_monocyte/CompBio/peak_lengths/$dir_name/THP1_negatives.fa

	# Get corresponding bed files for negative sequence fasta files
	#python fasta_to_bed.py -fi /home/sjgibson/data/THP1_monocyte/CompBio/peak_lengths/$dir_name/THP1_negatives.fa -bed /home/sjgibson/data/THP1_monocyte/CompBio/peak_lengths/$dir_name/THP1_negatives.bed -l $dir_name

	# Use synteny split method to create train/test/val split with 5 folds for each directory
	NEG=/home/sjgibson/data/THP1_monocyte/CompBio/peak_lengths/$dir_name/THP1_negatives.bed
	POS=/home/sjgibson/data/THP1_monocyte/CompBio/peak_lengths/$dir_name/THP1_peaks.bed
	SPLIT_DIR_NEG=/home/sjgibson/data/THP1_monocyte/CompBio/peak_lengths/$dir_name/neg/
	SPLIT_DIR_POS=/home/sjgibson/data/THP1_monocyte/CompBio/peak_lengths/$dir_name/pos/
	#mkdir $SPLIT_DIR_NEG
	#mkdir $SPLIT_DIR_POS
	python /home/sjgibson/atac_data_pipeline/scripts/preprocessing.py split --in_files $POS --split_ref_species hg38 --out_dir $SPLIT_DIR_POS --create_folds 1 2 3 4 5
	python /home/sjgibson/atac_data_pipeline/scripts/preprocessing.py split --in_files $NEG --split_ref_species hg38 --out_dir $SPLIT_DIR_NEG --create_folds 1 2 3 4 5

    fi
done
