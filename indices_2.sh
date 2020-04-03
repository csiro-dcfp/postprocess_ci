#! /bin/bash
# build a couple of files that put all the data as a function of lead time.

# ensemble mean forecast
##ncecat m.2*.nc m.cat.nc
cd indices


# remap with observations with lead time to be consistent with forecast data
# remove only needed if starting fresh
rm *.lag.nc
rm *.fix.nc
#
vv=( n3 n4 n34 n12 iod ipotpi t_coral p1 p2 p3)
yr=( 1980 1981 1982 1983 1984 1985 1986 1987 1988 1989
  1990  1991 1992 1993 1994 1995 1996 1997 1998 1999
  2000 2001 2002 2003 2004 2005 2006 2007 2008 2009
  2010 2011 2012 2013 2014 2015 2016 2017 2018 2019) 
#yr=( 2010 )
mon=( 11 ) 
for month in ${mon[*]}
do 
for year in ${yr[*]}
do
ncecat -O indices.${year}.${month}.*.nc ${year}.${month}.tfix.nc 
ncrename -d record,member ${year}.${month}.tfix.nc
ncks -O --fix_rec_dmn member ${year}.${month}.tfix.nc ${year}.${month}.fix.nc 

for var in ${vv[*]}
do
#echo ${var}
ferret -gif -script ../lag2.jnl  ${year} ${var} ${month}
#ncrename -v OB,ob_${var} -v DA,DA_${var} ${year}.${var}.tmp.nc 
ncrename -v OB,ob_${var} ${year}.${month}.${var}.tmp.nc 
ncks -A ${year}.${month}.${var}.tmp.nc ${year}.${month}.lag.nc
done
done

ncecat -O [1-2]*.${month}.lag.nc  data.${month}.lag.nc 
rm  2*.tmp.nc
ncecat -O *.fix.nc model.${month}.lag.nc
#rm *.*fix.nc
#rm 2*.lag.nc 
mv *.*fix.nc work1
mv [1-2]*.lag.nc  work1

done
exit

