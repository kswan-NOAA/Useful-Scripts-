#!/bin/bash

# Created by: Alex Swan
# 6-29-23
# Simple script for setting up a working environment in orion

# CHANGE: working directory
module use /work/noaa/da/kswan/gdasapp/modulefiles/

module load GDAS/orion

# Account setup
export SLURM_ACCOUNT=da-cpu
export SALLOC_ACCOUNT=$SLURM_ACCOUNT
export SBATCH_ACCOUNT=$SLURM_ACCOUNT
export SLURM_QOS=debug

