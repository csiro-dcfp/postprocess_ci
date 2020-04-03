# scripts to build the files for the ENSO verification analysis
# from matt
#rsync /short/v19/mtc599/ao_am2/sep17b/work2/indices.collate.nc . 

# From DA run
#cp /short/v14/tok599/coupled/ao_am2/coupled_da/workdir2/OUTPUT-2step-nobreeding-carbon2/temp_inc_januarys_2002-2016.nc .
#cp /short/v14/tok599/coupled/ao_am2/coupled_da/workdir2/OUTPUT-2step-nobreeding-carbon2/temp_inc_timevg_januarys_2002-2016.nc .
# builds files of 
# ensemble mean and members 
# observed values on model grid

# builds climate indices
./indices_1.sh 
# combine climate indices into one file
./indices_2.sh  

