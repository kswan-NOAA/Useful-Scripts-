#!/bin/bash

#Created by: Alex Swan
# Updated 6-29-23
# This script currently sorts test output into a single file location

cd /work/noaa/da/kswan/jeditestrun/analysis/20210801T00000000Z

ls
test = $(!!)
echo $test
direc=1.00



mkdir ./20210801T00000000Z/$

if [ $? -ne 0 ]
then
   echo "hello world"
fi

direc=./20210801T00000000Z/T1E
boolvar=0

mv ./latlon.an.hyb-3dvar.20210801T000000Z.nc $direc/latlon.an.hyb-3dvar.20210801T000000Z.nc

# Currently does nothing

#f [ $? -eq 0 ]
#hen
#  boolvar=1
#i
   
mv ./latlon.inc.hyb-3dvar.20210801T000000Z.nc $direc/latlon.inc.hyb-3dvar.20210801T000000Z.nc

cd ..

mv ./output.log ./analysis/$direc/output.log
mv /work/noaa/da/kswan/jeditestrun/anl/* /work/noaa/da/kswan/jeditestrun/analysis/20210801T00000000Z/T1E

# Currently does nothing

#f [ $boolvar -eq 1 ] 
#hen
#  echo "hello!"
#  cd analysis
   #rm latlon.an.hyb-3dvar.20210801T000000Z.nc
   #rm latlon.inc.hyb-3dvar.20210801T000000Z.nc
#i 


