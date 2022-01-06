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

prefix_input=/home/users/gu5/yamato/hp36s
prefix_flat_system=/home/users/gu5/flat/verify_hp36

## output directory setting
output_dir=$prefix_flat_system/5hflux/$data_id
if [ ! -e $output_dir ]
then
  mkdir -p $output_dir
else
  echo "${output_dir} directory exist."
  exit 1
fi

## work dirextory setting
WORK_DIR=/work/users/gu5/flat/heat_current_of_residue/$data_id # "/flat/heat_current_of_residue" avoid you to collide namespace.
if [ ! -e $WORK_DIR ]
then
  mkdir -p $WORK_DIR
else
  echo "${WORK_DIR} directory exists."
  exit 1
fi
cd $WORK_DIR
cp $prefix_input/0strct/strip.prmtop ./ # parmtop file
cp $prefix_flat_system/config/heat_current_of_residues.cfg ./ # flux configuration file
cp $prefix_flat_system/gpair/${data_id}.dat ./gpair.dat
# cp $prefix_input/4nve/$data_id/stripped0-200.crd.nc cc.crd.nc
# cp $prefix_input/4nve/$data_id/adjusted0-200.vel.nc vv.vel.nc
ln -s $prefix_input/4nve/$data_id/stripped0-200.crd.nc cc.crd.nc
ln -s $prefix_input/4nve/$data_id/adjusted0-200.vel.nc vv.vel.nc

logfile_name=${data_id}.log

curp compute heat_current_of_residues.cfg > $logfile_name

mv $WORK_DIR/flux_grp.nc $output_dir/heat_flux.nc
mv $WORK_DIR/$logfile_name $output_dir/$logfile_name
mv $WORK_DIR/heat_current_of_residues.cfg $output_dir/config.cfg

rm -r $WORK_DIR
