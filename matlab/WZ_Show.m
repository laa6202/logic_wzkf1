%0.
clear all
clc

%1. load file
fn = 'dirFile.dat';
fid = fopen(fn,'rb');
sample_rate = 2000;


%2. raed package 
[pkg_head,len_head] = fread(fid,12,'uint8');
[pkg_load,len_load] = fread(fid,sample_rate*9,'uint8');
[pkg_tail,len_tail] = fread(fid,48,'uint8');
[pkg_crc,len_crc]   = fread(fid,2,'uint8');


%3 seperate 3 channel
data_ch1 = zeros(3,sample_rate);
data_ch2 = zeros(3,sample_rate);
data_ch3 = zeros(3,sample_rate);
d1 = zeros(1,sample_rate);
d2 = zeros(1,sample_rate);
d3 = zeros(1,sample_rate);
for i=1:2000
    data_ch1(1,i) = pkg_load(i*9-8);
    data_ch1(2,i) = pkg_load(i*9-7);
    data_ch1(3,i) = pkg_load(i*9-6);
    data_ch2(1,i) = pkg_load(i*9-5);
    data_ch2(2,i) = pkg_load(i*9-4);
    data_ch2(3,i) = pkg_load(i*9-3);
    data_ch3(1,i) = pkg_load(i*9-2);
    data_ch3(2,i) = pkg_load(i*9-1);
    data_ch3(3,i) = pkg_load(i*9);
end
for i=1:2000
    d1(i) = bitshift(data_ch1(1,i),16) + bitshift(data_ch1(2,i),8) + data_ch1(3,i);
    d2(i) = bitshift(data_ch2(1,i),16) + bitshift(data_ch2(2,i),8) + data_ch2(3,i);
    d3(i) = bitshift(data_ch3(1,i),16) + bitshift(data_ch3(2,i),8) + data_ch3(3,i);
end
clear i;
clear data_ch2 data_ch1 data_ch3;


%4. plot 3 chanel 
subplot(2,2,1);
plot(d1);
title('channel 1');
subplot(2,2,2);
plot(d2);
title('channel 2');
subplot(2,2,3);
plot(d3);
title('channel 3');

