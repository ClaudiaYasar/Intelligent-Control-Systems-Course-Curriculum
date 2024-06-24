%% Landmarks 

worldmap world
load coastlines
whos
[latcells, loncells] = polysplit(coastlat, coastlon);
numel(latcells)
geoshow('landareas.shp', 'FaceColor', 'k')
geoshow('worldlakes.shp', 'FaceColor', 'cyan')
geoshow('worldrivers.shp', 'Color', 'blue')
geoshow('worldcities.shp', 'Marker', '.',...
                           'MarkerEdgeColor', 'magenta')

%% World Map
sea_data = fopen('sealeveldata.txt');
SL = textscan(sea_data,'%f %f %f %f %f %f %f %f','headerlines',7);
fclose(sea_data);

sl = [SL{1} SL{2} SL{3} SL{4} SL{5} SL{6} SL{7} SL{8}]';
sl(sl==999)=NaN;
sl = (reshape(sl,[1440 716]))';

lat = repmat(linspace(89.5,-89.5,716)',1,1440);
lon = repmat(linspace(0,360,1440),716,1);

% Map Part
figure
ax = worldmap('World');
land = shaperead('landareas', 'UseGeoCoords', true);
geoshow(ax, land, 'FaceColor', 'k');

% plots sea level data
pcolorm(lat,lon,sl)  

cb = colorbar('location','southoutside');
caxis([-15 15])
title(ax,'Rising Sea Levels across the Globe','FontWeight','bold','FontSize',10)
xlabel(cb,'Sea level rise (mm/yr)','FontWeight','bold','FontSize',12)





    
%% correlation
load('final_matrix.mat')
r = corr(finalMatrix);
n = 6;
L = {'year', 'co2','ohclevitus','population','sea level','temp'};
close all;
imagesc(r); % plot the matrix
set(gca, 'XTick', 1:n); % center x-axis ticks on bins
set(gca, 'YTick', 1:n); % center y-axis ticks on bins
set(gca, 'XTickLabel', L); % set x-axis labels
set(gca, 'YTickLabel', L); % set y-axis labels
title('Correlation matrix', 'FontSize', 14); % set title
colormap('jet'); % set the colorscheme
colorbar() ; % Add color bar and make sure the color ranges from 0.9:1
caxis([0.9,1]);

%% Curve Fitting 
% Import Data
load("seaRiseMatrix.mat")
temp = temp_data(:,2);
searise = searise_data(:,2);
population = population_data(:,2);
ohclevitus = ohclevitusclimdashseasonal_data(:,2);
co2 = co2_data(:,2);
year = temp_data(:,1);



%% Fit: 'Linear Fitting'.
[xData, yData] = prepareCurveData( year, searise );

% Set up fittype and options.
ft = fittype( {'(sin(x-pi))', '((x-10)^2)', '1'}, 'independent', 'x', 'dependent', 'y', 'coefficients', {'a', 'b', 'c'} );

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft );

% Plot fit with data.
figure( 'Name', 'Linear Fitting' );
h = plot( fitresult, xData, yData );
legend( h, 'searise vs. year', 'Linear Fitting', 'Location', 'NorthEast', 'Interpreter', 'none' );
% Label axes
xlabel( 'year', 'Interpreter', 'none' );
ylabel( 'searise', 'Interpreter', 'none' );grid on


%% Fit: 'Polynomial(deg1)'.
[xData, yData] = prepareCurveData( year, searise );

% Set up fittype and options.
ft = fittype( 'poly1' );

% Fit model to data.
[fitresult1, gof] = fit( xData, yData, ft );

% Plot fit with data.
figure( 'Name', 'Polynomial(deg1)' );
h = plot( fitresult1, xData, yData );
legend( h, 'searise vs. year', 'Polynomial(deg1)', 'Location', 'NorthEast', 'Interpreter', 'none' );
% Label axes
xlabel( 'year', 'Interpreter', 'none' );
ylabel( 'searise', 'Interpreter', 'none' );
grid on




%% Fit: 'Polynomial(deg2)'.
[xData, yData] = prepareCurveData( year, searise );

% Set up fittype and options.
ft = fittype( 'poly2' );

% Fit model to data.
[fitresult2, gof] = fit( xData, yData, ft );

% Plot fit with data.
figure( 'Name', 'Polynomial(deg2)' );
h = plot( fitresult2, xData, yData );
legend( h, 'searise vs. year', 'Polynomial(deg2)', 'Location', 'NorthEast', 'Interpreter', 'none' );
% Label axes
xlabel( 'year', 'Interpreter', 'none' );
ylabel( 'searise', 'Interpreter', 'none' );
grid on




%% Fit: 'Polynomial(deg3)'.
[xData, yData] = prepareCurveData( year, searise );

% Set up fittype and options.
ft = fittype( 'poly3' );

% Fit model to data.
[fitresult3, gof] = fit( xData, yData, ft, 'Normalize', 'on' );

% Plot fit with data.
figure( 'Name', 'Polynomial(deg3)' );
h = plot( fitresult3, xData, yData );
legend( h, 'searise vs. year', 'Polynomial(deg3)', 'Location', 'NorthEast', 'Interpreter', 'none' );
% Label axes
xlabel( 'year', 'Interpreter', 'none' );
ylabel( 'searise', 'Interpreter', 'none' );
grid on


%%
subplot(2,2,1)
h = plot( fitresult, xData, yData );
legend( h, 'searise vs. year', 'Linear Fitting', 'Location', 'NorthEast', 'Interpreter', 'none' );
% Label axes
xlabel( 'year', 'Interpreter', 'none' );
ylabel( 'searise', 'Interpreter', 'none' );grid on

subplot(2,2,2)
h = plot( fitresult1, xData, yData );
legend( h, 'searise vs. year', 'Polynomial(deg1)', 'Location', 'NorthEast', 'Interpreter', 'none' );
% Label axes
xlabel( 'year', 'Interpreter', 'none' );
ylabel( 'searise', 'Interpreter', 'none' );
grid on

subplot(2,2,3)
h = plot( fitresult2, xData, yData );
legend( h, 'searise vs. year', 'Polynomial(deg2)', 'Location', 'NorthEast', 'Interpreter', 'none' );
% Label axes
xlabel( 'year', 'Interpreter', 'none' );
ylabel( 'searise', 'Interpreter', 'none' );
grid on

subplot(2,2,4)
h = plot( fitresult3, xData, yData );
legend( h, 'searise vs. year', 'Polynomial(deg3)', 'Location', 'NorthEast', 'Interpreter', 'none' );
% Label axes
xlabel( 'year', 'Interpreter', 'none' );
ylabel( 'searise', 'Interpreter', 'none' );
grid on

close all;



%% Sea Level Prediction with Neural Network

for i = 2021:2035
    yearx = i;
    result(i-2020) = 0.02354*(yearx^2) -91.4*yearx + 8.866e+04 ;
    yearss(i-2020) = i ;
end

plot(yearss,result)
xlabel('year')
ylabel('seaLevel')
title('Sea Level Prediction with Neural Network')



