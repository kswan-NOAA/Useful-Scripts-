#!/bin/bash
#SBATCH -J singleObTest
#SBATCH -o singleObTest.o%j
#SBATCH -A da-cpu
#SBATCH -q debug
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH -t 25:00

# *CHANGE: Working Directory
workdir=/work/noaa/da/kswan

# *CHANGE: Output Directory and Input File
dir1="T2.4"
obfile="singleob.yaml"
mkdir $workdir/jeditestrun/analysis/20210801T00000000Z/$dir1
 
# Load Modules
echo "Loading modules into $workdir"
cd $workdir
module load intel
module use $workdir/gdasapp/modulefiles
module load GDAS/orion
module load ncview
cd jeditestrun/

# Upgrade our single ob file before assimilation

echo "Upgrading $obfile"
upgrade_to_v3.sh $obfile

# Perform single var incremental assimilation using 3DVar
echo "Starting srun..."
srun -n 216 --exclusive -t 25:00 fv3jedi_var.x sample_var.yaml &> output.log

# Move the increment netCDF files to one directory
cd $workdir/jeditestrun/analysis
echo "Moving files to $dir1"
./test_run.loc_to_dir.sh $dir1

# Creates a copy of a templated .yaml file, and uses a token to set output to the directory
cp testCubedSphereRestart_templated.yaml testCubedSphereRestart.yaml
find_dir="@dir@"
sed -i "s/$find_dir/$dir1/g" testCubedSphereRestart.yaml

# Load modules and run EVA
cd $workdir
module load EVA/orion
echo "Evaluating testCubedSphereRestart.yaml, outputting to $dir1"
eva testCubedSphereRestart.yaml
#rm testCubedSphereRestart_tmp.yaml

# OPTIONAL: Copy output plots and logs to the plots directory
cd $workdir/jeditestrun/analysis/20210801T00000000Z/$dir1
mkdir $workdir/jeditestrun/plots/"$dir1""_plots"
for png in $(ls *.png); do
    
    cp $png $workdir/jeditestrun/plots/"$dir1""_plots"/$png
done
cp output.log $workdir/jeditestrun/plots/"$dir1""_plots"
cd $workdir/jeditestrun/plots/


# OPTIONAL: Upload changes to a github repository
dir2="$dir1""_plots"
repo="https://github.com/kswan-NOAA/Single-Obs-Experiment-Data.git"

git init
git add $dir2/\*
git commit -m "Added plots from $dir1"
git branch -M main
git push -u origin main
#git init

#for png in $(ls *.png); do
#    tmp=$png
#    git add $png
#done

#git commit -m "Added .pngs from $dir"

#git branch -M main

#git remote add origin https://github.com/kswan-NOAA/Personal-Work-Repo.git

#git push -u origin main


    
