% normxcorr2を使ったレジストレーション
% xy方向しか動かないが、とても速く、領域を指定する必要なし
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
parfor t = 1:T
    source = raw_IMG(:,:,t);
    c = normxcorr2(source, target);
    [ypeak, xpeak] = find(c==max(c(:)));
    dy = ypeak - size(source,1);
    dx = xpeak - size(source,2);
    IMG(:,:,t) = imtranslate(source,[dx dy]);
    Result(t,:) = [c(ypeak, xpeak), 0, dx, dy];
    disp(['現在 ',num2str(t),'スライス目を完了']);
end
disp('レジスト完了')
toc

%% 結果の表示
figure
subplot(2,2,1)
plot(Result(:,1))
title('レジスト時の相関係数')
subplot(2,2,3)
plot(Result(:,3))
title('x方向移動量')
subplot(2,2,4)
plot(Result(:,4))
title('y方向移動量')

%% アニメーション表示
figure
for t = 1:T
    imshow(IMG(:,:,t),[])
    pause(0.05)
end
%% 書き込み
tic
IMG = cast(IMG,['uint',num2str(bit)]);
imwrite(IMG(:,:,1),[file_path, 'MATregedFast_', file,'.tif']);
for t = 2:T
    imwrite(IMG(:,:,t),[file_path, 'MATregedFast_', file,'.tif'],'WriteMode','append');
end
disp('書き込み完了')
toc