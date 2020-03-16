% function viper_demo

% fprintf('viper_gen_train ... \n');
% viper_gen_train;

% fprintf('viper_extract_feat ... \n');
% viper_extract_feat;

Nid = 632;

folder1 = 'datasets/VIPeR/cam_a/';
folder2 = 'datasets/VIPeR/cam_b/';
files1 = dir([folder1, '*.bmp']); 
files2 = dir([folder2, '*.bmp']);

img_file_names = cell(Nid, 2);
img_file_paths = cell(Nid, 2);
for i = 1:Nid
    img_file_paths{i,1} = [folder1, files1(i).name];
    img_file_paths{i,2} = [folder2, files2(i).name];
    img_file_names{i,1} = files1(i).name(1:end-4);
    img_file_names{i,2} = files2(i).name(1:end-4);
end

feat_folder_a = 'feat/VIPeR/cam_a/';
feat_folder_b = 'feat/VIPeR/cam_b/';
mkdir(feat_folder_a);
mkdir(feat_folder_b);

wid = 48-1; hgt = 128-1;

for i = 1:1

% fprintf('viper_part_kmeans ... \n');
% Nf1 = i * 1e2;
% Nf2 = i * 1e2;
% viper_part_kmeans;

fprintf('viper_encode_img ... \n');
viper_encode_img;

fprintf('viper_gen_dt_feat ... \n');
viper_gen_dt_feat;

fprintf('viper_train_liblinear ... \n');
viper_train_liblinear;

fprintf('viper_test ... \n');
viper_test;

end
