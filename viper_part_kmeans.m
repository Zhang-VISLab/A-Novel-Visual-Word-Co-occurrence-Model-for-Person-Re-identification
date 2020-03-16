% function viper_filter_kmeans(Nf1, Nf2)

parts = cell(1,2);

% run('vlfeat-0.9.18/toolbox/vl_setup.m');

%%  cam a
feat_folder_a = 'feat/VIPeR/cam_a/';
files1 = dir([feat_folder_a, '*.mat']); 
x = [];
parfor i = 1:length(files1)
    densefeat = myLoadFeat([feat_folder_a, files1(i).name]);
    id = randsample(size(densefeat, 1), 50);
    x = [x; densefeat(id,:)];
end

% Nf1 = 1e2;
[~, parts{1}] = kmeans(single(x), Nf1);

%%  cam b
feat_folder_b = 'feat/VIPeR/cam_b/';
files2 = dir([feat_folder_b, '*.mat']);
x = [];
parfor i = 1:length(files2)
    densefeat = myLoadFeat([feat_folder_b, files2(i).name]);
    id = randsample(size(densefeat, 1), 50);
    x = [x; densefeat(id,:)];
end

% Nf2 = 1e2;
[~, parts{2}] = kmeans(single(x), Nf2);

% save('files/VIPeR/parts.mat', 'parts');