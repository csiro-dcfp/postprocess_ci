
#! /bin/bash
# generate indices

#make_des DA/201[3-6]*/ocean_daily_* > DA1.des
#c5-d60-pX-f5-19961101
module load netcdf
module load nco
module load ferret
#
yr=(  1991 )  
yr=`ls -1 f5 | sed -n 's/c5-d60-pX-f5-//p' | sed -n 's/1101//p'`
yr=(  1981 )  
echo $yr
mem=( 001 002 003 004 005 006 007 008 009 010)

echo ${yr[*]}
for year in ${yr[*]}
do
rm yr${year}
ln -s f5/c5-d60-pX-f5-${year}1101 yr${year}
for i in ${mem[*]}
do
 file=OUTPUT.${i}
 echo ${file}, ${i} ${year} 
~/bin/make_des yr${year}/mem${i}.0/ocean_daily*.nc > odaily.${i}.des
ferret -gif -script model.indices.jnl  ${i} ${year} 11
done
done

# now observations for just one file
 ferret -gif -script obs.indices.jnl

exit

