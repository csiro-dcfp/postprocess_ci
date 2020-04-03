# scripts to build the files for the sst analysis

# From DA run
#cp /short/v14/tok599/coupled/ao_am2/coupled_da/workdir2/OUTPUT-2step-nobreeding-carbon2/temp_inc_januarys_2002-2016.nc .
#cp /short/v14/tok599/coupled/ao_am2/coupled_da/workdir2/OUTPUT-2step-nobreeding-carbon2/temp_inc_timevg_januarys_2002-2016.nc .
# builds files of 
# ensemble mean and members 
# observed values on model grid

# builds climate indices
# ../scripts/run0.sh 
# combine climate indices into one file
# ../scripts/run2.sh 

# monthly data
../scripts/run1.sh 
# daily data
../scripts/run1d.sh 

