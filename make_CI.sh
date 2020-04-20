#!/bin/bash -l 

# scripts to build the climate indices files for verification analysis
# plot an ensmble of forecasts for a give initial start time
# include the observation index on the plot

conda activate ferret
conda env list

cd postprocess_ci
mkdir indices
mkdir tmp

year=1982
year=$1  # pass to script at command line

# builds climate indices for 
# forecast ensemble members 
# observed values on the same time axis as forecasts
./indices_1.sh ${year} 

# produce plot of the climate indices
conda activate notebook
python climate_indices.py ${year}

mkdir plots
# move plot to a common directory
mv ${year}_*.pdf plots


