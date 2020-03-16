% function viper_gen_dt_feat

% load('files/VIPeR/encode_im.mat', 'encode_im');
% load('files/VIPeR/parts.mat', 'parts');
% Nf1 = size(parts{1}, 2);
% Nf2 = size(parts{2}, 2);

beta = 1/6;

dt_feat = cell(1 ,2);

%%  cam a
hgt = size(encode_im{1}, 1);
wid = size(encode_im{1}, 2);
Nx = size(encode_im{1}, 3);
X = [];
parfor i = 1:Nx
    im = encode_im{1}(:,:,i);
    uid = unique(im);
    x = zeros(hgt*wid, Nf1);
    for j = 1:length(uid)
        tmp = (im==uid(j));
        [dis idx] = bwdist(tmp, 'chessboard');
%         dis = max(0, 1 - dis*beta)';
        dis = exp(-(dis*beta).^2);
        dis(dis<1e-1) = 0;
        x(:,uid(j)) = dis(:);
    end
    X = [X sparse(x)];   
end
dt_feat{1} = mat2cell(X, [size(X,1)], Nf1*ones(1, Nx));

%%  cam b
hgt = size(encode_im{2}, 1);
wid = size(encode_im{2}, 2);
Nx = size(encode_im{2}, 3);
X = [];
parfor i = 1:Nx
    im = encode_im{2}(:,:,i);
    uid = unique(im);
    x = zeros(hgt*wid, Nf2);
    for j = 1:length(uid)
        tmp = (im==uid(j));
        [dis idx] = bwdist(tmp, 'chessboard');
%         dis = max(0, 1 - dis*beta)';
        dis = exp(-(dis*beta).^2);
        dis(dis<1e-1) = 0;
        x(:,uid(j)) = dis(:);
    end
    X = [X sparse(x)];   
end
dt_feat{2} = mat2cell(X, [size(X,1)], Nf2*ones(1, Nx));
clear X;

% save('files/VIPeR/dt.mat', 'dt_feat', 'dt_idx', '-v7.3');

