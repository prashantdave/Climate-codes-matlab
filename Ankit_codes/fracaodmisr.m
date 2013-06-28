clc
clear all
load('aod_mm_dec06.mat')
misr_small = aod_ave_dec(:,4) + aod_ave_dec(:,5);
misr_large = aod_ave_dec(:,6);
misr_sph = aod_ave_dec(:,7);
misr_nsph = aod_ave_dec(:,8);
misr_unc = aod_ave_dec(:,9);
misr_sfrac = zeros(912,1);
misr_lfrac = zeros(912,1);
misr_spfrac = zeros(912,1);
misr_nspfrac = zeros(912,1);
misr_sunc = zeros(912,1);
misr_lunc = zeros(912,1);
misr_sphunc = zeros(912,1);
misr_nsphunc = zeros(912,1);
lat = aod_ave_dec(:,1);
lon = aod_ave_dec(:,2);
for i = 1:912
    if (misr_small(i) + misr_large(i)) ~= 0
        misr_sfrac(i) = misr_small(i)/(misr_small(i) + misr_large(i));
        misr_lfrac(i) = misr_large(i)/(misr_small(i) + misr_large(i));
        %misr_sunc(i) = (misr_sfrac(i)^2/(misr_sfrac(i)^2 + misr_lfrac(i)^2))*misr_unc(i);
        %misr_lunc(i) = (misr_lfrac(i)^2/(misr_sfrac(i)^2 + misr_lfrac(i)^2))*misr_unc(i);
    end
    if (misr_sph(i) + misr_nsph(i)) ~= 0
        misr_spfrac(i) = misr_sph(i)/(misr_sph(i) + misr_nsph(i));
        misr_nspfrac(i) = misr_nsph(i)/(misr_sph(i) + misr_nsph(i));
        %misr_sphunc(i) = (misr_spfrac(i)^2/(misr_spfrac(i)^2 + misr_nspfrac(i)^2))*misr_unc(i);
        %misr_nsphunc(i) = (misr_nspfrac(i)^2/(misr_spfrac(i)^2 + misr_nspfrac(i)^2))*misr_unc(i);
    end
end
misr_dec_small = [lat lon misr_small misr_sfrac];
misr_dec_large = [lat lon misr_large misr_lfrac];
misr_dec_sph = [lat lon misr_sph misr_spfrac];
misr_dec_nsph = [lat lon misr_nsph misr_nspfrac];
save('misr_dec06_small.mat', 'misr_dec_small')
save('misr_dec06_large.mat', 'misr_dec_large')
save('misr_dec06_sph.mat', 'misr_dec_sph')
save('misr_dec06_nsph.mat', 'misr_dec_nsph')