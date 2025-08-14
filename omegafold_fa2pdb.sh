#!/bin/bash
set -e

checkpoint_file='~/omegafold_weights_release1.pt'
#checkpoint_file='~/omegafold_weights_release2.pt'

checkpoint_path=`realpath $(checkpoint_file)`
if [ ! -f $checkpoint ]; then
    echo "Omegafold checkpoint weights file $(checkpoint_file) not found!"
    exit 1
fi


while :; do
    case $1 in
	-h|--help)
	    printf 'omegafold_fa2pdb.sh -f seqs.fa -o output_directory\n'
	    exit
	    ;;
	-f)
	    fasta_file=$2
	    shift
	    ;;
    -o)
        output_dir=$2
        shift
        ;;
	-?*)
	    printf 'ERROR: Unknown option: %s\n' "$1" 1>&2
	    exit 1
        ;;
	*)
	    break
    esac
    
    shift
done

fasta_path=`realpath $(fasta_file)`

if [ ! -f $fasta_path ]; then
    echo "Input fasta file not found!"
    exit 1
fi

if [ ! -d "$output_dir" ]; then
    echo "Output directory not found!"
    exit 1
fi


docker run --runtime=nvidia --gpus all -it \
    -v $(checkpoint):/home/app/.cache/omegafold_ckpt/model.pt \
    -v $(fasta_path):/input_data/input.fa \
    -v $(output_dir):/output_data \
    omegafold \
    omegafold /input_data/input.fa /output_data
