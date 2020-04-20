#!/usr/bin/env python
# coding: utf-8

# # Initial notebook to look at the cafe f5 forecasts
# 
# working version started as a notebook but will be turned into a script 

# In[1]:


import numpy as np
import matplotlib.pyplot as plt
from scipy.io import netcdf
import scipy.stats as stats
import sys
import netCDF4 as nc
import xarray as xr

import cartopy.crs as ccrs
from cartopy import config
import dask

#dask.config.set(scheduler='threads')


# Open dataset and produce plots of the figures 
# Need to pass the year to the file to run as a script

# In[2]:


import sys

print("Starting")
try:
	get_ipython
	year='1981'
except:
	print( 'Number of arguments:', len(sys.argv), 'arguments.')
	print( 'Argument List:', str(sys.argv) )
	year=(sys.argv[1])
	print(year)
	quit

print(year)


# In[3]:



model = xr.open_mfdataset('indices/model.11.lag.nc',combine='by_coords')

data=xr.open_dataset('indices/data.11.lag.nc')


# In[4]:


var=['iod','ipotpi','n12','t_coral','n34','n4']


# In[5]:


def plot_xx(l):
    ax=plt.subplot(3,2,l)
    file='indices/'+year+'.11.fix.nc'
    dfile='indices/'+year+'.11.lag.nc'
    fcst=xr.open_dataset(file)
    obs=xr.open_dataset(dfile)

    sclim=model[svar].mean(axis=[0,1])
    x=np.copy(fcst.TIME1)[0:1826]
    ym=np.copy(fcst[svar][:,0:1826].mean(axis=0))  - np.copy(sclim)
    y1=np.copy(fcst[svar][:,0:1826].min(axis=0)) -np.copy(sclim)
    y2=np.copy(fcst[svar][:,0:1826].max(axis=0)) -np.copy(sclim)

    oclim=data['ob_'+svar].mean(axis=0)
    xo=np.copy(obs.TIME1)[0:1826]
    yo=np.copy(obs['ob_'+svar][0:1826]) - np.copy(oclim)

    plt.plot(x,ym,color='red')
    plt.fill_between(x,y1,y2)

    plt.plot(xo,yo,color='black')
    plt.title(year+':  '+svar)
    plt.xlim=(-4,4)
    
    return
    


# In[7]:


plt.figure(figsize=(10, 10))
i=0
ax = plt.subplot(3,2,1)
for name in var:
    print(name) 
    i=i+1
    svar=name
    plot_xx(i)
    
    
    plt.savefig(year+'_climate_indices.pdf',dpi=600)
    


# ## finished generating plot
