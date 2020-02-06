range_xy = 30; %ずらす最大値（＋,ー）
range_theta = 0;%回転する最大値(度)
addpath('function')
%% tifファイルの読み取り
tic
[file, file_path] = uigetfile('*.tif');
file_info = imfinfo([file_path, file]);
d1 = file_info(1).Height;
d2 = file_info(1).Width;
T = numel(file_info);
bit = file_info(1).BitDepth;
 
raw_IMG = zeros(d1,d2,T);
for t = 1:T
    raw_IMG(:,:,t) = imread([file_path, file], t);
end
disp('データ読み取り完了')
toc

%% レジスト
tic
target = mean(raw_IMG,3);
IMG = zeros(d1,d2,T);
Result = zeros(T,4);
for t = 1:T
    [Result(t,:), IMG(:,:,t)] = image_regist_rigid_GPU(raw_IMG(:,:,t), target, range_xy, range_theta);
    disp(['現在 ',num2str(t),'スライス目を完了']);
end
disp('レジスト完了')
toc

%% 結果の表示
figure
subplot(2,2,1)
plot(Result(:,1))
title('レジスト時の相関係数')
subplot(2,2,2)
plot(Result(:,2))
hold on
plot(1:T, range_theta * ones(1,T))
hold on
plot(1:T, -range_theta * ones(1,T))
title('回転量')
subplot(2,2,3)
plot(Result(:,3))
hold on
plot(1:T, range_xy * ones(1,T))
hold on
plot(1:T, -range_xy * ones(1,T))
title('x方向移動量')
subplot(2,2,4)
plot(Result(:,4))
hold on
plot(1:T, range_xy * ones(1,T))
hold on
plot(1:T, -range_xy * ones(1,T))
title('y方向移動量')

%% アニメーション表示
figure
tic
for t = 1:T
    imshow(IMG(:,:,t),[])
    pause(0.01)
end
toc

%% 書き込み
tic
IMG = cast(IMG,['uint',num2str(bit)]);
imwrite(IMG(:,:,1),[file_path, 'MATreged_', file]);
for t = 2:T
    imwrite(IMG(:,:,t),[file_path, 'MATreged_', file],'WriteMode','append');
end
disp('書き込み完了')
toc
