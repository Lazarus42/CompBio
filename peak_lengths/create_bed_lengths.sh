#!/bin/bash
for dir in */
do
    # Check if directory name is a number
    if [[ $dir =~ ^[0-9]+/$ ]]; then
        # Remove the trailing slash from directory name
        dir_name=${dir%/}
        
        # Call your Python script with the directory name
        echo "Processing directory: " $dir_name
	python /home/sjgibson/atac_data_pipeline/scripts/preprocessing.py expand_peaks -l $dir_name -i /home/sjgibson/data/THP1_monocyte/THP1_monocytes.idr.optimal_peak.narrowPeak -o /home/sjgibson/data/THP1_monocyte/peak_lengths/$dir_name/temp.bed

	python /home/sjgibson/atac_data_pipeline/scripts/preprocessing.py filter_length -i /home/sjgibson/data/THP1_monocyte/peak_lengths/$dir_name/temp.bed -o /home/sjgibson/data/THP1_monocyte/peak_lengths/$dir_name/THP1_peaks.bed --conditions "<=$dir_name" ">=$dir_name"
	#python /path/to/script.py $dir_name
	
	rm /home/sjgibson/data/THP1_monocyte/peak_lengths/$dir_name/temp.bed

	# Get the positives fasta file
	bedtools getfasta -fi /home/sjgibson/data/genomes/hg38/hg38.fa -bed /home/sjgibson/data/THP1_monocyte/peak_lengths/$dir_name/THP1_peaks.bed > /home/sjgibson/data/THP1_monocyte/peak_lengths/$dir_name/THP1_peaks.fa
    
	# Use biasaway to get GC matched negative sequences
	
    fi
done
