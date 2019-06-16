clear; close all; clc; 
aotmean = zeros(12,1801,3601);

ym = [linspace(200601,200612,12)];
for i = 1:12
    %for i = 1:length(month)

        %files = dir(strcat('AOT_AVHRR_v02r00_daily-avg_', num2str(year(y)), num2str(month(i)),  '*.nc'));
        files = dir(sprintf('*_%d*.nc',ym(i)));
        aot = zeros(length(files),1801,3601);
    
        for j = 1:length(files) 
        fprintf('Currentfile: %s\n', files(j).name);
        
        %get latitude, longitude, aot values
        ncid = netcdf.open(files(j).name,'NC_NOWRITE');
        latitude_data = netcdf.getVar(ncid,1); 
        longitude_data = netcdf.getVar(ncid,2);
        aot_data_daily = netcdf.getVar(ncid,3); 
        %aot = ncread(A(i).name,'aot1');
    
        % Inquire about variable and extract an attribute.
        varid = netcdf.inqVarID(ncid,'aot1');
        aot_fill_value = netcdf.getAtt(ncid,varid,'_FillValue');
        aot_data_daily_p = permute(aot_data_daily,[3,2,1]);
        aot_data_daily_p(aot_data_daily_p == aot_fill_value) = NaN; 
        aot(i,:,:) = aot_data_daily_p; 
        
        end
        
        aotmean(i,:,:) = nanmean(aot,1);
        clear files;
        
    %end
    
end
        
        
  

