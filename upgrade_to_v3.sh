#!/bin/bash


# Created by: Alex Swan
# 6-29-23
# Takes an input single ob .yaml, converts to netCDF, and upgrades to v3.


# Setup environment
module use /work/noaa/da/kswan/gdasapp/modulefiles/
module load GDAS/orion

# Set python path and create ob file
export PYTHONPATH=$PYTHONPATH:/work/noaa/da/kswan/gdasapp/iodaconv/src
/work/noaa/da/kswan/gdasapp/build/bin/gen_single_ob.py -y singleob.yaml

# Upgraders
/work/noaa/da/kswan/gdasapp/build/bin/ioda-upgrade-v1-to-v2.x singleob.nc singleob_v2.nc
/work/noaa/da/kswan/gdasapp/build/bin/ioda-upgrade-v2-to-v3.x singleob_v2.nc singleob_v3.nc /work/noaa/da/kswan/gdasapp/ioda/share/ioda/yaml/validation/ObsSpace.yaml

# Optional
cp ./singleob_v3.nc ./obs/singleob_v3.nc

