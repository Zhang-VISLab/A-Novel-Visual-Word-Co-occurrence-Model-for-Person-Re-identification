function viper_extract_feat

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

wid = 48; hgt = 128;

%%  cam a
parfor i = 1:Nid
    im = imread(img_file_paths{i,1});
    im = rgb2hsv(im);
    [imy imx imz] = size(im);
    densefeat = [];    
    for j = 1:2
        for k = 1:2
            tmp = im(j:imy-2+j, k:imx-2+k, :);
            densefeat = [densefeat, reshape(tmp, (imy-1)*(imx-1), [])];
        end
    end
    densefeat = single(densefeat);
    mySaveFeat([feat_folder_a, img_file_names{i,1}, '.mat'], densefeat);
end

%%  cam b
parfor i = 1:Nid
    im = imread(img_file_paths{i,2});
    im = rgb2hsv(im);
    [imy imx imz] = size(im);
    densefeat = [];    
    for j = 1:2
        for k = 1:2
            tmp = im(j:imy-2+j, k:imx-2+k, :);
            densefeat = [densefeat, reshape(tmp, (imy-1)*(imx-1), [])];
        end
    end
    densefeat = single(densefeat);
    mySaveFeat([feat_folder_b, img_file_names{i,2}, '.mat'], densefeat);
end
