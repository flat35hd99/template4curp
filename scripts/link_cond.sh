#!/bin/bash

prefix_src=/home/users/gu5/flat/verify_hp36/6hcond
prefix_dist=/home/users/gu5/flat/verify_hp36/link

for smp in $(seq 0 4)
  do
  for run in $(seq 0 9)
    do
    smp=$( printf %02d $smp )
    filepath="$prefix_src/data${smp}_${run}/conductivity.dat"
    ln -s $filepath "${prefix_dist}/data${smp}_${run}.dat"
  done
done

