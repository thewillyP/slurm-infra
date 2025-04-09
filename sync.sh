#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=12G
#SBATCH --time=05:00:00
#SBATCH --job-name=wandb_sync
#SBATCH --cpus-per-task=6
#SBATCH --output="/scratch/wlp9800/logs/wandb_sync_%j.out"   
#SBATCH --error="/scratch/wlp9800/logs/wandb_sync_%j.err"    
#SBATCH --mail-type=END
#SBATCH --mail-user=wlp9800@nyu.edu

source ~/.secrets/env.sh

singularity exec --containall --no-home --cleanenv \
    --bind /scratch/${USER}/wandb:/wandb_data \
    --bind /home/${USER}/dev:/dev \
    --env WANDB_API_KEY=${WANDB_API_KEY} \
    --env WANDB_DIR=/wandb_data \
    --env WANDB_CACHE_DIR=/wandb_data/.cache/wandb \
    --env WANDB_CONFIG_DIR=/wandb_data/.config/wandb \
    --env WANDB_DATA_DIR=/wandb_data/.cache/wandb-data/ \
    --env WANDB_ARTIFACT_DIR=/wandb_data/.artifacts \
    /scratch/${USER}/images/devenv.sif bash -c \
    "cd /dev/slurm-infra && python wandb_syncp.py"

