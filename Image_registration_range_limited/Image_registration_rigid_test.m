
range_xy = 20; %ずらす最大値（＋,ー）
range_theta = 0.3;%回転する最大値(度)
addpath('function')
%% tifファイルの読み取り
tic
[file, file_path] = uigetfile('*.tif');
raw_IMG1 = double(imread([file_path, file], 1));
disp('データ読み取り完了')
toc

%% tifファイルの読み取り
tic
[file, file_path] = uigetfile('*.tif');
raw_IMG2 = double(imread([file_path, file], 1));
disp('データ読み取り完了')
toc

%%
tic
source = raw_IMG1;
target = raw_IMG2;
[dif, f] = image_regist_rigid(source, target, range_xy, range_theta);
toc
%%
figure
subplot(1,2,1)
    imshowpair(raw_IMG1,raw_IMG2);
    title("レジスト前")
subplot(1,2,2)
    imshowpair(f,target);
    title("レジスト後")
