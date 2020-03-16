% function viper_test

load('files/VIPeR/train_test_setting.mat');

w = model.Label(1)*model.w(1:end-1);
b = model.Label(1)*model.w(end);

Nte = length(test_id);
dec = zeros(Nte, Nte, 'single');    
for i = 1:length(train_id)
    dt_feat{2}{train_id(i)} = [];
end
dt_feat{2} = cell2mat(dt_feat{2});
parfor i = 1:Nte
    tmp = dt_feat{1}{test_id(i)}' * dt_feat{2};
    tmp = reshape(tmp, Nf1*Nf2, []);
    dec(i,:) = w * tmp;
end


%%% top-k cmc
fprintf('calculating CMC ...\n');
[~,I] = sort(dec, 2, 'descend'); % find the template that best matches with the query
rank_list = zeros(Nte, 1);
for i = 1:Nte
    rank_list(i) = find(I(i,:) == i);
end
tmp = histc(rank_list, 1:Nte);
cmc = cumsum(tmp)/max(cumsum(tmp));

[~,I] = sort(dec', 2, 'descend'); % find the template that best matches with the query
rank_list = zeros(Nte, 1);
for i = 1:Nte
    rank_list(i) = find(I(i,:) == i);
end
tmp = histc(rank_list, 1:Nte);
cmc = [cmc cumsum(tmp)/max(cumsum(tmp))];

figure;
subplot(1,2,1), plot(cmc(1:15, 1));
subplot(1,2,2), plot(cmc(1:15, 2));

% save(sprintf('files/VIPeR/%d_%d_%d.mat', Nf1, Nf2, size(dt_feat{2}, 1)), ...
%     'parts', 'model', 'dec');

