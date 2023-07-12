#! /bin/bash
#$ -wd /u/home/c/ckyriazi/project-klohmuel/caracal_simulations/output
#$ -l h_rt=200:59:00,h_data=8G,highp
#$ -o /u/home/c/ckyriazi/project-klohmuel/caracal_simulations/output
#$ -e /u/home/c/ckyriazi/project-klohmuel/caracal_simulations/output
#$ -N caracals_K76000_mig0.5_041323
#$ -m a
#$ -t 1:100


source /u/local/Modules/default/init/modules.sh
module load gcc/4.9.5

SLIMDIR=/u/home/c/ckyriazi/project-klohmuel/software/slim_build


${SLIMDIR}/slim /u/home/c/ckyriazi/project-klohmuel/caracal_simulations/scripts/caracals_K76000_mig0.5_041323.slim

