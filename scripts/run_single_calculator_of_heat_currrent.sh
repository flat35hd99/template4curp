#!/bin/bash

# Run single calculation of heat current
# This script depends on calculator_of_heat_current.sh

# Usage
# ./run_single_calculator_of_heat_current.sh <run_number> <sample_number>

# Example
# ./run_single_calculator_of_heat_current.sh 2 3
# > Calculate data_02_3's heat current 

if [ $# != 2 ]; then
  echo "Two arguments are required"
  exit 1
fi

run=$( printf %02d $1 )
sample=$2

job_name="ws_${run}_${sample}_hc"
jobfile=$HOME/flat/hp36s/scripts/calculator_of_heat_current.sh

jsub -N $job_name -v "RUN=${run},SMP=${sample}" $jobfile 
