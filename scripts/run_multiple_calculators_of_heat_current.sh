#!/bin/bash

# Run multiple calculations of heat current
# This script depends on calculator_of_heat_current.sh

# Usage
# ./run_multiple_calculators_of_heat_current.sh <run_number> <start_of_sample_number> <end_of_sample_number>

# Example
# ./run_single_calculator_of_heat_current.sh 2 0 9
# > Calculate data_02_0, data_02_1, data_02_2, data_02_3, data_02_4, ... , data_02_09 of heat current(s)

if [ $# != 3 ]; then
  echo "Three arguments are required"
  echo "Usage"
  echo "\$ ./run_multiple_calculators_of_heat_current.sh <run_number> <start_of_sample_number> <end_of_sample_number>"
  exit 1
fi

run=$( printf %02d $1 )
start_sample=$2
end_sample=$3

jobfile=$HOME/flat/hp36s/scripts/calculator_of_heat_current.sh

for sample_number in $( seq $start_sample $end_sample )
do
  variables="RUN=${run},SMP=${sample_number}"
  job_name="ws_${run}_${sample_number}_hc"

  jsub -N $job_name -v $variables $jobfile

  # Debug
  echo "data_${run}_${sample_number}"
  echo $variables
  echo $job_name
done

