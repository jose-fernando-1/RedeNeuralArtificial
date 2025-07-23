#!/bin/bash

FASTA_DIR="/home/jf/GitRepositories/RedeNeuralArtificial/data/fastas_rs126"
PSSM_DIR="/home/jf/GitRepositories/RedeNeuralArtificial/data/pssm_rs126"
DB_NAME="/home/jf/Downloads/swissprot"
THREADS=4

mkdir -p "$PSSM_DIR"

for fasta in "$FASTA_DIR"/*.fasta; do
    base=$(basename "$fasta" .fasta)
    out_pssm="$PSSM_DIR/${base}.pssm"

    if [ ! -f "$out_pssm" ]; then
        echo "[INFO] Gerando PSSM para $base"
        psiblast -query "$fasta" \
                 -db "$DB_NAME" \
                 -num_iterations 3 \
                 -evalue 0.001 \
                 -num_threads "$THREADS" \
                 -out_ascii_pssm "$out_pssm" \
                 -out /dev/null
    else
        echo "[INFO] PSSM já existe para $base, pulando..."
    fi
done

echo "[INFO] Finalizado. PSSMs estão em $PSSM_DIR."
