#!/bin/sh -xe
#PBS -l select=1:ncpus=1:mpiprocs=1:ompthreads=1:jobtype=core
#PBS -l walltime=50:00:00

if [ "$PBS_O_WORKDIR" ]; then
  cd ${PBS_O_WORKDIR}
fi

# RUN
# SMP
# These number automatically will be filled by job scheduler
data_id=data${RUN}_${SMP}

prefix_flat_system=/home/users/gu5/flat/verify_hp36
prefix_output_dir=$prefix_flat_system/6hcond

## output directory setting
output_dir=$prefix_output_dir/$data_id
if [ ! -e $output_dir ]
then
  mkdir -p $output_dir
else
  echo "${output_dir} directory exist."
  exit 1
fi
## Working directory settings
## This job use RAM disk
RAMD_DIR=/ramd/users/gu5/$PBS_JOBID
flux_filename=flux.nc
cp $0 $output_dir/
cd $RAMD_DIR
# cp $prefix_flat_system/5hflux/$data_id/heat_flux.nc $flux_filename
ln -s $prefix_flat_system/5hflux/$data_id/heat_flux.nc $flux_filename

## output file settings
log_filename=curp.log
acf_filename=acf.nc
heat_conductivity_filename=conductivity.dat

echo "${time}"
curp cal-tc \
  --frame-range 1 100000 2 --average-shift 4 \
  --dt 0.0005  \
  -a $RAMD_DIR/$acf_filename \
  -o $output_dir/$heat_conductivity_filename \
  $RAMD_DIR/$flux_filename > $output_dir/$log_filename

mv $RAMD_DIR/$acf_filename $output_dir/
