
range_xy = 20; %���炷�ő�l�i�{,�[�j
range_theta = 0.3;%��]����ő�l(�x)
 
%% tif�t�@�C���̓ǂݎ��
tic
[file, file_path] = uigetfile('*.tif');
raw_IMG1 = double(imread([file_path, file], 1));
disp('�f�[�^�ǂݎ�芮��')
toc

%% tif�t�@�C���̓ǂݎ��
tic
[file, file_path] = uigetfile('*.tif');
raw_IMG2 = double(imread([file_path, file], 1));
disp('�f�[�^�ǂݎ�芮��')
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
    title("���W�X�g�O")
subplot(1,2,2)
    imshowpair(f,target);
    title("���W�X�g��")