% function viper_gen_dt_feat
%%
% load('files/VIPeR/parts.mat', 'parts');
encode_im = cell(1,2);

%%  cam a
feat_folder_a = 'feat/VIPeR/cam_a/';
files1 = dir([feat_folder_a, '*.mat']); 
% part_norms = sum(parts{1}.^2, 1);
% hgt = 128-1;
% wid = 48-1;
x = zeros(hgt, wid, length(files1), 'single');
parfor i = 1:length(files1)
    densefeat = single(myLoadFeat([feat_folder_a, files1(i).name]));    
%     densefeat = densefeat(:,1:288);
%     feat_norms = sum(densefeat.^2, 2);    
%     dis = -bsxfun(@minus, bsxfun(@minus, 2*densefeat*parts{1}, part_norms), feat_norms);    
    dis = sp_dist2(densefeat, parts{1});
    [~, tmp] = min(dis, [], 2);
    x(:,:,i) = reshape(tmp, [hgt, wid]);
end
encode_im{1} = single(x);

%%  cam b
feat_folder_b = 'feat/VIPeR/cam_b/';
files2 = dir([feat_folder_b, '*.mat']);
% part_norms = sum(parts{2}.^2, 1);
% hgt = 128-1;
% wid = 48-1;
x = zeros(hgt, wid, length(files2), 'single');
parfor i = 1:length(files2)
    densefeat = single(myLoadFeat([feat_folder_b, files2(i).name]));
%     densefeat = densefeat(:,1:288);
%     feat_norms = sum(densefeat.^2, 2);
%     dis = -bsxfun(@minus, bsxfun(@minus, 2*densefeat*parts{2}, part_norms), feat_norms);
    dis = sp_dist2(densefeat, parts{2});
    [~, tmp] = min(dis, [], 2);
    x(:,:,i) = reshape(tmp, [hgt, wid]);
end
encode_im{2} = single(x);

% save('files/VIPeR/encode_im.mat', 'encode_im');