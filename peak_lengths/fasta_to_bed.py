
def write_bed_from_fasta(fasta_file, bed_file, seq_length):
    with open(fasta_file, 'r') as file, open(bed_file, 'w') as output_file:
        # loop through and write each header to a new bed file
        for line in file:
            if line.startswith('>'):
                line = line.strip()
                last_underscore = line.rfind("_")
                chrom = line[1:last_underscore]
                start = int(line[last_underscore + 1:]) - 1
                end = start + int(seq_length) 
                output_file.write(chrom + '\t' + str(start) + '\t' + str(end) + '\n')

def get_args():
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument('--fasta_file', '-fi')
    parser.add_argument('--bed_file', '-bed')
    parser.add_argument('--seq_length', '-l')
    return parser.parse_args()

def main(args):
    write_bed_from_fasta(args.fasta_file, args.bed_file, args.seq_length)

if __name__ == '__main__':
    main(get_args())
