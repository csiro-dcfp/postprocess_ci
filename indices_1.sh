#! /bin/bash -l 
# generate indices

dir=/group/pawsey0315/CAFE/forecasts/f5/WIP
file=c5-d60-pX-f5

mon=( 11 ) 
yr=(  1981 ) # fixed now passed 
yr=$1
echo $yr $file
mem=( 001 002 003 004 005 006 007 008 009 010)
vv=( n3 n4 n34 n12 iod ipotpi t_coral p1 p2 p3)


ln -s $dir f5
conda activate ferret

echo ${yr[*]}
for year in ${yr[*]}
do
rm yr${year}
ln -s f5/c5-d60-pX-f5-${year}1101 yr${year}
for i in ${mem[*]}
do
 file=OUTPUT.${i}
 echo ${file}, ${i} ${year} 
./make_des yr${year}/mem${i}.0/ocean_daily*.nc > odaily.${i}.des
ferret -gif -script model.indices.jnl  ${i} ${year} 11
done
done

# now observations 
# one file for all year
 ferret -gif -script obs.indices.jnl

# obs file for the give year
cd tmp

for month in ${mon[*]}
do 
for year in ${yr[*]}
do
for var in ${vv[*]}
do
#echo ${var}
ferret -gif -script ../lag2.jnl  ${year} ${var} ${month}
#ncrename -v OB,ob_${var} -v DA,DA_${var} ${year}.${var}.tmp.nc 
ncrename -v OB,ob_${var} ${year}.${month}.${var}.tmp.nc 
ncks -A ${year}.${month}.${var}.tmp.nc ${year}.${month}.obs.nc
done
echo "output file " ${year}.${month}.obs.nc
mv ${year}.${month}.obs.nc ../indices
done
done

# combine all the ensemble members into one file

for month in ${mon[*]}
do 
for year in ${yr[*]}
do
ncecat -O indices.${year}.${month}.*.nc ${year}.${month}.tfix.nc 
ncrename -d record,member ${year}.${month}.tfix.nc
ncks -O --fix_rec_dmn member ${year}.${month}.tfix.nc ${year}.${month}.fcst.nc 
rm  ${year}.${month}.tfix.nc
echo "output file " ${year}.${month}.fcst.nc
mv ${year}.${month}.fcst.nc ../indices
done
done

# final model file is ${year}.${month}.fcst.nc
# final obs file is ${year}.${month}.obs.nc
exit

