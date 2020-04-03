#! /bin/bash
# fix the years with first forecast member being longer than other forecasts
# fix the forecasts missing a member 2008 month 4 missing 9 member

cd indices

yr=( 2008  )
for year in ${yr[*]}
do
cp indices.${year}.4.1.nc indices.${year}.4.9.nc 
done

# first year to ensure the data file can be built
yr=( 2005 2006 )
for year in ${yr[*]}
do
ncks -O -d TIME1,0,528 indices.${year}.1.10.nc tmp.nc; mv tmp.nc indices.${year}.1.10.nc 
done

ncks -d TIME1,0,528 indices.2008.3.10.nc  tmp.nc; mv tmp.nc indices.2008.3.10.nc
ncks -d TIME1,0,528 indices.2005.3.10.nc  tmp.nc; mv tmp.nc indices.2005.3.10.nc
cp indices.2008.3.1.nc indices.2008.3.9.nc 

