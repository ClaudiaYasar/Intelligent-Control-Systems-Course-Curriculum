%% Specific Lat-Lon to visualization

clear all;
clc;
% You can use that part to visualize specific year !
% take user input for the year they want projected sea rise
yearx = input("Enter the year you would like to learn sea level rise in future: ");
%d = datetime('today');

result = 0.02354*(yearx^2) -91.4*yearx + 8.866e+04 ;
result = result - 88;

% 36-42 lat ---- 26-45 lon is Turkey's parameters

lat_start = 36;
lat_end = 42;

lon_start = 26;
lon_end = 45 ;

% create the map
geolimits([lat_start lat_end],[lon_start lon_end])
geobasemap streets

gtextm("The average sea level rise is " + string(result) + " mm")