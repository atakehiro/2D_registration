range_xy = 30; %���炷�ő�l�i�{,�[�j
range_theta = 0;%��]����ő�l(�x)

%% tif�t�@�C���̓ǂݎ��
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
disp('�f�[�^�ǂݎ�芮��')
toc

%% ���W�X�g
tic
target = mean(raw_IMG,3);
IMG = zeros(d1,d2,T);
Result = zeros(T,4);
for t = 1:T
    [Result(t,:), IMG(:,:,t)] = image_regist_rigid_GPU(raw_IMG(:,:,t), target, range_xy, range_theta);
    disp(['���� ',num2str(t),'�X���C�X�ڂ�����']);
end
disp('���W�X�g����')
toc

%% ���ʂ̕\��
figure
subplot(2,2,1)
plot(Result(:,1))
title('���W�X�g���̑��֌W��')
subplot(2,2,2)
plot(Result(:,2))
hold on
plot(1:T, range_theta * ones(1,T))
hold on
plot(1:T, -range_theta * ones(1,T))
title('��]��')
subplot(2,2,3)
plot(Result(:,3))
hold on
plot(1:T, range_xy * ones(1,T))
hold on
plot(1:T, -range_xy * ones(1,T))
title('x�����ړ���')
subplot(2,2,4)
plot(Result(:,4))
hold on
plot(1:T, range_xy * ones(1,T))
hold on
plot(1:T, -range_xy * ones(1,T))
title('y�����ړ���')

%% �A�j���[�V�����\��
figure
tic
for t = 1:T
    imshow(IMG(:,:,t),[])
    pause(0.01)
end
toc

%% ��������
tic
IMG = cast(IMG,['uint',num2str(bit)]);
imwrite(IMG(:,:,1),[file_path, 'MATreged_', file,'.tif']);
for t = 2:T
    imwrite(IMG(:,:,t),[file_path, 'MATreged_', file,'.tif'],'WriteMode','append');
end
disp('�������݊���')
toc