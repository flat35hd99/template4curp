#!/bin/bash

# Run single calculation of heat conductivity
# This script depends on calculator_of_heat_conductivity.sh

# Usage
# ./run_single_calculator_of_heat_conductivity.sh <run_number> <sample_number>

# Example
# ./run_single_calculator_of_heat_conductivity.sh 2 3
# > Calculate data_02_3's heat current 

if [ $# != 2 ]; then
  echo "Two arguments are required"
  exit 1
fi

run=$( printf %02d $1 )
sample=$2

job_name="ws_hcond_${run}_${sample}"
variables="RUN=${run},SMP=${sample}" 
jobfile=$HOME/flat/hp36s/scripts/calculator_of_heat_conductivity.sh

jsub -N $job_name -v $variables $jobfile 
