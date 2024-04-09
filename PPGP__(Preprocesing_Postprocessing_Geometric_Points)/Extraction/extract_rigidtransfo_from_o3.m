%% Extracting R and T from input data O3 %%%%%%%%%%%%%%%%
clc
clear

addpath '.\Calculation_Geometrices'
addpath '.\Calculation_Statistiques'
addpath '.\Commands'
addpath '.\Conversion'
addpath '.\Defination'
addpath '.\Extraction'
addpath '.\Visualization'
sample = 'sample number';

sample_pre = ['Input address\' sample '\o3\' sample '.pre.o3'];
sample_post = ['Input address\' sample '\o3\' sample '.post.o3'];

Num = o32Num3D(sample_post);
Num3D = axesvertebrescalc(Num);
transfo = rigidtransfocalc(Num3D);
