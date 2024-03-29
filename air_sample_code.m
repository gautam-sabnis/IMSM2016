% air_sample_code.m
% These are just a few snippets to get you started with working with netCDF
% files in Matlab.

clear all;
close all;

%% Inquiries about file.

% Get basic information about the file.
finfo = ncinfo('/Volumes/Sev/NARR/daily/air.2m/air.2m.2008.nc')

% Display information about file.
ncdisp('/Volumes/Sev/NARR/daily/air.2m/air.2m.2008.nc')


%% Extracting data.

% Open the file.
ncid = netcdf.open('/Volumes/Sev/NARR/daily/air.2m/air.2m.2008.nc', 'NC_NOWRITE');

% Get information about the contents of the file.
[numdims, numvars, numglobalatts, unlimdimID] = netcdf.inq(ncid)

% Get information about 2nd variable in the file (indexing starts with 0).
[varname, xtype, dimids, numatts] = netcdf.inqVar(ncid,1)

% Get data.
latitude_data = netcdf.getVar(ncid,1);
longitude_data = netcdf.getVar(ncid,2);
air_data_daily = netcdf.getVar(ncid,6);

% Inquire about variable and extract an attribute.
varid = netcdf.inqVarID(ncid,'air');
air_fill_value = netcdf.getAtt(ncid,varid,'_FillValue');

netcdf.close(ncid);


% %% Plot data.
% 
% air_data_daily_p = permute(air_data_daily,[3 2 1]); % Permute variable dimensions.
% air_data_daily_p(air_data_daily_p == air_fill_value) = NaN; % Clear out fill values.
% 
% figure(1)
% pcolor(longitude_data, latitude_data, air_data_daily_p)
% shading interp
% xlabel('Longitude')
% ylabel('Latitude')
% title('air (daily)')
% colorbar



