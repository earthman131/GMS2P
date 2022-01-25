%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Modified interpolation-iteration continuation method
% Author: Lianghui Guo (guolh@cugb.edu.cn)
% Organization: China University of Geosciences (Beijing), School of Geophysics and Information Technology
% Compiled version: MATLAB R2017b
% Reference: 
%       Guo L H, Cui Y T. New methods and programs for frequency-domain processing and imaging of gravity  
%       and magnetic data. Beijing: Geological publishing house, 2021. (in Chinese)
% Description of the input parameters: 
%       infile_obs£ºoriginal anomaly data file
%       infile_topo£ºundulant observation surface file, positive upward, unit: m
%       iter£ºnumber of iterations
%       hmin£ºinitial elevation of interpolation, generally less than the lowest value of the undulant surface, unit: m
%       hmax£ºfinal elevation of interpolation, generally greater than the highest value of the undulant surface, unit: m
%       dh£ºspacing in the altitude direction, unit: m
% Description of the output parameters: 
%       outfile: result file
% Description of primary identifiers£º
%       x, y: x, y verctor
%       nx, ny: number of points in x and y directions
%       dx, dy: spacing in x and y directions
%       g: observed anomaly data
%       t: undulating observation surface data
%       npts: extension points
%       nh: number of points in altitude direction
%       h: altitude direction vector
%       g3: result data
% Description of subroutine function£º
%       readgrd.m: read surfer text grd file
%       s2p.m: modified interpolation-iteration continuation
%       upcon.m: upward continuation in frequency domain
%       taper2d.m: cosine attenuation edge extension
%       savegrd.m: save surfer text grd file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
clear;
close all;
%%%%%%%%%%%% I/O parameters %%%%%%%%%%%%%
infile_obs = 'gobs.grd'; 
infile_topo = 'topo.grd'; 
iter = 20; 
hmin = 0; 
hmax = 2200; 
dh = 200; 
outfile = 'gp.grd'; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[g,x,y,nx,ny,dx,dy] = readgrd( infile_obs );
[t,~,~,~,~,~,~] = readgrd( infile_topo ); 
tmin = min(t(:));
tmax = max(t(:));
tt=(t-tmin)/(tmax-tmin);
nmax = max([nx ny]);
npts = 2^nextpow2(nmax);
% Modified interpolation-iteration continuation method
g3 = s2p(g,npts,hmin,hmax,dh,tt,x,y,nx,ny,dx,iter);
% Save
savegrd(g3,x,y,nx,ny,outfile)
