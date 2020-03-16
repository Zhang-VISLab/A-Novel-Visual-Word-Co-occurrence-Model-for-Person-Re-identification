function viper_gen_train

dataset_name = 'VIPeR';

Nid = 632;
train_id = randsample(Nid, Nid/2);
train_id = sort(train_id);
test_id = 1:Nid;
test_id(train_id) = [];

mkdir('files/');
mkdir(sprintf('files/%s/', dataset_name));

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

% train_pair_id = [train_id train_id];
% id1 = randsample(Nid/2, 1e5, 1);
% id2 = randsample(Nid/2, 1e5, 1);
% train_pair_id = [train_pair_id; [train_id(id1) train_id(id2)]];
% train_pair_id = unique(train_pair_id, 'rows');
% train_pair_y = double(train_pair_id(:,1)==train_pair_id(:,2));
% train_pair_y(train_pair_y==0) = -1;

tid = [1:Nid/2]';
train_pair_id = [tid tid];
id1 = randsample(Nid/2, 5e4, 1);
id2 = randsample(Nid/2, 5e4, 1);
train_pair_id = [train_pair_id; [tid(id1) tid(id2)]];
train_pair_id = unique(train_pair_id, 'rows');
train_pair_y = double(train_pair_id(:,1)==train_pair_id(:,2));
train_pair_y(train_pair_y==0) = -1;

save(sprintf('files/%s/train_test_setting.mat', dataset_name), ...
    'train_id', 'test_id', 'img_file_paths', 'img_file_names', 'train_pair_id', 'train_pair_y');

